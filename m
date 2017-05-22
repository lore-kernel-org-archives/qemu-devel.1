Received: from eggs.gnu.org ([2001:4830:134:3::10]:34143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrAc-0005v0-Q2
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrAZ-0004hJ-Ea
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:31:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCrAZ-0004gl-6C
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3A3F811AC
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:30:57 +0000 (UTC)
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-6-berrange@redhat.com>
	<b8303243-384c-88a5-b372-c6e3e429e628@redhat.com>
	<20170522165650.GG25655@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d68a34b-d248-ab1e-0825-0ed7fdc1774a@redhat.com>
Date: Mon, 22 May 2017 12:30:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170522165650.GG25655@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="agrQ4bp4S1dnHbmEFq4G8eKE3GEnxNF9c"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tests: add functional test
 validating ipv4/ipv6 address flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--agrQ4bp4S1dnHbmEFq4G8eKE3GEnxNF9c
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <8d68a34b-d248-ab1e-0825-0ed7fdc1774a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tests: add functional test validating
 ipv4/ipv6 address flag handling
References: <20170519180342.19618-1-berrange@redhat.com>
 <20170519180342.19618-6-berrange@redhat.com>
 <b8303243-384c-88a5-b372-c6e3e429e628@redhat.com>
 <20170522165650.GG25655@redhat.com>
In-Reply-To: <20170522165650.GG25655@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 11:56 AM, Daniel P. Berrange wrote:
> On Mon, May 22, 2017 at 11:00:26AM -0500, Eric Blake wrote:
>> On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
>>> The semantics around handling ipv4=3Don|off & ipv6=3Don|off are quite=

>>> subtle to understand in combination with the various hostname address=
es
>>> and backend types. Introduce a massive test matrix that launches QEMU=

>>> and validates the ability to connect a client on each protocol as
>>> appropriate.
>>>
>>> The test requires that the host has ability to bind to both :: and
>>> 0.0.0.0, on port 9000. If either protocol is not available, or if
>>> something is already listening on that port the test will skip.
>>>

>>
>> 'make check' passed for me with your patches (on a system with both IP=
v4
>> and IPv6 support), so:
>>
>> Tested-by: Eric Blake <eblake@redhat.com>
>>

I take that back. While the sequential version passed, 'make -j3 check'
failed:

ERROR:tests/test-sockets-proto.c:774:test_listen: assertion failed:
(data->error)
GTester: last random seed: R02Sb234b038cf2cb256668c3f8d68b73cb6
**
ERROR:tests/test-sockets-proto.c:805:test_listen: assertion failed:
(child !=3D 0)
GTester: last random seed: R02S9da269b6008df86a92d3fa931b311f54
**
ERROR:tests/test-sockets-proto.c:774:test_listen: assertion failed:
(data->error)
GTester: last random seed: R02S40fd0cddf35acf3acdde9c1d0bc5430c

Probably because it raced between two separate qtest programs (in my
case, check-qtest-x86_64 ran in parallel with check-qtest-ppc64), at
which point there was competition for port 9000 that survived past the
initial check but not for the complete test run.

Can you make the test a bit more robust by finding a free port during
initial setup for all the tests to hammer on, rather than hard-coding 900=
0?

>>> +int main(int argc, char **argv)
>>> +{
>>> +    int ret;
>>> +    gsize i;
>>> +
>>> +    if (check_protocol_support() < 0) {
>>> +        return 0; /* Skip test if we can't bind */
>>
>> We don't have a magic number for skipped tests?  Many projects use exi=
t
>> status 77 (rather than 0) to delineate a test that did not fail, but
>> whose skip results cannot be used as conclusive evidence of passing.  =
At
>> any rate, you've answered my question earlier - you do behave sanely i=
f
>> you cannot test both IPv4 and IPv6 on a given host.
>=20
> I thought about using status 77, but that doesn't seem to be done in
> QEMU unit tests, so I stuck with 0.

Yeah, cleaning that up is a separate series, if ever.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--agrQ4bp4S1dnHbmEFq4G8eKE3GEnxNF9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIyBNAAoJEKeha0olJ0NqVlUIAKtTOcHkJcV4jkTA+Y0Wp9+b
cKfu9Os6w1zQ6CV5/06d/rk/DMpteC+pgU8PZn6mfNwCCp/vrYWyjIb2NVZ/gwiL
eXr7cgO0j5tW3xMSuzBnjWpisFhBRmYSvLH32XhNk4CkR1JxOzuzZlx0Ffmy5KBH
/4dnadRH8F8YOPYLACuj137+B8DsIvNzBARVxMOln3PqiWOZFaPEApl2Bq+0fZfC
itCuX3SOXW96pmyAc16blLAwrpc7tGng5mSdZ+MAuKSV4WKnzBw5mpW9sSFXnrPM
m65dUkR5SMgvGHbTfwnGm5GU5fdMVSMap3VSLzVhbjDAg/HYNcdoTuPjSyLvAYc=
=Vj++
-----END PGP SIGNATURE-----

--agrQ4bp4S1dnHbmEFq4G8eKE3GEnxNF9c--
