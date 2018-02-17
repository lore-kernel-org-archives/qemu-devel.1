Received: from eggs.gnu.org ([2001:4830:134:3::10]:55097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emwo5-0007Ji-00
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 02:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emwo1-0007Hy-Rf
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 02:21:12 -0500
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-2-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8ba5f5d8-09dc-8d2d-be8d-9ac0501409ca@redhat.com>
Date: Sat, 17 Feb 2018 08:20:47 +0100
MIME-Version: 1.0
In-Reply-To: <1518818879-18608-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 01/12] s390-ccw: refactor boot map table
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

On 16.02.2018 23:07, Collin L. Walling wrote:
> Some ECKD bootmap code was using structs designed for SCSI.
> Even though this works, it confuses readability. Add a new
> BootMapTable struct to assist with readability in bootmap
> entry code. Also:
>=20
> - replace ScsiMbr in ECKD code with appropriate structs
> - fix read_block messages to reflect BootMapTable
> - fixup ipl_scsi to use BootMapTable (referred to as Program Table)
> - defined value for maximum table entries
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 60 +++++++++++++++++++++-----------------=
--------
>  pc-bios/s390-ccw/bootmap.h | 11 ++++++++-
>  2 files changed, 37 insertions(+), 34 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 67a6123..286de40 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -182,24 +182,24 @@ static block_number_t load_eckd_segments(block_nu=
mber_t blk, uint64_t *address)
>      return block_nr;
>  }
> =20
> -static void run_eckd_boot_script(block_number_t mbr_block_nr)
> +static void run_eckd_boot_script(block_number_t bmt_block_nr)
>  {
>      int i;
>      unsigned int loadparm =3D get_loadparm_index();
>      block_number_t block_nr;
>      uint64_t address;
> -    ScsiMbr *bte =3D (void *)sec; /* Eckd bootmap table entry */
> +    BootMapTable *bmt =3D (void *)sec;
>      BootMapScript *bms =3D (void *)sec;
> =20
>      debug_print_int("loadparm", loadparm);
> -    IPL_assert(loadparm < 31, "loadparm value greater than"
> +    IPL_assert(loadparm <=3D MAX_TABLE_ENTRIES, "loadparm value greate=
r than"
>                 " maximum number of boot entries allowed");
> =20
>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -    read_block(mbr_block_nr, sec, "Cannot read MBR");
> +    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
> =20
> -    block_nr =3D eckd_block_num((void *)&(bte->blockptr[loadparm]));
> -    IPL_assert(block_nr !=3D -1, "No Boot Map");
> +    block_nr =3D eckd_block_num((void *)&bmt->entry[loadparm]);

I think you could drop the "(void *)" cast here now.

> +    IPL_assert(block_nr !=3D -1, "Cannot find Boot Map Table Entry");
> =20
>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>      read_block(block_nr, sec, "Cannot read Boot Map Script");
> @@ -223,7 +223,7 @@ static void ipl_eckd_cdl(void)
>      XEckdMbr *mbr;
>      Ipl2 *ipl2 =3D (void *)sec;
>      IplVolumeLabel *vlbl =3D (void *)sec;
> -    block_number_t block_nr;
> +    block_number_t bmt_block_nr;
> =20
>      /* we have just read the block #0 and recognized it as "IPL1" */
>      sclp_print("CDL\n");
> @@ -238,8 +238,8 @@ static void ipl_eckd_cdl(void)
>      IPL_assert(mbr->dev_type =3D=3D DEV_TYPE_ECKD,
>                 "Non-ECKD device type in zIPL section of IPL2 record.")=
;
> =20
> -    /* save pointer to Boot Script */
> -    block_nr =3D eckd_block_num((void *)&(mbr->blockptr));
> +    /* save pointer to Boot Map Table */
> +    bmt_block_nr =3D eckd_block_num((void *)&mbr->blockptr);

dito, (void *) should not be needed here.

But apart from those two nits, the patch looks fine to me now, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
