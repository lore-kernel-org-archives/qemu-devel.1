Received: from eggs.gnu.org ([2001:4830:134:3::10]:48325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcAC-0000YW-LS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcAB-000567-Ii
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:43:36 -0500
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-3-stefanha@redhat.com>
	<CANz-nerKaY_NG4enTxut9RuerWGL47sNKkgtJ_QpHws75ckO7A@mail.gmail.com>
	<CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <72f1506e-1ed3-183d-db5e-06670241add6@redhat.com>
Date: Wed, 7 Mar 2018 17:43:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lscbzhbJXE7S17nEmHL8BPocA4tUpeSYV"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] iotests: add 208
 nbd-server + blockdev-snapshot-sync test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefano Panella <spanella@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lscbzhbJXE7S17nEmHL8BPocA4tUpeSYV
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefano Panella <spanella@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Message-ID: <72f1506e-1ed3-183d-db5e-06670241add6@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/2] iotests: add 208 nbd-server +
 blockdev-snapshot-sync test case
References: <20180306204819.11266-1-stefanha@redhat.com>
 <20180306204819.11266-3-stefanha@redhat.com>
 <CANz-nerKaY_NG4enTxut9RuerWGL47sNKkgtJ_QpHws75ckO7A@mail.gmail.com>
 <CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
In-Reply-To: <CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-07 11:55, Stefan Hajnoczi wrote:
> On Tue, Mar 6, 2018 at 11:25 PM, Stefano Panella <spanella@gmail.com> w=
rote:
>> I have applied this patch and when I run the following qmp commands I =
I do
>> not see the crash anymore but there is still something wrong because o=
nly
>> /root/a is opened from qemu. It looks like nbd-server-stop is also get=
ting
>> rid of the nodes added with blockdev-snapshot-sync, therfore is than n=
ot
>> possible to do blockdev-del on /root/d because node-name is not found
>=20
> Nodes are reference counted.  If nothing holds a refcount then the
> node is freed.
>=20
> The blockdev-add command holds a reference to the node.  The node will
> stay alive until blockdev-del, which releases that reference.
>=20
> blockdev-snapshot-sync does not hold a reference.

I think that's a bug.  When you specify a node name for the new node, it
should get a reference.

>                                                    Therefore snapshot
> nodes are freed once nothing is using them anymore.  When the snapshot
> node is created, the users of the parent node are updated to point to
> the snapshot node instead.  This is why the NBD server switches to the
> snapshot mode after blockdev-snapshot-sync.
>=20
> This is why the snapshot nodes disappear after the NBD server is
> stopped while /root/a stays alive.
>=20
> I'm not sure if the current blockdev-snapshot-sync behavior is useful.
> Perhaps the presence of the "snapshot-node-name" argument should cause
> the snapshot node to be treated as monitor-owned, just like
> blockdev-add.  This would introduce leaks for existing QMP clients
> though, so it may be necessary to add yet another argument for this
> behavior.

That's true.

> Anyway, I hope this explains the current behavior.  I don't see a
> problem with it, but it's something the API users need to be aware of.

Hm, OK.

As an explanation: blockdev-snapshot-sync is from before we had node
names and blockdev-add.  You'd just create something that needs the
block layer (like a guest device or an NBD server) and then you'd open
the BDS chain you want to go with it (mostly by just specifying the
filename of the top image, and maybe its format).

Then you'd use blockdev-snapshot-sync to just create an overlay during
runtime, and since there weren't any node names it was clear that it
would go away if you deleted whatever was using the chain (like the NBD
server).

Then we introduced node names, and blockdev-snapshot-sync gained the
ability to give one to the overlay -- basically as an afterthought.  I
think we didn't really have a fleshed-out concept of monitor references
back then...  So we forgot to give the overlay an additional reference
in such a case (because we didn't know better).

As you pointed to in your other reply, blockdev-snapshot is the "pure"
blockdev command that should ideally be used.  It allows you much more
control over the overlay (because you have to do the blockdev-add
yourself), and it doesn't have this reference issue.

Max


--lscbzhbJXE7S17nEmHL8BPocA4tUpeSYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgFqYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnpQH/j2YAIZ/Zp2SJwuGjxrgKQqg8C3NZe9V
w/VBI2jVn4vkrT/+41xZD+/ysNJmFoAaL4dKrlELq+hJkuTFHREiV9wQ5Y4+ozfe
yjGQ6pPPZWCVZ75aLlqXsnWh7sCPUhp8+yU96FoVRcUxk9Vj3PHLEUtgE9Tj+Q7T
zNBTD7JN/xvZ74OxASINcOqVzpAX9SEi0vY1sUeMVF8zvEeL5ZSrrayZtj7AhxvW
XlZlMZ91dn67/zzOWAS6lhtdzAnQCEyy5gqmrT5MHYIPeNN9zpT0y6pHRbIF+yJn
iDKgymIBj7mL4DoG1NKWubvCDcfwbrjspVLIfccyStIcQfz9c+w6eQY=
=5c71
-----END PGP SIGNATURE-----

--lscbzhbJXE7S17nEmHL8BPocA4tUpeSYV--
