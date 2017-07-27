Received: from eggs.gnu.org ([2001:4830:134:3::10]:36513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dafiC-0007Xo-AW
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dafiB-0007pn-9j
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:08:08 -0400
Date: Thu, 27 Jul 2017 11:07:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170727100755.GC10129@stefanha-x1.localdomain>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20170726182320.cnqx3y64c7nmhvp3@postretch>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 09:23:20PM +0300, Manos Pitsidianakis wrote:
> On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
> > > This proposal follows a discussion we had with Kevin and Stefan on fi=
lter
> > > node management.
> > >=20
> > > With block filter drivers arises a need to configure filter nodes on =
runtime
> > > with QMP on live graphs. A problem with doing live graph modification=
s is
> > > that some block jobs modify the graph when they are done and don't op=
erate
> > > under any synchronisation, resulting in a race condition if we try to=
 insert
> > > a filter node in the place of an existing edge.
> >=20
> > But maybe you are thinking about higher level race conditions between
> > QMP commands.  Can you give an example of the race?
>=20
> Exactly, synchronisation between the QMP/user actions. Here's an example,
> correct me if I'm wrong:
>=20
> User issues a block-commit to this tree to commit A onto B:
>    BB -> A -> B
>=20
> This inserts the dummy mirror node at the top since this is a mirror job
> (active commit)
>    BB -> dummy -> A -> B
>=20
> User wants to add a filter node F below the BB. First we create the node:
>    BB -> dummy -> A -> B
>       F /
>=20
> Commit finishes before we do block-insert-node, dummy and A is removed fr=
om
> the BB's chain, mirror_exit calls bdrv_replace_node()
>=20
>    BB ------------> B
>                F -> /
>=20
> Now inserting F under BB will error since dummy does not exist any more.

I see the diagrams but the flow isn't clear without the user's QMP
commands.

F is created using blockdev-add?  What are the parameters and how does
it know about dummy?  I think this is an interesting question in itself
because dummy is a transient internal node that QMP users don't
necessarily know about.

What is the full block-insert-node command?

> The proposal doesn't guard against the following:
> User issues a block-commit to this tree to commit B onto C:
>    BB -> A -> B -> C
>=20
> The dummy node (commit's top bs is A):
>    BB -> A -> dummy -> B -> C
>=20
> blockdev-add of a filter we wish to eventually be between A and C:
>    BB -> A -> dummy -> B -> C
>             F/
>=20
> if commit finishes before we issue block-insert-node (commit_complete()
> calls bdrv_set_backing_hd() which only touches A)
>    BB -> A --------------> C
>           F -> dummy -> B /
>    resulting in error when issuing block-insert-node,
>=20
> else if we set the job to manual-delete and insert F:
>    BB -> A -> F -> dummy -> B -> C
> deleting the job will result in F being lost since the job's top bs wasn't
> updated.

manual-delete is a solution for block jobs.  The write threshold feature
is a plain QMP command that in the future will create a transient
internal node (before write notifier).

I'm not sure it makes sense to turn the write threshold feature into a
block job.  I guess it could work, but it seems a little unnatural and
maybe there will be other features that use transient internal nodes.

What I'm getting at is that there might be alternative to manual-delete
that work in the general case.  For example, if blockdev-add +
block-insert-node are part of a QMP 'transaction' command, can we lock
the graph to protect it against modifications?

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZebt7AAoJEJykq7OBq3PIyCAH/2ZrMCe80tc2zcaNonq5Ayd+
AaDHbhdFLl3IK8gBTyuH0LzGEvsu7xf4MPLM4XrDcSvWxCS0eN9Eg+cUmNGwQP88
jaghg9C30FReaDaSSlI2Gvliaz9UjDyCykFD2/X4eIsz6TMscr+2WcdilrxSfTyI
6b866CaqN8F3ZxQ8Rs1HiO+kLMuLFLTvQUytMc9Jr24PiADwYY8l44dfDkm3eFW+
thhCYH15O4c1FAyc60mnfBT9zKAL7E/RyhFhNpSzrDVEokCQVh8sR12OJA48yZeg
UrDXs0YZEZURBYOGnEdEEmEINBs8ybphfurty8RfL+tYlUguK8MellgT5dBg2ng=
=j/FP
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
