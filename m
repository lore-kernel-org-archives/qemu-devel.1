Received: from eggs.gnu.org ([2001:4830:134:3::10]:52220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDsVJ-0002O9-6D
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDsVE-00040u-AV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:13:09 -0400
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
	<b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
	<w51h8nqcijb.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
Date: Wed, 2 May 2018 16:12:49 +0200
MIME-Version: 1.0
In-Reply-To: <w51h8nqcijb.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w8ZGOnNpJbcewO3psGF1QEokCSLOLLf7v"
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w8ZGOnNpJbcewO3psGF1QEokCSLOLLf7v
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
Subject: Re: [RFC] Intermediate block mirroring
References: <20180412170711.GA6240@igalia.com>
 <1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
 <w517ep7gpsz.fsf@maestria.local.igalia.com>
 <ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
 <w51bmegjzp4.fsf@maestria.local.igalia.com>
 <216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
 <w5136zjsar5.fsf@maestria.local.igalia.com>
 <bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
 <w51wowvqu65.fsf@maestria.local.igalia.com>
 <b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
 <w51h8nqcijb.fsf@maestria.local.igalia.com>
In-Reply-To: <w51h8nqcijb.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 15:07, Alberto Garcia wrote:
> On Wed 25 Apr 2018 04:03:22 PM CEST, Max Reitz wrote:
>>>> But the question stands whether we need simple node replacement when=

>>>> we want bdrv_reopen() anyway.  In addition, we don't need just
>>>> replacement, we also need addition and removal (e.g. for backing
>>>> files or quorum children) -- and especially in the case of quorum,
>>>> that is going to be a pain (mostly naming the children).
>>>>
>>>> With bdrv_reopen(), we can just require the user to respecify all
>>>> children, so we don't run into the issue of how to name things at
>>>> least.
>>>
>>> So in this example, if you want to replace [B] with [E] you would
>>> reopen [C] specifying the new backing file?
>>>
>>>    [A] <- [B] <- [C] <- [D]
>>>
>>>           [E]
>>
>> You can just use child node name references like in blockdev-add.
>=20
> Were the (more or less) exact requirements of QMP blockdev-reopen
> discussed? How is it different from qemu-io's "reopen" command? What ar=
e
> the options that you can and can not change?

I can't quite remember, I'm afraid.  I think it was supposed to be
pretty much qemu-io's reopen (so just bdrv_reopen()).  I suppose you
cannot change the driver (obviously) or probably the node name, because
either would result in the node being replaced by a completely new one.

Other than that, it probably depends on what the block driver supports,
but ideally you should be able to change everything.

> Also, you could replace an element in the backing chain using reopen,
> but can you replace a node that is not a backing image of another one?

Node replacement only makes sense if the node is used as the child of
something.  Otherwise it's just a blockdev-add + blockdev-del.

But it doesn't have to be in a backing chain, of course.  It would work
for Quorum children, too.

> With QMP blockdev-replace you could use the existing blockdev-add
> command and create an arbitrary tree and then simply do blockdev-replac=
e
> so I suppose that for some use cases at least it would be pretty
> straightforward.

You can do the same with reopen.  Just use a reference for the child name=
=2E

Say you have a qcow2 node "overlay" with a backing child.  Now you want
to replace that with a different child "new-backing".

For both blockdev-replace and reopen the first thing you can do is
blockdev-add the new child.  Then it depends:

blockdev-replace: You call it with parent=3Doverlay, child=3Dbacking,
node=3Dnew-backing.

reopen: You call it like blockdev-add, that is:
    { "node-name": "overlay",
      "backing": "new-backing" }
In theory every option you do not specify is unchanged, so I suppose you
can leave out e.g. the "driver" option here.

Sure, with reopen you can also respecify the whole tree if you so desire
(so you can get away without blockdev-add'ing new-backing before), but
you don't have to.

Max


--w8ZGOnNpJbcewO3psGF1QEokCSLOLLf7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrpx2EACgkQ9AfbAGHV
z0D3mAf/TYe4SqAqF82zwLPKJLEB+eE19chmoi0Xpekz45NVR8EemGLanvRL0Bb1
eYdwJtPWMPCvnnNVnmOXw85/1GIAODWP+t8M593Z8dvTt7gFZSKqPJ9yV+yvdRu2
EyhpfwLwzngjVIBbrYbg2u6B5jX5Tb59EELX0MKabR2m2KwBZ2eNZMSluj6oTMfZ
TtBd07NgMMPYco9YzfUEtqLKNP38MIAKwFVVenOjTzkTeBGrAigZMU69WTf75QO6
2xf3rgKZDLepsmomuhBOeDQ9wD+RgnA76BjxscbbJYAf9FqUD8Qik2RER7hAdTo4
xK/V5USvoTEqx+ykFPMddMcbEnPodA==
=/mtz
-----END PGP SIGNATURE-----

--w8ZGOnNpJbcewO3psGF1QEokCSLOLLf7v--
