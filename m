Received: from eggs.gnu.org ([2001:4830:134:3::10]:42196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg6M2-0000EQ-9q
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg6Lz-0004t0-1Q
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:07:58 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <362b0cf9-b6e5-e606-ffb7-84cf8e2a4537@redhat.com>
Date: Mon, 29 Jan 2018 11:07:51 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 09/10] s390-ccw: read user
 input for boot index via the SCLP console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> Implements an sclp_read function to capture input from the
> console and a wrapper function that handles parsing certain
> characters and adding input to a buffer. The input is checked
> for any erroneous values and is handled appropriately.
>=20
> A prompt will persist until input is entered or the timeout
> expires (if one was set). Example:
>=20
>     Please choose (default will boot in 10 seconds):

Wondering if it would be possible to print the list of boot options
(just like zipl, if that is possible).

>=20
> Correct input will boot the respective boot index. If the
> user's input is empty, 0, or if the timeout expires, then
> the default zipl entry will be chosen. If the input is
> within the range of available boot entries, then the
> selection will be booted. Any erroneous input will cancel
> the timeout and re-prompt the user.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c     | 152 ++++++++++++++++++++++++++++++++++++=
+++++++-
>  pc-bios/s390-ccw/s390-ccw.h |   2 +
>  pc-bios/s390-ccw/sclp.c     |  20 ++++++
>  pc-bios/s390-ccw/virtio.c   |   2 +-
>  4 files changed, 172 insertions(+), 4 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 174285e..24d4bba 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -12,16 +12,162 @@
>  #include "menu.h"
>  #include "s390-ccw.h"
> =20
> -static uint8_t flags;
> -static uint64_t timeout;
> +#define KEYCODE_NO_INP '\0'
> +#define KEYCODE_ESCAPE '\033'
> +#define KEYCODE_BACKSP '\177'
> +#define KEYCODE_ENTER  '\r'
> =20
>  /* Offsets from zipl fields to zipl banner start */
>  #define ZIPL_TIMEOUT_OFFSET 138
>  #define ZIPL_FLAG_OFFSET    140
> =20
> +#define TOD_CLOCK_SECOND    0xf4240000
> +
> +static uint8_t flags;
> +static uint64_t timeout;
> +
> +static inline void enable_clock_int(void)
> +{
> +    uint64_t tmp =3D 0;

Initialization is not necessary. (output only register.)

> +
> +    asm volatile(
> +        "stctg      0,0,%0\n"
> +        "oi         6+%0, 0x8\n"

Isn't the commonly used syntax 6(%0)? (e.g. see consume_sclp_int )

(but then I think you would have to move tmp into an "r" instead).

Definitely not an expert :)

> +        "lctlg      0,0,%0"
> +        : : "Q" (tmp) : "memory"
> +    );
> +}
> +
> +static inline void disable_clock_int(void)
> +{
> +    uint64_t tmp =3D 0;

dito.

Wonder if some stctg/lctlg helpers would be better, than the
anding/oring can be done in c code.

> +
> +    asm volatile(
> +        "stctg      0,0,%0\n"
> +        "ni         6+%0, 0xf7\n"
> +        "lctlg      0,0,%0"
> +        : : "Q" (tmp) : "memory"
> +    );
> +}
> +
> +static inline void set_clock_comparator(uint64_t time)
> +{
> +    asm volatile("sckc %0" : : "Q" (time));
> +}
> +
> +static inline bool check_clock_int(void)
> +{
> +    uint16_t *code =3D (uint16_t *)0x86; /* low-core external interrup=
t code */
> +
> +    consume_sclp_int();

Can you add a comment like

/*
 * We either receive an sclp interrupt or a timer interrupt.
 */

However, I think this would be much cleaner if refactored into:

consume_sclp_int() -> consume_ext_int().

And move
- the "enable service interrupts in cr0" into a C function
  enable_sclp_int()
- the "disable service interrupts in cr0" into a C function
  disable_sclp_int()

void consume_sclp_int(void)
{
	enable_sclp_int();
	consume_ext_int();
	disable_sclp_int();
}

For existing code and for your function here e.g.

	enable_sclp_int();
	enable_clock_comparator_int();
	consume_ext_int();
	disable_clck_comparator_int();
	disable_sclp_int();

	return *code =3D=3D 0x1004;

> +
> +    return *code =3D=3D 0x1004;
> +}
> +
> +static int read_prompt(char *buf, size_t len)
> +{
> +    char inp[2] =3D {};
> +    uint8_t idx =3D 0;
> +    uint64_t time;
> +
> +    if (timeout) {
> +        time =3D get_clock() + (timeout * TOD_CLOCK_SECOND);
> +        set_clock_comparator(time);
> +        enable_clock_int();
> +        timeout =3D 0;
> +    }
> +
> +    while (!check_clock_int()) {
> +
> +        /* Process only one character at a time */
> +        sclp_read(inp, 1);
> +
> +        switch (inp[0]) {
> +        case KEYCODE_NO_INP:
> +        case KEYCODE_ESCAPE:
> +            continue;
> +        case KEYCODE_BACKSP:
> +            if (idx > 0) {
> +                buf[--idx] =3D 0;
> +                sclp_print("\b \b");
> +            }
> +            continue;
> +        case KEYCODE_ENTER:
> +            disable_clock_int();
> +            return idx;
> +        }
> +
> +        /* Echo input and add to buffer */
> +        if (idx < len) {
> +            buf[idx] =3D inp[0];
> +            sclp_print(inp);
> +            idx++;
> +        }
> +    }
> +
> +    disable_clock_int();
> +    *buf =3D 0;
> +
> +    return 0;
> +}
> +
> +static int get_index(void)
> +{
> +    char buf[10];
> +    int len;
> +    int i;
> +
> +    memset(buf, 0, sizeof(buf));
> +
> +    len =3D read_prompt(buf, sizeof(buf));
> +
> +    /* If no input, boot default */
> +    if (len =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    /* Check for erroneous input */
> +    for (i =3D 0; i < len; i++) {
> +        if (!isdigit(buf[i])) {
> +            return -1;
> +        }
> +    }
> +
> +    return atoi(buf);
> +}
> +
> +static void boot_menu_prompt(bool retry)
> +{
> +    char tmp[6];
> +
> +    if (retry) {
> +        sclp_print("\nError: undefined configuration"
> +                   "\nPlease choose:\n");
> +    } else if (timeout > 0) {
> +        sclp_print("Please choose (default will boot in ");
> +        sclp_print(itostr(timeout, tmp, sizeof(tmp)));
> +        sclp_print(" seconds):\n");
> +    } else {
> +        sclp_print("Please choose:\n");
> +    }
> +}
> +
>  static int get_boot_index(int entries)
>  {
> -    return 0; /* Implemented next patch */
> +    int boot_index;
> +    bool retry =3D false;
> +    char tmp[5];
> +
> +    do {
> +        boot_menu_prompt(retry);
> +        boot_index =3D get_index();
> +        retry =3D true;
> +    } while (boot_index < 0 || boot_index >=3D entries);
> +
> +    sclp_print("\nBooting entry #");
> +    sclp_print(itostr(boot_index, tmp, sizeof(tmp)));
> +
> +    return boot_index;
>  }
> =20
>  static void zipl_println(const char *data, size_t len)
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 25d4d21..df4bc88 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -71,6 +71,7 @@ unsigned int get_loadparm_index(void);
>  void sclp_print(const char *string);
>  void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
> +void sclp_read(char *str, size_t len);
> =20
>  /* virtio.c */
>  unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
> @@ -79,6 +80,7 @@ bool virtio_is_supported(SubChannelId schid);
>  void virtio_blk_setup_device(SubChannelId schid);
>  int virtio_read(ulong sector, void *load_addr);
>  int enable_mss_facility(void);
> +u64 get_clock(void);
>  ulong get_second(void);
> =20
>  /* bootmap.c */
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 486fce1..5e4a78b 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -101,3 +101,23 @@ void sclp_get_loadparm_ascii(char *loadparm)
>          ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
>      }
>  }
> +
> +void sclp_read(char *str, size_t len)
> +{
> +    ReadEventData *sccb =3D (void *)_sccb;
> +    char *buf =3D (char *)(&sccb->ebh) + 7;
> +
> +    /* Len should not exceed the maximum size of the event buffer */
> +    if (len > SCCB_SIZE - 8) {
> +        len =3D SCCB_SIZE - 8;
> +    }
> +
> +    sccb->h.length =3D SCCB_SIZE;
> +    sccb->h.function_code =3D SCLP_UNCONDITIONAL_READ;
> +    sccb->ebh.length =3D sizeof(EventBufferHeader);
> +    sccb->ebh.type =3D SCLP_EVENT_ASCII_CONSOLE_DATA;
> +    sccb->ebh.flags =3D 0;
> +
> +    sclp_service_call(SCLP_CMD_READ_EVENT_DATA, sccb);
> +    memcpy(str, buf, len);
> +}
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index c890a03..817e7f5 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -176,7 +176,7 @@ void vring_send_buf(VRing *vr, void *p, int len, in=
t flags)
>      }
>  }
> =20
> -static u64 get_clock(void)
> +u64 get_clock(void)
>  {
>      u64 r;
> =20
>=20


--=20

Thanks,

David / dhildenb
