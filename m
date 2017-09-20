Received: from eggs.gnu.org ([2001:4830:134:3::10]:49106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duieM-0002H7-FO
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duieJ-00036r-RQ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duieJ-00036U-Kw
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:18:59 -0400
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-18-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fdf215f-de6f-7bb1-51e7-cdf2d0c076a0@redhat.com>
Date: Wed, 20 Sep 2017 19:18:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170920114637.42004-18-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 17/18] memory: Create FlatView
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
> +static void flatview_update_topology_single(AddressSpace *as)

address_space_update_topology?

Thanks,

Paolo

> +{
> +    MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
> +    FlatView *new_view;
> +
> +    flatviews_init();
> +    new_view = g_hash_table_lookup(flat_views, physmr);
> +    if (!new_view) {
> +        new_view = generate_memory_topology(physmr);
> +        g_hash_table_insert(flat_views, physmr, new_view);
> +    }
> +    flatview_set_to_address_space(as);
> +}
> +
>  void memory_region_transaction_begin(void)
>  {
>      qemu_flush_coalesced_mmio_buffer();
> @@ -2731,7 +2745,6 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
>  void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>  {
>      memory_region_ref(root);
> -    memory_region_transaction_begin();
>      as->root = root;
>      as->current_map = NULL;
>      as->ioeventfd_nb = 0;
> @@ -2739,8 +2752,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>      QTAILQ_INIT(&as->listeners);
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
>      as->name = g_strdup(name ? name : "anonymous");
> -    memory_region_update_pending |= root->enabled;
> -    memory_region_transaction_commit();
> +    flatview_update_topology_single(as);
