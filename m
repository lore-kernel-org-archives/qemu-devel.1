Received: from eggs.gnu.org ([2001:4830:134:3::10]:33721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dv1hW-0008S0-E1
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dv1hT-00075w-9t
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:39:34 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dv1hT-00075R-0l
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:39:31 -0400
Received: by mail-pg0-x242.google.com with SMTP id i130so3459630pgc.0
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:39:30 -0700 (PDT)
References: <20170921120751.3027-1-pbonzini@redhat.com>
	<20170921120751.3027-3-pbonzini@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1d5f2bb4-c330-98b9-bf1a-6024a9f9093d@ozlabs.ru>
Date: Thu, 21 Sep 2017 23:39:25 +1000
MIME-Version: 1.0
In-Reply-To: <20170921120751.3027-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] memory: seek FlatView sharing
 candidates among children subregions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 22:07, Paolo Bonzini wrote:
> A container can be used instead of an alias to allow switching between
> multiple subregions.  In this case we cannot directly share the
> subregions (since they only belong to a single parent), but if the
> subregions are aliases we can in turn walk those.
> 
> While this does not reduce much the number of FlatViews that are created,
> it makes it possible to share the PCI bus master FlatViews and their
> AddressSpaceDispatch structures.  For 112 virtio-net-pci devices, boot time
> is reduced from 25 to 10 seconds and memory consumption from 1.4 to 1 G.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  memory.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 4952cc5d84..3207ae55e2 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -733,12 +733,41 @@ static void render_memory_region(FlatView *view,
>  
>  static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
>  {
> -    while (mr->alias && !mr->alias_offset &&
> -           int128_ge(mr->size, mr->alias->size)) {
> -        /* The alias is included in its entirety.  Use it as
> -         * the "real" root, so that we can share more FlatViews.
> -         */
> -        mr = mr->alias;
> +    while (mr->enabled) {
> +        if (mr->alias && !mr->alias_offset &&
> +            int128_ge(mr->size, mr->alias->size)) {
> +            /* The alias is included in its entirety.  Use it as
> +             * the "real" root, so that we can share more FlatViews.
> +             */
> +            mr = mr->alias;
> +            continue;
> +        }
> +
> +        if (!mr->terminates) {

Can an MR have terminates==true and children by the same time? If so, what for?


> +            unsigned int found = 0;
> +            MemoryRegion *child, *next = NULL;
> +            QTAILQ_FOREACH(child, &mr->subregions, subregions_link) {
> +                if (child->enabled) {
> +                    if (++found > 1) {
> +                        next = NULL;
> +                        break;
> +                    }
> +                    if (!child->addr && int128_ge(mr->size, child->size)) {


Ah, I tried this one but in v4's 18/18 (that hinting thing), did not work
out but for a different reason.


> +                        /* A child is included in its entirety.  If it's the only
> +                         * enabled one, use it in the hope of finding an alias down the
> +                         * way. This will also let us share FlatViews.
> +                         */
> +                        next = child;
> +                    }
> +                }
> +            }
> +            if (next) {
> +                mr = next;
> +                continue;
> +            }
> +        }
> +
> +        break;
>      }
>  
>      return mr;
> 


-- 
Alexey
