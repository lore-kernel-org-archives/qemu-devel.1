Received: from eggs.gnu.org ([2001:4830:134:3::10]:59268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cZd7N-0006EY-J6
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cZd7M-0004fH-Na
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:37:33 -0500
Date: Fri, 3 Feb 2017 13:37:54 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170203123754.GC1528@andariel.pipo.sk>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 20:42:33 +0100, Markus Armbruster wrote:

[...]

> =3D=3D=3D Comparison =3D=3D=3D
>=20
> In my opinion, dotted keys are weird and ugly, but at least they don't
> add to the quoting mess.  Structured values look better, except when
> they do add to the quoting mess.

=46rom libvirt's point of view anything that can be easily generated from
the JSON representation into command line arguments is acceptable.
Neither uglyness, nor escaping worry us that much. Libvirt users usually
don't come into contact with the command line and if they do it's messy
anyways.

> I'm having a hard time deciding which one I like less :)

I don't like plain JSON. On the other hand I like the dotted syntax ...
mostly as I've already written the convertors for it a while ago :) [1]

Currently we already to that with anything '-object' related that we do
in libvirt (memory backing objects, master encryption key, etc) and for
a few certain network disk backing protocols:

I stole this example above:

We already generate this internally:
    '{ "file": {
       "driver": "gluster", "volume": "testvol",
       "path": "/path/a.qcow2", "debug": 9,
       "server": [ { "type": "tcp",
                     "host": "1.2.3.4", "port": "24007"},
                   { "type": "unix",
                     "socket": "/var/run/glusterd.socket" } ] } }'

And convert it to this:
>     -drive driver=3Dqcow2,file.driver=3Dgluster,
>            file.volume=3Dtestvol,file.path=3D/path/a.qcow2,file.debug=3D9,
>            file.server.0.type=3Dtcp,
>            file.server.0.host=3D1.2.3.4,
>            file.server.0.port=3D24007,
>            file.server.1.type=3Dunix,
>            file.server.1.socket=3D/var/run/glusterd.socket

There are unfortunately two implementations of the array generator:
For -object we use the repeated key method, and for gluster we use the
numbered method. It might be due to the fact that I tried to do bitmap
to array conversion, where the bitmap is represented by a list of
ranges. It was necessary for memory hotplug

Peter

[1] 331b2583ec2928b in libvirt introduces the first generator (2015/01)
    b7eef33df20dc19 adds the numbered array methot so that it can be
                    uset with gluster (2016/07)

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAliUeaAACgkQHGwCByjY
1GqdXg//fX1TwL+I+Hp8GMAmrSKPC5ccWJTAwHQtmaiw7me82PVH7htNqTd6MA+3
Gsnip17JhJPWfgXlrsFKedmNHf12GZUlSB8mTVCbsme6m31aNdrxVTZzg0T7WT9+
i9IXy+OhafWGF3yRjX2iBu5vmuR9DmkXhpwKjCEg6rvYgsvVU8uICuh81BnsdrvS
OPUbL9ZJW7Hwe3uRD/Rsl8vHSJIKeDMxkW979dWOfh6iHc5VdUON4md/6/N3EYs2
GV5BpzHnh17B7Ix/FxKYHxi7wotIxf237tyLKe060WgxJqgeMFhue/hj2m7Yd2JD
zGJ+S6h3ot31eOAhncwF/zJBN15HygZ3J59cq1VSi/tfq8sxwaXeDk0M6HxiHWGe
2+qxRw+fQAns1xQ+k5ti4g3KYp6otb/undCP30I/EhcYLNWlbS/EzWvxw90ECq5l
zGttJHOtn/pXTJfGGV3UFmWThXLgJrztmB2MDCrG+tA/pe+6lopDv/H4aAbANglK
y7+uTWDNVdX1rwUeCRmzhhOHiBclHPSsK9wrfvJA0/vyS9QcWZOtZjR4vMUja0x5
zCY+DJ32C9bSL5CajijR/+5Y/xtqnZcCQQlXdzFZMYgm/HBKu7z7PEvqwMyVxHso
zJbrOBlsZpqAULohz/mCusALy8uLCcy2wpgCW0FSA43Uq9xpAks=
=Eqfg
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
