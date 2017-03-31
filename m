Received: from eggs.gnu.org ([2001:4830:134:3::10]:55941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctkbd-0001U6-De
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 20:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctkba-0003Fk-Bo
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 20:39:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctkba-0003FF-30
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 20:39:54 -0400
References: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de0d3d40-833b-f24b-7689-b23eb9c78244@redhat.com>
Date: Thu, 30 Mar 2017 19:39:50 -0500
MIME-Version: 1.0
In-Reply-To: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mpm1g2FgAeAqX6E7ceCpqbDMLgvrjxWjk"
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
--mpm1g2FgAeAqX6E7ceCpqbDMLgvrjxWjk
From: Eric Blake <eblake@redhat.com>
To: Alexandru Avadanii <Alexandru.Avadanii@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: svc-armband <armband@enea.com>, Jeff Cody <jcody@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <de0d3d40-833b-f24b-7689-b23eb9c78244@redhat.com>
Subject: Re: [Qemu-devel] rbd: Possible regression in 2.9 RCs
References: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
In-Reply-To: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 06:42 PM, Alexandru Avadanii wrote:
> Hi,
> While testing out 2.9.0-rc2 on AArch64, we noticed a possible regressio=
n in QEMU, related to parsing -drive 'file=3Drbd/...':
>> "conf option 6789 has no value".
>=20
> Instance logs [1].

Pastebins don't last forever; it helps to paste the actual error message
in the email for archival purposes, and to make it easier for readers to
see your problem without having to chase URLs:

2017-03-30T20:02:27.499695Z qemu-system-aarch64: -drive
file=3Drbd:volumes/volume-ea141b5c-cdb3-4765-910d-e7008b209a70:id=3Dcompu=
te:key=3DAQAVkvxXAAAAABAA9ZxWFYdRmV+DSwKr7BKKXg=3D=3D:auth_supported=3Dce=
phx\;none:mon_host=3D192.168.1.2\:6789,format=3Draw,if=3Dnone,id=3Ddrive-=
virtio-disk0,serial=3Dea141b5c-cdb3-4765-910d-e7008b209a70,cache=3Dwriteb=
ack:
conf option 6789 has no value

Looking at that, the only instance of 6789 that I see is the
'mon_host=3D192.168.1.2\:6789,' portion.  I bet what is happening is that=

we are mis-parsing the string, and trying to treat it as a key-values
pair.  In other words, it's probably an unintended regression introduced
in the range of 7830f909..0a55679b by Jeff [3] or in Markus' cleanups
between f51c363c..2836284d [4].

On the bright side, we still have time to fix it before 2.9 goes final,
now that you called it to our attention.

> Occasionally, we get "conf option too long", with the same effect.
>=20
> We bisected this manually between 2.8.0 (working ok with the above cmd)=
 and 2.9.0-rc2, and the problematic change seems to be the merge point [2=
].

I suspect you didn't run the bisect quite correctly, as that merge point
has nothing to do with block/rbd.c.

>=20
> [1] http://paste.openstack.org/show/604938/
> [2] https://github.com/qemu/qemu/commit/9a81b79
>=20

[3] https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07506.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05565.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--mpm1g2FgAeAqX6E7ceCpqbDMLgvrjxWjk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3aVWAAoJEKeha0olJ0NqcQ0H/1g+fiPErb3PndckAIncEyD5
90NY1XWppMrxWIvvMFEcvJfeTDE5Cd00Y9rbpWULRL0c/me0zGgkc9Z8hkjOgfxR
c6uydC0td0XNCeHo6GMdanAwnjT0Ji0mTeja1dzeXwFI4FrpIGa1N4Upum1YxkKm
E+JU2W3SIJQCpQ+BGx3gtOQQyJeHFWiTtN9VbIDrey4QpqcVNROMPQq5b+08ijHC
IepDTcah4fJ5hCkOu+/hQlrCU9kxKWYA1oiEe0PuIBCu/WD6WX87ibV4TCMlhqlU
JHpQQoQF2qnO/Aja1kztXObZWhfhFH0XvNdTQx3+gXBo4gEGFuo6UhoqBdCO4j4=
=FV80
-----END PGP SIGNATURE-----

--mpm1g2FgAeAqX6E7ceCpqbDMLgvrjxWjk--
