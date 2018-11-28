Received: from eggs.gnu.org ([2001:4830:134:3::10]:47378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRwhS-00047w-PJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRwhO-0001JS-Q5
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:04:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRwhO-0001IN-CD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:04:02 -0500
References: <20181128.181700.1038782556965887223.atsushi.nemoto@sord.co.jp>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6bc70d3-7fdb-5c38-3846-10b36830a446@redhat.com>
Date: Wed, 28 Nov 2018 11:03:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181128.181700.1038782556965887223.atsushi.nemoto@sord.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: update coalesced_range on
 transaction_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>, qemu-devel@nongnu.org

On 28/11/18 10:17, Atsushi Nemoto wrote:
> The e1000 driver calls memory_region_add_coalescing but
> kvm_coalesce_mmio_region never been called for those regions.
>=20
> Update coalesced_range on memory_region_transaction_commit to fix this.
>=20
> It seems very old bug since memory region API
> was merged on commit 093bc2cd885e ("Hierarchical memory region API").
>=20
> Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> ---
>  memory.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index d14c6dec1d..f773b0be50 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1021,6 +1021,8 @@ void memory_region_transaction_begin(void)
>      ++memory_region_transaction_depth;
>  }
> =20
> +static void memory_region_update_coalesced_range_as(MemoryRegion *mr, =
AddressSpace *as);
> +
>  void memory_region_transaction_commit(void)
>  {
>      AddressSpace *as;
> @@ -1038,6 +1040,7 @@ void memory_region_transaction_commit(void)
>              QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>                  address_space_set_flatview(as);
>                  address_space_update_ioeventfds(as);
> +                memory_region_update_coalesced_range_as(NULL, as);
>              }
>              memory_region_update_pending =3D false;
>              ioeventfd_update_pending =3D false;
> @@ -2142,7 +2145,7 @@ static void memory_region_update_coalesced_range_=
as(MemoryRegion *mr, AddressSpa
> =20
>      view =3D address_space_get_flatview(as);
>      FOR_EACH_FLAT_RANGE(fr, view) {
> -        if (fr->mr =3D=3D mr) {
> +        if (fr->mr =3D=3D mr || (!mr && !QTAILQ_EMPTY(&fr->mr->coalesc=
ed))) {
>              section =3D (MemoryRegionSection) {
>                  .fv =3D view,
>                  .offset_within_address_space =3D int128_get64(fr->addr=
.start),

I'm worried that coalesced_io_del would be skipped when the region is
deleted.  I think the right place to add the coalesced_io_{add,del}
calls is address_space_update_topology_pass.

Let me test an alternative fix and post it; thanks for the report in the
meanwhile!

Paolo

> @@ -2152,7 +2155,7 @@ static void memory_region_update_coalesced_range_=
as(MemoryRegion *mr, AddressSpa
>              MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &secti=
on,
>                                   int128_get64(fr->addr.start),
>                                   int128_get64(fr->addr.size));
> -            QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
> +            QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
>                  tmp =3D addrrange_shift(cmr->addr,
>                                        int128_sub(fr->addr.start,
>                                                   int128_make64(fr->off=
set_in_region)));
>=20
