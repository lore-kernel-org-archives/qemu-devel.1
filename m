Received: from eggs.gnu.org ([2001:4830:134:3::10]:48642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duidW-0001gS-91
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duidS-0002c6-G0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:18:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duidS-0002bo-9M
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:18:06 -0400
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-13-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8660368-ffec-9051-7dcb-97d13c6ba850@redhat.com>
Date: Wed, 20 Sep 2017 19:18:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170920114637.42004-13-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 12/18] memory: Share FlatView's and
 dispatch trees between address spaces
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
> +    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> +        MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
> +        FlatView *new_view = g_hash_table_lookup(flat_views, physmr);
> +
> +        if (new_view) {
> +            continue;
> +        }
> +
> +        new_view = generate_memory_topology(physmr);
> +        g_hash_table_insert(flat_views, physmr, new_view);

generate_memory_topology can do the g_hash_table_lookup + insert I think?

>  static void flatview_set_to_address_space(AddressSpace *as)
>  {
> -    FlatView *old_view = address_space_get_flatview(as);
> +    FlatView *old_view = address_space_to_flatview(as);
>      MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
>      FlatView *new_view = g_hash_table_lookup(flat_views, physmr);

Rename to address_space_set_flatview?

Thanks,

Paolo
