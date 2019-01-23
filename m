Received: from eggs.gnu.org ([209.51.188.92]:40234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmNuI-0003Bb-Sm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmNuH-0005nq-88
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:09:50 -0500
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
	<e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
	<CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9aef3157-e49e-4b53-f0de-75593df06da9@redhat.com>
Date: Wed, 23 Jan 2019 13:09:41 -0600
MIME-Version: 1.0
In-Reply-To: <CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YhoOm5X7isAIajmhPQqB8g1gMO78w3m45"
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>
Cc: qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>, Suman Swaroop <suman.swaroop@rubrik.com>, kchamart@redhat.com, John Snow <jsnow@redhat.com>, qemu-discuss@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YhoOm5X7isAIajmhPQqB8g1gMO78w3m45
From: Eric Blake <eblake@redhat.com>
To: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>
Cc: qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Suman Swaroop <suman.swaroop@rubrik.com>, kchamart@redhat.com,
 John Snow <jsnow@redhat.com>, qemu-discuss@nongnu.org
Message-ID: <9aef3157-e49e-4b53-f0de-75593df06da9@redhat.com>
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
 <e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
 <CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
In-Reply-To: <CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 12:08 PM, Bharadwaj Rayala wrote:

>>> Issues i face:
>>> 1. Does the drive-backup stall for the whole time the block job is in=

>>> progress. This is a strict no for me. I didnot find any documentation=

>>> regarding it but a powerpoint presentation(from kaskyapc) mentioning =
it.
>>> (Assuming yes!)
>>
>> The drive-backup is running in parallel to the guest.  I'm not sure wh=
at
>> stalls you are seeing - but as qemu is doing all the work, it DOES hav=
e
>> to service both guest requests and the work to copy out the backup;
>> also, if you have known-inefficient lseek() situations, there may be
>> cases where qemu is doing a lousy job (there's work underway on the li=
st
>> to improve qemu's caching of lseek() data).
>>
>>
> Eric, I watched your kvm forum video
> https://www.youtube.com/watch?v=3DzQK5ANionpU. Which cleared out someth=
ings
> for me. Lets say you have a disk of size 10GB, I had assumed that, if
> drive-backup has copied till 2 gb offset, that wouldnt qemu have to sta=
ll
> writes coming from guest b/w 2gb and 10gb ? Unless qemu does some inter=
nal
> qcow snapshoting at the start of the backup job and committing at the e=
nd.
> But if i get it correctly from what you explained, qemu doesnot create =
a
> new qcow file, but when a write comes from the guest to the live image,=
 old
> block is first written to the backup synchronously before writing new d=
ata
> to the live qcow2 file. This would not stall the writes, but this would=

> slow down the writes of the guest, as an extra write to target file on
> secondary storage(over nfs) has to happen first. If the old block write=
 to
> nfs fails, does backup fail with on-target-error appropriately set? or =
does
> it stall the guest write ?

You have various knobs to control what happens on write failures, both
on the source and on the destination (on-source-error and
on-target-error) as well as how synchronized the image will be
(MirrorCopyMode of background vs. write-blocking - but only since 3.0).
Between those knobs, you should be able to control whether a failure to
write to the backup image halts the guest or merely halts the job.  But
yes, I/O issued by the guest to a cluster currently being serviced by
the backup code can result in longer write completion times from the
guest's perspective on those clusters.

>=20
>=20
>>> 2. Is the backup consistent? Are the drive file-systems quiesced on
>> backup?
>>> (Assuming no!)
>>
>> If you want the file systems quiesced on backup, then merely bracket
>> your transaction that kicks off the drive-backup inside guest-agent
>> commands that freeze and thaw the disk.  So, consistency is not defaul=
t
>> (because it requires trusting the guest), but is possible.
>>
>>
> Ok. Method 2 below would not even be required if both the above issues =
can
> be solved.
>=20

>>>
>>> *I cannot do this because drive-backup doesnot allow bitmap and node =
that
>>> the bitmap is attached to, to be different. :( *
>>
>> It might, as long as the bitmap is found on the backing chain (I'm a b=
it
>> fuzzier on that case, but KNOW that for pull-mode backups, my libvirt
>> code is definitely relying on being able to access the bitmap from the=

>> backing file of the BDS being exported over NBD).
>>
>>
> Sorry. I dont get this. So lets say this was the drive-1 I had. A(raw) =
<---
> B (qcow2) . @suman(cc'ed) created a bitmap(bitmap1) on device:drive-1 ,=

> then took a snapshot of it. At this point the chain would be something =
like
> A(raw) <-- B(qcow2 -  snapshot)  <--- C(qcow2 - live). Would the bitmap=

> that was created on drive-1 still be attached to #nodeB or would it be
> attached to #nodeC. Would it have all the dirty blocks from "bitmap-add=
 to
> now" or would it only have dirty blocks from "bitmap-add to snapshot".
> If the bitmap's now attached to live drive-1( i.e, nodeC) it would have=
 all
> the dirty blocks, but then can i do a drive-backup(bitmap1, src=3D#node=
B).

We are still exploring how external snapshots should interact with
bitmaps (the low level building blocks may or may not already be present
in qemu 3.1, but libvirt certainly hasn't been coded to use them to
actually prove what works, as I'm still struggling to get the
incremental backups without external snapshot code in libvirt first). At
the moment, when you create nodeC, the bitmap in node B effectively
becomes read-only (no more writes to nodeB, so the bitmap doesn't change
content). You can, at the time you create nodeC but before wiring it
into the chain using blockdev-add, also create another bitmap living in
nodeC, such that when you then perform the snapshots, writes to nodeC
are tracked in the new bitmap.  To track all changes from the time that
bitmap1 was first created, you'd need to be able to merge the bits set
in bitmap1 of nodeB plus the bits set in the bitmap in nodeC.  Qemu does
not automatically move bitmaps from one image to another, so it really
does boil down to whether we have enough other mechanisms for merging
bitmaps from cross-image sources.

>=20
> If the bitmap stays attached to ( nodeB), it would have only dirty bloc=
ks
> till the point snapshot C is created. But this is a problem, as a backu=
p
> workflow/program shouldnot restrict users from creating other snapshots=
=2E

Not a problem if you also create a bitmap every time you take an
external snapshot, and then piece together bitmaps as needed to collect
all changes between the point in time of interest and the present.

> Backup workflow can take additional snapshots as done in method2 above =
if
> it wants, and then remove the snapshot once the backup job is done. I g=
uess
> this problem would be there for the pull based model as well. I am
> currently trying my workflow on an rhev cluster, and i donot want my ba=
ckup
> workflow to interfere with snapshots triggered from rhevm/ovirt.

"Incremental backup" means only the data that changed since the last
backup (which can either be done via a single bitmap or by treating all
external snapshot creation operations as a backup point in time);
"differential backup" is the more powerful term that means tracking
MULTIPLE points in time (in my libvirt code, by having a chain of
multiple bitmaps, and then piecing together the right set of bitmaps as
needed).  But yes, it sounds like you want differential backups, by
piecing together bitmaps over multiple points in time, and where you
take care to freeze one bitmap and create a new one at any point in time
where you want to be able to track changes since that point in time
(whether kicking off a backup job, or doing an external snapshot).


>> To
>>> either fail the whole backup or succeed(when multiple drives are
>> present),
>>> i can use completion-mode =3D grouped. But then i cant combine them a=
s its
>>> not supported. i.e, do a
>>>     Transaction{drive-backup(drive1), dirty-bitmap-add(drive1,
>>> bitmap1),drive-backup(drive2), dirty-bitmap-add(drive2, bitmap1),
>>> completion-mode=3Dgrouped}.
>>
>> What error message are you getting?  I'm not surprised if
>> completion-mode=3Dgrouped isn't playing nicely with bitmaps in
>> transactions, although that should be something that we should fix.
>>
>=20
> error says grouped completion-mode not allowed with command
> 'drity-bitmap-add'
>=20

The other thing to consider is whether you really need
completion-mode=3Dgrouped, or whether you can instead use push-mode
backups with a temporary backup.  But again, that won't help you prior
to qemu 3.1, where you don't have easy access to creating/merging
bitmaps on the fly.  The approach I'm using in libvirt is that since
qemu's push-mode backup success destroys the old state of the bitmap,
that I instead create a temporary bitmap, merge the real bitmap into the
temporary bitmap (in a transaction), then kick off the backup job. If
the backup job succeeds, delete the temporary bitmap, all is well; if it
fails, then merge the temporary bitmap back into the real bitmap, but at
the end of the day, by managing the bitmaps myself instead of letting
qemu auto-manage them, I did not have to rely on completion-mode=3Dgroupe=
d
in order to get sane failure handling of push-mode backups across
multiple disks.  (Well, truth be told, that's the part of the libvirt
code that I did NOT have working at KVM Forum, and where I still have
not posted a working demo to the libvirt list in the meantime - so far,
I have only demo'd pull-mode backups, and not push-mode, because I am
still playing with how libvirt will make push-mode work reliably).

>>> 3. Is there a way pre 2.12 to achieve auto-finalise =3D false in a
>>> transaction. Can I somehow add a dummy block job, that will only fini=
sh
>>> when i want to finalise the actual 2 disks block jobs? My backup work=
flow
>>> needs to run on env's pre 2.12.
>>
>> Ouch - backups pre-2.12 have issues.  If I had not read this paragraph=
,
>> my recommendation would be to stick to 3.1 and use pull-mode backups
>> (where you use NBD to learn which portions of the image were dirtied,
>> and pull those portions of the disk over NBD rather than qemu pushing
>> them); I even have a working demo of preliminary libvirt code driving
>> that which I presented at last year's KVM Forum.
>>
>=20
> What do you mean by issues? Do you mean any data/corruption bugs or lac=
k of
> some nice functionality that we are talking here?

Lack of functionality.  In particular, the 4.0 commands
block-dirty-bitmap-{enable,merge,disable} (or their 3.1 counterparts
x-block-dirty-bitmap-*) are essential to the workflow of differential
backups (without being able to manage bitmaps yourself, you can only get
the weaker incremental backup, and that means qemu itself is clearing
the bitmap out of under your feet on success, and where you are having
to worry about completion-mode=3Dgrouped).

>=20
> Thanks a lot Eric for spending your time in answering my queries. I don=
t
> know if you work with Kashyap Chamarthy, but your help and his blogs ar=
e
> lifesavers.

Yes, Kashyap is trying to build solutions on top of the building blocks
that I am working on, so we have collaborated several times on these
types of issues (he does a lot better at blog posts extracted from my
mailing list brain dumps).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YhoOm5X7isAIajmhPQqB8g1gMO78w3m45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIu/UACgkQp6FrSiUn
Q2pGowf8Dx3Z+wVlqKFce4NPfnH/E0Llg/G+8ymHdzRWRLNRLe9xVNDQxWVNNFif
5ftWoGs3/Zot4wTUnX3s0IPCB6t6r+rKCru5Foe7/DHfX74RTMiGxFLNmzLDbcRL
7AFLxYfX/IzKt5KmvDxSl4iwEQsmGiJTdgCiy45YVOrbjZcXG6elSFUYOjDUOV4Q
qY8/ugQiED2RI3oC2ntCdl1xPm5aAsB5Hk8+ZcbOCJWmkAxe2/49+cc28G/aHTV3
k7+Nr/y3Z4+haV9b/yp1/usmo5TsREVO72qPyw35hTZr79S1KiQlvrFFmXn7EM2V
xdYjAL85a6tLbrLNqbBpzTVZ5MNH2A==
=vPjO
-----END PGP SIGNATURE-----

--YhoOm5X7isAIajmhPQqB8g1gMO78w3m45--
