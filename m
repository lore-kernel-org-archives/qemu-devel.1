Received: from eggs.gnu.org ([2001:4830:134:3::10]:35365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1faiRQ-0002h5-8a
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1faiRI-0002Ty-12
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:07:32 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
	<920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
	<e97fb1f7-a864-a413-0ea4-f3e1dc29bc9f@virtuozzo.com>
	<20180703111538.GB3812@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <480692b8-cbe1-3499-89c8-0d3f2cf99eb4@redhat.com>
Date: Wed, 4 Jul 2018 16:07:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180703111538.GB3812@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7xl2NCPUdyLdYdMnVVJSFqBPUF6KMZx49"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/fleecing-filter: new filter
 driver for fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, famz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7xl2NCPUdyLdYdMnVVJSFqBPUF6KMZx49
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 famz@redhat.com, den@openvz.org
Message-ID: <480692b8-cbe1-3499-89c8-0d3f2cf99eb4@redhat.com>
Subject: Re: [PATCH v2 2/3] block/fleecing-filter: new filter driver for
 fleecing
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
 <20180629151524.138542-3-vsementsov@virtuozzo.com>
 <32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
 <920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
 <e97fb1f7-a864-a413-0ea4-f3e1dc29bc9f@virtuozzo.com>
 <20180703111538.GB3812@localhost.localdomain>
In-Reply-To: <20180703111538.GB3812@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-03 13:15, Kevin Wolf wrote:
> Am 02.07.2018 um 14:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 29.06.2018 20:40, Eric Blake wrote:
>>> On 06/29/2018 12:30 PM, John Snow wrote:
>>>>
>>>>
>>>> On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> We need to synchronize backup job with reading from fleecing image
>>>>> like it was done in block/replication.c.
>>>>>
>>>>> Otherwise, the following situation is theoretically possible:
>>>>>
>>>>> 1. client start reading
>>>>> 2. client understand, that there is no corresponding cluster in
>>>>> =C2=A0=C2=A0=C2=A0 fleecing image
>>>>
>>>> I don't think the client refocuses the read, but QEMU does. (the cli=
ent
>>>> has no idea if it is reading from the fleecing node or the backing
>>>> file.)
>>>>
>>>> ... but understood:
>>>>
>>>>> 3. client is going to read from backing file (i.e. active image)
>>>>> 4. guest writes to active image
>>>>
>>>> My question here is if QEMU will allow reads and writes to interleav=
e in
>>>> general. If the client is reading from the backing file, the active
>>>> image, will QEMU allow a write to modify that data before we're done=

>>>> getting that data?
>>>>
>>>>> 5. this write is stopped by backup(sync=3Dnone) and cluster is copi=
ed to
>>>>> =C2=A0=C2=A0=C2=A0 fleecing image
>>>>> 6. guest write continues...
>>>>> 7. and client reads _new_ (or partly new) date from active image
>>>>>
>>>>
>>>> I can't answer this for myself one way or the other right now, but I=

>>>> imagine you observed a failure in practice in your test setups, whic=
h
>>>> motivated this patch?
>>>>
>>>> A test or some proof would help justification for this patch. It wou=
ld
>>>> also help prove that it solves what it claims to!
>>>
>>> In fact, do we really need a new filter, or do we just need to make t=
he
>>> "sync":"none" blockdev-backup job take the appropriate synchronizatio=
n
>>> locks?
>>>
>>
>> How? We'll need additional mechanism like serializing requests.. Or a =
way to
>> reuse serializing requests. Using backup internal synchronization look=
s
>> simpler, and it is already used in block replication.
>=20
> But it also just an ugly hack that fixes one special case and leaves
> everything else broken. replication is usually not a good example for
> anything. It always gives me bad surprises when I have to look at it.
>=20
> We'll have to figure out where to fix this problem (or what it really
> is, once you look more than just at fleecing), but I think requiring th=
e
> user to add a filter driver to work around missing serialisation in
> other code, and corrupting their image if they forget to, is not a
> reasonable solution.
>=20
> I see at least two things wrong in this context:
>=20
> * The permissions don't seem to match reality. The NBD server
>   unconditionally shares PERM_WRITE, which is wrong in this case. The
>   client wants to see a point-in-time snapshot that never changes. This=

>   should become an option so that it can be properly reflected in the
>   permissions used.
>=20
> * Once we have proper permissions, the fleecing setup breaks down
>   because the guest needs PERM_WRITE on the backing file, but the
>   fleecing overlay allows that only if the NBD client allows it (which
>   it doesn't for fleecing).
>=20
>   Now we can implement an exception right into backup that installs a
>   backup filter driver between source and target if the source is the
>   backing file of the target. The filter driver would be similar to the=

>   commit filter driver in that it simply promises !PERM_WRITE to its
>   parents, but allows PERM_WRITE on the source because it has installed=

>   the before_write_notifier that guarantees this condition.

I don't quite understand what you mean "between source and target",
because *the* backup filter driver would need to be on top of both.
Unless you continue to use before-write notifiers, but I don't see why
when a driver that sits on top of source would intercept all requests
anyway.

And if we want to unify mirror and backup at any time, I think we have
to get away from before-write anyway.

>   All writes to the target that are made by the backup job in this setu=
p
>   (including before_write_notifier writes) need to be marked as
>   serialising so that any concurrent reads are completed first.
>=20
> And if we decide to add a target filter to backup, we should probably a=
t
> the same time use a filter driver for intercepting source writes instea=
d
> of using before_write_notifier.
>=20
> Max, I think you intended to make both source and target children of th=
e
> same block job node (or at least for mirror). But wouldn't that create
> loops in a setup like this? I think we may need two filters that are
> only connected through the block job, but not with block graph edges.

A node can only provide one data view to all of its parents.  It cannot
distinguish based on the parent.  Therefore, the main backup driver on
top of source and target would necessarily present the current disk
(changing) state, just like the mirror filter does.

Fleecing wants another view, though.  It wants an unchanging view.  It
therefore seems clear to me that we'd need to separate nodes: One
between guest and source (which performs the backup by intercepting
write requests), and one between the fleecing user (e.g. NBD) and the
target.  The former presents the current state, the latter presents the
"unchanging" point-in-time snapshot.

Sure, we can get away without the former (we do so today), but I don't
see why we would want to.  blockdev-copy (as an extension of
blockdev-mirror) would have such a node anyway, and I can see no reason
why we wouldn't attach both source and target to it.

Max


--7xl2NCPUdyLdYdMnVVJSFqBPUF6KMZx49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAls81IsACgkQ9AfbAGHV
z0Aw/Af/U/citm1n6mizOagkMxXQKy/DVH75+QmDZ0eysVgGJYyXS8bJa4G9Spf/
PSNFqgf0cjubpCVPprziKiBia9NjqMoN7W0WQwGIOu+xs0mjjpulMIqyXiccU4dR
7iYsVeEQcgcZ+Hf3X2jJstla6/l2EMqBGwBn6Y61//gb+Dj4s/vjG2WVfM2yQWEh
b/mVUTj5vFtgTI65R5ukJl5yeWOJapfZ3nb8DoYS4HBD6HwvR666YDlI2YuJqGO0
+StgFE45uVURu7xMhZA0AnGzblRU95NFmvXy32Ev+C+oHPMCyUVkIHTkKC/Qt9HS
berTiPlqqDpZ1mSm9JL6NsBbDkr+Mw==
=7WYI
-----END PGP SIGNATURE-----

--7xl2NCPUdyLdYdMnVVJSFqBPUF6KMZx49--
