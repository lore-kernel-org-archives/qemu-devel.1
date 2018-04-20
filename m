Received: from eggs.gnu.org ([2001:4830:134:3::10]:58931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vrl-0004oV-OB
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vri-0003TD-J4
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:14:17 -0400
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
Date: Fri, 20 Apr 2018 15:13:49 +0200
MIME-Version: 1.0
In-Reply-To: <w51bmegjzp4.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n8qhAjElBt93gUQfAljKprZ5PiLwevgq7"
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
--n8qhAjElBt93gUQfAljKprZ5PiLwevgq7
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
Subject: Re: [RFC] Intermediate block mirroring
References: <20180412170711.GA6240@igalia.com>
 <1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
 <w517ep7gpsz.fsf@maestria.local.igalia.com>
 <ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
 <w51bmegjzp4.fsf@maestria.local.igalia.com>
In-Reply-To: <w51bmegjzp4.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-18 17:34, Alberto Garcia wrote:
> On Mon 16 Apr 2018 05:15:21 PM CEST, Max Reitz wrote:
>> On 2018-04-16 16:59, Alberto Garcia wrote:
>>> On Fri 13 Apr 2018 04:23:07 PM CEST, Max Reitz wrote:
>>>> On 2018-04-12 19:07, Alberto Garcia wrote:
>>>>> Hello,
>>>>>
>>>>> I mentioned this some time ago, but I'd like to retake it now: I'm
>>>>> checking how to copy arbitrary nodes on a backing chain, so if I ha=
ve
>>>>> e.g.
>>>>>
>>>>>    [A] <- [B] <- [C] <- [D]
>>>>>
>>>>> I'd like to end up with
>>>>>
>>>>>    [A] <- [E] <- [C] <- [D]
>>>>>
>>>>> where [E] is a copy of [B]. The most obvious use case is to move [B=
]
>>>>> to a different storage backend.
>>>>>
>>>>> At the moment we can already copy [B] into [E] (outside QEMU) and t=
hen
>>>>> do
>>>>>
>>>>>    change-backing-file device=3D[D] image-node-name=3D[C] backing-f=
ile=3D[E]
>>>>>
>>>>> However this only changes the image on disk and the bs->backing_fil=
e
>>>>> string in memory. QEMU keeps using the [B] BlockDriverState, and we=

>>>>> need to make it switch to [E].
>>>>>
>>>>> One possible way to do this would be to modify blockdev-mirror so t=
he
>>>>> source image can be located anywhere on a chain. Currently there's
>>>>> bs->backing_blocker preventing that, plus qmp_blockdev_mirror()
>>>>> refuses to take any non-root source node. Other than permission
>>>>> changes I don't think the algorithm itself needs any additional
>>>>> modification, although I suppose we'd like to change the backing fi=
le
>>>>> as part of the same job, and that would require API changes.
>>>>
>>>> Another way would be to write blockdev-copy. :-)
>>>
>>> Something like blockdev-backup but without copying data from backing
>>> files? blockdev-mirror already allows configuring that using the
>>> MirrorSyncMode parameter.
>>
>> No, a block job that unites blockdev-backup, blockdev-mirror, and
>> block-commit.
>=20
> Yeah, I was reading again the notes from December. This would then unif=
y
> all those existing commands.
>=20
> Is there any other plan or roadmap for this command, or was just an ide=
a
> that was discussed as nice to have?

Mostly the latter, I think.  Well, there definitely isn't a roadmap and
there is no plan apart from what's in the December notes.

>                                     Also, does that mean that the old
> commands should not be changed now? I'm asking because there's a big
> difference between updating blockdev-mirror to allow non-root source
> nodes and creating this new command that would support all features of
> the old ones :-)

No, changing old commands is OK.  We just should think about how to
incorporate those changes into blockdev-copy (so don't introduce some
way of doing the same thing with two different interfaces to both mirror
and backup).

Especially adding things to mirror should be OK, because I suppose
mirror is going to be our blockdev-copy (and we'll just extend it to
cover backup and non-active commit).

Of course, things usually don't get done because they're "nice to have"
but because someone actually needs them.  So that's the reason why I
mentioned blockdev-copy. O:-)

>> I think we wanted to exclude streaming, because that works
>> differently.  But, well, streaming would be just installing a COR
>> filter node and doing a blockdev-copy to null-co://, right? :-)
>=20
> Yeah I suppose, but I don't think you can make the filter step part of
> the blockdev-copy API.

No, definitely not.

Or, well, actually...  If you could start block jobs by installing their
filter nodes via blockdev-add, then maybe you could in a sense, but
let's not get into that rabbit hole now. O:-)

[...]

>>>>> One other way is to have a more generic replace-node command which
>>>>> would call bdrv_replace_node(), but I don't know if we want to
>>>>> expose that and I don't have any other use case for it at the
>>>>> moment.
>>>>
>>>> I think we do want to expose that.  As far as I'm informed, for
>>>> graph manipulation we want a command that can replace nodes
>>>> (including replacing nothing by a new node or replacing an existing
>>>> node by nothing, if the parent supports that).
>>>
>>> Was there any discussion about this in the mailing list? (proposed
>>> name for this function, features, etc.)
>>
>> Well, there is x-blockdev-change.  But we probably want to expose
>> bdrv_reopen() in the long run.
>=20
> Exposing bdrv_reopen() itself shouldn't be too much work (it takes just=

> two node names, or am I missing something?).

I suppose Kevin knows more about this.  I guess there may be things in
the block layer that cannot cope with an arbitrary reopen from the user,
but that's the only thing that would come to my mind.

So from my perspective...  If you think it's easy, why don't you try it
and then we'll see? *cough*

> There's still the question of how to update the backing file string (on=

> the overlay). stream and commit do it automatically, but if we do
> bdrv_reopen() or the aforementioned modification to blockdev-mirror we'=
d
> need to do it explicitly with change-backing-file, or extend the API to=

> allow for that.

Well, the December notes do say that we probably want an option to
specify the target's filename which is what will be written into the
overlays of @to_replace as their backing file string, so I think
extending the API should be fine.

Max


--n8qhAjElBt93gUQfAljKprZ5PiLwevgq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrZ540ACgkQ9AfbAGHV
z0CXIAf+IChTk92qBVVdqhy/3VJcn1oHo215KCkRIF7J3LWOEFl3JrX8hIfOrsvC
YAmEgmHjzHyZzesdkhI0V6CcaaG84PotDFt97XmX65o4JLrYlbOtHSqMOFIl8smW
UfqBUA6pGE7BA+78qWeNaIDEXnSQC2kXsPqyl1v76pirrzOnPCzzh+TOaQN7NKIL
TvcwABjDh2HuYjqgkCBxDbsjT0e3oVDisdkYWyM2e00NaZ6a12TW+buYRZCIJMae
89vLy7KGBahKdO4y9dPjLbBP+zm46KKij8quX6trxgFo9Ntxi4x0+Zuj3vhg0TLn
Lbl2EAW/FtlypUgAsxZlD+41/mOgEQ==
=IViP
-----END PGP SIGNATURE-----

--n8qhAjElBt93gUQfAljKprZ5PiLwevgq7--
