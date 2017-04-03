Received: from eggs.gnu.org ([2001:4830:134:3::10]:39420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7uQ-0005s0-22
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7uM-0003P1-TM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cv7uM-0003Oo-K9
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:58 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d684062-be31-153e-3f94-b1193440c8e3@redhat.com>
Date: Mon, 3 Apr 2017 14:44:47 -0500
MIME-Version: 1.0
In-Reply-To: <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gG6gjmp6xLvGpUR7j9TlTIvVo5ipdRp7i"
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, pkrempa@redhat.com, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gG6gjmp6xLvGpUR7j9TlTIvVo5ipdRp7i
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, pkrempa@redhat.com,
 Alexandru Avadanii <Alexandru.Avadanii@enea.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 svc-armband <armband@enea.com>
Message-ID: <4d684062-be31-153e-3f94-b1193440c8e3@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
 <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
 <20170403081542.GA5036@noname.str.redhat.com>
 <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
In-Reply-To: <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 07:39 AM, Max Reitz wrote:
>>> As for just allowing the NBD server write access to the device... To =
me
>>> that appears pretty difficult from an implementation perspective. We
>>> assert that nobody can write without having requested write access an=
d
>>> we make sure that nobody can request write access without it being
>>> allowed. Making an exception for NBD seems very difficult and would
>>> probably mean we'd have to drop the assertion for write accesses alto=
gether.
>>
>> Making an exception would simply be wrong.
>=20
> Indeed. That is why it would be so difficult.
>=20
> The question remains whether it is practical not to make an exception.
> As far as I know, libvirt is only guaranteed to support older qemu
> versions, not necessarily future ones. So we should be allowed to break=

> existing use cases here until libvirt is updated (assuming it is
> possible for libvirt to express "guest device allows shared writes" as
> an option for its next release).

In general, we support:

old qemu, old libvirt (well, as long as those versions are supported)
old qemu, new libvirt
new qemu, new libvirt

but we do NOT make any guarantees of supporting

new qemu, old libvirt

In other words, this may be a failure where new qemu requires extra care
and thus a new libvirt for it to be useful.  It's not nice to break qemu
back-compat if any other solution is possible (new qemu and old libvirt
should work more often than not), but it is the one scenario that no one
supports (whether here, upstream libvirt, or in downstream backports).

Or, put another way, it's perfectly fine if we require that the use of
qemu 2.9 requires that you also use libvirt 3.3.0 or newer (since we
missed the boat on fixing libvirt 3.2 to pass shared-rw or any other
handshaking we come up with), although it's also nice if we figure out
how to make qemu work with what existing libvirt wants to do (the NBD
export needs to be writable by the source pre-migration, and by the
destination post-migration; so there is that aspect of two clients both
wanting to write - but the destination doesn't need to write until after
the source no longer has anything to write, so if we have a clean way to
turn writes off for the source, then turn writes on for the destination,
all before migrating which host is writing, that would be even cleaner).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gG6gjmp6xLvGpUR7j9TlTIvVo5ipdRp7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4qYvAAoJEKeha0olJ0Nq7/kH/1J0ml+NrnVbAN3YiUDTNEqT
cubXK/kgS8ubqEhUvL0c9/d0BHrPkXBUAcNlaih9TiKF9zPYFhsmRep2i7VVCyrH
BMdqTkynGL47NgvqIyBclWq3IjAMPAa7Bcw26W38KydyAFFKIRiBNZ/BRv1t4Pil
ksmowOH8cGvfX7+Ypy/veWkb0ROXwH4ExQb/87bRqyey0pdxb0FetxMaHonOIGQz
S5yspvzpUpAcEzc/5Eq0ci1XKbf5z07i9jzewAPF4Ua1TDHqprI6OX0z+8ktc9ry
WdlCf9d34eq5dBAOnY77fE1cxOWwQGJmTO/zsSl6AWc334Gon93BFA5WRjAgDB0=
=X1rn
-----END PGP SIGNATURE-----

--gG6gjmp6xLvGpUR7j9TlTIvVo5ipdRp7i--
