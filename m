Received: from eggs.gnu.org ([2001:4830:134:3::10]:47869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ecb3N-0006Je-Ep
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ecb3I-0000kp-En
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:06:13 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:43906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ecb3I-0000k4-4j
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:06:08 -0500
Received: from player698.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 900FFB8E6E
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 19:06:06 +0100 (CET)
Date: Fri, 19 Jan 2018 19:05:55 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180119190555.35127373@bahia.lan>
In-Reply-To: <899644b1-e401-8ed5-8a49-1f0e2dbf9b2b@huawei.com>
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
	<e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
	<20180119112733.4a9dd43f@bahia.lan>
	<05660a29-b22d-7bd6-91e2-37c54b5f2194@huawei.com>
	<899644b1-e401-8ed5-8a49-1f0e2dbf9b2b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] qid path collision issues in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Veaceslav Falico <veaceslav.falico@huawei.com>
Cc: Eduard Shishkin <eduard.shishkin@huawei.com>, Antonios Motakis <antonios.motakis@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei
	(CR)" <zhangwei555@huawei.com>, "Emilio G. Cota" <cota@braap.org>

On Fri, 19 Jan 2018 17:37:58 +0100
Veaceslav Falico <veaceslav.falico@huawei.com> wrote:

> On 1/19/2018 4:52 PM, Eduard Shishkin wrote:
> >=20
> >=20
> > On 1/19/2018 11:27 AM, Greg Kurz wrote: =20
> >> On Mon, 15 Jan 2018 11:49:31 +0800
> >> Antonios Motakis <antonios.motakis@huawei.com> wrote:
> >> =20
> >>> On 13-Jan-18 00:14, Greg Kurz wrote: =20
> >>>> On Fri, 12 Jan 2018 19:32:10 +0800
> >>>> Antonios Motakis <antonios.motakis@huawei.com> wrote:
> >>>> =20
> >>>>> Hello all,
> >>>>> =20
> >>>>
> >>>> Hi Antonios,
> >>>>
> >>>> I see you have attached a patch to this email... this really isn't t=
he preferred
> >>>> way to do things since it prevents to comment the patch (at least wi=
th my mail
> >>>> client). The appropriate way would have been to send the patch with =
a cover
> >>>> letter, using git-send-email for example. =20
> >>>
> >>> I apologize for attaching the patch, I should have known better!
> >>> =20
> >>
> >> np :)
> >> =20
> >>>> =20
> >>>>> We have found an issue in the 9p implementation of QEMU, with how q=
id paths are generated, which can cause qid path collisions and several iss=
ues caused by them. In our use case (running containers under VMs) these ha=
ve proven to be critical.
> >>>>> =20
> >>>>
> >>>> Ouch...
> >>>> =20
> >>>>> In particular, stat_to_qid in hw/9pfs/9p.c generates a qid path usi=
ng the inode number of the file as input. According to the 9p spec the path=
 should be able to uniquely identify a file, distinct files should not shar=
e a path value.
> >>>>>
> >>>>> The current implementation that defines qid.path =3D inode nr works=
 fine as long as there are not files from multiple partitions visible under=
 the 9p share. In that case, distinct files from different devices are allo=
wed to have the same inode number. So with multiple partitions, we have a v=
ery high probability of qid path collisions.
> >>>>>
> >>>>> How to demonstrate the issue:
> >>>>> 1) Prepare a problematic share:
> >>>>> =C2=A0- mount one partition under share/p1/ with some files inside
> >>>>> =C2=A0- mount another one *with identical contents* under share/p2/
> >>>>> =C2=A0- confirm that both partitions have files with same inode nr,=
 size, etc
> >>>>> 2) Demonstrate breakage:
> >>>>> =C2=A0- start a VM with a virtio-9p pointing to the share
> >>>>> =C2=A0- mount 9p share with FSCACHE on
> >>>>> =C2=A0- keep open share/p1/file
> >>>>> =C2=A0- open and write to share/p2/file
> >>>>>
> >>>>> What should happen is, the guest will consider share/p1/file and sh=
are/p2/file to be the same file, and since we are using the cache it will n=
ot reopen it. We intended to write to partition 2, but we just wrote to par=
tition 1. This is just one example on how the guest may rely on qid paths b=
eing unique.
> >>>>>
> >>>>> In the use case of containers where we commonly have a few containe=
rs per VM, all based on similar images, these kind of qid path collisions a=
re very common and they seem to cause all kinds of funny behavior (sometime=
s very subtle).
> >>>>>
> >>>>> To avoid this situation, the device id of a file needs to be also t=
aken as input for generating a qid path. Unfortunately, the size of both in=
ode nr + device id together would be 96 bits, while we have only 64 bits fo=
r the qid path, so we can't just append them and call it a day :(
> >>>>>
> >>>>> We have thought of a few approaches, but we would definitely like t=
o hear what the upstream maintainers and community think:
> >>>>>
> >>>>> * Full fix: Change the 9p protocol
> >>>>>
> >>>>> We would need to support a longer qid path, based on a virtio featu=
re flag. This would take reworking of host and guest parts of virtio-9p, so=
 both QEMU and Linux for most users.
