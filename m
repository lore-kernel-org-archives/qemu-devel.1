Received: from eggs.gnu.org ([2001:4830:134:3::10]:45200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebjEo-00039k-25
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebjEk-0001yb-S5
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:38:26 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-6-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <315c794c-7e75-fd90-8327-b22847247983@redhat.com>
Date: Wed, 17 Jan 2018 09:38:11 +0100
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-6-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/8] s390-ccw: interactive boot menu for
 eckd dasd (read stage2 data)
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
> Read the stage2 boot loader data block-by-block. We scan the
> current block for the string "zIPL" to detect the start of the
> boot menu banner. We then load the adjacent blocks (previous
> block and next block) to account for the possibility of menu
> data spanning multiple blocks.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 112 +++++++++++++++++++++++++++++++++++++=
++++++--
>  pc-bios/s390-ccw/bootmap.h |   1 +
>  pc-bios/s390-ccw/menu.h    |  10 ++++
>  3 files changed, 118 insertions(+), 5 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 29915e4..fb8ff80 100644
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
> @@ -83,6 +84,10 @@ static void jump_to_IPL_code(uint64_t address)
> =20
>  static unsigned char _bprs[8*1024]; /* guessed "max" ECKD sector size =
*/
>  static const int max_bprs_entries =3D sizeof(_bprs) / sizeof(ExtEckdBl=
ockPtr);
> +static uint8_t _s2[MAX_SECTOR_SIZE * 4] __attribute__((__aligned__(PAG=
E_SIZE)));

If I get the code right, you only load three sectors (prev, cur and
next), aren't you? So "* 3" instead of "* 4" should be enough?

> +static void *s2_prev_blk =3D _s2;
> +static void *s2_cur_blk =3D _s2 + MAX_SECTOR_SIZE;
> +static void *s2_next_blk =3D _s2 + MAX_SECTOR_SIZE * 2;
> =20
>  static inline void verify_boot_info(BootInfo *bip)
>  {
> @@ -182,7 +187,94 @@ static block_number_t load_eckd_segments(block_num=
ber_t blk, uint64_t *address)
>      return block_nr;
>  }
> =20
> -static void run_eckd_boot_script(block_number_t mbr_block_nr)
> +static ZiplParms get_zipl_parms(int offset)
> +{
> +    ZiplParms zipl_parms =3D {
> +        .flag =3D *(uint16_t *)(s2_cur_blk + offset - ZIPL_FLAG_OFFSET=
),
> +        .timeout =3D *(uint16_t *)(s2_cur_blk + offset - ZIPL_TIMEOUT_=
OFFSET),
> +        .menu_start =3D offset,
> +    };
> +
> +    return zipl_parms;
> +}

Looks weird that you need a separate function (with 9 lines of code) for
just setting three values in a struct ... and since the function is also
only used once: Why don't you simply set the three values at the place
where you call this function below?

