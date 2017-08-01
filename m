Received: from eggs.gnu.org ([2001:4830:134:3::10]:60634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcXZU-0006D3-Mr
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcXZT-0005sN-F3
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:52 -0400
Date: Tue, 1 Aug 2017 15:50:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170801135036.GC4257@localhost.localdomain>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<20170727100755.GC10129@stefanha-x1.localdomain>
	<20170728120843.GD3983@localhost.localdomain>
	<20170731173017.yorggmbkjmcppkka@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20170731173017.yorggmbkjmcppkka@postretch>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.07.2017 um 19:30 hat Manos Pitsidianakis geschrieben:
> On Fri, Jul 28, 2017 at 02:08:43PM +0200, Kevin Wolf wrote:
> > Am 27.07.2017 um 12:07 hat Stefan Hajnoczi geschrieben:
> > > On Wed, Jul 26, 2017 at 09:23:20PM +0300, Manos Pitsidianakis wrote:
> > > > On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
> > > > > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wro=
te:
> > > > > > This proposal follows a discussion we had with Kevin and Stefan=
 on filter
> > > > > > node management.
> > > > > >
> > > > > > With block filter drivers arises a need to configure filter nod=
es on runtime
> > > > > > with QMP on live graphs. A problem with doing live graph modifi=
cations is
> > > > > > that some block jobs modify the graph when they are done and do=
n't operate
> > > > > > under any synchronisation, resulting in a race condition if we =
try to insert
> > > > > > a filter node in the place of an existing edge.
> > > > >
> > > > > But maybe you are thinking about higher level race conditions bet=
ween
> > > > > QMP commands.  Can you give an example of the race?
> > > >
> > > > Exactly, synchronisation between the QMP/user actions. Here's an ex=
ample,
> > > > correct me if I'm wrong:
> > > >
> > > > User issues a block-commit to this tree to commit A onto B:
> > > >    BB -> A -> B
> > > >
> > > > This inserts the dummy mirror node at the top since this is a mirro=
r job
> > > > (active commit)
> > > >    BB -> dummy -> A -> B
> > > >
> > > > User wants to add a filter node F below the BB. First we create the=
 node:
> > > >    BB -> dummy -> A -> B
> > > >       F /
> > > >
> > > > Commit finishes before we do block-insert-node, dummy and A is remo=
ved from
> > > > the BB's chain, mirror_exit calls bdrv_replace_node()
> > > >
> > > >    BB ------------> B
> > > >                F -> /
> > > >
> > > > Now inserting F under BB will error since dummy does not exist any =
more.
> > >=20
> > > I see the diagrams but the flow isn't clear without the user's QMP
> > > commands.
> > >=20
> > > F is created using blockdev-add?  What are the parameters and how does
> > > it know about dummy?  I think this is an interesting question in itse=
lf
> > > because dummy is a transient internal node that QMP users don't
> > > necessarily know about.
> >=20
> > We can expect that users of block-insert-node also know about block job
> > filter nodes, simply because the former is newer than the latter.
> >=20
> > (I also don't like the name "dummy", this makes it sound like it's not
> > really a proper node. In reality, there is little reason to treat it
> > specially.)
> >=20
> > > What is the full block-insert-node command?
> > >=20
> > > > The proposal doesn't guard against the following:
> > > > User issues a block-commit to this tree to commit B onto C:
> > > >    BB -> A -> B -> C
> > > >
> > > > The dummy node (commit's top bs is A):
> > > >    BB -> A -> dummy -> B -> C
> > > >
> > > > blockdev-add of a filter we wish to eventually be between A and C:
> > > >    BB -> A -> dummy -> B -> C
> > > >             F/
> > > >
> > > > if commit finishes before we issue block-insert-node (commit_comple=
te()
> > > > calls bdrv_set_backing_hd() which only touches A)
> > > >    BB -> A --------------> C
> > > >           F -> dummy -> B /
> > > >    resulting in error when issuing block-insert-node,
> > > >
> > > > else if we set the job to manual-delete and insert F:
> > > >    BB -> A -> F -> dummy -> B -> C
> > > > deleting the job will result in F being lost since the job's top bs=
 wasn't
> > > > updated.
> > >=20
> > > manual-delete is a solution for block jobs.  The write threshold
> > > feature is a plain QMP command that in the future will create a
> > > transient internal node (before write notifier).
> >=20
> > Yes, that becomes a legacy QMP command then. The new way is blockdev-add
> > and block-insert-node for write threshold, too.
> >=20
> > Apart from that, a write threshold node never disappears by itself, it
> > is only inserted or removed in the context of a QMP command. That makes
> > it a lot less dangerous than automatic block completion.
> >=20
> > > I'm not sure it makes sense to turn the write threshold feature into a
> > > block job.  I guess it could work, but it seems a little unnatural and
> > > maybe there will be other features that use transient internal nodes.
> >=20
> > Yeah, no reason to do so. Just a manually created filter node.
> >=20
>=20
> Can you explain what you have in mind? The current workflow is using
> block-set-write-threshold on the targetted bs. If we want write threshold=
 to
> be on node level we would want a new filter driver so that it can take
> options special to write-threshold.

Yes, I think that's what we want.

> Unless we make the notify filter be a write threshold by default, and
> when using it internally by the backup job, disable the threshold and
> add our backup notifier to the node's list. Of course the current
> write threshold code could be refactored into a new driver so that it
> doesn't have to rely on notifiers.

As discussed on IRC, we shouldn't implement a bad interface (which
notifiers are, they bypass normal block device configuration) in a
different way, but we should replace it by something that fits better in
the block layer design.

In other words, don't add magic to provide the same notifier functions
as we had, but convert their callers to have a block node of their own
(i.e. one backup_top driver, one write-treshold driver, etc.).

> The way I've currently done the conversion is to add an implicit
> filter when enabling the threshold, just like in backup jobs.

This is fine, but it should be specifically a write-threshold filter
that a user can also manually insert whereever they like. The old QMP
interfaces would be considered legacy commands then, because
blockdev-add and blockdev-insert-node can provide the same thing.

Kevin

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZgIcsAAoJEH8JsnLIjy/Wkp4P/1ahSDVlW9kjgYRK75Yq7GcB
CQ4mNgLI3bQIyy0XFEtjGwL3bRgUqCOc6FCIh+ZNOUNW9mG/JdL1r7wCZSRDWpWw
2yFg22QtSalEB+awibqRsaqSlO1vkVfbzAARVSZBEg8aEioBgwhMNw1EaL24xNOs
lEt5FpxmwA38cpZvKthfIOUlE1ToxN2A1O+aH4fjkFkp8jVJOxtrLY7Z8Wx0fO5d
YYB66oKz7vZ6OLXROo56UWMgTQx+884CSu/n+nKz2N0BQttUgr9RguDIEGimVvVc
qYvil0i5w/t9BmS9Amz7/KLEvoknfmypxJtDgsmwRUuCTZoqQZPRHW2K17cchwmf
twh/ji+tUIyy5HMFx4EA4GhTlFDoAJfUdEKkKf7UwBpjTwf+GbxinoG5kTl7Cx6v
qmrX19eLz5WsAqNezN/BJgi9+QgLqxkVaHCNMVLM7c3RS/3yOP56e2LgEP6f9wT5
WhU/bCZ2ZHHi20yMrXedpAWYSIYwY4C9UERBwvNjfhfNLl60n78vKyKIh8BBEEx6
J0yJRjX2wlXSSZfDoIprpuYq4Yot7qyg9gnLMkjsKdMbWwEFuNyhgSEsN+LtXakG
AR5O1mQ6Y2JNDNfD/EdlrtQCfvUIxfYBlrrCh/A4Y2oiZYbwdzDpdSrySGH3j92Q
aC/kOa/U9+XLZMwn5SWy
=eVxo
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
