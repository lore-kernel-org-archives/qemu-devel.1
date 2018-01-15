Received: from eggs.gnu.org ([2001:4830:134:3::10]:35162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1eavmY-0000Qs-BX
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1eavmU-0003pJ-C8
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:49:58 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:38998 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1eavmU-0003nW-2u
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:49:54 -0500
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
From: Antonios Motakis <antonios.motakis@huawei.com>
Message-ID: <e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
Date: Mon, 15 Jan 2018 11:49:31 +0800
MIME-Version: 1.0
In-Reply-To: <20180112171416.6048ae9e@bahia.lan>
Content-Type: text/plain; charset="windows-1252"
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
To: Greg Kurz <groug@kaod.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Veaceslav Falico <veaceslav.falico@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, Eduard Shishkin <Eduard.Shishkin@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei (CR)" <zhangwei555@huawei.com>



On 13-Jan-18 00:14, Greg Kurz wrote:
> On Fri, 12 Jan 2018 19:32:10 +0800
> Antonios Motakis <antonios.motakis@huawei.com> wrote:
>=20
>> Hello all,
>>
>=20
> Hi Antonios,
>=20
> I see you have attached a patch to this email... this really isn't the =
preferred
> way to do things since it prevents to comment the patch (at least with =
my mail
> client). The appropriate way would have been to send the patch with a c=
over
> letter, using git-send-email for example.

I apologize for attaching the patch, I should have known better!

>=20
>> We have found an issue in the 9p implementation of QEMU, with how qid =
paths are generated, which can cause qid path collisions and several issu=
es caused by them. In our use case (running containers under VMs) these h=
ave proven to be critical.
>>
>=20
> Ouch...
>=20
>> In particular, stat_to_qid in hw/9pfs/9p.c generates a qid path using =
the inode number of the file as input. According to the 9p spec the path =
should be able to uniquely identify a file, distinct files should not sha=
re a path value.
>>
>> The current implementation that defines qid.path =3D inode nr works fi=
ne as long as there are not files from multiple partitions visible under =
the 9p share. In that case, distinct files from different devices are all=
owed to have the same inode number. So with multiple partitions, we have =
a very high probability of qid path collisions.
>>
>> How to demonstrate the issue:
>> 1) Prepare a problematic share:
>>  - mount one partition under share/p1/ with some files inside
>>  - mount another one *with identical contents* under share/p2/
>>  - confirm that both partitions have files with same inode nr, size, e=
tc
>> 2) Demonstrate breakage:
>>  - start a VM with a virtio-9p pointing to the share
>>  - mount 9p share with FSCACHE on
>>  - keep open share/p1/file
>>  - open and write to share/p2/file
>>
>> What should happen is, the guest will consider share/p1/file and share=
/p2/file to be the same file, and since we are using the cache it will no=
t reopen it. We intended to write to partition 2, but we just wrote to pa=
rtition 1. This is just one example on how the guest may rely on qid path=
s being unique.
>>
>> In the use case of containers where we commonly have a few containers =
per VM, all based on similar images, these kind of qid path collisions ar=
e very common and they seem to cause all kinds of funny behavior (sometim=
es very subtle).
>>
>> To avoid this situation, the device id of a file needs to be also take=
n as input for generating a qid path. Unfortunately, the size of both ino=
de nr + device id together would be 96 bits, while we have only 64 bits f=
or the qid path, so we can't just append them and call it a day :(
>>
>> We have thought of a few approaches, but we would definitely like to h=
ear what the upstream maintainers and community think:
>>
>> * Full fix: Change the 9p protocol
>>
>> We would need to support a longer qid path, based on a virtio feature =
flag. This would take reworking of host and guest parts of virtio-9p, so =
both QEMU and Linux for most users.
>>
>=20
> I agree for a longer qid path, but we shouldn't tie it to a virtio flag=
 since
> 9p is transport agnostic. And it happens to be used with a variety of t=
ransports.
> QEMU has both virtio-9p and a Xen backend for example.
>=20
>> * Fallback and/or interim solutions
>>
>> A virtio feature flag may be refused by the guest, so we think we stil=
l need to make collisions less likely even with 64 bit paths. E.g.
>=20
> In all cases, we would need a fallback solution to support current
> guest setups. Also there are several 9p server implementations out
> there (ganesha, diod, kvmtool) that are currently used with linux
> clients... it will take some time to get everyone in sync :-\
>=20
>> 1. XOR the device id with inode nr to produce the qid path (we attach =
a proof of concept patch)
>=20
> Hmm... this would still allow collisions. Not good for fallback.
>=20
>> 2. 64 bit hash of device id and inode nr
>=20
> Same here.
>=20
>> 3. other ideas, such as allocating new qid paths and keep a look up ta=
ble of some sorts (possibly too expensive)
>>
>=20
> This would be acceptable for fallback.

Maybe we can use the QEMU hash table (https://github.com/qemu/qemu/blob/m=
aster/util/qht.c) but I wonder if it scales to millions of entries. Do yo=
u think it is appropriate in this case?

I was thinking on how to implement something like this, without having to=
 maintain millions of entries... One option we could consider is to split=
 the bits into a directly-mapped part, and a lookup part. For example:

Inode =3D
[ 10 first bits ] + [ 54 lowest bits ]

A hash table maps [ inode 10 first bits ] + [ device id ] =3D> [ 10 bit p=
refix ]
The prefix is uniquely allocated for each input.

Qid path =3D=20
[ 10 bit prefix ] + [ inode 54 lowest bits ]

Since inodes are not completely random, and we usually have a handful of =
device IDs, we get a much smaller number of entries to track in the hash =
table.

So what this would give:
(1)	Would be faster and take less memory than mapping the full inode_nr,d=
evi_id tuple to unique QID paths
(2)	Guaranteed not to run out of bits when inode numbers stay below the l=
owest 54 bits and we have less than 1024 devices.
(3)	When we get beyond this this limit, there is a chance we run out of b=
its to allocate new QID paths, but we can detect this and refuse to serve=
 the offending files instead of allowing a collision.

We could tweak the prefix size to match the scenarios that we consider mo=
re likely, but I think close to 10-16 bits sounds reasonable enough. What=
 do you think?

>=20
>> With our proof of concept patch, the issues caused by qid path collisi=
ons go away, so it can be seen as an interim solution of sorts. However, =
the chance of collisions is not eliminated, we are just replacing the cur=
rent strategy, which is almost guaranteed to cause collisions in certain =
use cases, with one that makes them more rare. We think that a virtio fea=
ture flag for longer qid paths is the only way to eliminate these issues =
completely.
>>
>> This is the extent that we were able to analyze the issue from our sid=
e, we would like to hear if there are some better ideas, or which approac=
h would be more appropriate for upstream.
>>
>> Best regards,
>>
>=20
> Cheers,
>=20
> --
> Greg
>=20

--=20
Antonios Motakis
Virtualization Engineer
Huawei Technologies Duesseldorf GmbH
European Research Center
Riesstrasse 25, 80992 M=FCnchen
