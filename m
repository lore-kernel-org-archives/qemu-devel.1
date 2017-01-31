Received: from eggs.gnu.org ([2001:4830:134:3::10]:53300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYVJi-0001p7-On
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYVJe-0005L2-KD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:05:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cYVJe-0005Kq-6v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:05:34 -0500
Date: Tue, 31 Jan 2017 10:05:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170131100528.GC2395@work-vm>
References: <1485327241-15104-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485327241-15104-3-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485327241-15104-3-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] savevm: Add new helpers to process the
 different stages of loadvm/savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com, xuquan8@huawei.com, Li Zhijian <lizhijian@cn.fujitsu.com>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> There are several stages during loadvm/savevm process. In different stage,
> migration incoming processes different types of sections.
> We want to control these stages more accuracy, it will benefit COLO
> performance, we don't have to save type of QEMU_VM_SECTION_START
> sections everytime while do checkpoint, besides, we want to separate
> the process of saving/loading memory and devices state.
> 
> So we add three new helper functions: qemu_loadvm_state_begin(),
> qemu_load_device_state() and qemu_savevm_live_state() to achieve
> different process during migration.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I don't think this one can go in without the patch that follows which
uses these functions; we don't normally add functions
without the patch that uses them.

Dave

> ---
>  include/sysemu/sysemu.h |  4 ++++
>  migration/savevm.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index ff8ffb5..d9214bf 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -126,7 +126,11 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>                                             uint64_t *start_list,
>                                             uint64_t *length_list);
>  
> +void qemu_savevm_live_state(QEMUFile *f);
> +
>  int qemu_loadvm_state(QEMUFile *f);
> +int qemu_loadvm_state_begin(QEMUFile *f);
> +int qemu_load_device_state(QEMUFile *f);
>  
>  extern int autostart;
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 92b3d6c..04dee4f 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1264,6 +1264,13 @@ done:
>      return ret;
>  }
>  
> +void qemu_savevm_live_state(QEMUFile *f)
> +{
> +    /* save QEMU_VM_SECTION_END section */
> +    qemu_savevm_state_complete_precopy(f, true);
> +    qemu_put_byte(f, QEMU_VM_EOF);
> +}
> +
>  static int qemu_save_device_state(QEMUFile *f)
>  {
>      SaveStateEntry *se;
> @@ -2064,6 +2071,40 @@ int qemu_loadvm_state(QEMUFile *f)
>      return ret;
>  }
>  
> +int qemu_loadvm_state_begin(QEMUFile *f)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    if (qemu_savevm_state_blocked(&local_err)) {
> +        error_report_err(local_err);
> +        return -EINVAL;
> +    }
> +    /* Load QEMU_VM_SECTION_START section */
> +    ret = qemu_loadvm_state_main(f, mis);
> +    if (ret < 0) {
> +        error_report("Failed to loadvm begin work: %d", ret);
> +    }
> +    return ret;
> +}
> +
> +int qemu_load_device_state(QEMUFile *f)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    int ret;
> +
> +    /* Load QEMU_VM_SECTION_FULL section */
> +    ret = qemu_loadvm_state_main(f, mis);
> +    if (ret < 0) {
> +        error_report("Failed to load device state: %d", ret);
> +        return ret;
> +    }
> +
> +    cpu_synchronize_all_post_init();
> +    return 0;
> +}
> +
>  void hmp_savevm(Monitor *mon, const QDict *qdict)
>  {
>      BlockDriverState *bs, *bs1;
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
