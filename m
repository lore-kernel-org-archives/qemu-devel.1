Received: from eggs.gnu.org ([2001:4830:134:3::10]:44202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctlGX-0002Fx-Dv
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctlGS-0002vs-I5
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctlGS-0002vd-95
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:22:08 -0400
References: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
	<de0d3d40-833b-f24b-7689-b23eb9c78244@redhat.com>
	<058D52979F67BF47BCD9EA78EAECA6DC7779F35F@SESTOEX04.enea.se>
From: Eric Blake <eblake@redhat.com>
Message-ID: <153e27df-ed6d-f562-9831-9790b584beb1@redhat.com>
Date: Thu, 30 Mar 2017 20:22:05 -0500
MIME-Version: 1.0
In-Reply-To: <058D52979F67BF47BCD9EA78EAECA6DC7779F35F@SESTOEX04.enea.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H16xra2LdWHRGFHD0J8Ec9G3v5xX2qJi5"
Subject: Re: [Qemu-devel] rbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandru Avadanii <Alexandru.Avadanii@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: svc-armband <armband@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H16xra2LdWHRGFHD0J8Ec9G3v5xX2qJi5
From: Eric Blake <eblake@redhat.com>
To: Alexandru Avadanii <Alexandru.Avadanii@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: svc-armband <armband@enea.com>, Jeff Cody <jcody@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <153e27df-ed6d-f562-9831-9790b584beb1@redhat.com>
Subject: Re: [Qemu-devel] rbd: Possible regression in 2.9 RCs
References: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
 <de0d3d40-833b-f24b-7689-b23eb9c78244@redhat.com>
 <058D52979F67BF47BCD9EA78EAECA6DC7779F35F@SESTOEX04.enea.se>
In-Reply-To: <058D52979F67BF47BCD9EA78EAECA6DC7779F35F@SESTOEX04.enea.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:05 PM, Alexandru Avadanii wrote:
> c7cacb3e7a2e9fdf929c993b98268e4179147cbb is the first bad commit
>     block/rbd: parse all options via bdrv_parse_filename

Yep, my bisect finished about 2 minutes after your email on the same
spot. I'm working on a patch.  I can reproduce the problem with a mere:

=2E/x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
-drive
'file=3Drbd:volumes/volume-ea141b5c-cdb3-4765-910d-e7008b209a70:id=3Dcomp=
ute:key=3DAQAVkvxXAAAAABAA9ZxWFYdRmV+DSwKr7BKKXg=3D=3D:auth_supported=3Dc=
ephx\;none:mon_host=3D192.168.1.2\:6789,format=3Draw,if=3Dnone,id=3Ddrive=
-virtio-disk0,serial=3Dea141b5c-cdb3-4765-910d-e7008b209a70,cache=3Dwrite=
back'

the good behavior (on my setup) just hangs trying to connect to a
non-existent machine, the bad behavior gets rather-badly misparsed
(splitting the escaped : in the host:port portion as if the port were
the next key-value pair) resulting in an instant error message. I don't
have an actual RBD setup for testing the fix, but will cc you on the
patch that I propose once I have something.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--H16xra2LdWHRGFHD0J8Ec9G3v5xX2qJi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3a89AAoJEKeha0olJ0Nqcz8H/inAQWdXyl6tbteMcaCTQ+Q9
nc7mVyXC7v7idbrhZv0RYTy4i57uoY0IsKsPHzOaSwmHVd6oAKe1mIRsG1lX6PB6
L0Zce4UeJ7QQHvLGAO0NuichoQwtJu7cKb3KyfeNkwD5Q6WIR1QeIIIWsAE9j44O
ocOcf0eXa/gb77zY/5vPVkZ4WQsD+vSSpOBT7ODkzKMIXKrCSfhZdgykSy8y9pOj
xXXybWp1na/gYHAF2HBILzvBll6FLyoMbesjmBTmvLfRO/5O6YgTp1IiWc49XpAk
ImDNGg4bSOPwcYwZIEhZuiULXNkpC/qaU8kLbhpn0MvhYzmGForQC7nA2Tr+l8I=
=Z3aX
-----END PGP SIGNATURE-----

--H16xra2LdWHRGFHD0J8Ec9G3v5xX2qJi5--
