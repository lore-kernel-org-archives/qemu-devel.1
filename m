Received: from eggs.gnu.org ([2001:4830:134:3::10]:58912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwtm3-0003ez-Mf
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwtm2-0001yz-3I
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:35:59 -0400
Date: Tue, 26 Sep 2017 19:35:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170926173547.GD14717@localhost.localdomain>
References: <20170925122808.14561-1-kwolf@redhat.com>
	<20170925122808.14561-3-kwolf@redhat.com>
	<59f25063-4338-dc44-be0b-bc682e72d4ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <59f25063-4338-dc44-be0b-bc682e72d4ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] commit: Support multiple roots above
 top node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.09.2017 um 21:38 hat Eric Blake geschrieben:
> On 09/25/2017 07:28 AM, Kevin Wolf wrote:
> > This changes the commit block job to support operation in a graph where
> > there is more than a single active layer that references the top node.
> >=20
> > This involves inserting the commit filter node not only on the path
> > between the given active node and the top node, but between the top node
> > and all of its parents.
> >=20
> > On completion, bdrv_drop_intermediate() must consider all parents for
> > updating the backing file link. These parents may be backing files
> > themselves and such read-only; reopen them temporarily if necessary.
>=20
> s/such/as such/

Yes, thanks.

> > Previously this was achieved by the bdrv_reopen() calls in the commit
> > block job that made overlay_bs read-write for the whole duration of the
> > block job, even though write access is only needed on completion.
>=20
> Do we know, at the start of the operation, enough to reject attempts
> that will eventually fail because we cannot obtain write access at
> completion, without having to wait for all the intermediate work before
> the completion phase is reached?  If not, that might be a bit of a
> regression (where a command used to fail up front, we now waste a lot of
> effort, and possibly modify the backing chain irreversably, before
> finding out we still fail because we lack write access).

It is kind of a change in behaviour, but I wouldn't call it a
regression. The reason is that today I'm looking at it with a completely
different perspective than when the command was added.

Originally, we assumed a more or less static block node graph, which in
fact was only a mostly degenerated tree - a backing file chain. Block
jobs were kind of an exceptional thing and we allowed only one per
chain. In this restricted setting, checking at the start of the
operation made sense because we wouldn't allow things to change while
the job was running anyway.

A big part of the recent blockdev work, however, is about getting rid of
arbitrary restrictions like this. We want to allow running two commit
operations in the same backing chain as long as they don't conflict. We
don't want to prevent adding new users to an existing node unless there
is a good reason.

If you consider this, the set of nodes that will get their backing file
rewritten at the end of the block job isn't known yet when the job
starts; and even if we knew it, keeping the nodes writable all the time
while the job runs feels like it could easily conflict with other
callers of bdrv_reopen().

> > Now that we consider all parents, overlay_bs is meaningless. It is left
> > in place in this commit, but we'll remove it soon.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c        | 68 ++++++++++++++++++++++++++++++++++----------------=
--------
> >  block/commit.c |  2 +-
> >  2 files changed, 41 insertions(+), 29 deletions(-)
> > =20
> >      /* success - we can delete the intermediate states, and link top->=
base */
> > -    if (new_top_bs->backing->role->update_filename) {
> > -        backing_file_str =3D backing_file_str ? backing_file_str : bas=
e->filename;
> > -        ret =3D new_top_bs->backing->role->update_filename(new_top_bs-=
>backing,
> > -                                                         base, backing=
_file_str,
> > -                                                         &local_err);
> > -        if (ret < 0) {
> > -            bdrv_set_backing_hd(new_top_bs, top, &error_abort);
> > +    backing_file_str =3D backing_file_str ? backing_file_str : base->f=
ilename;
> > +
> > +    QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
> > +        /* Check whether we are allowed to switch c from top to base */
> > +        GSList *ignore_children =3D g_slist_prepend(NULL, c);
> > +        bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
> > +                               ignore_children, &local_err);
> > +        if (local_err) {
> > +            ret =3D -EPERM;
> > +            error_report_err(local_err);
> >              goto exit;
> >          }
> > -    }
> > +        g_slist_free(ignore_children);
> > =20
>=20
> And it looks like you DO check up front that permissions are sufficient
> for later on.

This is already during completion. The completion code uses the
transactional nature of permission updates to make sure that the
in-memory graph stays consistent with the on-disk backing file links
even in case of errors, but it's not really upfront in the sense of
checking when the block job is started. (You also need to hold the BQL
between starting and completing a permission change transaction, so just
moving this code wouldn't work.)

Kevin

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZyo/zAAoJEH8JsnLIjy/We8UQAJreXUrut3kheSJyQ6P8P3rE
vLMrOzZNGy10WMRg2u1Uy765FOIKeC9rCpNYO8ZPE04Z45S376vZ5Cl1LFeGhUUq
P1of0d9tH8jgSv972bh9U3C89/GUg3wBWVxLTdkhSADClM++LZuTnsZU1g5ZOJWq
NWO38GHNoJl3vJ87cbyM3krAFR/BWeSgV4PzG0XCmO6YvrMnfEfyphU/ZYyRQEj3
2WLXY26eGdYi1i5QMHnRFXxSdnujUmXQVSDdYDm05anJ7fzzST0lwUXQLSQAD1pS
Bq20Ah8kcUm1lzOsFnJO1dgXzg33zXYP28P0DwaPk0nGRcw8fwA/SR60Y1tcjkre
aFkK9S75PW3lrpLG+NkjlqjDnRxigyl4XBlQwRR4+O4/BI0kreNQLKemfnJ8CFRL
iJ5VVeigVCQRy7T5XEeNHMM4fBGo8FOJhPvsjt38n7yy0GuqQNL9RarfiH71HPDk
AgLGi16oGccEQeSDEkrwiZ9zK3BAGC7dBrhPO9k6OlJ7cFXCZMqgcjLWBzfhTXwJ
anm248wROldudcPQJsix3qG58MaPbCHwTM07xVYEyLSP/kFh8rYx5fksJGsLzNwi
Jhu504qHSPRMnlP3M1zZ8DbDDO5N4uDM05J+bewL3oACZdJM6JdJJZ4HZRBB6onu
9TvHROMCNYMrnDVTcQ1B
=3HBO
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
