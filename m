Received: from eggs.gnu.org ([2001:4830:134:3::10]:50597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTgVI-000363-Ev
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTgVF-000113-B1
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:10:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gTgVF-00010l-5o
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:10:41 -0500
Date: Mon, 3 Dec 2018 13:10:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181203051025.GB27620@xz-x1>
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
	<1543803511-34793-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543803511-34793-5-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v10 4/7] migration: API to clear bits of
 guest free pages from the dirty bitmap
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

On Mon, Dec 03, 2018 at 10:18:28AM +0800, Wei Wang wrote:
> This patch adds an API to clear bits corresponding to guest free pages
> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
> RAMBlock boundary.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> ---

[...]

> +void qemu_guest_free_page_hint(void *addr, size_t len)
> +{
> +    RAMBlock *block;
> +    ram_addr_t offset;
> +    size_t used_len, start, npages;
> +    MigrationState *s = migrate_get_current();
> +
> +    /* This function is currently expected to be used during live migration */
> +    if (!migration_is_setup_or_active(s->state)) {
> +        return;
> +    }
> +
> +    for (; len > 0; len -= used_len, addr += used_len) {
> +        block = qemu_ram_block_from_host(addr, false, &offset);
> +        if (unlikely(!block || offset > block->used_length)) {

Maybe >=?  My fault if it is...

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
