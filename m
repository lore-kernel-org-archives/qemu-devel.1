Received: from eggs.gnu.org ([2001:4830:134:3::10]:32953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVAYy-0008Kj-Aj
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVAYv-0002yC-6B
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:28:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gVAYu-0002xa-Un
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:28:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 737AE40F06
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 07:28:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-3-pbonzini@redhat.com>
Date: Fri, 07 Dec 2018 08:28:33 +0100
In-Reply-To: <20181206232333.22408-3-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Fri, 7 Dec 2018 00:23:29 +0100")
Message-ID: <87ftv93ie6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/6] qemu/queue.h: leave head structs
 anonymous unless necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Most list head structs need not be given a name.  In most cases the
> name is given just in case one is going to use QTAILQ_LAST, QTAILQ_PREV
> or reverse iteration, but this does not apply to lists of other kinds,
> and even for QTAILQ in practice this is only rarely needed.  In addition,
> we will soon reimplement those macros completely so that they do not
> need a name for the head struct.  So clean up everything, not giving a
> name except in the rare case where it is necessary.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4880a05399..4e1de942ce 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -86,7 +86,7 @@ struct KVMState
>      int robust_singlestep;
>      int debugregs;
>  #ifdef KVM_CAP_SET_GUEST_DEBUG
> -    struct kvm_sw_breakpoint_head kvm_sw_breakpoints;
> +    QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
>  #endif
>      int many_ioeventfds;
>      int intx_set_mask;
> @@ -102,7 +102,7 @@ struct KVMState
>      int nr_allocated_irq_routes;
>      unsigned long *used_gsi_bitmap;
>      unsigned int gsi_count;
> -    QTAILQ_HEAD(msi_hashtab, KVMMSIRoute) msi_hashtab[KVM_MSI_HASHTAB_SIZE];
> +    QTAILQ_HEAD(, KVMMSIRoute) msi_hashtab[KVM_MSI_HASHTAB_SIZE];
>  #endif
>      KVMMemoryListener memory_listener;
>      QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
> diff --git a/block/gluster.c b/block/gluster.c
> index 5e300c96c8..72891060e3 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -72,7 +72,7 @@ typedef struct ListElement {
>      GlfsPreopened saved;
>  } ListElement;
>  
> -static QLIST_HEAD(glfs_list, ListElement) glfs_list;
> +static QLIST_HEAD(, ListElement) glfs_list;
>  
>  static QemuOptsList qemu_gluster_create_opts = {
>      .name = "qemu-gluster-create-opts",
> diff --git a/block/mirror.c b/block/mirror.c
> index 8f52c6215d..6250cc3c87 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -72,7 +72,7 @@ typedef struct MirrorBlockJob {
>      unsigned long *in_flight_bitmap;
>      int in_flight;
>      int64_t bytes_in_flight;
> -    QTAILQ_HEAD(MirrorOpList, MirrorOp) ops_in_flight;
> +    QTAILQ_HEAD(, MirrorOp) ops_in_flight;
>      int ret;
>      bool unmap;
>      int target_cluster_size;
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index accebef4cf..b946301429 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -77,8 +77,6 @@ typedef struct Qcow2BitmapTable {
>      uint32_t size; /* number of 64bit entries */
>      QSIMPLEQ_ENTRY(Qcow2BitmapTable) entry;
>  } Qcow2BitmapTable;
> -typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable)
> -    Qcow2BitmapTableList;
>  
>  typedef struct Qcow2Bitmap {
>      Qcow2BitmapTable table;
> @@ -1316,7 +1314,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>      int ret;
>      Qcow2BitmapList *bm_list;
>      Qcow2Bitmap *bm;
> -    Qcow2BitmapTableList drop_tables;
> +    QSIMPLEQ_HEAD(, Qcow2BitmapTable) drop_tables;
>      Qcow2BitmapTable *tb, *tb_next;
>  
>      if (!bdrv_has_changed_persistent_bitmaps(bs)) {

Thanks for getting rid of typedefs like this one.

> diff --git a/block/qcow2.h b/block/qcow2.h
> index 8662b68575..d747dd14a2 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -281,7 +281,7 @@ typedef struct BDRVQcow2State {
>      uint8_t *cluster_cache;
>      uint8_t *cluster_data;
>      uint64_t cluster_cache_offset;
> -    QLIST_HEAD(QCowClusterAlloc, QCowL2Meta) cluster_allocs;
> +    QLIST_HEAD(, QCowL2Meta) cluster_allocs;
>  
>      uint64_t *refcount_table;
>      uint64_t refcount_table_offset;
[Snip...]

Did you create this patch manually, or (partly) mechanically?

Commit message claims a named struct is not needed for "lists of other
kinds, and even for QTAILQ in practice this is only rarely needed".
Let's see:

    $ git-grep 'Q[A-Z]*_HEAD(,' | wc -l
    246
    $ git-grep 'Q[A-Z]*_HEAD([^,]' | grep -v '#define' | wc -l
    25

Yup, "rarely" is fair.

    $ git-grep 'Q[A-Z]*_HEAD([^,]' | grep -v '#define' | grep -v QTAILQ_HEAD
    block/qcow2-bitmap.c:typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
    include/block/block.h:typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
    include/hw/vfio/vfio-common.h:typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
    qemu-bridge-helper.c:typedef QSIMPLEQ_HEAD(ACLList, ACLRule) ACLList;

Are these four names left in intentionally?

If the name is indeed not needed for lists of other kinds, should we
simplify the macros so their users don't have to supply an empty first
argument?