> >>>>> =20
> >>>>
> >>>> I agree for a longer qid path, but we shouldn't tie it to a virtio f=
lag since
> >>>> 9p is transport agnostic. And it happens to be used with a variety o=
f transports.
> >>>> QEMU has both virtio-9p and a Xen backend for example.
> >>>> =20
> >>>>> * Fallback and/or interim solutions
> >>>>>
> >>>>> A virtio feature flag may be refused by the guest, so we think we s=
till need to make collisions less likely even with 64 bit paths. E.g. =20
> >>>>
> >>>> In all cases, we would need a fallback solution to support current
> >>>> guest setups. Also there are several 9p server implementations out
> >>>> there (ganesha, diod, kvmtool) that are currently used with linux
> >>>> clients... it will take some time to get everyone in sync :-\
> >>>> =20
> >>>>> 1. XOR the device id with inode nr to produce the qid path (we atta=
ch a proof of concept patch) =20
> >>>>
> >>>> Hmm... this would still allow collisions. Not good for fallback.
> >>>> =20
> >>>>> 2. 64 bit hash of device id and inode nr =20
> >>>>
> >>>> Same here.
> >>>> =20
> >>>>> 3. other ideas, such as allocating new qid paths and keep a look up=
 table of some sorts (possibly too expensive)
> >>>>> =20
> >>>>
> >>>> This would be acceptable for fallback. =20
> >>>
> >>> Maybe we can use the QEMU hash table (https://github.com/qemu/qemu/bl=
ob/master/util/qht.c) but I wonder if it scales to millions of entries. Do =
you think it is appropriate in this case?
> >>> =20
> >>
> >> I don't know QHT, hence Cc'ing Emilio for insights.
> >> =20
> >>> I was thinking on how to implement something like this, without havin=
g to maintain millions of entries... One option we could consider is to spl=
it the bits into a directly-mapped part, and a lookup part. For example:
> >>>
> >>> Inode =3D
> >>> [ 10 first bits ] + [ 54 lowest bits ]
> >>>
> >>> A hash table maps [ inode 10 first bits ] + [ device id ] =3D> [ 10 b=
it prefix ]
> >>> The prefix is uniquely allocated for each input.
> >>>
> >>> Qid path =3D
> >>> [ 10 bit prefix ] + [ inode 54 lowest bits ]
> >>>
> >>> Since inodes are not completely random, and we usually have a handful=
 of device IDs, we get a much smaller number of entries to track in the has=
h table.
> >>>
> >>> So what this would give:
> >>> (1)=C2=A0=C2=A0=C2=A0 Would be faster and take less memory than mappi=
ng the full inode_nr,devi_id tuple to unique QID paths
> >>> (2)=C2=A0=C2=A0=C2=A0 Guaranteed not to run out of bits when inode nu=
mbers stay below the lowest 54 bits and we have less than 1024 devices.
> >>> (3)=C2=A0=C2=A0=C2=A0 When we get beyond this this limit, there is a =
chance we run out of bits to allocate new QID paths, but we can detect this=
 and refuse to serve the offending files instead of allowing a collision.
> >>>
> >>> We could tweak the prefix size to match the scenarios that we conside=
r more likely, but I think close to 10-16 bits sounds reasonable enough. Wh=
at do you think?
> >>> =20
> >>
> >> I think that should work. Please send a patchset :) =20
> >=20
> > Hi Greg,
> >=20
> > This is based on the assumption that high bits of inode numbers are
> > always zero, which is unacceptable from my standpoint. Inode numbers
> > allocator is a per-volume file system feature, so there may appear
> > allocators, which don't use simple increment and assign inode number
> > with non-zero high bits even for the first file of a volume.
> >=20
> > As I understand, the problem is that the guest doesn't have enough
> > information for proper files identification (in our case share/p1/file
> > and share/p2/file are wrongly identified as the same file). It seems
> > that we need to transmit device ID to the guest, and not in the high bi=
ts of the inode number.
> >=20
> > AFAIK Slava has patches for such transmission, I hope that he will send
> > it eventually. =20
>=20
> They're pretty trivial, however it'll require great effort and coordinati=
on
> for all parties involved, as they break backwards compatibility (QID beco=
mes
> bigger and, thus, breaks "Q" transmission).
>=20
> I'd like to raise another issue - it seems that st_dev and i_no aren't
> enough:
>=20
> mkdir -p /tmp/mounted
> touch /tmp/mounted/file
> mount -o bind /tmp/mounted t1
> mount -o bind /tmp/mounted t2
> stat t{1,2}/file  | grep Inode
> Device: 805h/2053d      Inode: 42729487    Links: 3
> Device: 805h/2053d      Inode: 42729487    Links: 3
>=20
> In that case, even with the patch applied, we'll still have the issue of
> colliding QIDs guest-side - so, for example, after umount t1, t2/file
> becomes unaccessible, as the inode points to t1...
>=20

t1/file and t2/file really point to the same file on the server, so
it is expected they have the same QIDs.

> I'm not sure how to fix this one. Ideas?

fscache bug ?

>=20
> >=20
> > Thanks,
> > Eduard.
> >  =20
> >> =20
> >>>> =20
> >>>>> With our proof of concept patch, the issues caused by qid path coll=
isions go away, so it can be seen as an interim solution of sorts. However,=
 the chance of collisions is not eliminated, we are just replacing the curr=
ent strategy, which is almost guaranteed to cause collisions in certain use=
 cases, with one that makes them more rare. We think that a virtio feature =
flag for longer qid paths is the only way to eliminate these issues complet=
ely.
> >>>>>
> >>>>> This is the extent that we were able to analyze the issue from our =
side, we would like to hear if there are some better ideas, or which approa=
ch would be more appropriate for upstream.
> >>>>>
> >>>>> Best regards,
> >>>>> =20
> >>>>
> >>>> Cheers,
> >>>>
> >>>> --=20
> >>>> Greg
> >>>> =20
> >>> =20
> >> =20
> >=20
> > .
> >  =20
>=20
>=20
