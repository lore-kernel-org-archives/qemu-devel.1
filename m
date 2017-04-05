Received: from eggs.gnu.org ([2001:4830:134:3::10]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvoOe-0006Kk-So
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvoOb-0000qF-O5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cvoOb-0000ps-FM
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:07:01 -0400
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-18-marcandre.lureau@redhat.com>
	<20170405161256.GA25291@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f015621-19aa-d70b-6103-fef6514fcd7e@redhat.com>
Date: Wed, 5 Apr 2017 12:06:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170405161256.GA25291@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5wGMWpf7vvinJ40Wi2OqvMgiOTOmT31QN"
Subject: Re: [Qemu-devel] [PATCH 17/21] virtio-channel: parse qga stream for
 VMDUMP_INFO event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, qemu-devel@nongnu.org, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5wGMWpf7vvinJ40Wi2OqvMgiOTOmT31QN
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, qemu-devel@nongnu.org,
 anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com
Message-ID: <2f015621-19aa-d70b-6103-fef6514fcd7e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/21] virtio-channel: parse qga stream for
 VMDUMP_INFO event
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
 <20170311132256.22951-18-marcandre.lureau@redhat.com>
 <20170405161256.GA25291@redhat.com>
In-Reply-To: <20170405161256.GA25291@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/05/2017 11:12 AM, Daniel P. Berrange wrote:
> On Sat, Mar 11, 2017 at 05:22:52PM +0400, Marc-Andr=C3=A9 Lureau wrote:=

>> On virtio channel "org.qemu.guest_agent.0", parse the json stream unti=
l
>> the VMDUMP_INFO is received and retrieve the dump details.
>>

>=20
> so we just continually feed data into the json parser until we see the
> event we care about....
>=20
> What kind of denial of service protection does our JSON parser have. No=
w
> that QEMU is directly parsing JSON from QEMU guest agent, it is exposed=

> to malicious attack by the guest agent.

Our JSON parser rejects input that exceeds various limits:

json-lexer.c:
#define MAX_TOKEN_SIZE (64ULL << 20)

json-streamer.c:
#define MAX_TOKEN_SIZE (64ULL << 20)
#define MAX_TOKEN_COUNT (2ULL << 20)
#define MAX_NESTING (1ULL << 10)

>=20
> eg what happens if the 'vmcoreinfo' string in the JSON doc received fro=
m
> the guest ends up being 10GB in size ? Is that going to cause our JSON
> parser to allocate QString which is 10GB in size which we'll further
> try to strdup just below too...

The parser will have rejected the guest data long before the 10GB mark.
But our error recovery from that rejection may not be ideal...


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5wGMWpf7vvinJ40Wi2OqvMgiOTOmT31QN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5SQwAAoJEKeha0olJ0NqrV4H/iM+BITQZBWxUypAPadu7IjB
kTuhju0pSGBI8//LZtMN7tmsvSXDhY2ks6e+au+aqAPRoDlUBU6KZTmy28+/+uaA
J35ACS6hDte24fKdaFyq3qWmtXp5/TyVHcmDcB4GFiNWbgfC+kcEMR8lhZHm90hE
UeBqkiy9srJ+I4z5aKd9V3WQdKLRayG1RilfTwrbu7Y/es78Yf/Zz2ifWRGeRA/b
qhoneCUxMsJoHrPhQSXE3Alr/57M3MQkT8srSI60KFYoJCPhsJCeTAWJoTxp3tmi
Pk1XKEK+uFVlqu7FIX3vJLPiHCOleHTWydOTQnDzA6Rrj4oGapesJhJizts/BIU=
=2WX3
-----END PGP SIGNATURE-----

--5wGMWpf7vvinJ40Wi2OqvMgiOTOmT31QN--
