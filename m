Received: from eggs.gnu.org ([2001:4830:134:3::10]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBK8B-0001mu-4B
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBK8A-0001ie-5s
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:06:43 -0400
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
Date: Wed, 25 Apr 2018 15:06:34 +0200
MIME-Version: 1.0
In-Reply-To: <w5136zjsar5.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2NPbC5nS5CPkEmLyx58REXMlrWbt1WZYD"
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
--2NPbC5nS5CPkEmLyx58REXMlrWbt1WZYD
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
Subject: Re: [RFC] Intermediate block mirroring
References: <20180412170711.GA6240@igalia.com>
 <1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
 <w517ep7gpsz.fsf@maestria.local.igalia.com>
 <ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
 <w51bmegjzp4.fsf@maestria.local.igalia.com>
 <216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
 <w5136zjsar5.fsf@maestria.local.igalia.com>
In-Reply-To: <w5136zjsar5.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-25 14:58, Alberto Garcia wrote:
> On Fri 20 Apr 2018 03:13:49 PM CEST, Max Reitz wrote:
>>>>>>> One other way is to have a more generic replace-node command
>>>>>>> which would call bdrv_replace_node(), but I don't know if we want=

>>>>>>> to expose that and I don't have any other use case for it at the
>>>>>>> moment.
>>>>>>
>>>>>> I think we do want to expose that.  As far as I'm informed, for
>>>>>> graph manipulation we want a command that can replace nodes
>>>>>> (including replacing nothing by a new node or replacing an
>>>>>> existing node by nothing, if the parent supports that).
>>>>>
>>>>> Was there any discussion about this in the mailing list? (proposed
>>>>> name for this function, features, etc.)
>>>>
>>>> Well, there is x-blockdev-change.  But we probably want to expose
>>>> bdrv_reopen() in the long run.
>>>
>>> Exposing bdrv_reopen() itself shouldn't be too much work (it takes
>>> just two node names, or am I missing something?).
>=20
> I just realized that I meant "Exposing bdrv_replace_node()" here.
>=20
>> So from my perspective...  If you think it's easy, why don't you try
>> it and then we'll see? *cough*
>=20
> I'm doing it :-)
>=20
>>> There's still the question of how to update the backing file string
>>> (on the overlay). stream and commit do it automatically, but if we do=

>>> bdrv_reopen() or the aforementioned modification to blockdev-mirror
>=20
> bdrv_replace_node() again

But the question stands whether we need simple node replacement when we
want bdrv_reopen() anyway.  In addition, we don't need just replacement,
we also need addition and removal (e.g. for backing files or quorum
children) -- and especially in the case of quorum, that is going to be a
pain (mostly naming the children).

With bdrv_reopen(), we can just require the user to respecify all
children, so we don't run into the issue of how to name things at least.

(Other things we we'd want bdrv_reopen() are listed in the meeting notes.=
)

>>> we'd need to do it explicitly with change-backing-file, or extend the=

>>> API to allow for that.
>>
>> Well, the December notes do say that we probably want an option to
>> specify the target's filename which is what will be written into the
>> overlays of @to_replace as their backing file string, so I think
>> extending the API should be fine.
>=20
> Yes, but how do you find out what the overlays are (without an
> additional parameter, that is)? I thought we didn't want to support
> walking the backing chain in reverse direction.

We already have an .update_filename() BdrvChildRole callback, though.

Max


--2NPbC5nS5CPkEmLyx58REXMlrWbt1WZYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrgfVoACgkQ9AfbAGHV
z0DIBAf9GoX+JScMGl52feQxrIHv9AmONoztoAo+zPLJ9waSRl5k3qVw8uBnv3TF
CNfnRLAnlqWEIuyn2cy0L2qPAj8oEPfuTveRcuXL8tDNci9k7tb2D/5dnlFtlS76
Hl8mfhxwD3ijk8K1rBAIGcBwyu/UC/xvnus0sNppqJM5T133s7Bz5PBiSGasJ2by
YsawWo+T4CvwQn+WXGlUM66Y+gR0fwD7Adtej1aoUVy7agFF8ZJXqYnlYedawmQl
8FiDDjl7/UE9K/fXKY84yqVoo8/ITB+uOvMsaCd8CvTfufn7Q3IHrNJo3g+L8dgu
VPCnNJS0mROEO5XHqodX+xShO7a2aQ==
=0QRj
-----END PGP SIGNATURE-----

--2NPbC5nS5CPkEmLyx58REXMlrWbt1WZYD--
