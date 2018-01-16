Received: from eggs.gnu.org ([2001:4830:134:3::10]:47145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQPr-0003Ly-BO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQPj-0002ij-Hw
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:32:35 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-3-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4d5caff2-335e-d936-5540-00ae755d55a9@redhat.com>
Date: Tue, 16 Jan 2018 13:32:14 +0100
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-3-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] s390-ccw: ipl structs for eckd
 cdl/ldl
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
> ECKD DASDs have different IPL structures for CDL and LDL
> formats. The current Ipl1 and Ipl2 structs follow the CDL
> format, so we prepend "EckdCdl" to them. Boot info for LDL
> has been moved to a new struct: EckdLdlIpl1.
> 
> Also introduce structs for IPL stages 1 and 1b and for
> disk geometry.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 29 +++++++++++++-----------
>  pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++-------------
>  2 files changed, 56 insertions(+), 28 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 6f8e30f..29915e4 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -221,9 +221,9 @@ static void run_eckd_boot_script(block_number_t mbr_block_nr)
>  static void ipl_eckd_cdl(void)
>  {
>      XEckdMbr *mbr;
> -    Ipl2 *ipl2 = (void *)sec;
> +    EckdCdlIpl2 *ipl2 = (void *)sec;
>      IplVolumeLabel *vlbl = (void *)sec;
> -    block_number_t block_nr;
> +    block_number_t mbr_block_nr;
>  
>      /* we have just read the block #0 and recognized it as "IPL1" */
>      sclp_print("CDL\n");
> @@ -231,16 +231,13 @@ static void ipl_eckd_cdl(void)
>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>      read_block(1, ipl2, "Cannot read IPL2 record at block 1");
>  
> -    mbr = &ipl2->u.x.mbr;
> +    mbr = &ipl2->mbr;
>      IPL_assert(magic_match(mbr, ZIPL_MAGIC), "No zIPL section in IPL2 record.");
>      IPL_assert(block_size_ok(mbr->blockptr.xeckd.bptr.size),
>                 "Bad block size in zIPL section of IPL2 record.");
>      IPL_assert(mbr->dev_type == DEV_TYPE_ECKD,
>                 "Non-ECKD device type in zIPL section of IPL2 record.");
>  
> -    /* save pointer to Boot Script */
> -    block_nr = eckd_block_num((void *)&(mbr->blockptr));
> -
>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>      read_block(2, vlbl, "Cannot read Volume Label at block 2");

Why did you move the block_nr = eckd_block_num(...) behind the
read_block() ? That sounds like you could different values here now. If
that has been done on purpose and is not a mistake, please add a proper
sentence about this to the patch description.

>      IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
> @@ -249,7 +246,10 @@ static void ipl_eckd_cdl(void)
>                 "Invalid magic of volser block");
>      print_volser(vlbl->f.volser);
>  
> -    run_eckd_boot_script(block_nr);
> +    /* save pointer to Boot Script */
> +    mbr_block_nr = eckd_block_num((void *)&mbr->blockptr);
> +
> +    run_eckd_boot_script(mbr_block_nr);
>      /* no return */
>  }
>  
> @@ -280,8 +280,8 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
>  
>  static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>  {
> -    block_number_t block_nr;
> -    BootInfo *bip = (void *)(sec + 0x70); /* BootInfo is MBR for LDL */
> +    block_number_t mbr_block_nr;
> +    EckdLdlIpl1 *ipl1 = (void *)sec;
>  
>      if (mode != ECKD_LDL_UNLABELED) {
>          print_eckd_ldl_msg(mode);
> @@ -292,15 +292,18 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>      read_block(0, sec, "Cannot read block 0 to grab boot info.");
>      if (mode == ECKD_LDL_UNLABELED) {
> -        if (!magic_match(bip->magic, ZIPL_MAGIC)) {
> +        if (!magic_match(ipl1->boot_info.magic, ZIPL_MAGIC)) {
>              return; /* not applicable layout */
>          }
>          sclp_print("unlabeled LDL.\n");
>      }
> -    verify_boot_info(bip);
> +    verify_boot_info(&ipl1->boot_info);
> +
> +    /* save pointer to Boot Script */
> +    mbr_block_nr =
> +        eckd_block_num((void *)&ipl1->boot_info.bp.ipl.bm_ptr.eckd.bptr);

Well, the original code fitted nicely in one line ... thus maybe better
keep the original variable name? (or use mbr_blk_nr or something similar
shorter?)

> -    block_nr = eckd_block_num((void *)&(bip->bp.ipl.bm_ptr.eckd.bptr));
> -    run_eckd_boot_script(block_nr);
> +    run_eckd_boot_script(mbr_block_nr);
>      /* no return */
>  }

 Thomas
