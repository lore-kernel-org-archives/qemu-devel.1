Received: from eggs.gnu.org ([2001:4830:134:3::10]:58369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiwBJ-0007PR-I4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 00:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiwBF-00028b-Hb
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 00:52:37 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-2-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fec28e66-4b6e-d448-9245-77583608dcf6@redhat.com>
Date: Tue, 6 Feb 2018 06:52:22 +0100
MIME-Version: 1.0
In-Reply-To: <1517864246-11101-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 01/12] s390-ccw: refactor
 boot map table code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 05.02.2018 21:57, Collin L. Walling wrote:
> - replace ScsiMbr in ECKD code with BootMapTable
> - fix read_block messages to reflect BMT
> - reduce ipl_scsi code with BMT struct
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
[...]
> @@ -449,10 +451,8 @@ static void zipl_run(ScsiBlockPtr *pte)
>  static void ipl_scsi(void)
>  {
>      ScsiMbr *mbr = (void *)sec;
> -    uint8_t *ns, *ns_end;
>      int program_table_entries = 0;
> -    const int pte_len = sizeof(ScsiBlockPtr);
> -    ScsiBlockPtr *prog_table_entry = NULL;
> +    BootMapTable *bmt = (void *)sec;
>      unsigned int loadparm = get_loadparm_index();
>  
>      /* Grab the MBR */
> @@ -467,34 +467,23 @@ static void ipl_scsi(void)
>      debug_print_int("MBR Version", mbr->version_id);
>      IPL_check(mbr->version_id == 1,
>                "Unknown MBR layout version, assuming version 1");
> -    debug_print_int("program table", mbr->blockptr[0].blockno);
> -    IPL_assert(mbr->blockptr[0].blockno, "No Program Table");
> +    debug_print_int("program table", mbr->bmt.blockno);
> +    IPL_assert(mbr->bmt.blockno, "No Program Table");
>  
>      /* Parse the program table */
> -    read_block(mbr->blockptr[0].blockno, sec,
> -               "Error reading Program Table");
> +    read_block(mbr->bmt.blockno, sec, "Error reading Program Table");
>  
>      IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
>  
>      debug_print_int("loadparm index", loadparm);
> -    ns_end = sec + virtio_get_block_size();
> -    for (ns = (sec + pte_len); (ns + pte_len) < ns_end; ns += pte_len) {
> -        prog_table_entry = (ScsiBlockPtr *)ns;
> -        if (!prog_table_entry->blockno) {
> -            break;
> -        }
>  
> +    while (bmt->bte[program_table_entries].scsi.blockno) {
>          program_table_entries++;

I think it might make sense to somehow limit this loop like it was done
for the original for-loop, so that in case the sector only contains
non-zero garbage you do not loop here forever.

> -        if (program_table_entries == loadparm + 1) {
> -            break; /* selected entry found */
> -        }
>      }
>  
>      debug_print_int("program table entries", program_table_entries);
>  
> -    IPL_assert(program_table_entries != 0, "Empty Program Table");

Don't want to keep the IPL_assert now that you've kept the
program_table_entries variable?

> -    zipl_run(prog_table_entry); /* no return */
> +    zipl_run(&bmt->bte[loadparm].scsi); /* no return */
>  }

 Thomas
