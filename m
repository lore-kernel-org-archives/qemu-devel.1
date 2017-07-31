Received: from eggs.gnu.org ([2001:4830:134:3::10]:36605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcEWX-0008Vz-87
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcEWW-0002bk-5L
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:30:33 -0400
Date: Mon, 31 Jul 2017 20:30:17 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170731173017.yorggmbkjmcppkka@postretch>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<20170727100755.GC10129@stefanha-x1.localdomain>
	<20170728120843.GD3983@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dddoqqdx3mzco3vf"
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--dddoqqdx3mzco3vf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 02:08:43PM +0200, Kevin Wolf wrote:
>Am 27.07.2017 um 12:07 hat Stefan Hajnoczi geschrieben:
>> On Wed, Jul 26, 2017 at 09:23:20PM +0300, Manos Pitsidianakis wrote:
>> > On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
>> > > On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
>> > > > This proposal follows a discussion we had with Kevin and Stefan on=
 filter
>> > > > node management.
>> > > >
>> > > > With block filter drivers arises a need to configure filter nodes =
on runtime
>> > > > with QMP on live graphs. A problem with doing live graph modificat=
ions is
>> > > > that some block jobs modify the graph when they are done and don't=
 operate
>> > > > under any synchronisation, resulting in a race condition if we try=
 to insert
>> > > > a filter node in the place of an existing edge.
>> > >
>> > > But maybe you are thinking about higher level race conditions between
>> > > QMP commands.  Can you give an example of the race?
>> >
>> > Exactly, synchronisation between the QMP/user actions. Here's an examp=
le,
>> > correct me if I'm wrong:
>> >
>> > User issues a block-commit to this tree to commit A onto B:
>> >    BB -> A -> B
>> >
>> > This inserts the dummy mirror node at the top since this is a mirror j=
ob
>> > (active commit)
>> >    BB -> dummy -> A -> B
>> >
>> > User wants to add a filter node F below the BB. First we create the no=
de:
>> >    BB -> dummy -> A -> B
>> >       F /
>> >
>> > Commit finishes before we do block-insert-node, dummy and A is removed=
 from
>> > the BB's chain, mirror_exit calls bdrv_replace_node()
>> >
>> >    BB ------------> B
>> >                F -> /
>> >
>> > Now inserting F under BB will error since dummy does not exist any mor=
e.
>>
>> I see the diagrams but the flow isn't clear without the user's QMP
>> commands.
>>
>> F is created using blockdev-add?  What are the parameters and how does
>> it know about dummy?  I think this is an interesting question in itself
>> because dummy is a transient internal node that QMP users don't
>> necessarily know about.
>
>We can expect that users of block-insert-node also know about block job
>filter nodes, simply because the former is newer than the latter.
>
>(I also don't like the name "dummy", this makes it sound like it's not
>really a proper node. In reality, there is little reason to treat it
>specially.)
>
>> What is the full block-insert-node command?
>>
>> > The proposal doesn't guard against the following:
>> > User issues a block-commit to this tree to commit B onto C:
>> >    BB -> A -> B -> C
>> >
>> > The dummy node (commit's top bs is A):
>> >    BB -> A -> dummy -> B -> C
>> >
>> > blockdev-add of a filter we wish to eventually be between A and C:
>> >    BB -> A -> dummy -> B -> C
>> >             F/
>> >
>> > if commit finishes before we issue block-insert-node (commit_complete()
>> > calls bdrv_set_backing_hd() which only touches A)
>> >    BB -> A --------------> C
>> >           F -> dummy -> B /
>> >    resulting in error when issuing block-insert-node,
>> >
>> > else if we set the job to manual-delete and insert F:
>> >    BB -> A -> F -> dummy -> B -> C
>> > deleting the job will result in F being lost since the job's top bs wa=
sn't
>> > updated.
>>
>> manual-delete is a solution for block jobs.  The write threshold
>> feature is a plain QMP command that in the future will create a
>> transient internal node (before write notifier).
>
>Yes, that becomes a legacy QMP command then. The new way is blockdev-add
>and block-insert-node for write threshold, too.
>
>Apart from that, a write threshold node never disappears by itself, it
>is only inserted or removed in the context of a QMP command. That makes
>it a lot less dangerous than automatic block completion.
>
>> I'm not sure it makes sense to turn the write threshold feature into a
>> block job.  I guess it could work, but it seems a little unnatural and
>> maybe there will be other features that use transient internal nodes.
>
>Yeah, no reason to do so. Just a manually created filter node.
>

Can you explain what you have in mind? The current workflow is using=20
block-set-write-threshold on the targetted bs. If we want write=20
threshold to be on node level we would want a new filter driver so that=20
it can take options special to write-threshold. Unless we make the=20
notify filter be a write threshold by default, and when using it=20
internally by the backup job, disable the threshold and add our backup=20
notifier to the node's list. Of course the current write threshold code=20
could be refactored into a new driver so that it doesn't have to rely on=20
notifiers.

The way I've currently done the conversion is to add an implicit filter=20
when enabling the threshold, just like in backup jobs.

--dddoqqdx3mzco3vf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAll/aSkACgkQc2J8L2kN
9xBtIQ//fPHfoip4lDP7+gNIQE+Av1MiFAms4dxs36QeyvMjAnfYrTAUXNI+8hQJ
CvqQIAY80ocnqR2tfLVmij5EBiFMK3XWJe+A3Vm8XVhZHfVvEbZDagevORGI17QI
/UFnzzEmTWnN0zMDtevdKQ4As2K8J+Ma0xz46d3LWOsLpe/x7z1Y1KhA+oLI3aLz
H71KOSn+0W1rf3yDL0W1kqkmNEf7YuLE5CeIJWFiIGm2mSvF+5WK9+ccNQUbVQBT
6DVAE4UJAyrPIljhoQg+s9r7zFD/TOPIi+tfOT8BPCfQpyIuhkPb90tGx+D7ryyj
9PZq7tYUOYMz3tCMMei4APMqNc7riLPBCdvkn5dhpDeOYHWsTGwLVD9n6mgXA8Ug
soQ6gO6qdBgYRhV+rX9M6oK96FCedwJ9/gY2kLRAx8oFSPD58EfSHWPc8fbujb2j
MSk5SVOFvhD2eLOCMq499g3TZUJN8ADi5vmqb+3rR2B6BNW2kuq7kpqKN45N9nIs
1rl5GWVPUIFR7qHxmZg1hydDtB1Z6Tr9/aXGJY781kQO5iqkfr2tO/2NFBKT0XeR
YbNMuBOpoZuiwLjKLQ5cHh0jgg4PxqOmL1fkmrNXxlmO6woWMJdAL0vrUETGH3Ni
R0gOq4XUcksIi28pSBBJhV5HsFVRciZ1FWCqm5Iu9CBln1NTKiY=
=Cmbc
-----END PGP SIGNATURE-----

--dddoqqdx3mzco3vf--
