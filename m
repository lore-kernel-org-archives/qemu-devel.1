Received: from eggs.gnu.org ([2001:4830:134:3::10]:39464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBjUM-0004vj-Cj
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBjUH-0003l3-O7
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:11:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBjUH-0003ki-IM
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:11:13 -0400
Date: Thu, 26 Apr 2018 17:11:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180426161103.GJ2631@work-vm>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-2-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524666934-8064-2-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] migration: disable RDMA WRITE after
 postcopy started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> RDMA WRITE operations are performed with no notification to the destination
> qemu, then the destination qemu can not wakeup. This patch disable RDMA WRITE
> after postcopy started.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/qemu-file.c |  8 ++++++--
>  migration/rdma.c      | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index bb63c77..add8c3a 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -253,8 +253,12 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>      if (f->hooks && f->hooks->save_page) {
>          int ret = f->hooks->save_page(f, f->opaque, block_offset,
>                                        offset, size, bytes_sent);
> -        f->bytes_xfer += size;
> -        if (ret != RAM_SAVE_CONTROL_DELAYED) {
> +        if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
> +            f->bytes_xfer += size;
> +        }
> +
> +        if (ret != RAM_SAVE_CONTROL_DELAYED &&
> +            ret != RAM_SAVE_CONTROL_NOT_SUPP) {
>              if (bytes_sent && *bytes_sent > 0) {
>                  qemu_update_position(f, *bytes_sent);
>              } else if (ret < 0) {
> diff --git a/migration/rdma.c b/migration/rdma.c
> index da474fc..a22be43 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2927,6 +2927,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
>  
>      CHECK_ERROR_STATE();
>  
> +    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        return RAM_SAVE_CONTROL_NOT_SUPP;
> +    }
> +
>      qemu_fflush(f);
>  
>      if (size > 0) {
> @@ -3482,6 +3486,10 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
>  
>      CHECK_ERROR_STATE();
>  
> +    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        return 0;
> +    }
> +
>      trace_qemu_rdma_registration_start(flags);
>      qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
>      qemu_fflush(f);
> @@ -3504,6 +3512,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
>  
>      CHECK_ERROR_STATE();
>  
> +    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        return 0;
> +    }
> +
>      qemu_fflush(f);
>      ret = qemu_rdma_drain_cq(f, rdma);
>  
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
