Received: from eggs.gnu.org ([2001:4830:134:3::10]:35425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXgU-0003CK-Eq
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXgS-00036F-W6
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:58:06 -0400
Date: Tue, 1 Aug 2017 16:57:56 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170801135756.haskbcc3a7jv6lms@postretch>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<20170727100755.GC10129@stefanha-x1.localdomain>
	<20170728120843.GD3983@localhost.localdomain>
	<20170731173017.yorggmbkjmcppkka@postretch>
	<20170801135036.GC4257@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlsom625sawsa3tf"
Content-Disposition: inline
In-Reply-To: <20170801135036.GC4257@localhost.localdomain>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--wlsom625sawsa3tf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Tue, Aug 01, 2017 at 03:50:36PM +0200, Kevin Wolf wrote:
>Am 31.07.2017 um 19:30 hat Manos Pitsidianakis geschrieben:
>> On Fri, Jul 28, 2017 at 02:08:43PM +0200, Kevin Wolf wrote:
>> > Am 27.07.2017 um 12:07 hat Stefan Hajnoczi geschrieben:
>> > > On Wed, Jul 26, 2017 at 09:23:20PM +0300, Manos Pitsidianakis wrote:
>> > > > On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
>> > > > > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
>> > > > > > This proposal follows a discussion we had with Kevin and Stefan on filter
>> > > > > > node management.
>> > > > > >
>> > > > > > With block filter drivers arises a need to configure filter nodes on runtime
>> > > > > > with QMP on live graphs. A problem with doing live graph modifications is
>> > > > > > that some block jobs modify the graph when they are done and don't operate
>> > > > > > under any synchronisation, resulting in a race condition if we try to insert
>> > > > > > a filter node in the place of an existing edge.
>> > > > >
>> > > > > But maybe you are thinking about higher level race conditions between
>> > > > > QMP commands.  Can you give an example of the race?
>> > > >
>> > > > Exactly, synchronisation between the QMP/user actions. Here's an example,
>> > > > correct me if I'm wrong:
>> > > >
>> > > > User issues a block-commit to this tree to commit A onto B:
>> > > >    BB -> A -> B
>> > > >
>> > > > This inserts the dummy mirror node at the top since this is a mirror job
>> > > > (active commit)
>> > > >    BB -> dummy -> A -> B
>> > > >
>> > > > User wants to add a filter node F below the BB. First we create the node:
>> > > >    BB -> dummy -> A -> B
>> > > >       F /
>> > > >
>> > > > Commit finishes before we do block-insert-node, dummy and A is removed from
>> > > > the BB's chain, mirror_exit calls bdrv_replace_node()
>> > > >
>> > > >    BB ------------> B
>> > > >                F -> /
>> > > >
>> > > > Now inserting F under BB will error since dummy does not exist any more.
>> > >
>> > > I see the diagrams but the flow isn't clear without the user's QMP
>> > > commands.
>> > >
>> > > F is created using blockdev-add?  What are the parameters and how does
>> > > it know about dummy?  I think this is an interesting question in itself
>> > > because dummy is a transient internal node that QMP users don't
>> > > necessarily know about.
>> >
>> > We can expect that users of block-insert-node also know about block job
>> > filter nodes, simply because the former is newer than the latter.
>> >
>> > (I also don't like the name "dummy", this makes it sound like it's not
>> > really a proper node. In reality, there is little reason to treat it
>> > specially.)
>> >
>> > > What is the full block-insert-node command?
>> > >
>> > > > The proposal doesn't guard against the following:
>> > > > User issues a block-commit to this tree to commit B onto C:
>> > > >    BB -> A -> B -> C
>> > > >
>> > > > The dummy node (commit's top bs is A):
>> > > >    BB -> A -> dummy -> B -> C
>> > > >
>> > > > blockdev-add of a filter we wish to eventually be between A and C:
>> > > >    BB -> A -> dummy -> B -> C
>> > > >             F/
>> > > >
>> > > > if commit finishes before we issue block-insert-node (commit_complete()
>> > > > calls bdrv_set_backing_hd() which only touches A)
>> > > >    BB -> A --------------> C
>> > > >           F -> dummy -> B /
>> > > >    resulting in error when issuing block-insert-node,
>> > > >
>> > > > else if we set the job to manual-delete and insert F:
>> > > >    BB -> A -> F -> dummy -> B -> C
>> > > > deleting the job will result in F being lost since the job's top bs wasn't
>> > > > updated.
>> > >
>> > > manual-delete is a solution for block jobs.  The write threshold
>> > > feature is a plain QMP command that in the future will create a
>> > > transient internal node (before write notifier).
>> >
>> > Yes, that becomes a legacy QMP command then. The new way is blockdev-add
>> > and block-insert-node for write threshold, too.
>> >
>> > Apart from that, a write threshold node never disappears by itself, it
>> > is only inserted or removed in the context of a QMP command. That makes
>> > it a lot less dangerous than automatic block completion.
>> >
>> > > I'm not sure it makes sense to turn the write threshold feature into a
>> > > block job.  I guess it could work, but it seems a little unnatural and
>> > > maybe there will be other features that use transient internal nodes.
>> >
>> > Yeah, no reason to do so. Just a manually created filter node.
>> >
>>
>> Can you explain what you have in mind? The current workflow is using
>> block-set-write-threshold on the targetted bs. If we want write threshold to
>> be on node level we would want a new filter driver so that it can take
>> options special to write-threshold.
>
>Yes, I think that's what we want.
>
>> Unless we make the notify filter be a write threshold by default, and
>> when using it internally by the backup job, disable the threshold and
>> add our backup notifier to the node's list. Of course the current
>> write threshold code could be refactored into a new driver so that it
>> doesn't have to rely on notifiers.
>
>As discussed on IRC, we shouldn't implement a bad interface (which
>notifiers are, they bypass normal block device configuration) in a
>different way, but we should replace it by something that fits better in
>the block layer design.
>
>In other words, don't add magic to provide the same notifier functions
>as we had, but convert their callers to have a block node of their own
>(i.e. one backup_top driver, one write-treshold driver, etc.).
>
>> The way I've currently done the conversion is to add an implicit
>> filter when enabling the threshold, just like in backup jobs.
>
>This is fine, but it should be specifically a write-threshold filter
>that a user can also manually insert whereever they like. The old QMP
>interfaces would be considered legacy commands then, because
>blockdev-add and blockdev-insert-node can provide the same thing.
>
>Kevin

Alright thanks, this will make it easier.

--wlsom625sawsa3tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmAiOQACgkQc2J8L2kN
9xB2kw//RoVuS4TPqMtHRVZWYNI30e0FzYDRQVN3i188keqADmCutEGJkhSci+2R
c2pyyBB0/gr/fDpioRtoNm7G99sPxIZ+RK20IZ6yj2S9P53nhGhobblVmP1MzWMU
js//TZ7AMXqLtQO/2O7o6co5tniUfG+zYEWdHwLR7Uhb+ZbFkzj1hocFXv/PHUKA
Y1U4IKrAAkE2qrOKbaxvrfnBGHraj8nYy20m9o5vECXPBwbd3CLGJoAYwfCYhPQA
cC22z4UJqnTmgUkUhsNo4zfH48zInWyzykR9fzt6tdvE9vg8zlRt3DQTw+WL+fwK
+mRIlCxB/pd911zZcXKU+AqHWZqbQmx9e2ZXBl38IL0DeV2CwZPMO6OOMT7b+KS+
/cmX1WV3sVjeax7XJcu1188LC4oCvuj2d64tepeVsFh+vlGvIgADPorEattyVByN
m+0CIS6cQXtgc32o4IDkt5Bu1X8BQYTZM0FhKEahTq6t47hqvMgoodTmhNeCdbyW
kY96OvnEMCW+bGYsrGkGgCyHiSD+uOmjomajaKFLB2ISXnEEdVlqXbYDtFZNPfrI
CD19GMbdVICyDfPpSkL5eY9FuTR+vtG0FsJ1xglouU2ekNtGEaPk5LVkh9edFmkA
xVuM8V3U9XSJN1GcF1PveQ2hwg4HBV/9C+Xoj7WbiL/MQT4iYTg=
=BLWx
-----END PGP SIGNATURE-----

--wlsom625sawsa3tf--
