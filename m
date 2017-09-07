Received: from eggs.gnu.org ([2001:4830:134:3::10]:32958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppTJ-0000p0-Mc
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppTI-0002dX-N0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:35:25 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-13-eblake@redhat.com>
	<28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
	<1a55f8d5-b4d3-85c7-dab4-472ccc4dca52@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a0e0335b-2d2f-6220-e2f7-24ef01bc2bad@redhat.com>
Date: Thu, 7 Sep 2017 07:35:01 +0200
MIME-Version: 1.0
In-Reply-To: <1a55f8d5-b4d3-85c7-dab4-472ccc4dca52@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="W2CKhcAKGrFw176w37XndFR58q8QHXm1H"
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W2CKhcAKGrFw176w37XndFR58q8QHXm1H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.09.2017 23:00, Eric Blake wrote:
> On 09/05/2017 04:36 AM, Thomas Huth wrote:
>> On 01.09.2017 20:03, Eric Blake wrote:
>>> When initializing a QPCIBus, track which QTestState the bus is
>>> associated with (so that a later patch can then explicitly use
>>> that test state for all communication on the bus, rather than
>>> blindly relying on global_qtest).  Update the initialization
>>> functions to take another parameter, and update all callers to
>>> pass in state (for now, most callers get away with passing the
>>> current global_qtest as the current state, although this required
>>> fixing the order of initialization to ensure qtest_start() is
>>> called before qpci_init*() in rtl8139-test, and provided an
>>> opportunity to pass in the allocator in e1000e-test).
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>> [...]
>>> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
>>> index 6226546c28..c95428e1cb 100644
>>> --- a/tests/libqos/libqos.c
>>> +++ b/tests/libqos/libqos.c
>>> @@ -26,8 +26,8 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdl=
ine_fmt, va_list ap)
>>>          if (ops->init_allocator) {
>>>              qs->alloc =3D ops->init_allocator(ALLOC_NO_FLAGS);
>>>          }
>>> -        if (ops->qpci_init && qs->alloc) {
>>> -            qs->pcibus =3D ops->qpci_init(qs->alloc);
>>> +        if (ops->qpci_init) {
>>
>> Why did you remove the check for qs->alloc?
>>
>>> +            qs->pcibus =3D ops->qpci_init(qs->qts, qs->alloc);
>=20
> Because we want to ensure qpci_init() is called to set qs->qts
> (presumably, whether or not qs->alloc is set).  Furthermore, only two
> files declare a 'static QOSOps' structure in the first place
> (libqos-pc.c and libqos-spapr.c); where both files set both the
> .init_allocator and .qpci_init callbacks; a little bit of auditing show=
s
> that the .init_allocator() never returns NULL (although that requires
> browsing yet more files for malloc-{pc,spapr}.c).

OK, thanks for the explanation! ... but maybe we should
g_assert(gs->alloc) somewhere instead? ... just an idea, I'm also fine
if you leave it away.

 Thomas


--W2CKhcAKGrFw176w37XndFR58q8QHXm1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZsNqKAAoJEC7Z13T+cC213rIP+wU8stw+lHJmJL+jg7e2IQqk
CtIBfe8KGiCAcLWDLeg/FMc4AcZ67RwszZh1a4YWU/mKWEqVtwA06Ap7t1QFP6g/
TvhAsTLX9DXOxKyVF6mD26ib4ZSMv+wW98qW3eGE+IrkW+0BmT4QXlxDudE4KExL
yeqb/YYf9L5Jwf1r7BEjPrrlT/ob/Df/CpbS+QdgGw0jfm6alwZicUJ7PGg1D+Mz
EDY8IjawUbgilPSyzWm+5IJsqkP/fg1xB4FWui4jJLoEAYziMd8hTIK8yTTD0hB+
kxDfvPyNv5yVaFpN06kLbjGYFmIfb3UOl0aXovLEETLxULdXgtlQ6++7hc71E3/U
Ygf7Ly9kfkljGgbuoxv7u/EnKjAyZPhUNJyd22mSPeKTaV7g9C40bqQhlU8qGB76
e5Yc0otbIN2WK+jO45B4YKAwM8NEt71UkjOUFmGDjT3ezjRASfb9sYE9hRlU0yiI
ycHUWbcOPA9A3UnGaV1I4GoU0qNrnNkcJE9hJrmSIzbRyG/CeUOaXMwU/3l6ol9s
yUXIiuOuT918kliVELgEZWi2WyU5pbiTI2lDRy3bcBkfFaEhxAVrIA7mCuK8ZMjN
BhE50Oy4/bKMZ8W2tIlMCUUoso+/pkxly1N2l4wH+8Ozzfo1VuKk5OTM4Pjp2xOo
Oo5+BuNhNUQ51Tghw8df
=S7UY
-----END PGP SIGNATURE-----

--W2CKhcAKGrFw176w37XndFR58q8QHXm1H--
