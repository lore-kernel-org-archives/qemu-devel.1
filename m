Received: from eggs.gnu.org ([2001:4830:134:3::10]:52938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db44f-0003Zf-O6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db44e-00024f-Fc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:08:57 -0400
Date: Fri, 28 Jul 2017 14:08:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170728120843.GD3983@localhost.localdomain>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<20170727100755.GC10129@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20170727100755.GC10129@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.07.2017 um 12:07 hat Stefan Hajnoczi geschrieben:
> On Wed, Jul 26, 2017 at 09:23:20PM +0300, Manos Pitsidianakis wrote:
> > On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
> > > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
> > > > This proposal follows a discussion we had with Kevin and Stefan on =
filter
> > > > node management.
> > > >=20
> > > > With block filter drivers arises a need to configure filter nodes o=
n runtime
> > > > with QMP on live graphs. A problem with doing live graph modificati=
ons is
> > > > that some block jobs modify the graph when they are done and don't =
operate
> > > > under any synchronisation, resulting in a race condition if we try =
to insert
> > > > a filter node in the place of an existing edge.
> > >=20
> > > But maybe you are thinking about higher level race conditions between
> > > QMP commands.  Can you give an example of the race?
> >=20
> > Exactly, synchronisation between the QMP/user actions. Here's an exampl=
e,
> > correct me if I'm wrong:
> >=20
> > User issues a block-commit to this tree to commit A onto B:
> >    BB -> A -> B
> >=20
> > This inserts the dummy mirror node at the top since this is a mirror job
> > (active commit)
> >    BB -> dummy -> A -> B
> >=20
> > User wants to add a filter node F below the BB. First we create the nod=
e:
> >    BB -> dummy -> A -> B
> >       F /
> >=20
> > Commit finishes before we do block-insert-node, dummy and A is removed =
=66rom
> > the BB's chain, mirror_exit calls bdrv_replace_node()
> >=20
> >    BB ------------> B
> >                F -> /
> >=20
> > Now inserting F under BB will error since dummy does not exist any more.
>=20
> I see the diagrams but the flow isn't clear without the user's QMP
> commands.
>=20
> F is created using blockdev-add?  What are the parameters and how does
> it know about dummy?  I think this is an interesting question in itself
> because dummy is a transient internal node that QMP users don't
> necessarily know about.

We can expect that users of block-insert-node also know about block job
filter nodes, simply because the former is newer than the latter.

(I also don't like the name "dummy", this makes it sound like it's not
really a proper node. In reality, there is little reason to treat it
specially.)

> What is the full block-insert-node command?
>=20
> > The proposal doesn't guard against the following:
> > User issues a block-commit to this tree to commit B onto C:
> >    BB -> A -> B -> C
> >=20
> > The dummy node (commit's top bs is A):
> >    BB -> A -> dummy -> B -> C
> >=20
> > blockdev-add of a filter we wish to eventually be between A and C:
> >    BB -> A -> dummy -> B -> C
> >             F/
> >=20
> > if commit finishes before we issue block-insert-node (commit_complete()
> > calls bdrv_set_backing_hd() which only touches A)
> >    BB -> A --------------> C
> >           F -> dummy -> B /
> >    resulting in error when issuing block-insert-node,
> >=20
> > else if we set the job to manual-delete and insert F:
> >    BB -> A -> F -> dummy -> B -> C
> > deleting the job will result in F being lost since the job's top bs was=
n't
> > updated.
>=20
> manual-delete is a solution for block jobs.  The write threshold
> feature is a plain QMP command that in the future will create a
> transient internal node (before write notifier).

Yes, that becomes a legacy QMP command then. The new way is blockdev-add
and block-insert-node for write threshold, too.

Apart from that, a write threshold node never disappears by itself, it
is only inserted or removed in the context of a QMP command. That makes
it a lot less dangerous than automatic block completion.

> I'm not sure it makes sense to turn the write threshold feature into a
> block job.  I guess it could work, but it seems a little unnatural and
> maybe there will be other features that use transient internal nodes.

Yeah, no reason to do so. Just a manually created filter node.

> What I'm getting at is that there might be alternative to manual-delete
> that work in the general case.  For example, if blockdev-add +
> block-insert-node are part of a QMP 'transaction' command, can we lock
> the graph to protect it against modifications?

We thought about this at the last STR meeting. However, not for much
longer than a minute. Markus and I both agreed that we wouldn't be the
ones to try and make blockdev-add transactionable. It sounds like a huge
amount of work and a high risk of bugs for little benefit.

Let's just make sure that we provide a way for management tools to avoid
any surprise changes in the block graph.

Kevin

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZeylLAAoJEH8JsnLIjy/WnRIP/1dF2Mdozvo9KeNVb72k7Zip
2iDfmkMeVK/g7LVYO50Ue7erGnHtdH0+RCt67PqxEr6ezxdYLLkYxeO74cNcLP9C
QW3V+l0g0XW7uc6Fuhsw5xwiel4FAc2iqF/9/auWHLuczmImWPJQNr9HfAtODKlE
XUBsHIvCns3Dv+sC1Eed9MlI4kwNVfxhsHGgnYgBZWq7+VzeHjvVukGtvwnF0ox/
/okfZom1lKNS8PmyPseWXTBz5lhwo3shxO6i7x4SeD9Xo1RlKU+ErPEmNP8++9Fw
o2hvyBGnsRFEmxDFE4BUh1pqO98iVeduAYlGVTkujLsrTTbZ+ZZIoEJW+Zfyt1gw
K8tLa3OC0D4nNSYCDiYGTh+XeLdl/nO3w6GGQ+ikQXXu1T/R+fQXm/dzjm+YsRoG
nszo5yHuZIWglgEPzP7b+iPAeMW5FjzAhyoDFWGXjhXTJ9QsMdEhDVELgZ4Y7tM4
jfQVSZTS8Dn8dP3BC8cil4yJCWa7J0fyL7a0kxRn1UfnXZYefFA766I9Y9rON9Vh
tfEa59HMYD8cF+X4KzIxYAbbmOj5hVVBi7g1CStPp+6QBDnF0sbJSoMaN12TMHp8
gu11TkzNSncQKEDJZbtvF6vf94AHD8Ym95g7xRxkpTEEtPWbrG8WvAHAu4FgU25n
3LEx2xRnQXfkUC2oUQb9
=vTVK
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
