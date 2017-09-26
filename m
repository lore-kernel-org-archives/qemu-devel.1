Received: from eggs.gnu.org ([2001:4830:134:3::10]:57162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwvGK-00049U-40
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwvGI-0005Ob-Lv
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:11:20 -0400
Date: Tue, 26 Sep 2017 21:11:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170926191102.GF14717@localhost.localdomain>
References: <20170926175942.GE14717@localhost.localdomain>
	<c8191d37-28e3-1acd-797f-0c456f44541e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <c8191d37-28e3-1acd-797f-0c456f44541e@redhat.com>
Subject: Re: [Qemu-devel] blockdev-commit design
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.09.2017 um 20:29 hat Eric Blake geschrieben:
> On 09/26/2017 12:59 PM, Kevin Wolf wrote:
> > This was the easy part. Then I started looking at the code and found a
> > few a bit more interesting questions:
> >=20
> >   * The old block-commit command decides between an "actual" commit job
> >     and the mirror-based active commit based on whether top is the
> >     active layer.
>=20
> And libvirt HAS to know whether it is requesting an active vs.
> intermediate commit job up front, because the two code paths have
> different expected signals for handling job completion (it is only
> active commit that reaches a ready point between phases, requiring
> further QMP commands to end the job).

This is a good point. If this isn't transparent and libvirt has to know
anyway which kind of commit job it is using, there is no point in hiding
the difference in the QMP command that starts the job.

> >     We don't get an option for the active layer any more now, so this
> >     isn't how things can work for blockdev-commit. We could probably
> >     check whether top has a BlockBackend parent, but that's not really
> >     what we're interested in anyway. Maybe the best we could do to
> >     decide this automatically is to check whether there is any parent of
> >     top that requires write permissions. If there is, we need active
> >     commit, otherwise the "normal" one is good enough.
> >=20
> >     However, who says that the intentions of the user stay as we deduce
> >     them at the start of the block job? Who says that the user doesn't
> >     want to add a writable disk as a user of the node while the block
> >     job is running?
> >=20
> >     The optimal solution to this would be that the commit filter node
> >     responds to permission requests and switches between active and
> >     "normal" commit mode. I'm not sure how hard this would be to
> >     implement.
> >=20
> >     As long as we don't have the automatic switch, do we have to allow
> >     the user to specify explicitly which mode they want instead of
> >     automatically choosing one?
>=20
> When committing one read-only image into another, you don't need the
> active mode.  On the other hand, committing a writeable image generally
> means you don't want to lose any data, even as further writes happen
> while the job is ongoing.  Does a "normal" mode commit make sense on a
> writeable image

No, it doesn't. If you start a "normal" mode commit, it wouldn't have
BLK_PERM_WRITE in its shared permissions, so it would fail to start if
there is a writer. And once it is started, adding a writer would fail.

The explicit option would be for the case where a "normal" mode commit
is possible to start, but you intend to add a writer later, so you want
to start an active commit even though the writer doesn't exist yet.

> (perhaps as a point-in-time operation: all data that was present when
> the job started gets written, but if we do a NEW write, we make sure
> to FIRST commit the old data into the backing file then do the write
> into the active layer, and mark that cluster as no longer needing
> commit), differently from an "active" mode commit (a write to the
> active layer dirties the cluster, and we make as many passes as
> necessary, possibly writing some clusters to the backing file multiple
> times, so that the backing file contains the contents at the point the
> job ends rather than starts).

This sounds a lot like what the backup job is to mirror, just applied to
commit. It's an interesting idea, but I'm not sure if it wouldn't be a
separate block job then, like backup is separate from mirror.

Or maybe backup actually becomes very similar to the mirror job once we
implement the active mirror which intercepts requests...

> With our existing active commit code, is there a way to do an
> intermediate style commit instead of an active commit (by passing the
> node name instead of the device name, even though it resolves to the
> same 'top' node)?

No, passing the node name and passing the device name both starts an
active commit job.

> Maybe an optional boolean is worth having, where we default to active
> if 'top' is writable and 'normal' otherwise; but can set the boolean
> to force 'normal' even on a writable, and where setting the boolean on
> something that is not writable is either a no-op or an error?

I think if we add an option, I would actually make it mandatory.

Another thought I had is that we could make blockdev-commit support only
'normal' and extend the blockdev-mirror command so that you can use that
to start an active commit. I don't think there is a lot of code in the
mirror job implementation that has special cases for active commit.

> >=20
> >   * The 'backing-file' option (which specifies the new backing file
> >     string for parents after the commit job completes) is currently not
> >     allowed if top is the active layer. If we allow graph changes, this
> >     doesn't seem to make sense to me because even if top doesn't have a
> >     parent node when the job starts, it could have one when it's
> >     completed.
>=20
> Based on your recent patch series, I think we're still murky on exactly
> what graph changes the op-blockers are going to prevent.

Yes, it's still unclear how the protection is going to work in detail.
At the moment we're still using the old op blockers which just prevent
any change.

But I think the expected future behaviour for individual cases can be
reasonably clear. Adding new parents for the top node in a commit job
seems completely fine to me (because the commit operation should be
totally transparent for anything that looks at top), so maybe the APIs
should anticipate this.

> But allowing 'backing-file' even when 'top' starts life as the active
> layer makes sense, as we may create a snapshot or some other operation
> that changes 'top' into something that is no longer active, without
> invalidating the fact that we are doing a commit job

Right, taking a snapshot is a good practical example for adding a new
parent. Currently the old op blockers prevent this, but it's clear to me
that we want to allow this one day.

> (but there's also the tricky issue of whether libvirt should expect
> only one event with no followup command to end the job, or two events
> marking the two phases where a followup is necessary).

Yes. This seems to be an argument in favour of explicitly requesting
'normal' or active mode in the QMP command.

Kevin

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZyqZGAAoJEH8JsnLIjy/Wd/QQAKn3awpKJqd75vMt0SawNLRX
kv+6iTdDgqz7NP3lCck6Fb7pnNVt8MG9E0nGKLRYXZZ/W0G0mywjP+K1/NOIBb2w
G0O38vs/c9aTUDQeNzgMEUj5IYMTDmLyJ+uPFx+DRGniGOK5wLCFPIhCqn55D0ba
7iDwt+qjeaUCCntNfZCF/4Bq3kHWPEUmh0WdutIqczz75CwXrXyX94NI/3P4lMj/
u8aA+e6I8qRifkGOZWas7frdRASXqfpxelxAhLE4X665aWTwrUVZ4XSuaW9TNubi
Qz5AdUlQ54irKM8bjoCLg1+M/Zug6HNoO48RUGm9qV1DjcFHsG0u0o/oHxLgImRq
07wpQ/FR7TE2hLvYK0xgBUxv1vM/+FS3XzdauvGJZUXzgoHlN6Gx0ruZNMiljcfB
N/eA7gZi+2ozj/OZpOXQc+x8rRwo9vqbSsxajhHngfudBAoFTYjUUH62NzkfNVCU
/TrfTMaG80vQqqTUVSSAJE76aVt61haxYWRBIza9xcjcvkgg+1dzZpgxPIgFMczo
vNSMG+b4qJ6gwMjVbdsKxY8Y03+7IHwBHECRv+fbJp00KBNnG/eIePd20g2PCKSY
IfKVt+o5ikCAcw+65mkXtK6srHdFzXA91e1uxlX1VDB1Z70HWJynoirm6q5cOJ6n
UQ0DRB0jojcTizy0aI5d
=kq+a
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
