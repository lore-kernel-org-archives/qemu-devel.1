Received: from eggs.gnu.org ([2001:4830:134:3::10]:41124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ewrhf-0002Gy-VI
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ewrhb-0006vX-3h
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:55:36 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:39316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ewrha-0006ux-PB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:55:31 -0400
Received: by mail-wm0-x231.google.com with SMTP id u10so3926212wmu.4
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 08:55:30 -0700 (PDT)
Date: Fri, 16 Mar 2018 15:55:27 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180316155527.GC21347@stefanha-x1.localdomain>
References: <1521040041089.43942@citrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <1521040041089.43942@citrix.com>
Subject: Re: [Qemu-devel] block-layer: questions on manipulation of internal
 nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Panella <stefano.panella@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 03:07:21PM +0000, Stefano Panella wrote:
> Hi everybody,
>=20
> I am a relatively new user of qemu block layer. I am interested in it mai=
nly because it looks very powerful and general and I am hoping to integrate=
 it on our product and to contribute to it for new usecases.
>=20
> I have existing use cases where we work with a model of a disk process pe=
r VM disk and I am experimenting with qemu and qmp to  build something simi=
lar.
>=20
> At the moment I have managed to build a new binary, called qemu-dp (proba=
bly should be called qemu-bl for block layer) which is basically starting a=
s a qmp server and accepting qmp block layer commands to operate on disks.
>=20
> just to give you an example this is the kind of thing I am doing:
>=20
> EXTERNALLY:
> /usr/lib64/xen/bin/qemu-img create -f qcow2 -o size=3D1M /root/a
> /usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/a -o size=3D1M /root=
/b
> /usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/b -o size=3D1M /root=
/c
> /usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/c -o size=3D1M /root=
/d
> /usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/d -o size=3D1M /root=
/e
>=20
> let's assume there were some data in every layer....
>=20
> Than:
>=20
> USING QMP:
> { "execute": "qmp_capabilities" }
> {
> 	"execute": "blockdev-add", =20
> 	"arguments": {
> 		"driver": "qcow2",=20
> 		"node-name": "qemu_node",
> 		"discard": "unmap",
> 		"cache": {
> 			"direct": true
> 		},
> 		"file": {
> 			"driver": "file",
> 			"filename": "/root/e"
> 		}
> 	}
> }
>=20
> {
> 	"execute": "nbd-server-start",
> 	"arguments": {=20
> 		"addr": {
> 			"type": "unix",
> 			"data": {
> 				"path": "/tmp/nbd.test1"
> 			}
> 		}
> 	}
> }
>=20
> {
> 	"execute": "nbd-server-add",
> 	"arguments": {=20
> 		"device": "qemu_node",
> 		"writable": true
> 	}
> }
>=20
> after this the chain looks like:
>=20
> a < b < c < d < e < NBD_server
>=20
> now I make a full copy of b and c which I call b1 and c1 and for example =
I run externally qemu-img commit c1 -> b1 while qemu-dp has still the chain=
 opened.
>=20
> I would now like to send a qmp command to tell qemu-dp to hold any IO fro=
m the NBD_server and forget about a, b, c and insert b1 as d's child, like =
this:
>=20
> a < b1 < d < e < NBD_server

Holding I/O is done via bdrv_drained_begin/end() and most block-related
monitor commands should use it.

> I have tried to implement this qmp command and looked at=20
>=20
> qmp_change_backing_file()
> qmp_x_blockdev_change()
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02660.html
>=20
> but did not figure out a way of doing that yet...
>=20
> I suspect my problem is that I am still very confused about the semantics=
 of the object model in the block layer, the ref counting, the graph manipu=
lation, the monitor etc. etc.
>=20
> I have tried to have some interactive chats on irc and they have been ver=
y useful so far (thanks again stefanha, kwolf, berto, eblake) but maybe a p=
roper email would be a good starting point as stefanha has suggested.
>=20
> Please if somebody could point me to a bit of code to achieve my example =
that would be great, otherwise if there is no code for that kind of functio=
nality, it would be good to have a little guide on the sequence of block pr=
imiteve I should call and on which node, including refs, locking, drain, ca=
ches, reopen etc...

blockdev-add and related APIs are still under development and incomplete.

Manos' block-insert-node is probably closest to what you need, so I
would start there.

I'm not clear enough on what exactly is necessary on top of Manos' patch
without doing the work myself, so I'm afraid I can't give a detailed
sequence of steps you need to take.

Stefan

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaq+jvAAoJEJykq7OBq3PIrXQIAMGRbDIvS022/HXO+GwH09He
Aky92ljGCOMgkE8qdiczyTVBOSddeNdmoyoMaCQjQPmX5rhol9NCI8roum0a9WO2
uEQ/Ja8CoJJv1A7hslnEvkMclQc6lHsrjNdzvb1Wi5OBYTTBvIzaT+9gEZ4PNArD
XCeKTKRL0vQJ83LMrQ2egLfUiWM33b5jsGC9WyV/iFKWUzLd4bFr06PZ/NwsPJKs
dRxrBpMy0jkpyuMLk2c/3hIjpNj3jj2YyRcpPIvpmQpw2F/D6/NZ82LfLd81EqhD
ymZjIbGj38btUzRSjT31dmhrN79n+h+8b0WHMxgF+hAgXH+YXBS5dzNmUxIg7KI=
=e8tZ
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
