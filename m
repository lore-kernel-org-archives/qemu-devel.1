Received: from eggs.gnu.org ([2001:4830:134:3::10]:45765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQDsu-0007sV-UU
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQDsr-0007Sk-QM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQDsr-0007SN-Hn
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:23:57 -0400
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<d9660b46628b52aa8c63c21fe20618b5bc33bb4c.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<20170628131852.GH29134@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66fab3ea-5033-851c-ec8e-5740c7108ab7@redhat.com>
Date: Wed, 28 Jun 2017 09:23:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170628131852.GH29134@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EHIEHrGSJBnivobjI9HJISQsdaIKnMJSC"
Subject: Re: [Qemu-devel] [PATCH v6 1/4] net/socket: Don't treat odd socket
 type as SOCK_STREAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EHIEHrGSJBnivobjI9HJISQsdaIKnMJSC
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Message-ID: <66fab3ea-5033-851c-ec8e-5740c7108ab7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] net/socket: Don't treat odd socket
 type as SOCK_STREAM
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
 <d9660b46628b52aa8c63c21fe20618b5bc33bb4c.1498654240.git.maozy.fnst@cn.fujitsu.com>
 <20170628131852.GH29134@redhat.com>
In-Reply-To: <20170628131852.GH29134@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 08:18 AM, Daniel P. Berrange wrote:
> On Wed, Jun 28, 2017 at 09:08:47PM +0800, Mao Zhongyi wrote:
>> In net_socket_fd_init(), the 'default' case is odd: it warns,
>> then continues as if the socket type was SOCK_STREAM. The
>> comment explains "this could be a eg. a pty", but that makes
>> no sense. If @fd really was a pty, getsockopt() would fail
>> with ENOTSOCK. If @fd was a socket, but neither SOCK_DGRAM nor
>> SOCK_STREAM. It should not be treated as if it was SOCK_STREAM.
>>
>> Turn this case into an Error. If there is a genuine reason to
>> support something like SOCK_RAW, it should be explicitly
>> handled.
>>

>>      default:
>> -        /* who knows ... this could be a eg. a pty, do warn and conti=
nue as stream */
>> -        fprintf(stderr, "qemu: warning: socket type=3D%d for fd=3D%d =
is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
>> -        return net_socket_fd_init_stream(peer, model, name, fd, is_co=
nnected);
>> +        error_report("qemu: error: socket type=3D%d for fd=3D%d is no=
t"
>> +                " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
>=20
> Please drop the 'qemu: error: ' prefix on the message
>=20
> Also, rather than 'is not' I suggest 'must be either'

Indentation is also off; we prefer that the second line starts right
after the ( of the first line, as in:

error_report("part 1"
             "part 2")


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EHIEHrGSJBnivobjI9HJISQsdaIKnMJSC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU7v5AAoJEKeha0olJ0NqQqcIAILqrwRTLSx7SSYMYLunnwfX
c6QCzeoF0+PYjndJa5NmmzDICgJwsJYu7vNFFqQxwm9TQkB9nh3+qBb6mp1j1kPb
XrShLgiNEicjZ6t6klxkTyVfWQO7HREkdJh5yBjWfJbRpZ1s+PmfFNQyvT9z/fxM
Wv98cg65R9OaDxGOKiaIvxHc/WfdKdkuQi2RXcAAPrwURBcaBIp82ClOTTAJQTzj
yXXMdJRiyZkK+zs6xtHMKvfKAf/KfjN1ZmtjusdrcoqgHBHIWBPYQQGBjPbVlfLq
7jNa6E5AGB0Kppy+0Pg5L4xqUTPdrbyjgM/Zi2aK37q8SspJa1VG9JAY37xOVbw=
=ARTp
-----END PGP SIGNATURE-----

--EHIEHrGSJBnivobjI9HJISQsdaIKnMJSC--
