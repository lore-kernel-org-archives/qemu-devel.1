Received: from eggs.gnu.org ([2001:4830:134:3::10]:37332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cF4Pv-0002mK-6e
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 14:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cF4Ps-00084z-4k
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 14:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cF4Pr-000845-TJ
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 14:31:40 -0500
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
	<20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
Date: Thu, 8 Dec 2016 20:31:32 +0100
MIME-Version: 1.0
In-Reply-To: <20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Upa4eE5Q71fct2PbCHNe74UGitHI6fG2q"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Upa4eE5Q71fct2PbCHNe74UGitHI6fG2q
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Message-ID: <9100954e-d7e6-8670-e614-0fa611d6f248@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
 <09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
 <20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
In-Reply-To: <20d0895e-9d22-8718-a1d8-618d5b7d75d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.12.2016 16:23, Eric Blake wrote:
> On 12/07/2016 08:28 PM, Gonglei (Arei) wrote:
>=20
>>> As far as I'm aware, other projects usually have a special memset
>>> variation for doing this. That is because compilers may choose to
>>> "optimize" memset(p, ...) + free(p) to just the free(p). Having a
>>
>> Actually, I googled this, but I didn't find a definite answer. And
>>
>> The Linux kernel uses kzfree instead of memset + kfree (mm/slab_common=
=2Ec).

Well, I personally don't mind whether we use a custom zfree() or a
custom memset_s() + free(). I only mind that this patch actually always
does what it is intended to do.

> If we're worried about cleaning things without allowing the compiler a
> chance to optimize, then writing our own qemu_zfree() wrapper may indee=
d
> make sense.  But that won't cover the case in Daniel's earlier patch
> (referenced elsewhere in this thread), as that was zeroizing stack
> memory (before it went out of scope) rather than heap memory (before
> free).  So you'd still need some sort of 'write this memory no matter
> what' primitive that would be directly usable on stack memory and
> indirectly used as part of the qemu_zfree() wrapper.
>=20
> But I wouldn't worry about it for now, unless someone proves we actuall=
y
> have a compiler optimizing away the cleanups.

It's true that we don't have to worry about it *now*, but the approach
of waiting until the compiler breaks it does not seem right to me.

If at some point some compiler recognizes g_free() as being the same
function as free() and thus optimizes memset() + g_free(), we simply
won't notice because nobody will keep track of the generated assembly
output all the time.

There is a reason C11 introduced memset_s(), and it is this.

Max


--Upa4eE5Q71fct2PbCHNe74UGitHI6fG2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhJtRUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOhEIAIPMMgiq52gKfch3vLqpVta4HWdOGJ86
Yw7JBYgwGAokq4iwiFBxU362epYAr5kj1Uur0zlmXN84IU1gTXKZq47zV88NHYjP
h/z8lNdXBSgBI2A0HMfQWOetTirKCCmIVskuz+XboKlFhb9UU5wdb4mCgtGDMXfi
QhL5cl+qljnD0InS+PMf/Cd1wRKReQE2Mkje24xof7HCE+gpGejpDOeUblZTMlHr
rzDuk8wJfpQFwZjV2Q9bCQ2aV5zMapGexCSAZqQWnNdMqp/MN15D7/9qwKfCydTn
ilIK3TBWaNsL6O2s4sNFvZV5i+cHYpOOSepf7oOmhNWLYXnhCw79AzA=
=CQA3
-----END PGP SIGNATURE-----

--Upa4eE5Q71fct2PbCHNe74UGitHI6fG2q--
