Received: from eggs.gnu.org ([2001:4830:134:3::10]:43629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfwM-0002T0-Ue
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfwL-0000Oq-RE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:22:06 -0400
References: <20170713092100.GD4011@redhat.com>
	<e0a85555-aaa9-c2d0-efc7-8a932ca8a915@kamp.de>
	<20170713140022.GN4011@redhat.com>
	<1f4ca3cc-b17b-b577-f5a7-5d550c387cb5@kamp.de>
	<20170713140711.GO4011@redhat.com>
	<4648fb64-c1ea-0962-0123-2326769a07c2@kamp.de>
	<20170713145801.GP4011@redhat.com>
	<37d97fcb-aa71-1ed4-2134-6d308da7b527@kamp.de>
	<20170713150148.GQ4011@redhat.com>
	<2c5db580-1e3e-9b82-2768-ba2510173387@kamp.de>
	<20170713150652.GR4011@redhat.com>
	<07042f09-594a-a288-588b-59c70479c414@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2348778a-dfff-804f-32f7-4325f7347633@redhat.com>
Date: Thu, 13 Jul 2017 10:21:56 -0500
MIME-Version: 1.0
In-Reply-To: <07042f09-594a-a288-588b-59c70479c414@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q9hheDLKPO9l2ouaDQswh3Vp4sItpJSFm"
Subject: Re: [Qemu-devel] [PATCH V2 5/8] block/qcow2: read and write the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q9hheDLKPO9l2ouaDQswh3Vp4sItpJSFm
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <2348778a-dfff-804f-32f7-4325f7347633@redhat.com>
Subject: Re: [PATCH V2 5/8] block/qcow2: read and write the compress format
 extension
References: <20170713092100.GD4011@redhat.com>
 <e0a85555-aaa9-c2d0-efc7-8a932ca8a915@kamp.de>
 <20170713140022.GN4011@redhat.com>
 <1f4ca3cc-b17b-b577-f5a7-5d550c387cb5@kamp.de>
 <20170713140711.GO4011@redhat.com>
 <4648fb64-c1ea-0962-0123-2326769a07c2@kamp.de>
 <20170713145801.GP4011@redhat.com>
 <37d97fcb-aa71-1ed4-2134-6d308da7b527@kamp.de>
 <20170713150148.GQ4011@redhat.com>
 <2c5db580-1e3e-9b82-2768-ba2510173387@kamp.de>
 <20170713150652.GR4011@redhat.com>
 <07042f09-594a-a288-588b-59c70479c414@kamp.de>
In-Reply-To: <07042f09-594a-a288-588b-59c70479c414@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 10:13 AM, Peter Lieven wrote:
>>>>>>
>>>>>>> I currently have the following:
>>>>>>>
>>>>>>>        options =3D qemu_opts_to_qdict(opts, NULL);
>>>>>>>        qdict_extract_subqdict(options, &compressopts, "compress."=
);

Can you show your .json patches as well?

> Yes, but visit_type_Qcow2Compress_members always returns an error if
> compress.format
> is missing from the options. So I should not call it an error out if
> compress.format is not in the
> options. Thus the check if either compress.format or compress.level is
> specified at all.

In the JSON, you want '*compress':'CompressUnion' (or some such name)
(overall, the user does not have to specify compression); but within
CompressUnion, you want 'format' to be unconditional (it is the
discriminator), and then branches of the union to add whatever other
fields match the enum members covered by 'format'.

{ 'enum': 'CompressionType', 'data': [ 'gzip', 'lzo' ] }
{ 'union': 'CompressUnion', 'discriminator': 'format',
  'base': { 'format': 'CompressionType', '*level': 'int' },
  'data': { 'gzip': {...any gzip-specific extras}, 'lzo': {...any
lzo-specific extras} } }

[hmm, I think I'm STILL missing my patches to allow for an anonymous
base...  I should rebase and send those; but in the meantime, you'll
have to create a separate 'CompressBase' struct and use
'base':'CompressBase' instead]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q9hheDLKPO9l2ouaDQswh3Vp4sItpJSFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ5AUAAoJEKeha0olJ0Nq8FsH/0qskuQ6CldZMu+W29KfU989
7HGc6ljFp9hzdZ7cbEeOFO47PV68DtEm6ZqXAi5Cq9CtxsDuZDgluoxB1RYmxYDt
h38I9+UrGSeJqtc3D4h0YEc1EdEBZP9kzhdicaCK4tdTwFqbqI004m0D/QuksNr7
bbEU74mpxnLa92gs0ntuI+XQq1DE0XiivpOd/IlSCAdFvcGQ6Cq2OezvMyfp16Vn
Oj7TAp0W35FxpKmFEowLTIdlaLgvfdcd/0FfRqLsKZ0RfIaAMLZ1ZwqsR9L4Z/mZ
2h+n5l++0+cspCADeYmWGOyVkEY8YEYNXf3irp9tvBU6iSKzqCoH3p02RHoBNiI=
=nB86
-----END PGP SIGNATURE-----

--Q9hheDLKPO9l2ouaDQswh3Vp4sItpJSFm--
