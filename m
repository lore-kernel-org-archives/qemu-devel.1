Received: from eggs.gnu.org ([2001:4830:134:3::10]:56031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgben-0002Zb-0a
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgbel-0004VH-Hi
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:28:53 -0500
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-3-berrange@redhat.com>
	<20170222151833.GM4112@noname.str.redhat.com>
	<20170222154925.GT28937@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21ccca53-659f-aa79-3b81-6a8cf1e66ba3@redhat.com>
Date: Wed, 22 Feb 2017 12:28:42 -0600
MIME-Version: 1.0
In-Reply-To: <20170222154925.GT28937@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5S9qni9f5haUPjicHEWPE9q6pNdtiFiil"
Subject: Re: [Qemu-devel] [PATCH v5 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5S9qni9f5haUPjicHEWPE9q6pNdtiFiil
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <21ccca53-659f-aa79-3b81-6a8cf1e66ba3@redhat.com>
Subject: Re: [PATCH v5 02/18] block: add ability to set a prefix for opt names
References: <20170221115512.21918-1-berrange@redhat.com>
 <20170221115512.21918-3-berrange@redhat.com>
 <20170222151833.GM4112@noname.str.redhat.com>
 <20170222154925.GT28937@redhat.com>
In-Reply-To: <20170222154925.GT28937@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 09:49 AM, Daniel P. Berrange wrote:
> On Wed, Feb 22, 2017 at 04:18:33PM +0100, Kevin Wolf wrote:
>> Am 21.02.2017 um 12:54 hat Daniel P. Berrange geschrieben:
>>> When integrating the crypto support with qcow/qcow2, we don't
>>> want to use the bare LUKS option names "hash-alg", "key-secret",
>>> etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
>>> so that they don't clash with any general qcow options at a later
>>> date.
>>
>> Or maybe "luks.key-secret", i.e. actually embed the LUKS options QAPI
>> type into the qcow2 one? In that case, maybe qdict_extract_subqdict()
>> can even be used before calling into this, so that we don't have to
>> write a QemuOpts version of the function.
>=20
> Yeah, the use of '-' vs '.'  is a significant decision point from
> a QAPI modelling POV. Currently as you see from earlier patch, I just
> add 'luks-key-secret' straight into BlockdevOptionsQcow2. ie I duplicat=
e
> fields from QCryptoBlockOptionsLUKS straight into BlockdevOptionsQcow2.=

> Likewise for fields from QCryptoBlockOptionsQCow.
>=20
> If we used '.', we could potentially have BlockdevOptionsQcow2 directly=

> reference the QCryptoBlockOptionsLUKS & QCryptoBlockOptionsQCow structs=
=2E

Using '.' would mean a layer of {} nesting on the wire, maybe as in:

{ "driver": "qcow2", ..., "luks" : { "hash-alg": ... } }

but conceptually, I like that a bit better, as it consolidates all the
luks-related options in one place, and may indeed make it possible to
reuse the type rather than having two variants (one prefixed, one not,
depending on whether it is standalone or qcow2).

I'm also looking later in your series (13/18), where you have:


@@ -2344,7 +2348,8 @@
             '*l2-cache-size': 'int',
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
-            '*aes-key-secret': 'str' } }
+            '*aes-key-secret': 'str',
+            '*luks-key-secret': 'str' } }


Uggh - we have two optional parameters, that must not both be present at
once.  I'm wondering if we can instead do this (hmm, my patches for
anonymous base/branches in a flat union haven't been taken yet, but you
get the idea):

=2E..
'*cache-clean-interval': 'int',
'*encryption': 'Qcow2Encryption' } }

{ 'enum': 'Qcow2EncryptionType': [ 'aes', 'luks' ] }
{ 'union': 'Qcow2Encryption', 'base': { 'type': 'Qcow2EncryptionType' },
  'discriminator': 'type', 'data': {
    'aes': { 'key-secret': 'str' },
    'luks': { 'key-secret': 'str', '*hash-alg': ..., '*slot': 'int' } } }=


so that you can only provide one encryption type, but once you have that
type, you can then provide all the associated fields for that type.  So
the QMP would look like:

{ "driver": "qcow2", ..., "encryption" : { "type": "luks", "hash-alg":
=2E.. } }

>=20
> As a point of reference though, we didn't do this for the standalone
> 'luks' block driver - BlockdevOptionsLUKS contains a copy of the
> fields from QCryptoBlockOptionsLUKS because it needs to add
> inheritance from BlockdevOptionsGenericFormat.
>=20
> Both approaches have pluses & minuses and I don't have a particularly
> strong opinion either way, so interested to hear what others thing.

I think there are enough potentials for alternative designs, especially
where we can reuse code/structs without having to do prefixes, that it
is worth exploring some of those possibilities to see if they turn out
nicer.

>=20
>> However, the only option I can see at the end of this series in
>> BlockdevOptionsQcow2 is luks-key-secret, so what happened with this
>> plan?
>>
>> And if we really have only luks-key-secret (and that not in a separate=

>> sub-dict), I don't really see the need to have separate aes-key-secret=

>> and luks-key-secret options.
>=20
> Currently, all except the key-secret are create time options, not
> runtime and blockdev hasn't qapi'ified create time options. So the
> bits like luks-cipher-alg, luks-cipher-mode, etc don't appear in
> the QAPI schema, only the QemuOpts runtime_opts variable.
>=20
> That both the legacy AES & LUKS modes only have a single runtime
> option is just a co-incidence that is likely to be a temporary
> state of affairs. It is quite possible that we'll gain more runtime
> LUKS options in the future. For example, options to specify which
> precise keyslot to load, or to provide the name of a separate image
> containing a standalone luks header, etc.

See my idea above about sticking a '*slot':'int' into the schema at the
right place; made easier if the qcow2-level member 'encryption' is a
nested flat union.

>=20
> Hence, I wanted to have separation between the legacy AES & LUKS
> namespaces, to make it clear what applies to what scenario.

Again, I think the idea of a flat union, with the discriminator, makes
it easier to enforce mutual exclusion, rather than having two top-level
optional fields that cannot both be specified at once.  Maybe we should
also consider making qapi flat unions support a default discriminator,
so that the "type":"luks" can be omitted, but that's sugar.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5S9qni9f5haUPjicHEWPE9q6pNdtiFiil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrdhbAAoJEKeha0olJ0NqRhAH/iCaGcv6Xer5pYcdJi/Yr5Sn
C8jgxsOBEohHuR/6whd6E3KowVzPwLCMsGTGkhQmXvIogAygCW+Izl4Gi17eayVG
8qi6OMggMFmmu8ICYJf0Q7TZxZo9uogqkl0kkyy/dyUT/ydeAVb2ARkXuPrLDmrP
Mz9MbS/pKM3xM7+KIJxxRdVKYN1hd9q8O2oAvQSlNDFP4PWmyrKDN8Uks5Ctrf5l
D4wZs7/yuYTV6M5c+msQH+ZLaae2xlvesQasHVQg67saQAIWOWyuGIZKoRovZ3gX
95Ac6V69jxxPv4ZQG777yvASoKEWDCbmj8tD8jnssLf1Wnq0eEhb1WrAprgqlMA=
=V2PG
-----END PGP SIGNATURE-----

--5S9qni9f5haUPjicHEWPE9q6pNdtiFiil--
