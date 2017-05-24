Received: from eggs.gnu.org ([2001:4830:134:3::10]:50494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDYhq-000516-NG
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDYhl-0003u8-55
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:00:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDYhk-0003rE-SM
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:00:09 -0400
References: <20170524154205.1914-1-berrange@redhat.com>
	<4706484e-b8dc-b8a8-d33f-48d82302d59b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de9edf69-282b-f12e-4868-493e1b4faf40@redhat.com>
Date: Wed, 24 May 2017 11:00:05 -0500
MIME-Version: 1.0
In-Reply-To: <4706484e-b8dc-b8a8-d33f-48d82302d59b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="80nMcE8VH5tL42d9DcTDqsdadbQIaUtIT"
Subject: Re: [Qemu-devel] [PATCH] sockets: report error if UNIX socket path
 is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Simon <qemu.bugs@whitewinterwolf.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--80nMcE8VH5tL42d9DcTDqsdadbQIaUtIT
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Simon <qemu.bugs@whitewinterwolf.com>
Message-ID: <de9edf69-282b-f12e-4868-493e1b4faf40@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: report error if UNIX socket path is
 too long
References: <20170524154205.1914-1-berrange@redhat.com>
 <4706484e-b8dc-b8a8-d33f-48d82302d59b@redhat.com>
In-Reply-To: <4706484e-b8dc-b8a8-d33f-48d82302d59b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 10:54 AM, Eric Blake wrote:
> On 05/24/2017 10:42 AM, Daniel P. Berrange wrote:
>> The 'struct sockaddr_un' only allows 108 bytes for the socket
>> path. Currently QEMU uses snprintf() and so silently truncates
>> the socket path provided by the user. This is undesirable because
>> the user will then be unable to connect to the path they asked
>> for. This change makes QEMU bounds check and report an explicit
>> error message.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  util/qemu-sockets.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>

>>          snprintf(un.sun_path, sizeof(un.sun_path), "%s", saddr->path)=
;
>=20
> Pre-existing, but now that we know things fit, isn't it faster to use
> strcpy (or strpcpy or strncpy) instead of the overhead of snprintf?
>=20
> You're on the right track, but it may be worth a v2 for further cleanup=
s.

Oh, and while there, I noticed:

        tmpdir =3D tmpdir ? tmpdir : "/tmp";
        if (snprintf(un.sun_path, sizeof(un.sun_path),
"%s/qemu-socket-XXXXXX",
                     tmpdir) >=3D sizeof(un.sun_path)) {
            error_setg_errno(errp, errno,
                             "TMPDIR environment variable (%s) too
large", tmpdir);

but 'errno' is NOT required to be set when snprintf() returns a larger
value, so our error message is (likely) garbage.  Better might be
calling error_setg_errno(errp, ENAMETOOLONG, ...), or just living with
the simpler error_setg().

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--80nMcE8VH5tL42d9DcTDqsdadbQIaUtIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJa4FAAoJEKeha0olJ0NqkxcH/1CTJbO/F6BwQK8oJaAeQQUv
l0MjQXREWDtsS1zh9gSpEIQxf/iAWI69GhX4rde405MJbaF6jXxRhk66qzqE6TSn
WucV7Kc93FTKP51SwSUchrWEzOcOOEOI13Yur86t2gEtqXf5EDOOvkqO8/cm384N
jQSR3BSG2Pg5uFx/exItmzNsjLWC+4t0uVV3Y7BVPMOO1+T5kmB7xMnLrfbi3j7W
BczN3hn7PXVJUBoQid1EJS/D+sbd3P8UWOv19RPqmUNpl+CAdxqIFpTRwAW9D/Mi
BOeqJt9i47CXp1p3ZrVj8Ca2n5rzZ/tzRtsOXt3AiotjB0PRstvk6qIMqjNVXvM=
=VBto
-----END PGP SIGNATURE-----

--80nMcE8VH5tL42d9DcTDqsdadbQIaUtIT--
