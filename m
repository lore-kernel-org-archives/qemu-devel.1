Received: from eggs.gnu.org ([2001:4830:134:3::10]:53656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJ8t-0000y9-Uq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJ8p-0007VI-TJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:54:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chJ8p-0007Uc-Jy
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:54:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4FFBC05AA61
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 16:54:46 +0000 (UTC)
References: <20170222180423.26571-1-pbonzini@redhat.com>
	<20170222180423.26571-2-pbonzini@redhat.com>
	<87d1e7abbb.fsf@dusky.pond.sub.org>
	<09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <488abb9e-d1d3-30ad-18e1-3a00bb7f10d8@redhat.com>
Date: Fri, 24 Feb 2017 10:54:44 -0600
MIME-Version: 1.0
In-Reply-To: <09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CN5hFnGVPsMPhitMSohxFBuR730B4AUjg"
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CN5hFnGVPsMPhitMSohxFBuR730B4AUjg
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Message-ID: <488abb9e-d1d3-30ad-18e1-3a00bb7f10d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
References: <20170222180423.26571-1-pbonzini@redhat.com>
 <20170222180423.26571-2-pbonzini@redhat.com>
 <87d1e7abbb.fsf@dusky.pond.sub.org>
 <09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
In-Reply-To: <09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 09:29 AM, Paolo Bonzini wrote:

>=20
>> Here's a non-ducky way to convert between QAPI types.  QAPI guarantees=

>> that a pointer to a QAPI type is also valid as pointer to its base typ=
e.
>> One can do:
>>
>>     UserDefOne *one;
>>     UserDefOneMore *more;
>>
>>     *(UserDefOne *)more =3D *one; // get UserDefOne into UserDefOneMor=
e
>>                                 // members not in one are untouched
>>     *one =3D *(UserDefOne *)more; // set UserDefOne from UserDefOneMor=
e
>>                                 // members not in one are ignored

And rather than having to write the casts yourself, the generator
produces qapi_UserDefOneMore_base() which returns the proper UserDefOne
pointer (giving you a bit more type safety, and isolates you from any
generator change in layout).

>>
>> Would this technique suffice for your problem?
>=20
> I am not sure.  What I'm trying to do here is to keep backwards
> compatibility in case a device provides UserDefOneMore for a well-known=

> property name, and another device provides UserDefOneAnother.  As long
> as all devices provide the same (duck-typed) base class, things work.
>=20
> Maybe the right thing to do would be to define a union, but I wasn't
> sure it was possible to do that in a fully backwards compatible way (ca=
n
> you define a union where the discriminator is optional, for example?).

Not yet, although I've discussed the idea of an optional discriminator
several times before.  As soon as we have a killer use case where an
optional discriminator makes sense, it shouldn't be too hard to add that
support into the generator.

>=20
> If you're setting UserDefOne from UserDefOneMore, some of the values ar=
e
> going to be lost.  Presumably there was a reason why you used
> UserDefOneMore, and therefore an error is the safe bet.
>=20
> If you're getting UserDefOne from UserDefOneMore, some of the values ar=
e
> going to be lost.  However, it's reasonable that you didn't even know
> that UserDefOneMore existed, which makes it sensible to allow reading
> into a covariant type.

How often to we add qapi subtypes, but not adjust the rest of the code
base to cope with it existing?  Is it going to be less of a maintenance
burden just patching all the uses of the property getters to deal with
the new type than it is to keep the non-strict visitor?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CN5hFnGVPsMPhitMSohxFBuR730B4AUjg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsGVUAAoJEKeha0olJ0NqDaIIAIqGEH7YQ7sAaj09tHmS+rEM
H4KZCALaYASEuB4s/BXRqMJmeI9Mc14Zl+QuFDXs4CNDHkcuGrYtuLx/p0MPB9f3
eXv1lXfjvf5KvSzZRzEAZcNnKoyZt2FlWTekCGWNgK68diqb/2CbIsP9UwKsxHNt
wLf3J0oW0ZdRL9xaqX7IqleMsNQk9UTw/dLeLghpS4FZmDL3ZZD/y+fWuY5hdVZz
AELBjPUuRcNhJEZzQwpE84H+tla0CXk+URYZAfepwQSxuAkCG4zPfjvM/aPCUHqZ
u4bP5FCsiBLvHk2XgblCzUao9+1wwbWAK+u8QSnfVIUuchVKBVknFIeKaYBYMT8=
=wQ5e
-----END PGP SIGNATURE-----

--CN5hFnGVPsMPhitMSohxFBuR730B4AUjg--
