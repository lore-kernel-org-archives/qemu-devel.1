Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJf82-0007px-RY
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJf7z-0000u9-LQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:36:46 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-5-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d007f7af-f15e-105c-7859-13b7141cf260@redhat.com>
Date: Tue, 28 Nov 2017 13:36:38 +0100
MIME-Version: 1.0
In-Reply-To: <1511816136-30068-5-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 4/5] s390-ccw: interactive
 boot menu for eckd dasd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 27.11.2017 21:55, Collin L. Walling wrote:
> When the boot menu options are present and the guest's
> disk has been configured by the zipl tool, then the user
> will be presented with an interactive boot menu with
> labeled entries. An example of what the menu might look
> like:
>=20
>     zIPL v1.37.1-build-20170714 interactive boot menu.
>=20
>      0. default (default)
>=20
>      1. default
>      2. performance
>      3. kvm
>=20
>     Please choose (default will boot in 10 seconds):
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
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile   |   2 +-
>  pc-bios/s390-ccw/bootmap.c  |  77 +++++++++++++++++++++++++-
>  pc-bios/s390-ccw/bootmap.h  |   2 +
>  pc-bios/s390-ccw/main.c     |  18 +++++-
>  pc-bios/s390-ccw/menu.c     | 108 ++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/s390-ccw.h |   6 ++
>  pc-bios/s390-ccw/sclp.c     | 132 ++++++++++++++++++++++++++++++++++++=
++++++++
>  7 files changed, 340 insertions(+), 5 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/menu.c
>=20
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 6d0c2ee..f03096b 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
> =20
>  .PHONY : all clean build-all
> =20
> -OBJECTS =3D start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o vir=
tio-blkdev.o
> +OBJECTS =3D start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o vir=
tio-blkdev.o menu.o
>  QEMU_CFLAGS :=3D $(filter -W%, $(QEMU_CFLAGS))
>  QEMU_CFLAGS +=3D -ffreestanding -fno-delete-null-pointer-checks -msoft=
-float
>  QEMU_CFLAGS +=3D -march=3Dz900 -fPIE -fno-strict-aliasing
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 5546b79..3aea6e0 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -28,6 +28,7 @@
> =20
>  /* Scratch space */
>  static uint8_t sec[MAX_SECTOR_SIZE*4] __attribute__((__aligned__(PAGE_=
SIZE)));
> +static uint8_t s2_area[STAGE2_MAX_SIZE] __attribute__((__aligned__(PAG=
E_SIZE)));
> =20
>  typedef struct ResetInfo {
>      uint32_t ipl_mask;
> @@ -182,7 +183,66 @@ static block_number_t load_eckd_segments(block_num=
ber_t blk, uint64_t *address)
>      return block_nr;
>  }
> =20
> -static void run_eckd_boot_script(block_number_t mbr_block_nr)
> +static block_number_t chs(const BootEckdSeekarg seek)
> +{
> +    /* we cannot have a sector of 0 */
> +    if (seek.sec =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    const uint64_t sectors =3D virtio_get_sectors();
> +    const uint64_t heads =3D virtio_get_heads();
> +
> +    return (seek.cyl * heads + seek.head) * sectors + (seek.sec - 1);
> +}

Could you please rename that function so that it has a more descriptive
name? Or put a proper comment in front of it so that it is clear what it
is supposed to do? Just reading "chs()" is really not self-explaining
code... :-(

> +static void read_stage2(block_number_t s1b_block_nr, void **stage2_dat=
a)
> +{
> +    block_number_t s2_block_nr;
> +    BootEckdStage1b *s1b =3D (void *)sec;
> +    int i;
> +
> +    /* Get Stage1b data */
> +    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> +    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader.");
> +
> +    /* Get Stage2 data */
> +    *stage2_data =3D (void *)s2_area;

I think you could also simply "return s2_area" at the end of the
function instead of using a pointer-to-a-pointer as parameter of the
function.

> +    memset(s2_area, FREE_SPACE_FILLER, sizeof(s2_area));
> +
> +    for (i =3D 0; i < STAGE2_MAX_SIZE / MAX_SECTOR_SIZE; i++) {
> +        s2_block_nr =3D chs(s1b->seek[i]);
> +        if (!s2_block_nr) {
> +            break;
> +        }
> +        read_block(s2_block_nr, (*stage2_data + MAX_SECTOR_SIZE * i),
> +                   "Error reading Stage2 data");
> +    }
> +}
> +
> +static int zipl_boot_menu(block_number_t s1b_block_nr)
> +{
> +    void *stage2_data, *menu_offset;
> +
> +    read_stage2(s1b_block_nr, &stage2_data);
> +    menu_offset =3D stage2_data;
> +
> +    /* Menu banner starts with "zIPL" */
> +    while (menu_offset < stage2_data + STAGE2_MAX_SIZE - 4) {
> +        if (magic_match(menu_offset, ZIPL_MAGIC_EBCDIC)) {
> +            return menu_get_zipl_boot_index(menu_offset);
> +        }
> +        menu_offset++;
> +    }
> +
> +    panic("\n! No menu data found !\n");

Maybe remove the initial exclamation mark?

> +    /* should not reach here */
> +    return 0;
> +}
[...]
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a8ef120..fd2b16f 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -12,6 +12,9 @@
>  #include "s390-ccw.h"
>  #include "virtio.h"
> =20
> +#define LOADPARM_EMPTY  "........"
> +#define LOADPARM_PROMPT "PROMPT  "
> +
>  char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>  static SubChannelId blk_schid =3D { .one =3D 1 };
>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> @@ -73,6 +76,16 @@ static bool find_dev(Schib *schib, int dev_no)
>      return false;
>  }
> =20
> +static void set_boot_menu(uint8_t boot_menu_enabled,
> +                          uint16_t boot_menu_timeout)
> +{
> +    if (memcmp(loadparm, LOADPARM_EMPTY, 8) =3D=3D 0 && boot_menu_enab=
led) {
> +        menu_enable(boot_menu_timeout);
> +    } else if (memcmp(loadparm, LOADPARM_PROMPT, 8) =3D=3D 0) {
> +        menu_enable(0);
> +    }
> +}
> +
>  static void virtio_setup(void)
>  {
>      Schib schib;
> @@ -101,6 +114,8 @@ static void virtio_setup(void)
>              blk_schid.ssid =3D iplb.ccw.ssid & 0x3;
>              debug_print_int("ssid ", blk_schid.ssid);
>              found =3D find_dev(&schib, dev_no);
> +            set_boot_menu(iplb.ccw.boot_menu_enabled,
> +                          iplb.ccw.boot_menu_timeout);
>              break;
>          case S390_IPL_TYPE_QEMU_SCSI:
>              vdev->scsi_device_selected =3D true;
> @@ -109,6 +124,8 @@ static void virtio_setup(void)
>              vdev->selected_scsi_device.lun =3D iplb.scsi.lun;
>              blk_schid.ssid =3D iplb.scsi.ssid & 0x3;
>              found =3D find_dev(&schib, iplb.scsi.devno);
> +            set_boot_menu(iplb.scsi.boot_menu_enabled,
> +                          iplb.scsi.boot_menu_timeout);
>              break;
>          default:
>              panic("List-directed IPL not supported yet!\n");
> @@ -122,7 +139,6 @@ static void virtio_setup(void)
>              }
>          }
>      }
> -

