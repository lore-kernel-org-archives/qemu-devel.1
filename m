Received: from eggs.gnu.org ([2001:4830:134:3::10]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQvhp-0000mp-1y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQvhk-0001or-Ts
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:43:45 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-5-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6c16c1e9-94bb-30bc-55ad-a486f282b679@redhat.com>
Date: Mon, 18 Dec 2017 14:43:32 +0100
MIME-Version: 1.0
In-Reply-To: <1513030760-26245-5-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] s390-ccw: interactive boot menu for
 eckd dasd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 11.12.2017 23:19, Collin L. Walling wrote:
> When the boot menu options are present and the guest's
> disk has been configured by the zipl tool, then the user
> will be presented with an interactive boot menu with
> labeled entries. An example of what the menu might look
> like:
>=20
>     zIPL v1.37.1-build-20170714 interactive boot menu.
>=20
>      0. default (linux-4.13.0)
>=20
>      1. linux-4.13.0
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
> The absence of any boot options on the command line will attempt
> to use the zipl loader values.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
[...]
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 5546b79..c817cf8 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -13,6 +13,7 @@
>  #include "bootmap.h"
>  #include "virtio.h"
>  #include "bswap.h"
> +#include "menu.h"
> =20
>  #ifdef DEBUG
>  /* #define DEBUG_FALLBACK */
> @@ -83,6 +84,7 @@ static void jump_to_IPL_code(uint64_t address)
> =20
>  static unsigned char _bprs[8*1024]; /* guessed "max" ECKD sector size =
*/
>  static const int max_bprs_entries =3D sizeof(_bprs) / sizeof(ExtEckdBl=
ockPtr);
> +static uint8_t stage2[STAGE2_MAX_SIZE] __attribute__((__aligned__(PAGE=
_SIZE)));
> =20
>  static inline void verify_boot_info(BootInfo *bip)
>  {
> @@ -182,7 +184,57 @@ static block_number_t load_eckd_segments(block_num=
ber_t blk, uint64_t *address)
>      return block_nr;
>  }
> =20
> -static void run_eckd_boot_script(block_number_t mbr_block_nr)
> +static void read_stage2(block_number_t s1b_block_nr)
> +{
> +    block_number_t s2_block_nr;
> +    EckdStage1b *s1b =3D (void *)sec;
> +    int i;
> +
> +    /* Get Stage1b data */
> +    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> +    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader.");
> +
> +    /* Get Stage2 data */
> +    memset(stage2, FREE_SPACE_FILLER, sizeof(stage2));
> +
> +    for (i =3D 0; i < STAGE2_MAX_SIZE / MAX_SECTOR_SIZE; i++) {
> +        s2_block_nr =3D eckd_block_num((void *)&(s1b->seek[i].cyl));

You can omit the parentheses around s1b->seek[i].cyl.

> +        if (!s2_block_nr) {
> +            break;
> +        }
> +
> +        read_block(s2_block_nr, (stage2 + MAX_SECTOR_SIZE * i),

You can omit the parentheses around the second parameter.

> +                   "Error reading Stage2 data");
> +    }
> +}
[...]
> @@ -241,6 +300,9 @@ static void ipl_eckd_cdl(void)
>      /* save pointer to Boot Script */
>      mbr_block_nr =3D eckd_block_num((void *)&(mbr->blockptr));
> =20
> +    /* save pointer to Stage1b Data */
> +    s1b_block_nr =3D eckd_block_num((void *)&(ipl2->stage1.seek[0].cyl=
));

You can omit the parentheses around ipl2->stage1.seek[0].cyl.

