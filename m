Received: from eggs.gnu.org ([2001:4830:134:3::10]:39299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcC4Q-0004d8-S2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcC4P-0004d4-E5
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:53:22 -0400
Date: Mon, 31 Jul 2017 15:53:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170731145310.GJ11830@stefanha-x1.localdomain>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<20170727100755.GC10129@stefanha-x1.localdomain>
	<20170728120843.GD3983@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Content-Disposition: inline
In-Reply-To: <20170728120843.GD3983@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 02:08:43PM +0200, Kevin Wolf wrote:
> Am 27.07.2017 um 12:07 hat Stefan Hajnoczi geschrieben:
> > On Wed, Jul 26, 2017 at 09:23:20PM +0300, Manos Pitsidianakis wrote:
> > > On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
> > > > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
> > > > > This proposal follows a discussion we had with Kevin and Stefan o=
n filter
> > > > > node management.
> > > > >=20
> > > > > With block filter drivers arises a need to configure filter nodes=
 on runtime
> > > > > with QMP on live graphs. A problem with doing live graph modifica=
tions is
> > > > > that some block jobs modify the graph when they are done and don'=
t operate
> > > > > under any synchronisation, resulting in a race condition if we tr=
y to insert
> > > > > a filter node in the place of an existing edge.
> > > >=20
> > > > But maybe you are thinking about higher level race conditions betwe=
en
> > > > QMP commands.  Can you give an example of the race?
> > >=20
> > > Exactly, synchronisation between the QMP/user actions. Here's an exam=
ple,
> > > correct me if I'm wrong:
> > >=20
> > > User issues a block-commit to this tree to commit A onto B:
> > >    BB -> A -> B
> > >=20
> > > This inserts the dummy mirror node at the top since this is a mirror =
job
> > > (active commit)
> > >    BB -> dummy -> A -> B
> > >=20
> > > User wants to add a filter node F below the BB. First we create the n=
ode:
> > >    BB -> dummy -> A -> B
> > >       F /
> > >=20
> > > Commit finishes before we do block-insert-node, dummy and A is remove=
d from
> > > the BB's chain, mirror_exit calls bdrv_replace_node()
> > >=20
> > >    BB ------------> B
> > >                F -> /
> > >=20
> > > Now inserting F under BB will error since dummy does not exist any mo=
re.
> >=20
> > I see the diagrams but the flow isn't clear without the user's QMP
> > commands.
> >=20
> > F is created using blockdev-add?  What are the parameters and how does
> > it know about dummy?  I think this is an interesting question in itself
> > because dummy is a transient internal node that QMP users don't
> > necessarily know about.
>=20
> We can expect that users of block-insert-node also know about block job
> filter nodes, simply because the former is newer than the latter.
>=20
> (I also don't like the name "dummy", this makes it sound like it's not
> really a proper node. In reality, there is little reason to treat it
> specially.)
>=20
> > What is the full block-insert-node command?
> >=20
> > > The proposal doesn't guard against the following:
> > > User issues a block-commit to this tree to commit B onto C:
> > >    BB -> A -> B -> C
> > >=20
> > > The dummy node (commit's top bs is A):
> > >    BB -> A -> dummy -> B -> C
> > >=20
> > > blockdev-add of a filter we wish to eventually be between A and C:
> > >    BB -> A -> dummy -> B -> C
> > >             F/
> > >=20
> > > if commit finishes before we issue block-insert-node (commit_complete=
()
> > > calls bdrv_set_backing_hd() which only touches A)
> > >    BB -> A --------------> C
> > >           F -> dummy -> B /
> > >    resulting in error when issuing block-insert-node,
> > >=20
> > > else if we set the job to manual-delete and insert F:
> > >    BB -> A -> F -> dummy -> B -> C
> > > deleting the job will result in F being lost since the job's top bs w=
asn't
> > > updated.
> >=20
> > manual-delete is a solution for block jobs.  The write threshold
> > feature is a plain QMP command that in the future will create a
> > transient internal node (before write notifier).
>=20
> Yes, that becomes a legacy QMP command then. The new way is blockdev-add
> and block-insert-node for write threshold, too.
>=20
> Apart from that, a write threshold node never disappears by itself, it
> is only inserted or removed in the context of a QMP command. That makes
> it a lot less dangerous than automatic block completion.

Nice thinking - write threshold can be a node too!

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZf0RWAAoJEJykq7OBq3PIYUgH/RXXKgDH0fs8IaTCKQnRJSj/
mVIOpXv1JyqUQsRcvSNGytnKo7UBGk8A3+YtkwomDzn2BqFCnBuMOiARzkenaPTW
zvQqipsVsa5u6LbvZ+dZWyaDLf8st6AbhBBCaV6p/+xq4J/gF4Pfj/E0vgK2UQcP
yAhlcZNdRiZ4jXHOcHPNx2moeHC2Brf4cxGq6hX8zGkxonMYmgql7vBYaejQ33fU
SmwOot2JCKJ/fPA7p30lez6DkE4E/NjrJNjR3ZJ8Yc/o3eozyKsMRJS1DfQT7fa/
bXkv3jlNX92zvWd2hnSY4QEJzwRuEN6cnyhziown09dZqkV5CFUlHbUoqc8q7+w=
=cOa+
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