Unrelated white-space change.

>      IPL_assert(found, "No virtio device found");
> =20
>      if (virtio_get_device_type() =3D=3D VIRTIO_ID_NET) {
[...]
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 486fce1..af64743 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -12,6 +12,11 @@
>  #include "s390-ccw.h"
>  #include "sclp.h"
> =20
> +#define KEYCODE_NO_INP '\0'
> +#define KEYCODE_ARROWS '\033'

That's not only used for the cursor keys, but also for all other escape
sequences, so maybe rename that to KEYCODE_ESC ?

> +#define KEYCODE_BACKSP '\177'
> +#define KEYCODE_ENTER  '\r'
> +
>  long write(int fd, const void *str, size_t len);
> =20
>  static char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
> @@ -101,3 +106,130 @@ void sclp_get_loadparm_ascii(char *loadparm)
>          ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
>      }
>  }
> +
> +static void read(char **str)

Please avoid using names from the standard C-library, unless the
function is supposed to do the same (as the write() function here).

> +{
> +    ReadEventData *sccb =3D (void *)_sccb;
> +    *str =3D (char *)(&sccb->ebh) + 7;
> +
> +    sccb->h.length =3D SCCB_SIZE;
> +    sccb->h.function_code =3D SCLP_UNCONDITIONAL_READ;
> +    sccb->ebh.length =3D sizeof(EventBufferHeader);
> +    sccb->ebh.type =3D SCLP_EVENT_ASCII_CONSOLE_DATA;
> +    sccb->ebh.flags =3D 0;
> +
> +    sclp_service_call(SCLP_CMD_READ_EVENT_DATA, sccb);
> +}
> +
> +static inline void enable_clock_int(void)
> +{
> +    uint64_t tmp =3D 0;
> +
> +    asm volatile(
> +        "stctg      0,0,%0\n"
> +        "oi         6+%0, 0x8\n"
> +        "lctlg      0,0,%0"
> +        : : "Q" (tmp)

Not sure, but I think I'd be better to add "memory" to the clobber list
... otherwise, GCC might assume that the memory for "tmp" is 0
afterwards and do some wrong optimizations for code that follows...

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
> +        : : "Q" (tmp)

dito

> +    );
> +}
> +
> +static inline bool check_clock_int(void)
> +{
> +    uint16_t code;
> +
> +    consume_sclp_int();
> +
> +    asm volatile(
> +        "lh         1, 0x86(0,0)\n"
> +        "sth        1, %0"
> +        : "=3Dr" (code)
> +    );

That way, you need r1 in the clobber list. But why don't you simply use
only "lh %0,0x86(0,0)\n" instead? Or simply do it without assembly:

 code =3D *(volatile uint16_t *)0x86;

?

> +
> +    return code =3D=3D 0x1004;
> +}
> +
> +static inline void set_clock_comparator(uint64_t time)
> +{
> +    asm volatile("sckc %0" : : "Q" (time));

Needs "memory" in the clobber list, I think.

> +}
> +
> +/* sclp_read
> + *
> + * Reads user input from the sclp console into a buffer. The buffer
> + * is set and the length is returned only if the enter key was detecte=
d.
> + *
> + * @param buf_ptr - a pointer to the buffer
> + *
> + * @param timeout - time (in milliseconds) to wait before abruptly
> + *                  ending user-input read loop. if 0, then loop
> + *                  until an enter key is detected
> + *
> + * @return - the length of the data in the buffer
> + */
> +int sclp_read(char **buf_ptr, uint64_t timeout)
> +{
> +    char *inp =3D NULL;
> +    char buf[255];
> +    uint8_t len =3D 0;
> +    uint64_t seconds;
> +
> +    memset(buf, 0, sizeof(buf));
> +
> +    if (timeout) {
> +        seconds =3D get_second() + timeout / 1000;
> +        set_clock_comparator((seconds * 1000000) << 12);
> +        enable_clock_int();
> +    }
> +
> +    while (!check_clock_int()) {
> +        read(&inp);
> +
> +        switch (inp[0]) {
> +        case KEYCODE_NO_INP:
> +        case KEYCODE_ARROWS:
> +            continue;
> +        case KEYCODE_BACKSP:
> +            if (len > 0) {
> +                len--;
> +
> +                /* Remove last character */
> +                buf[len] =3D ' ';
> +                write(1, "\r", 1);
> +                write(1, buf, len + 1);
> +
> +                /* Reset cursor */
> +                buf[len] =3D 0;
> +                write(1, "\r", 1);
> +                write(1, buf, len);
> +            }
> +            continue;
> +        case KEYCODE_ENTER:
> +            disable_clock_int();
> +
> +            *buf_ptr =3D buf;

So you're returning a pointer to a function-local variable on the stack
here? Sorry, no, that can only work by accident. Please move the buffer
array to the caller and pass in the pointer to the buffer and its length
to this function here.

> +            return len;
> +        }
> +
> +        /* Echo input and add to buffer */
> +        if (len < sizeof(buf)) {
> +            buf[len] =3D inp[0];
> +            len++;
> +            write(1, inp, 1);
> +        }
> +    }
> +
> +    disable_clock_int();
> +    return 0;
> +}
>=20

 Thomas
