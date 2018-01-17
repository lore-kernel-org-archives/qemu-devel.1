Received: from eggs.gnu.org ([2001:4830:134:3::10]:36757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebkg5-0005eg-UV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebkg2-0006D0-OI
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:10:41 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-8-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <838deb2e-0750-83b4-1e1c-29a75577fd11@redhat.com>
Date: Wed, 17 Jan 2018 11:10:29 +0100
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-8-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/8] s390-ccw: interactive boot menu for
 eckd dasd (read input)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 15.01.2018 17:44, Collin L. Walling wrote:
> When the boot menu options are present and the guest's
> disk has been configured by the zipl tool, then the user
> will be presented with an interactive boot menu with
> labeled entries. An example of what the menu might look
> like:
>=20
> zIPL v1.37.1-build-20170714 interactive boot menu.
>=20
> 0. default (linux-4.13.0)
>=20
>   1. linux-4.13.0
>   2. performance
>   3. kvm
>=20
> Please choose (default will boot in 10 seconds):
>=20
> If the user's input is empty or 0, the default zipl entry will
> be chosen. If the input is within the range presented by the
> menu, then the selection will be booted. Any erroneous input
> will cancel the timeout and prompt the user until correct
> input is given.
>=20
> Any value set for loadparm will override all boot menu options.
> If loadparm=3DPROMPT, then the menu prompt will continuously wait
> until correct user input is given.
>=20
> The absence of any boot options on the command line will attempt
> to use the zipl loader values.
>=20
> --- Specific notes regarding this patch ---
>=20
> Implements an sclp_read function to capture input from the
> console, and a wrapper function in that handles parsing
> certain characters and adding input to a buffer. The input
> is checked for any erroneous values and is handled
> appropriately. A correct value will boot the respective
> boot menu entry.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c     | 160 ++++++++++++++++++++++++++++++++++++=
+++++++-
>  pc-bios/s390-ccw/s390-ccw.h |   2 +
>  pc-bios/s390-ccw/sclp.c     |  20 ++++++
>  pc-bios/s390-ccw/virtio.c   |   2 +-
>  4 files changed, 182 insertions(+), 2 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 30470b3..c219b7f 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -12,9 +12,167 @@
>  #include "menu.h"
>  #include "s390-ccw.h"
> =20
> +#define KEYCODE_NO_INP '\0'
> +#define KEYCODE_ESCAPE '\033'
> +#define KEYCODE_BACKSP '\177'
> +#define KEYCODE_ENTER  '\r'
> +
>  static uint8_t flags;
>  static uint64_t timeout;
> =20
> +static inline void enable_clock_int(void)
> +{
> +    uint64_t tmp =3D 0;
> +
> +    asm volatile(
> +        "stctg      0,0,%0\n"
> +        "oi         6+%0, 0x8\n"
> +        "lctlg      0,0,%0"
> +        : : "Q" (tmp) : "memory"
> +    );
> +}
> +
> +static inline void disable_clock_int(void)
> +{
> +    uint64_t tmp =3D 0;
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
> +    uint16_t *code =3D (uint16_t *)0x86;

Maybe add a comment at the end of the line saying that 0x86 is the
"External-Interruption Code" field in the low-core.

> +    consume_sclp_int();
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
> +        time =3D get_clock() + (timeout << 32);

Well, that looks like you're calculating with 1s =3D 1024 ms here. That's
likely ok for small timeouts ... but anyway, why not do it correct right
from the start to avoid confusion later? (Testers sometime really try
large timeouts to see whether the time is accurate)

By the way, just an idea, but I currently wonder whether using a
resolution of 1s for timeout is really the best idea. Some people might
also want to wait for half of seconds, for example ... so a resolution
of 0.1s might be a better choice for the timeout value in the IPL block?

> +        set_clock_comparator(time);
> +        enable_clock_int();
> +        timeout =3D 0;
> +    }
> +
> +    while (!check_clock_int()) {> +
> +        /* Process only one character at a time */
> +        sclp_read(inp, 1);
> +
> +        switch (inp[0]) {
> +        case KEYCODE_NO_INP:
> +        case KEYCODE_ESCAPE:
> +            continue;
> +        case KEYCODE_BACKSP:
> +            if (idx > 0) {
> +                /* Remove last character */
> +                buf[idx - 1] =3D ' ';
> +                sclp_print("\r");
> +                sclp_print(buf);
> +
> +                idx--;
> +
> +                /* Reset cursor */
> +                buf[idx] =3D 0;
> +                sclp_print("\r");
> +                sclp_print(buf);

Not sure, but I think you could simplify this whole block in the curly
braces to:

                buf[--idx] =3D 0;
                sclp_print("\b \b");

?

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
[...]
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

Likely not required for your patch, but let me ask anyway:
I'm not very familiar with the SCLP call, but isn't there a way to
detect the amount of bytes that really have been read? ... it might be
good to use that as return value for this function, so that the caller
has a way to see how many bytes are valid.

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

 Thomas
