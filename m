Received: from eggs.gnu.org ([2001:4830:134:3::10]:34691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGck-00006i-Kq
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGch-0008EB-V9
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:14:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmGch-0008Dr-Ow
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:14:07 -0500
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<1489158897-9206-2-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53522014-8f70-9358-7d60-8b6c491c9611@redhat.com>
Date: Fri, 10 Mar 2017 10:14:02 +0100
MIME-Version: 1.0
In-Reply-To: <1489158897-9206-2-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, chao.p.peng@intel.com



On 10/03/2017 16:14, Yang Zhong wrote:
> There is no need to delete subregion and do memory begin/commit for
> subpage in memory_region_finalize().
>=20
> This patch is from Anthony Xu <anthony.xu@intel.com>.
>=20
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  memory.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index 284894b..3e9bfff 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1505,13 +1505,14 @@ static void memory_region_finalize(Object *obj)
>       * and cause an infinite loop.
>       */
>      mr->enabled =3D false;
> -    memory_region_transaction_begin();
> -    while (!QTAILQ_EMPTY(&mr->subregions)) {
> -        MemoryRegion *subregion =3D QTAILQ_FIRST(&mr->subregions);
> -        memory_region_del_subregion(mr, subregion);
> +    if (!mr->subpage) {
> +        memory_region_transaction_begin();
> +        while (!QTAILQ_EMPTY(&mr->subregions)) {
> +            MemoryRegion *subregion =3D QTAILQ_FIRST(&mr->subregions);
> +            memory_region_del_subregion(mr, subregion);
> +        }
> +        memory_region_transaction_commit();

Subpages never have subregions, so the loop never runs.  The
begin/commit pair then becomes:

    ++memory_region_transaction_depth;
    --memory_region_transaction_depth;
    if (!memory_region_transaction_depth) {
        if (memory_region_update_pending) {
            ...
        } else if (ioeventfd_update_pending) {
            ...
        }
        // memory_region_clear_pending()
        memory_region_update_pending =3D false;
        ioeventfd_update_pending =3D false;
   }

If memory_region_transaction_depth is > 0 the begin/commit pair does
nothing.

But if memory_region_transaction_depth is =3D=3D 0, there should be no
update pending because the loop has never run.  So I don't see what your
patch can change.

Of course there could be an update pending because of a bug elsewhere,
but I tried adding this patch:

diff --git a/memory.c b/memory.c
index 284894b..2208a21 100644
--- a/memory.c
+++ b/memory.c
@@ -903,6 +903,10 @@ static void
address_space_update_topology(AddressSpace *as)
 void memory_region_transaction_begin(void)
 {
     qemu_flush_coalesced_mmio_buffer();
+    if (!memory_region_transaction_depth) {
+        assert(!memory_region_update_pending);
+        assert(!ioeventfd_update_pending);
+    }
     ++memory_region_transaction_depth;
 }

and at least a basic qemu-system-x86_64 run started just fine.  So why
does this patch make a difference?

Paolo

>      }
> -    memory_region_transaction_commit();
> -
