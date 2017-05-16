Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAZJP-0000ga-WB
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAZJJ-0004hD-Tl
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAZJJ-0004gr-KV
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:02:33 -0400
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<1494838260-30439-2-git-send-email-peterx@redhat.com>
	<20170516025300.GA30022@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41cd420c-3a07-34a0-c0da-286a152eb70c@redhat.com>
Date: Tue, 16 May 2017 12:02:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170516025300.GA30022@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GWfH9IIDGt4wnpKhXUEg9SA4FWxJWCIi6"
Subject: Re: [Qemu-devel] [PATCH 1/4] exec: simplify phys_page_find() params
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GWfH9IIDGt4wnpKhXUEg9SA4FWxJWCIi6
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <41cd420c-3a07-34a0-c0da-286a152eb70c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] exec: simplify phys_page_find() params
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
 <1494838260-30439-2-git-send-email-peterx@redhat.com>
 <20170516025300.GA30022@umbus.fritz.box>
In-Reply-To: <20170516025300.GA30022@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 16/05/2017 04:53, David Gibson wrote:
> On Mon, May 15, 2017 at 04:50:57PM +0800, Peter Xu wrote:
>> It really only plays with the dispatchers, so the parameter list does
>> not need that complexity. This helps for readability at least.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Queued, thanks.

Paolo

>=20
>> ---
>>  exec.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index eac6085..1d76c63 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -371,10 +371,11 @@ static inline bool section_covers_addr(const Mem=
oryRegionSection *section,
>>                               int128_getlo(section->size), addr);
>>  }
>> =20
>> -static MemoryRegionSection *phys_page_find(PhysPageEntry lp, hwaddr a=
ddr,
>> -                                           Node *nodes, MemoryRegionS=
ection *sections)
>> +static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, h=
waddr addr)
>>  {
>> -    PhysPageEntry *p;
>> +    PhysPageEntry lp =3D d->phys_map, *p;
>> +    Node *nodes =3D d->map.nodes;
>> +    MemoryRegionSection *sections =3D d->map.sections;
>>      hwaddr index =3D addr >> TARGET_PAGE_BITS;
>>      int i;
>> =20
>> @@ -412,8 +413,7 @@ static MemoryRegionSection *address_space_lookup_r=
egion(AddressSpaceDispatch *d,
>>          section_covers_addr(section, addr)) {
>>          update =3D false;
>>      } else {
>> -        section =3D phys_page_find(d->phys_map, addr, d->map.nodes,
>> -                                 d->map.sections);
>> +        section =3D phys_page_find(d, addr);
>>          update =3D true;
>>      }
>>      if (resolve_subpage && section->mr->subpage) {
>> @@ -1246,8 +1246,7 @@ static void register_subpage(AddressSpaceDispatc=
h *d, MemoryRegionSection *secti
>>      subpage_t *subpage;
>>      hwaddr base =3D section->offset_within_address_space
>>          & TARGET_PAGE_MASK;
>> -    MemoryRegionSection *existing =3D phys_page_find(d->phys_map, bas=
e,
>> -                                                   d->map.nodes, d->m=
ap.sections);
>> +    MemoryRegionSection *existing =3D phys_page_find(d, base);
>>      MemoryRegionSection subsection =3D {
>>          .offset_within_address_space =3D base,
>>          .size =3D int128_make64(TARGET_PAGE_SIZE),
>=20


--GWfH9IIDGt4wnpKhXUEg9SA4FWxJWCIi6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlkaziUACgkQv/vSX3jH
roN6+Qf+Pl5wsry7HPw4SBxLRpgouSUXJwoA1/XUZpAO+BMFQMryS4FCahuu9itn
hGLMil9udIq5+uQ9mUhaSdHpz75TMTua+iHJzhUgPoANhD7MMP4esPPGUbqUI6/D
1E6LkOemYmf+OtdxHCnJTjk+qJ9FlwGTOqybnfw57cpPckX6FXTV7eh8RuYEDimW
rWh4p9f4XnEszqbm6+Ila//vkgBnRv1QEdzPVG5ch5cFnLTvL5LbRNED/Y+L34oQ
WXlNhQucpLwfjsn/u+R8KgVIjvR4duA53lTbZXe42ww9KHsC8VWiak5HcOMEU2yS
OD+2OpdVcU+s/W0LRPbOzRCzjnYLbQ==
=acab
-----END PGP SIGNATURE-----

--GWfH9IIDGt4wnpKhXUEg9SA4FWxJWCIi6--
