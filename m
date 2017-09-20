Received: from eggs.gnu.org ([2001:4830:134:3::10]:45958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiYi-0006YL-Mb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duiYg-0008A2-0D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:13:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duiYf-000891-Pd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:13:09 -0400
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-16-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54984f46-f50b-8306-2229-15ea96cea7d6@redhat.com>
Date: Wed, 20 Sep 2017 19:13:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170920114637.42004-16-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 15/18] memory: Share special empty
 FlatView
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
> This shares an cached empty FlatView among address spaces. The empty
> FV is used every time when a root MR renders into a FV without memory
> sections which happens when MR or its children are not enabled or
> zero-sized. The empty_view is not NULL to keep the rest of memory
> API intact; it also has a dispatch tree for the same reason.
> 
> On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this halves
> the amount of FlatView's in use (557 -> 260) and dispatch tables
> (~800000 -> ~370000), however the total memory footprint is pretty much
> the same as RCU is holding all these temporary FVs which are created
> (and then released) to make sure that they are empty and can be replaced
> with @empty_view.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  memory.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/memory.c b/memory.c
> index 4add0fd030..92b1304a20 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -48,6 +48,7 @@ static QTAILQ_HEAD(, AddressSpace) address_spaces
>      = QTAILQ_HEAD_INITIALIZER(address_spaces);
>  
>  static GHashTable *flat_views;
> +static FlatView *empty_view;
>  
>  typedef struct AddrRange AddrRange;
>  
> @@ -755,6 +756,19 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
>      }
>      flatview_simplify(view);
>  
> +    if (!view->nr) {
> +        flatview_unref(view);

This can be changed to flatview_destroy directly to avoid overloading
RCU with all these temporary FlatViews.

Paolo

> +        if (!empty_view) {
> +            empty_view = flatview_new(NULL);
> +        }
> +        view = empty_view;
> +        flatview_ref(view);
> +    }
> +
> +    if (view->dispatch) {
> +        return view;
> +    }
> +
>      view->dispatch = address_space_dispatch_new(view);
>      for (i = 0; i < view->nr; i++) {
>          MemoryRegionSection mrs =
> 
