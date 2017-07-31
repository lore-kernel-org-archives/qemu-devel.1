Received: from eggs.gnu.org ([2001:4830:134:3::10]:59191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9uX-0000dc-Gp
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9uU-0005Ag-BO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dc9uU-00058s-1j
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:34:58 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<20170728125759.GO12364@stefanha-x1.localdomain>
	<eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
	<7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
	<871soxaumw.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
Date: Mon, 31 Jul 2017 07:34:51 -0500
MIME-Version: 1.0
In-Reply-To: <871soxaumw.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NSmLCKDKg5WtKCrHJQNuCNiUf4SpAV1DK"
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NSmLCKDKg5WtKCrHJQNuCNiUf4SpAV1DK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-8-eblake@redhat.com>
 <20170728125759.GO12364@stefanha-x1.localdomain>
 <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
 <7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
 <871soxaumw.fsf@dusky.pond.sub.org>
In-Reply-To: <871soxaumw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 03:16 AM, Markus Armbruster wrote:

>>>> qtest_qmp(s, "%p", QOBJECT(dict)) takes ownership of dict?
>>>

>> So given the clean bill of health from valgrind, we definitely DO turn=

>> over responsibility for freeing on object to its new wrapper, once it =
is
>> passed through %p.  Documentation could be improved to make that clear=
=2E
>>
>> Eww, what happens if qobject_from_jsonf() can fail halfway through? If=

>> you mix %p with other stuff, how do you know on failure whether the
>> reference was taken or not yet reached?  Maybe the testsuite needs an
>> enhancement.
>=20
> What we actually need is qobject_from_jsonf() behaving sanely failure!

Agreed.  Looks like my v4 series will have another up-front patch to
clean things up.

> Either it takes over all references (just like on success) or none.

Taking over references is probably more convenient (we usually succeed,
where it really is easier to just free the new owner recursively, so
always reducing a reference even on failure is something that can easily
be reasoned about - and if the caller wants to hang on, they can
increase refcount).

>=20
> It delegates the part of its job that's relevant here to json-parser.c.=

> Looks like parse_escape() takes over the reference greedily.  If parsin=
g
> fails, it's released along with all the refernces to objects the parser=

> built.
>=20
> One way to do "none": delay taking over the reference until parsing
> succeeded.  Increment it in parse_escape(), decrement it in
> json_parser_parse_err().  Either hold %p arguments in JSONParserContext=
,
> so json_parser_parse_err() can find them easily, or iterate over @token=
s
> and @ap again.
>=20
> One way to do "all": on error, have json_parser_parse_err() iterate ove=
r
> remaining @tokens and @ap to consume references.

I'm leaning towards "all".  And of course, the very first thing is a
patch to the testsuite with two %p separated by something that causes a
mid-string parse error (but at the same time does not trip up -Wformat).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NSmLCKDKg5WtKCrHJQNuCNiUf4SpAV1DK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/I+sACgkQp6FrSiUn
Q2rlegf/XQo5MwQAjEbLq7yP6G5j6CNvjOUSV/fPNwb0tp/0w7DsRduylPQz/UB1
fdfOgL/48ghVLVmwge9lJXrUZjQKjRiNS0DBJD48AZd54IWXdSDcTN3rE+3j8U9m
Rxpn8omwigLP9ehi5V2KYfMpOjsFHpBx8vE3UttiL9owF3oY9IgjLaI93jbwCnsw
vJHyIzL/UcRIukErjo5B+8pUa3k69iD0I2lKMQDTXQ7QSxh5ykBnQ6wyOKTEcQZV
xau3Wka+WbngB+gvgGhaMuiBhGFDksWNxU2JYFrAkPZjSfqvHQ1ALP23GPCxPskq
FW9N46kMd6A8yQpGvu1ZMNF6feNbnw==
=PMXZ
-----END PGP SIGNATURE-----

--NSmLCKDKg5WtKCrHJQNuCNiUf4SpAV1DK--
