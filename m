Received: from eggs.gnu.org ([209.51.188.92]:35717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm40q-0003UD-SY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm40n-0005k6-5Z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:55:14 -0500
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
Date: Tue, 22 Jan 2019 15:54:54 -0600
MIME-Version: 1.0
In-Reply-To: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dyU0aTasuFcMQhEdy1tdebxD4uA2GPBFK"
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>, qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Cc: kashyap.cv@gmail.com, Suman Swaroop <suman.swaroop@rubrik.com>, kchamart@redhat.com, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dyU0aTasuFcMQhEdy1tdebxD4uA2GPBFK
From: Eric Blake <eblake@redhat.com>
To: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>, qemu-discuss@nongnu.org,
 qemu-devel@nongnu.org
Cc: kashyap.cv@gmail.com, Suman Swaroop <suman.swaroop@rubrik.com>,
 kchamart@redhat.com, John Snow <jsnow@redhat.com>
Message-ID: <e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
In-Reply-To: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 1:29 PM, Bharadwaj Rayala wrote:
> Hi,
>=20
> TL(Cant)R: I am trying to figure out a workflow for doing incremental
> drive-backups using dirty-bitmaps. Feels qemu lacks some essential feat=
ures
> to achieve it.
>=20
> I am trying to build a backup workflow(program) using drive-backup alon=
g
> with dirty bitmaps to take backups of kvm vms. EIther pull/push model w=
orks
> for me. Since drive-backup push model is already implemented, I am
> going forward with it. I am not able to figure out a few details and
> couldn't find any documentation around it. Any help would be appreciate=
d
>=20
> Context: I would like to take recoverable, consistent, incremental
> backups of kvm vms, whose disks are backed either by qcow2 or raw image=
s.
> Lets say there is a vm:vm1 with drive1 backed by image chain( A <-- B )=
=2E
> This are the rough steps i would like to do.
>=20
> Method 1:
> Backup:
> 1. Perform a full backup using `drive-backup(drive1, sync=3Dfull, dest =
=3D
> /nfs/vm1/drive1)`. Use transaction to do `block-dirty-bitmap-add(drive1=
,
> bitmap1)`. Store the vm config seperately
> 2. Perform an incremental backup using `drive-backup(drive1,
> sync=3Dincremental, mode=3Dexisting, bitmap=3Dbitmap1, dest=3D/nfs/vm1/=
drive1)`.
> Store the vm config seperately
> 3. Rinse and repeat.
> Recovery(Just the latest backup, incremental not required):
>     Copy the full qcow2 from nfs to host storage. Spawn a new vm with t=
he
> same vm config.
> Temporary quick recovery:
>     Create a new qcow2 layer on top of existing /nfs/vm1/drive1 on the =
nfs
> storage itself. Spawn a new vm with disk on nfs storage itself.

Sounds like it should work; using qemu to push the backup out.

> were
> Issues i face:
> 1. Does the drive-backup stall for the whole time the block job is in
> progress. This is a strict no for me. I didnot find any documentation
> regarding it but a powerpoint presentation(from kaskyapc) mentioning it=
=2E
> (Assuming yes!)

The drive-backup is running in parallel to the guest.  I'm not sure what
stalls you are seeing - but as qemu is doing all the work, it DOES have
to service both guest requests and the work to copy out the backup;
also, if you have known-inefficient lseek() situations, there may be
cases where qemu is doing a lousy job (there's work underway on the list
to improve qemu's caching of lseek() data).

> 2. Is the backup consistent? Are the drive file-systems quiesced on bac=
kup?
> (Assuming no!)

If you want the file systems quiesced on backup, then merely bracket
your transaction that kicks off the drive-backup inside guest-agent
commands that freeze and thaw the disk.  So, consistency is not default
(because it requires trusting the guest), but is possible.

>=20
> To achieve both of the above, one hack i could think of was to take a
> snapshot and read from the snapshot.
>=20
> Method 2:
> 1. Perform a full backup using `drive-backup(drive1, sync=3Dfull, dest =
=3D
> /nfs/vm1/drive1)`. Use transaction to do `block-dirty-bitmap-add(drive1=
,
> bitmap1)`. Store the vm config seperately
> 2. Perform the incremental backup by
>      a. add bitmap2 to drive1 `block-dirty-bitmap-add(drive1, bitmap2)`=
=2E
>      b. Take a vm snapshot with drive1(exclude memory, quiesce). The dr=
ive1
> image chain is now A<--B<--C.
>      c. Take incremental using bitmap1 but using data from node B.
> `drive-backup(*#nodeB*, sync=3Dincremental, mode=3Dexisting, bitmap=3Db=
itmap1,
> dest=3D/nfs/vm1/drive1)`
>      d. Delete bitmap1 `block-dirty-bitmap-delete(drive1, bitmap1)`
>      e. Delete vm snapshot on drive1. The drive1 image chain is now A <=
--B.
>      f. bitmap2 now tracks the changes from incrementa 1 to incremental=
 2.
>=20
> Drawbacks with this method would be(had it worked) that incremental bac=
kups
> would contain dirty blocks that are a superset of the actual blocks tha=
t
> are changed between the snapshot and the last snapshot.(Incremental x w=
ould
> contain blocks that have changed when incremental x-1 backup was in
> progress). But there are no correctness issues.
>=20
>=20
> *I cannot do this because drive-backup doesnot allow bitmap and node th=
at
> the bitmap is attached to, to be different. :( *

It might, as long as the bitmap is found on the backing chain (I'm a bit
fuzzier on that case, but KNOW that for pull-mode backups, my libvirt
code is definitely relying on being able to access the bitmap from the
backing file of the BDS being exported over NBD).

> Some other issues i was facing that i worked around:
> 1. Lets say i have to backup a vm with 2 disks(both at a fixed point in=

> time, either both fail or both pass). To atomically do a bitmap-add and=

> drive-backup(sync=3Dfull) i can use transcations. To achieve a backup a=
t a
> fixed point in time, i can use transaction with multiple drive-backups.=
 To
> either fail the whole backup or succeed(when multiple drives are presen=
t),
> i can use completion-mode =3D grouped. But then i cant combine them as =
its
> not supported. i.e, do a
>     Transaction{drive-backup(drive1), dirty-bitmap-add(drive1,
> bitmap1),drive-backup(drive2), dirty-bitmap-add(drive2, bitmap1),
> completion-mode=3Dgrouped}.

What error message are you getting?  I'm not surprised if
completion-mode=3Dgrouped isn't playing nicely with bitmaps in
transactions, although that should be something that we should fix.

>  Workaround: Create bitmaps first, then take full. Effect: Incrementals=

> would be a small superset of actual changed blocks.
> 2. Why do I need to dismiss old jobs to start a new job on node. I want=
 to
> retain the block-job end state for a day before i clear them. So i set
> auto-dismiss to false. This doesnot allow new jobs to run unless the ol=
d
> job is dismissed even if state=3Dconcluded.

Yes, there is probably more work needed to make parallel jobs do what
people want.

>  Workaround: no workaround, store the end-job-status somewhere else.
> 3. Is there a way pre 2.12 to achieve auto-finalise =3D false in a
> transaction. Can I somehow add a dummy block job, that will only finish=

> when i want to finalise the actual 2 disks block jobs? My backup workfl=
ow
> needs to run on env's pre 2.12.

Ouch - backups pre-2.12 have issues.  If I had not read this paragraph,
my recommendation would be to stick to 3.1 and use pull-mode backups
(where you use NBD to learn which portions of the image were dirtied,
and pull those portions of the disk over NBD rather than qemu pushing
them); I even have a working demo of preliminary libvirt code driving
that which I presented at last year's KVM Forum.

>  Workaround: Couldnot achieve this. So if an incremental fails after bl=
ock
> jobs succeed before i can ensure success(have to do some metadata
> operations on my side), i retry with sync=3Dfull mode.
>=20
>=20
> *So what is the recommeded way of taking backups with incremental bitma=
ps
> ? *
> Thanks you for taking time to read through this.
>=20
> Best,
> Bharadwaj.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--dyU0aTasuFcMQhEdy1tdebxD4uA2GPBFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHkS4ACgkQp6FrSiUn
Q2o1NAf+M0jKR3hSJfU2Y3APR1eOBkalt1hbZpq0BfdVrpzElKpBtGMxSsT+OGGp
87xWDajh9oa3lzqsUF1OyrGftiSd+Ni6EzIh0IQxspD9FIjBcFWtSZh8aZFCGSMF
ve9DLny4tDngeifm+nTIPIDqqWLWl21vXVuJkn6VUr0kZcYS13QbaenbY3fz3EZt
R4Ei3R0PHAf+Jk9U492cEPmUzwItnMbM4n1XFBSxyXHGjBWGCqMCDt5Ow6Zfg2uB
3+kOdg6r7OFIZLOW1OsX50+t2CzhUMZAw8ZjGfHT2n7WI3dbPJ0A8etqJuwy+zOa
IRwJv20Wad5RDg8mhAUPUyuSml394g==
=jJEo
-----END PGP SIGNATURE-----

--dyU0aTasuFcMQhEdy1tdebxD4uA2GPBFK--
