Received: from eggs.gnu.org ([2001:4830:134:3::10]:35756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cULhS-0007ti-DH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 18:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cULhP-00064n-61
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 18:00:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cULhO-000640-TF
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 18:00:55 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-5-git-send-email-mst@redhat.com>
	<aa9a259a-a649-d399-5895-837a5a23f56c@redhat.com>
	<20170120000636-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <459939cd-4f0e-bc08-7de8-5788e6f2e2aa@redhat.com>
Date: Thu, 19 Jan 2017 17:00:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170120000636-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cKFL7xSmAmtBLdc6QuH9xeOpp0w8b9t2h"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] ARRAY_SIZE: check that argument is
 an array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Sergey Fedorov <serge.fdrv@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cKFL7xSmAmtBLdc6QuH9xeOpp0w8b9t2h
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Sergey Fedorov <serge.fdrv@gmail.com>
Message-ID: <459939cd-4f0e-bc08-7de8-5788e6f2e2aa@redhat.com>
Subject: Re: [PATCH v3 4/4] ARRAY_SIZE: check that argument is an array
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
 <1484859998-25074-5-git-send-email-mst@redhat.com>
 <aa9a259a-a649-d399-5895-837a5a23f56c@redhat.com>
 <20170120000636-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170120000636-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 04:11 PM, Michael S. Tsirkin wrote:

>>> +#define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), \=

>>> +                                                        typeof(&(x)[=
0])))
>>>  #ifndef ARRAY_SIZE
>>> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>> +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>>> +                       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>>
>> We've got some double-negation going on here ("cause a build bug if th=
e
>> negation of QEMU_IS_ARRAY() is not 0") which takes some mental
>> gymnastics, but it is the correct result.  [I kind of like that gnulib=

>> uses positive logic in its 'verify(x)' meaning "verify that x is true,=

>> or cause a build error"; compared to the negative logic in the kernal
>> 'BUILD_BUG_ON[_ZERO](x)' meaning "cause a build bug if x is non-zero" =
-
>> but that's personal preference and not something for qemu to change]
>=20
> I can rename QEMU_IS_ARRAY to QEMU_IS_PTR and reverse the logic - would=

> this be preferable?

No, that's worse. As written, "cause a build bug if x is not an array"
is easier than "cause a build bug if x is a pointer", because now you
are missing an implicit "(instead of the intended array)".  Keep it the
way you have it.  I guess it's the _ZERO as a suffix that's throwing me;
a better name might have been QEMU_ZERO_OR_BUILD_BUG_ON(x) ("give me a
zero expression, or a build bug if x is non-zero") rather than
QEMU_BUILD_BUG_ON_ZERO (my first read was "give me a build bug if x is
zero", but a better read is "give me a build bug if x is not zero, else
give me x because it is zero") - but our choice of naming in patch 3/4
mirrors the kernel naming, so it's not worth changing.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cKFL7xSmAmtBLdc6QuH9xeOpp0w8b9t2h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgUUkAAoJEKeha0olJ0NqqfAIAJquUAsXLy+bZA1QfJ8+Qq3a
IA54z74I3FI2bej48bWrDGdCCgM+VYJqtMoGrIqLGBZs6l2nK5pUs3HujQrhDRA+
H5CwIiW5o/MdypCG+9LTbcL2i70ceEtqkC3D12sTxrdaeFe+/l6adAtwEPuJLUU7
/+lD9HOxWOE0c4dst1WI/VK1OZZ0g0T3nelSrnlmQS+6xC4bAQCz7rHtLzZOI/yi
X3WYoBOKtvAY5Ch1iDeqR51bl4WB7CDEGhFNuefc6YVJse3wQfMvtlSZk1W9rws4
8rCXX2Tg0xXcFxkT8eGSRuHsHAD2/LZtojMdIRCXd+DNLc7HFgrRGsUdXIN9Aw8=
=ApjR
-----END PGP SIGNATURE-----

--cKFL7xSmAmtBLdc6QuH9xeOpp0w8b9t2h--
