Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNhgf-0006m7-BZ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNhgd-0003MS-Sv
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:13:45 -0500
Date: Fri, 16 Nov 2018 18:13:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181116171302.GG5066@localhost.localdomain>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
	<20181116151834.GA5066@localhost.localdomain>
	<001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
	<20181116155106.GD5066@localhost.localdomain>
	<1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.11.2018 um 17:34 hat Max Reitz geschrieben:
> On 16.11.18 16:51, Kevin Wolf wrote:
> > Am 16.11.2018 um 16:27 hat Max Reitz geschrieben:
> >> On 16.11.18 16:18, Kevin Wolf wrote:
> >>> Am 16.11.2018 um 16:03 hat Alberto Garcia geschrieben:
> >>>>> I don't think anything needs a way to generally block graph changes
> >>>>> around some node.  We only need to prevent changes to very specific
> >>>>> sets of edges.  This is something that the permission system just
> >>>>> cannot do.
> >>>>
> >>>> But what would you do then?
> >>>
> >>> I agree with you mostly in that I think that most problems that Max
> >>> mentioned aren't readl. The only real problem I see with GRAPH_MOD as=
 a
> >>> permission on the node level is this overblocking
> >>
> >> I wholeheartedly disagree.  Yes, it is true that most of the issues I
> >> thought of can be fixed, and so those problems are not problems in a
> >> technical sense.  But to me this whole discussion points to the greate=
st
> >> issue I have, which is that GRAPH_MOD is just too complicated to
> >> understand.  And I don't like a solution that works on a technical lev=
el
> >> but that everybody is too afraid to touch because it's too weird.
> >=20
> > GRAPH_MOD with the meaning that Berto suggested isn't weird or
> > complicated to understand. It's only the wrong tool because it blocks
> > more than we want to block. But if we didn't care about that, it could
> > be just another permission like any other.
>=20
> The meaning Berto has suggested (AFAIU) is never taking the permission
> at all but just querying whether it is shared by all current parents
> before doing a graph change.
>=20
> That is very weird to me because permissions are there to be taken.

It would be a shortcut for taking the permission temporarily, which
would possibly work inside QEMU because we're holding the BQL, though
I'm not sure whether I/O threads couldn't influence this. Anyway, with
our mapping of permissions to filesystem locks, it's definitely not
correct any more and you do need to actually temporarily acquire the
locks.

> The meaning I have suggested is that it would be taken before a graph
> change and released right afterwards.  I think this is still weird
> because we don't take, say, the WRITE permission before every
> bdrv*_write*() call and release it afterwards.
>=20
> Sure you could say "actually, why not".  Please don't.[1]

Actually, why not? Not in the sense that it would be the right model for
WRITE, but it might still be the right one for GRAPH_MOD in most cases.

We do take the RESIZE permission in qmp_block_resize() before calling
blk_truncate(), and drop it right afterwards (by means of creating a
temporary BlockBackend only for the purpose of resizing), so there is
precedence.

Of course, all of this is moot because GRAPH_MOD can't provide the exact
semantics we want to have.

> > If you want to change the graph, you'd need to get the permission first,
> > and bdrv_replace_child_noperm() could assert that at least one parent of
> > the parent node has acquired the permission (unless you want to pass the
> > exact parent BdrvChild to it; maybe this is what we would really do
> > then).
>=20
> Yep, that assertion would be like we do it in bdrv_co_write_req_prepare().
>=20
> Thing is, you (as in "the caller that actually wants to do something",
> like mirror) don't just "get the permission".  Permissions are
> associated with children, so you cannot get this permission before you
> create your child.
>=20
> So this is where "parent of a parent node" comes in?  I'm afraid I don't
> understand that.

Including GRAPH_MOD in the permission system means that it controls an
operation that reaches a node through a BdrvChild. In this case, the
operation is "modifiying a BdrvChild of the node that the permission
holding BdrvChild points to".

Okay, if you say that affecting children of a node instead of just the
node itself is a bit unusual, I might have to agree.

> What would make sense to me would be for the generic block layer to take
> this permission on new children (and drop it immediately after having
> attached the child) and children that are about to be detached.  Which
> again is just different from any other permission, because things
> outside of block.c can never take it, they can only choose not to share
> it.  So it'd be an internal permission, which is visible to the outside,
> and I think this is at least weirder than just having an internal
> counter with a clear external interface (inc/dec).

I don't think I'd want to implement it like that (but then, I'll repeat
that I wouldn't want to implement it at all because it's the wrong
tool).

> Also, please excuse me for it being Friday and all, but I don't quite
> believe in "It's actually clear, I have no idea why you claim to always
> take so long to understand it."  The code clearly has no idea what it's
> supposed to do, and I do not believe that the sole reason for that is
> that someone who did understand didn't have the time or the need to fix
> it, or to implement it correctly in the first place.
>=20
> On the other hand it sounded a bit like Berto was about to fix it,
> though, so there's that.
>=20
> Or I just got you wrong and this is just the usual case of "Now that
> we've talked about this through a couple of lengthy emails, it does make
> sense" which is just all too familiar and exactly my issue with the
> whole thing.

