Received: from eggs.gnu.org ([2001:4830:134:3::10]:51570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBL1M-000402-RH
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBL1H-0007QI-2i
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:03:44 -0400
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
Date: Wed, 25 Apr 2018 16:03:22 +0200
MIME-Version: 1.0
In-Reply-To: <w51wowvqu65.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vuDoQpdvO5ENU02gm38HqiUje5UiQpr2v"
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
--vuDoQpdvO5ENU02gm38HqiUje5UiQpr2v
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
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
In-Reply-To: <w51wowvqu65.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-25 15:42, Alberto Garcia wrote:
> On Wed 25 Apr 2018 03:06:34 PM CEST, Max Reitz wrote:
>>>>>>>>> One other way is to have a more generic replace-node command
>>>>>>>>> which would call bdrv_replace_node(), but I don't know if we
>>>>>>>>> want to expose that and I don't have any other use case for it
>>>>>>>>> at the moment.
>>>>>>>>
>>>>>>>> I think we do want to expose that.  As far as I'm informed, for
>>>>>>>> graph manipulation we want a command that can replace nodes
>>>>>>>> (including replacing nothing by a new node or replacing an
>>>>>>>> existing node by nothing, if the parent supports that).
>>>>>>>
>>>>>>> Was there any discussion about this in the mailing list?
>>>>>>> (proposed name for this function, features, etc.)
>>>>>>
>>>>>> Well, there is x-blockdev-change.  But we probably want to expose
>>>>>> bdrv_reopen() in the long run.
>>>>>
>>>>> Exposing bdrv_reopen() itself shouldn't be too much work (it takes
>>>>> just two node names, or am I missing something?).
>>>
>>> I just realized that I meant "Exposing bdrv_replace_node()" here.
>>>
>>>> So from my perspective...  If you think it's easy, why don't you try=

>>>> it and then we'll see? *cough*
>>>
>>> I'm doing it :-)
>>>
>>>>> There's still the question of how to update the backing file string=

>>>>> (on the overlay). stream and commit do it automatically, but if we =
do
>>>>> bdrv_reopen() or the aforementioned modification to blockdev-mirror=

>>>
>>> bdrv_replace_node() again
>>
>> But the question stands whether we need simple node replacement when
>> we want bdrv_reopen() anyway.  In addition, we don't need just
>> replacement, we also need addition and removal (e.g. for backing files=

>> or quorum children) -- and especially in the case of quorum, that is
>> going to be a pain (mostly naming the children).
>>
>> With bdrv_reopen(), we can just require the user to respecify all
>> children, so we don't run into the issue of how to name things at
>> least.
>=20
> So in this example, if you want to replace [B] with [E] you would reope=
n
> [C] specifying the new backing file?
>=20
>    [A] <- [B] <- [C] <- [D]
>=20
>           [E]

You can just use child node name references like in blockdev-add.

Max


--vuDoQpdvO5ENU02gm38HqiUje5UiQpr2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrgiqoACgkQ9AfbAGHV
z0AdSAf/Sg6Rnl+Ells312HOosDhsF4fN5P+IKSYnvhRuDFsGcoqGLmBN+VZUwlo
4Yg3wW1+GldJzxSAehCjG7fk0IblXEUycESEFcT2h83Q4hooH99BNjqE5wo32yuz
4cVnNoPMdbvMoqGTt44LoO+rlSGXcwIYi4UilJLaY0HGARIQrEVJusa6xiQvYWr5
fdgc81JJWz3+x+QExBufJtu5DJker8Vj/nHa2m+lHspoTVzGriCP69dmFjkAg3dV
mO/FtqRcoCo9IooEYVXQLNI0Ep2ELKUKKz+mshXLcmZ2jbp7a5Yi1+GlBAK6/Y15
b8M7tAHt3hK+tx+fpFzv5pKjLMfBYA==
=CBbr
-----END PGP SIGNATURE-----

--vuDoQpdvO5ENU02gm38HqiUje5UiQpr2v--
