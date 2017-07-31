Received: from eggs.gnu.org ([2001:4830:134:3::10]:55983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcFbM-0000fX-H7
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcFbJ-000157-BO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcFbJ-00013l-0M
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:39:33 -0400
Date: Mon, 31 Jul 2017 19:39:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170731183923.GI2122@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-8-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-8-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 07/29] migration: better error handling with
 QEMUFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> If the postcopy down due to some reason, we can always see this on dst:
> 
>   qemu-system-x86_64: RP: Received invalid message 0x0000 length 0x0000
> 
> However in most cases that's not the real issue. The problem is that
> qemu_get_be16() has no way to show whether the returned data is valid or
> not, and we are _always_ assuming it is valid. That's possibly not wise.
> 
> The best approach to solve this would be: refactoring QEMUFile interface
> to allow the APIs to return error if there is. However it needs quite a
> bit of work and testing. For now, let's explicitly check the validity
> first before using the data in all places for qemu_get_*().
> 
> This patch tries to fix most of the cases I can see. Only if we are with
> this, can we make sure we are processing the valid data, and also can we
> make sure we can capture the channel down events correctly.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c |  5 +++++
>  migration/ram.c       | 22 ++++++++++++++++++----
>  migration/savevm.c    | 29 +++++++++++++++++++++++++++--
>  3 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index bdc4445..5b2602e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1543,6 +1543,11 @@ static void *source_return_path_thread(void *opaque)
>          header_type = qemu_get_be16(rp);
>          header_len = qemu_get_be16(rp);
>  
> +        if (qemu_file_get_error(rp)) {
> +            mark_source_rp_bad(ms);
> +            goto out;
> +        }
> +
>          if (header_type >= MIG_RP_MSG_MAX ||
>              header_type == MIG_RP_MSG_INVALID) {
>              error_report("RP: Received invalid message 0x%04x length 0x%04x",
> diff --git a/migration/ram.c b/migration/ram.c
> index c12358d..7f4cb0f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2416,7 +2416,7 @@ static int ram_load_postcopy(QEMUFile *f)
>      void *last_host = NULL;
>      bool all_zero = false;
>  
> -    while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> +    while (!(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr;
>          void *host = NULL;
>          void *page_buffer = NULL;
> @@ -2425,6 +2425,16 @@ static int ram_load_postcopy(QEMUFile *f)
>          uint8_t ch;
>  
>          addr = qemu_get_be64(f);
> +
> +        /*
> +         * If qemu file error, we should stop here, and then "addr"
> +         * may be invalid
> +         */
> +        if (qemu_file_get_error(f)) {
> +            ret = qemu_file_get_error(f);
> +            break;
> +        }

I'd prefer:
    ret = qemu_file_get_error(f);
    if (ret) {
        break;
    }


> +
>          flags = addr & ~TARGET_PAGE_MASK;
>          addr &= TARGET_PAGE_MASK;
>  
> @@ -2505,6 +2515,13 @@ static int ram_load_postcopy(QEMUFile *f)
>              error_report("Unknown combination of migration flags: %#x"
>                           " (postcopy mode)", flags);
>              ret = -EINVAL;
> +            break;
> +        }
> +
> +        /* Detect for any possible file errors */
> +        if (qemu_file_get_error(f)) {
> +            ret = qemu_file_get_error(f);
> +            break;
>          }
>  
>          if (place_needed) {
> @@ -2519,9 +2536,6 @@ static int ram_load_postcopy(QEMUFile *f)
>                                            place_source, block);
>              }
>          }
> -        if (!ret) {
> -            ret = qemu_file_get_error(f);
> -        }

I think we've lost an error check here; the code before this does:
   ret = postcopy_place_page.....

and if that failed it used to be detected by the !ret check in the
while condition, but with that gone, we need to add a check for ret
after the place page.
      
>      }
>  
>      return ret;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fdd15fa..13ae9d6 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1720,6 +1720,11 @@ static int loadvm_process_command(QEMUFile *f)
>      cmd = qemu_get_be16(f);
>      len = qemu_get_be16(f);
>  
> +    /* Check validity before continue processing of cmds */
> +    if (qemu_file_get_error(f)) {
> +        return qemu_file_get_error(f);
> +    }
> +
>      trace_loadvm_process_command(cmd, len);
>      if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
>          error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> @@ -1855,6 +1860,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>          return -EINVAL;
>      }
>  
> +    /* Check validity before load the vmstate */
> +    if (qemu_file_get_error(f)) {
> +        return qemu_file_get_error(f);
> +    }
> +

Do you need a check after the instance_id/version_id read and in
check_section_footer?


>      ret = vmstate_load(f, se);
>      if (ret < 0) {
>          error_report("error while loading state for instance 0x%x of"
> @@ -1888,6 +1898,11 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>          return -EINVAL;
>      }
>  
> +    /* Check validity before load the vmstate */
> +    if (qemu_file_get_error(f)) {
> +        return qemu_file_get_error(f);
> +    }
> +

Similar question; do you need the check after the section_id =   read ?

>      ret = vmstate_load(f, se);
>      if (ret < 0) {
>          error_report("error while loading state section id %d(%s)",
> @@ -1944,8 +1959,14 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
>      uint8_t section_type;
>      int ret = 0;
>  
> -    while ((section_type = qemu_get_byte(f)) != QEMU_VM_EOF) {
> -        ret = 0;
> +    while (true) {
> +        section_type = qemu_get_byte(f);
> +
> +        if (qemu_file_get_error(f)) {
> +            ret = qemu_file_get_error(f);
> +            break;
> +        }
> +
>          trace_qemu_loadvm_state_section(section_type);
>          switch (section_type) {
>          case QEMU_VM_SECTION_START:
> @@ -1969,6 +1990,10 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
>                  goto out;
>              }
>              break;
> +        case QEMU_VM_EOF:
> +            /* This is the end of migration */
> +            goto out;
> +            break;

Just the goto is sufficient there.

>          default:
>              error_report("Unknown savevm section type %d", section_type);
>              ret = -EINVAL;
> -- 
> 2.7.4

Dave

> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
