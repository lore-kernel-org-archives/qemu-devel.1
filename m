Received: from eggs.gnu.org ([2001:4830:134:3::10]:53189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYVIp-0001Qf-1T
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYVIl-00055j-0V
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:04:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cYVIk-00055B-PP
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:04:38 -0500
Date: Tue, 31 Jan 2017 10:04:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170131100432.GB2395@work-vm>
References: <1485327241-15104-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485327241-15104-2-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485327241-15104-2-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] savevm: split save/find
 loadvm_handlers entry into two helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com, xuquan8@huawei.com

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> COLO's checkpoint process is based on migration process,
> everytime we do checkpoint we will repeat the process of savevm and loadvm.
> 
> So we will call qemu_loadvm_section_start_full() repeatedly, It will
> add all migration sections information into loadvm_handlers list everytime,
> which will lead to memory leak.
> 
> To fix it, we split the process of saving and finding section entry into two
> helper functions, we will check if section info was exist in loadvm_handlers
> list before save it.
> 
> This modifications have no side effect for normal migration.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/savevm.c | 55 +++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f9c06e9..92b3d6c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1805,6 +1805,37 @@ void loadvm_free_handlers(MigrationIncomingState *mis)
>      }
>  }
>  
> +static LoadStateEntry *loadvm_save_section_entry(MigrationIncomingState *mis,

Can you change that to loadvm_add_section_entry please;  it's a bit
confusing using 'save' in a function name that's part of the 'load' path.

Dave

> +                                                 SaveStateEntry *se,
> +                                                 uint32_t section_id,
> +                                                 uint32_t version_id)
> +{
> +    LoadStateEntry *le;
> +
> +    /* Add entry */
> +    le = g_malloc0(sizeof(*le));
> +
> +    le->se = se;
> +    le->section_id = section_id;
> +    le->version_id = version_id;
> +    QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
> +    return le;
> +}
> +
> +static LoadStateEntry *loadvm_find_section_entry(MigrationIncomingState *mis,
> +                                                 uint32_t section_id)
> +{
> +    LoadStateEntry *le;
> +
> +    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
> +        if (le->section_id == section_id) {
> +            break;
> +        }
> +    }
> +
> +    return le;
> +}
> +
>  static int
>  qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>  {
> @@ -1847,15 +1878,12 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>          return -EINVAL;
>      }
>  
> -    /* Add entry */
> -    le = g_malloc0(sizeof(*le));
> -
> -    le->se = se;
> -    le->section_id = section_id;
> -    le->version_id = version_id;
> -    QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
> -
> -    ret = vmstate_load(f, le->se, le->version_id);
> +     /* Check if we have saved this section info before, if not, save it */
> +    le = loadvm_find_section_entry(mis, section_id);
> +    if (!le) {
> +        le = loadvm_save_section_entry(mis, se, section_id, version_id);
> +    }
> +    ret = vmstate_load(f, se, version_id);
>      if (ret < 0) {
>          error_report("error while loading state for instance 0x%x of"
>                       " device '%s'", instance_id, idstr);
> @@ -1878,12 +1906,9 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>      section_id = qemu_get_be32(f);
>  
>      trace_qemu_loadvm_state_section_partend(section_id);
> -    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
> -        if (le->section_id == section_id) {
> -            break;
> -        }
> -    }
> -    if (le == NULL) {
> +
> +    le = loadvm_find_section_entry(mis, section_id);
> +    if (!le) {
>          error_report("Unknown savevm section %d", section_id);
>          return -EINVAL;
>      }
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
