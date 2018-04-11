Received: from eggs.gnu.org ([2001:4830:134:3::10]:45179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6I7H-0004xj-32
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6I7D-0004ge-W2
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:56:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6I7D-0004gB-Qj
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:56:55 -0400
Date: Wed, 11 Apr 2018 16:56:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180411155647.GG2667@work-vm>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<1523089594-1422-6-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523089594-1422-6-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: disable RDMA WRITR after
 postcopy started.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> RDMA write operations are performed with no notification to the destination
> qemu, then the destination qemu can not wakeup. So disable RDMA WRITE after
> postcopy started.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

This patch needs to be near the beginning of the series; at the moment a
bisect would lead you to the middle of the series which had return
paths, but then would fail to work properly because it would try and use
the RDMA code.

> ---
>  migration/qemu-file.c |  3 ++-
>  migration/rdma.c      | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 8acb574..a64ac3a 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -260,7 +260,8 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>          int ret = f->hooks->save_page(f, f->opaque, block_offset,
>                                        offset, size, bytes_sent);
>          f->bytes_xfer += size;
> -        if (ret != RAM_SAVE_CONTROL_DELAYED) {
> +        if (ret != RAM_SAVE_CONTROL_DELAYED &&
> +            ret != RAM_SAVE_CONTROL_NOT_SUPP) {

What about f->bytes_xfer in this case?

Is there anything we have to do at the switchover into postcopy to make
sure that all pages have been received?

Dave

>              if (bytes_sent && *bytes_sent > 0) {
>                  qemu_update_position(f, *bytes_sent);
>              } else if (ret < 0) {
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 81be482..8529ddd 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2964,6 +2964,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
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
> @@ -3528,6 +3532,10 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
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
> @@ -3550,6 +3558,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
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