> +static bool find_zipl_boot_menu_banner(int *offset)
> +{
> +    int i;
> +
> +    /* Menu banner starts with "zIPL" */
> +    for (i =3D 0; i < virtio_get_block_size() - 4; i++) {
> +        if (magic_match(s2_cur_blk + i, ZIPL_MAGIC_EBCDIC)) {
> +            *offset =3D i;
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
> +{
> +    block_number_t cur_block_nr, prev_block_nr, next_block_nr;
> +    EckdStage1b *s1b =3D (void *)sec;
> +    ZiplParms zipl_parms;
> +    bool found =3D false;
> +    int offset;
> +    int i;
> +
> +    /* Get Stage1b data */
> +    memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> +    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader");
> +
> +    memset(_s2, FREE_SPACE_FILLER, sizeof(_s2));
> +
> +    /* Get Stage2 data */
> +    for (i =3D 0; i < STAGE2_BLK_CNT_MAX; i++) {
> +        cur_block_nr =3D eckd_block_num((void *)&s1b->seek[i].cyl);

Casting a subset of EckdSeekArg via a void* into a BootMapPointer is
quite ugly. Maybe you could refactor eckd_block_num() instead, e.g. like
this:

static block_number_t eckd_block_num_by_chs(uint64_t cylinder,
                                            uint64_t head, uint64_t sec)
{
    const uint64_t sectors =3D virtio_get_sectors();
    const uint64_t heads =3D virtio_get_heads();
    block_number_t block;

    cylinder =3D cylinder + ((head & 0xfff0) << 12);
    head =3D head & 0x000f;
    block =3D sectors * heads * cylinder
            + sectors * head + sec
            - 1; /* block nr starts with zero */

    return block;
}

static block_number_t eckd_block_num(BootMapPointer *p)
{
    const uint64_t sectors =3D virtio_get_sectors();
    const uint64_t heads =3D virtio_get_heads();
    const uint64_t cylinder =3D p->eckd.cylinder
                            + ((p->eckd.head & 0xfff0) << 12);
    const uint64_t head =3D p->eckd.head & 0x000f;
    const block_number_t block =3D sectors * heads * cylinder
                               + sectors * head
                               + p->eckd.sector
                               - 1; /* block nr starts with zero */
    return eckd_block_num_by_chs(p->eckd.cylinder, p->eckd.head,
                                 p->eckd.sector);
}

... and then use eckd_block_num_by_chs() here instead?

> +        if (!cur_block_nr) {
> +            break;
> +        }
> +
> +        read_block(cur_block_nr, s2_cur_blk, "Cannot read stage2 boot =
loader");
> +
> +        if (find_zipl_boot_menu_banner(&offset)) {
> +            /* Load the adjacent blocks to account for the
> +             * possibility of menu data spanning multiple blocks.
> +             */
> +            if (prev_block_nr) {

You did not pre-initialize prev_block_nr =3D 0 at the beginning of the
function. Do you feel confident enough that the first block never
contains the zipl banner? If not, please set prev_block_nr =3D 0 before
entering the for-loop.

> +                read_block(prev_block_nr, s2_prev_blk,
> +                           "Cannot read stage2 boot loader");
> +            }
> +
> +            if (i + 1 < STAGE2_BLK_CNT_MAX) {
> +                next_block_nr =3D eckd_block_num((void *)&s1b->seek[i =
+ 1].cyl);
> +            }
> +
> +            if (next_block_nr) {

Maybe also better set next_block_nr =3D 0 at the beginning of this functi=
on.

> +                read_block(next_block_nr, s2_next_blk,
> +                           "Cannot read stage2 boot loader");
> +            }
> +
> +            zipl_parms =3D get_zipl_parms(offset);
> +            found =3D true;
> +            break;
> +        }
> +
> +        prev_block_nr =3D cur_block_nr;
> +    }
> +
> +    if (!found) {
> +        sclp_print("No zipl boot menu data found. Booting default entr=
y.");
> +        return 0;
> +    }
> +
> +    zipl_parms.menu_start++; /* make compiler happy -- does nothing vi=
tal */

<nit>
It's always nicer to avoid introducing code that you've got to remove
right in the next patch. You could rather add a

int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms)
{
    /* implemented in the next patch */
}

to menu.c in this patch already, so you can already call it here and
don't have to modify eckd_get_boot_menu_index() again in the next patch.
</nit>

> +    return 0; /* implemented next patch */
> +}
> +
> +static void run_eckd_boot_script(block_number_t mbr_block_nr,
> +                                 block_number_t s1b_block_nr)
>  {
>      int i;
>      unsigned int loadparm =3D get_loadparm_index();
> @@ -191,6 +283,10 @@ static void run_eckd_boot_script(block_number_t mb=
r_block_nr)
>      ScsiMbr *bte =3D (void *)sec; /* Eckd bootmap table entry */
>      BootMapScript *bms =3D (void *)sec;
> =20
> +    if (menu_check_flags(BOOT_MENU_FLAG_BOOT_OPTS | BOOT_MENU_FLAG_ZIP=
L_OPTS)) {
> +        loadparm =3D eckd_get_boot_menu_index(s1b_block_nr);
> +    }
> +
>      debug_print_int("loadparm", loadparm);
>      IPL_assert(loadparm < 31, "loadparm value greater than"
>                 " maximum number of boot entries allowed");
> @@ -223,7 +319,7 @@ static void ipl_eckd_cdl(void)
>      XEckdMbr *mbr;
>      EckdCdlIpl2 *ipl2 =3D (void *)sec;
>      IplVolumeLabel *vlbl =3D (void *)sec;
> -    block_number_t mbr_block_nr;
> +    block_number_t mbr_block_nr, s1b_block_nr;
> =20
>      /* we have just read the block #0 and recognized it as "IPL1" */
>      sclp_print("CDL\n");
> @@ -249,7 +345,10 @@ static void ipl_eckd_cdl(void)
>      /* save pointer to Boot Script */
>      mbr_block_nr =3D eckd_block_num((void *)&mbr->blockptr);
> =20
> -    run_eckd_boot_script(mbr_block_nr);
> +    /* save pointer to Stage1b Data */
> +    s1b_block_nr =3D eckd_block_num((void *)&ipl2->stage1.seek[0].cyl)=
;

That could use eckd_block_num_by_chs(), too.

> +    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
>      /* no return */
>  }
> =20
> @@ -280,7 +379,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode=
)
> =20
>  static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>  {
> -    block_number_t mbr_block_nr;
> +    block_number_t mbr_block_nr, s1b_block_nr;
>      EckdLdlIpl1 *ipl1 =3D (void *)sec;
> =20
>      if (mode !=3D ECKD_LDL_UNLABELED) {
> @@ -303,7 +402,10 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>      mbr_block_nr =3D
>          eckd_block_num((void *)&ipl1->boot_info.bp.ipl.bm_ptr.eckd.bpt=
r);
> =20
> -    run_eckd_boot_script(mbr_block_nr);
> +    /* save pointer to Stage1b Data */
> +    s1b_block_nr =3D eckd_block_num((void *)&ipl1->stage1.seek[0].cyl)=
;

dito.

> +    run_eckd_boot_script(mbr_block_nr, s1b_block_nr);
>      /* no return */
>  }
> =20
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index df956f2..56445f2 100644
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
> diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
> index 04b1db1..3a8a487 100644
> --- a/pc-bios/s390-ccw/menu.h
> +++ b/pc-bios/s390-ccw/menu.h
> @@ -17,6 +17,16 @@
>  #define BOOT_MENU_FLAG_BOOT_OPTS 0x80
>  #define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
> =20
> +/* Offsets from zipl fields to zipl banner start */
> +#define ZIPL_TIMEOUT_OFFSET 138
> +#define ZIPL_FLAG_OFFSET    140
> +
> +typedef struct ZiplParms {
> +    uint16_t flag;
> +    uint16_t timeout;
> +    uint64_t menu_start;
> +} ZiplParms;
> +
>  void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeou=
t);
>  bool menu_check_flags(uint8_t check_flags);

 Thomas