>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>      read_block(2, vlbl, "Cannot read Volume Label at block 2");
>      IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
> @@ -249,7 +311,7 @@ static void ipl_eckd_cdl(void)
>                 "Invalid magic of volser block");
>      print_volser(vlbl->f.volser);
> =20
> -    run_eckd_boot_script(mbr_block_nr);
> +    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
>      /* no return */
>  }
> =20
> @@ -281,6 +343,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode=
)
>  static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>  {
>      block_number_t mbr_block_nr;
> +    block_number_t s1b_block_nr;
>      EckdLdlIpl1 *ipl1 =3D (void *)sec;
> =20
>      if (mode !=3D ECKD_LDL_UNLABELED) {
> @@ -302,7 +365,9 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>      mbr_block_nr =3D
>          eckd_block_num((void *)&(ipl1->boot_info.bp.ipl.bm_ptr.eckd.bp=
tr));
> =20
> -    run_eckd_boot_script(mbr_block_nr);
> +    s1b_block_nr =3D eckd_block_num((void *)&(ipl1->stage1.seek[0].cyl=
));

dito.

> +    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
>      /* no return */
>  }
> =20
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index b700d08..8089402 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -74,6 +74,7 @@ typedef struct ScsiMbr {
>  } __attribute__ ((packed)) ScsiMbr;
> =20
>  #define ZIPL_MAGIC              "zIPL"
> +#define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
>  #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* =3D=3D "IPL1" in EBCDIC */
>  #define IPL2_MAGIC "\xc9\xd7\xd3\xf2" /* =3D=3D "IPL2" in EBCDIC */
>  #define VOL1_MAGIC "\xe5\xd6\xd3\xf1" /* =3D=3D "VOL1" in EBCDIC */
> @@ -229,6 +230,7 @@ typedef struct BootInfo {          /* @ 0x70, recor=
d #0    */
>  /*
>   * Structs for IPL
>   */
> +#define STAGE2_MAX_SIZE     0x3000
>  #define STAGE2_BLK_CNT_MAX  24 /* Stage 1b can load up to 24 blocks */
> =20
>  typedef struct EckdCdlIpl1 {
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a8ef120..fb0ef92 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -11,6 +11,7 @@
>  #include "libc.h"
>  #include "s390-ccw.h"
>  #include "virtio.h"
> +#include "menu.h"
> =20
>  char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>  static SubChannelId blk_schid =3D { .one =3D 1 };
> @@ -101,6 +102,8 @@ static void virtio_setup(void)
>              blk_schid.ssid =3D iplb.ccw.ssid & 0x3;
>              debug_print_int("ssid ", blk_schid.ssid);
>              found =3D find_dev(&schib, dev_no);
> +            menu_set_parms(iplb.ccw.boot_menu_flags,
> +                           iplb.ccw.boot_menu_timeout);
>              break;
>          case S390_IPL_TYPE_QEMU_SCSI:
>              vdev->scsi_device_selected =3D true;
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> new file mode 100644
> index 0000000..d707afb
> --- /dev/null
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -0,0 +1,223 @@
> +/*
> + * QEMU S390 Interactive Boot Menu
> + *
> + * Copyright 2017 IBM Corp.
> + * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +
> +#include "libc.h"
> +#include "s390-ccw.h"
> +#include "menu.h"
> +
> +#define KEYCODE_NO_INP '\0'
> +#define KEYCODE_ESCAPE '\033'
> +#define KEYCODE_BACKSP '\177'
> +#define KEYCODE_ENTER  '\r'
> +
> +static uint8_t flags;
> +static uint64_t timeout;
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

Did you check whether we need "memory" in the clobber list here?

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
> +    uint16_t code =3D *(uint16_t *)0x86;
> +
> +    consume_sclp_int();

Don't you rather have to read the code from memory *after* calling
consume_sclp_int() ?

> +    return code =3D=3D 0x1004;
> +}
> +
> +static int read_prompt(char *buf, size_t len)
> +{
> +    char inp[2];
> +    uint8_t idx =3D 0;
> +    uint64_t time;
> +
> +    if (timeout) {
> +        time =3D get_clock() + (timeout << 32);
> +        set_clock_comparator(time);
> +        enable_clock_int();
> +    }
> +
> +    inp[1] =3D '\0';

I think I'd rather declare "char inp[2] =3D {}", just to make sure that
inp[0] is also correctly pre-initialized - so that in case anything goes
wrong with sclp_read() below, we can be sure that there is not random
data in inp[0].

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
> +    *buf =3D NULL;

Hmm, I'm used to see NULL only as a pointer, so "*buf =3D 0" would IMHO b=
e
nicer here?

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

I think you should rather use "sizeof(buf) - 1" here to make sure that
the string is always terminated with a 0?

> +    if (len =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    for (i =3D 0; i < len; i++) {
> +        if (!isdigit(buf[i])) {
> +            return -1;
> +        }
> +    }
> +
> +    return atoi(buf);
> +}

 Thomas
