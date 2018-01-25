Received: from eggs.gnu.org ([2001:4830:134:3::10]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eeeRk-0004EJ-BU
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eeeRf-00030P-8A
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:07:52 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-2-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0eee8b09-bcd6-9945-ae8c-1094a797f0b7@redhat.com>
Date: Thu, 25 Jan 2018 11:07:40 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/10] s390-ccw: refactor boot map table
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> - replace ScsiMbr in ECKD code with BootMapTable
> - fix read_block messages to reflect BMT
> - reduce ipl_scsi code with BMT struct
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 58 ++++++++++++++++----------------------=
--------
>  pc-bios/s390-ccw/bootmap.h |  9 ++++++-
>  2 files changed, 28 insertions(+), 39 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 67a6123..6b6c915 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -182,13 +182,13 @@ static block_number_t load_eckd_segments(block_nu=
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
> @@ -196,10 +196,10 @@ static void run_eckd_boot_script(block_number_t m=
br_block_nr)
>                 " maximum number of boot entries allowed");
> =20
>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> -    read_block(mbr_block_nr, sec, "Cannot read MBR");
> +    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
> =20
> -    block_nr =3D eckd_block_num((void *)&(bte->blockptr[loadparm]));
> -    IPL_assert(block_nr !=3D -1, "No Boot Map");
> +    block_nr =3D eckd_block_num((void *)&(bmt->bte[loadparm]));

Ok, I checked that sizeof(ScsiBlockPtr) =3D=3D sizeof(BootMapPointer), so
this should be fine.

But I think you can now remove the "(void *)". And while you're at it,
please also remove the superfluous parentheses:

    block_nr =3D eckd_block_num(&bmt->bte[loadparm]);

[...]
> @@ -449,10 +451,7 @@ static void zipl_run(ScsiBlockPtr *pte)
>  static void ipl_scsi(void)
>  {
>      ScsiMbr *mbr =3D (void *)sec;
> -    uint8_t *ns, *ns_end;
> -    int program_table_entries =3D 0;
> -    const int pte_len =3D sizeof(ScsiBlockPtr);
> -    ScsiBlockPtr *prog_table_entry =3D NULL;
> +    BootMapTable *bmt =3D (void *)sec;
>      unsigned int loadparm =3D get_loadparm_index();
> =20
>      /* Grab the MBR */
> @@ -467,34 +466,17 @@ static void ipl_scsi(void)
>      debug_print_int("MBR Version", mbr->version_id);
>      IPL_check(mbr->version_id =3D=3D 1,
>                "Unknown MBR layout version, assuming version 1");
> -    debug_print_int("program table", mbr->blockptr[0].blockno);
> -    IPL_assert(mbr->blockptr[0].blockno, "No Program Table");
> +    debug_print_int("program table", mbr->bmt.blockno);
> +    IPL_assert(mbr->bmt.blockno, "No Program Table");
> =20
>      /* Parse the program table */
> -    read_block(mbr->blockptr[0].blockno, sec,
> -               "Error reading Program Table");
> +    read_block(mbr->bmt.blockno, sec, "Error reading Program Table");
> =20
>      IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
> =20
>      debug_print_int("loadparm index", loadparm);
> -    ns_end =3D sec + virtio_get_block_size();
> -    for (ns =3D (sec + pte_len); (ns + pte_len) < ns_end; ns +=3D pte_=
len) {
> -        prog_table_entry =3D (ScsiBlockPtr *)ns;
> -        if (!prog_table_entry->blockno) {
> -            break;
> -        }
> -
> -        program_table_entries++;
> -        if (program_table_entries =3D=3D loadparm + 1) {
> -            break; /* selected entry found */
> -        }
> -    }
> -
> -    debug_print_int("program table entries", program_table_entries);
> -
> -    IPL_assert(program_table_entries !=3D 0, "Empty Program Table");

The new code looks much easier, indeed!

But is it OK that the "Empty Program Table" check is gone now? ... I
assume that zipl_run() will catch errors anyway, right?

 Thomas
