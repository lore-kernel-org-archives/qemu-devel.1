Received: from eggs.gnu.org ([2001:4830:134:3::10]:53188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTgpd-0003Ws-MT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTgpa-0001WZ-Ie
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:31:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gTgpZ-0001Vr-Nr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:31:42 -0500
Date: Mon, 3 Dec 2018 13:31:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181203053118.GD27620@xz-x1>
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
	<1543803511-34793-7-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543803511-34793-7-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v10 6/7] migration/ram.c: add a function to
 disable the bulk stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On Mon, Dec 03, 2018 at 10:18:30AM +0800, Wei Wang wrote:
> This patch adds a function to enable a precopy notifier callback outside
> the migration subsystem to disable the bulk stage flag. This is needed by
> the free page optimization offered by virtio-balloon.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h | 1 +
>  migration/ram.c          | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 15f8d00..47e7ff5 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -37,6 +37,7 @@ void precopy_infrastructure_init(void);
>  void precopy_add_notifier(NotifierWithReturn *n);
>  void precopy_remove_notifier(NotifierWithReturn *n);
>  int precopy_notify(PrecopyNotifyReason reason, Error **errp);
> +void precopy_disable_bulk_stage(void);
>  
>  void ram_mig_init(void);
>  void qemu_guest_free_page_hint(void *addr, size_t len);
> diff --git a/migration/ram.c b/migration/ram.c
> index b90a3f2..739dc97 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -354,6 +354,15 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
>      return notifier_with_return_list_notify(&precopy_notifier_list, &pnd);
>  }
>  
> +void precopy_disable_bulk_stage(void)
> +{
> +    if (!ram_state) {
> +        return;
> +    }
> +
> +    ram_state->ram_bulk_stage = false;
> +}
> +

This one is a bit tricky.  E.g., I think it'll at least affect XBZRLE
and compression somehow.  Since we will have the on-off switch for
balloon free page hinting so the user can at least decide what
features to use, with that I don't see much issue with it so far. But
I'd also like to see how other people see this change.

Regards,

-- 
Peter Xu