It's actually "now that we have a precise definition what GRAPH_MOD
means", at least for the sake of this discussion. It's not a useful
definition, so I don't think this is actually meaningful progress, but
having this definition, you can reason about it now. It's not very
complicated on the conceptual level (the implementation looks differernt
because we'd have to introduce another BdrvChild parameter everywhere to
know where the operation comes from), just not a very good tool either.

What we noted down about counters was more meaningful progress because
we think this can actually provide the semantics that we need. Of
course, there is still some hand-waving involved (we'll just check the
counter when modifying the graph), which might not be that trivial to
implement because bdrv_replace_child() can't return an error...

> >> We have this discussion again and again, and in the end we always come
> >> up with something that looks like it might work, but it's just so weird
> >> that we can't even remember it.
> >=20
> > I don't think we ever come up with something, weird or not, that
> > achieves what we wanted to achieve - because the problem simply can't be
> > solved properly at the node level.
>=20
> Yes, I've phrased my disagreement wrong.  Of course I don't disagree
> with you on that.  I just disagree that this is the only issue with
> GRAPH_MOD.
>=20
> >> Maybe it's just me, though.  Frankly, I think the permission system
> >> itself is already too complicated as it is, but I don't have a simpler
> >> solution there.
> >=20
> > It doesn't feel too bad to me, but that's subjective.
>=20
> It's not worse than quiescing/draining, that's for sure.

How would _you_ know? :-)

(But I agree.)

> [1] Please don't because on one hand I wouldn't have a counter-argument
> for this.  Yes, maybe we should actually take permissions right before
> the operations that require them.  Maybe keeping them around for as long
> as a child stays attached to a parent is just being lazy.

No, it's the very mechanism that requires users throughout the stack to
declare what they want to do with their nodes. If you just automatically
got write permissions when you do a write request, you could attach
read-write devices to a read-only node and things would go up in flames
as soon as the device actually writes.

This would be consistent with GRAPH_MOD (or actually even the counters),
if block jobs requested this from the beginning and not only when they
complete.

For the implementation with counters, maybe we actually need two of them
like perm/shared in the permission system. One that means that we're
going to modify the graph, and the other one that means that we can't
tolerate graph modifications.

For the public interface, we might actually treat it mostly like
permissions, just edge permissions, not node permissions.

> I suppose the main argument against taking permissions just when you
> need them is that this introduces additional points of failure that are
> mostly unnecessary.  For GRAPH_MOD, however, these points would be
> limited and easily handled, because they just involve making
> bdrv_attach_child() fail.

You probably don't even want to start the whole graph modification
(which may well involve multiple changed children) when one of the
changes is going to fail. So I think taking the permission beforehand is
useful.

I'd consider taking it even at the job start, but the latest I would
take it is at the start of the .prepare callback.

(This is relevant for the counters, too.)

> So, no, I do not have a good technical counter-argument.  But my
> argument of complexity still stands after having gone through
> understanding how GRAPH_MOD might actually work for at least the third
> time now, without it ever having made the next time any easier.
>=20
> Even if GRAPH_MOD were correctly implemented tomorrow, in a way
> conforming to what we've discussed now, I have the strong feeling that I
> still would get to a point where I forgot its meaning and would have to
> go through all of this again.
>=20
> And that's completely disregarding people new to the codebase.

As I said, it's moot anyway. It doesn't provide the right semantics.

Kevin

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb7vqeAAoJEH8JsnLIjy/WU48QAL/Kn3kuAwSe0vGPP81jTmsN
eOpTDKorv8ooTAm0oILtT6bydhx61EfEguLC6hXfURXvtLliP6LoPLuffPYZ7Ja4
wuNOu2hn08GBRy922Xxta3TS8DyopOQ+MApyRJibX/6KeIh91SVqKcJ116K/Y9UP
i2NUW7+AVyUxwAuuGtDFx/L0qCzbfkB0b9vpHbWVnJ5kV4CwPSXGDsg/fgHr9T0+
5kKRN2KnIFPvuul+3KEr/P9ISUzSh6ZqJHYi/BVrKCJ3W9AgvQMN3K0GyEnOOLu/
ZtE9775ub8YCgBeqkF1UrlaPC9yKDJZKkP/B+pWNIy0vb1mAnvhSyVKNIjohZgYo
GmkPEZypjRpt1/VtuyADAyTpxX38bIumuRME9FEt51PFS0ET2h6leWmTBvGqs8ih
aVRORpz6wjk/MFS6rvgRXugAKMIy/B1LHajPWFiNy5r577K8Hj52q4UaLZijQJX4
l4LML/rdNY1leFd8VByPiQwe+WH2pfmn8K0510IiyPOeN9i5JMnlm988xMTzTvZD
meJdUYwwXpYB44M2p84Bc1/BeoRLrLgA5IE5fVTD/ddfsbUTXK1NJwzRVwKxkErm
bN9u8Hx8gsShtp7owdBMyyQoC/dYdieRaI+myFOPv4AudbWTo0e/eq1cEo83WPhD
GkE6/bsozq8QE7fi6x5P
=ti6y
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
