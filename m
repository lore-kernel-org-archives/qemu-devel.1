Received: from eggs.gnu.org ([2001:4830:134:3::10]:35550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <veaceslav.falico@huawei.com>) id 1eek5P-0001LF-OH
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <veaceslav.falico@huawei.com>) id 1eek5M-0002eZ-Ey
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:09:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2158 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <veaceslav.falico@huawei.com>)
	id 1eek5L-0002d3-Ik
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:09:08 -0500
From: Veaceslav Falico <veaceslav.falico@huawei.com>
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
	<e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
	<20180119112733.4a9dd43f@bahia.lan>
	<05660a29-b22d-7bd6-91e2-37c54b5f2194@huawei.com>
	<899644b1-e401-8ed5-8a49-1f0e2dbf9b2b@huawei.com>
	<20180119190555.35127373@bahia.lan>
	<e6ad35e8-2fda-8318-c043-dcf092cc0daa@huawei.com>
Message-ID: <f0bd7f3d-d3ba-556b-3c69-cbfaf7d7b929@huawei.com>
Date: Thu, 25 Jan 2018 17:08:40 +0100
MIME-Version: 1.0
In-Reply-To: <e6ad35e8-2fda-8318-c043-dcf092cc0daa@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
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
Cc: Eduard Shishkin <eduard.shishkin@huawei.com>, Antonios Motakis <antonios.motakis@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei
	(CR)" <zhangwei555@huawei.com>, "Emilio G. Cota" <cota@braap.org>

On 1/25/2018 3:46 PM, Veaceslav Falico wrote:
> Hi,
>=20
> sorry for the late reply, we're acutally working on it internally...
>=20
> On 1/19/2018 7:05 PM, Greg Kurz wrote:
>> On Fri, 19 Jan 2018 17:37:58 +0100
>> Veaceslav Falico <veaceslav.falico@huawei.com> wrote:
>>
>>> On 1/19/2018 4:52 PM, Eduard Shishkin wrote:
>>>>
>>>>
>>>> On 1/19/2018 11:27 AM, Greg Kurz wrote: =20
>>>>> On Mon, 15 Jan 2018 11:49:31 +0800
>>>>> Antonios Motakis <antonios.motakis@huawei.com> wrote:
>>>>> =20
>>>>>> On 13-Jan-18 00:14, Greg Kurz wrote: =20
>>>>>>> On Fri, 12 Jan 2018 19:32:10 +0800
>>>>>>> Antonios Motakis <antonios.motakis@huawei.com> wrote:
>>>>>>> =20
>>>>>>>> Hello all,
>>>>>>>> =20
>>>>>>>
>>>>>>> Hi Antonios,
>>>>>>>
>>>>>>> I see you have attached a patch to this email... this really isn'=
t the preferred
>>>>>>> way to do things since it prevents to comment the patch (at least=
 with my mail
>>>>>>> client). The appropriate way would have been to send the patch wi=
th a cover
>>>>>>> letter, using git-send-email for example. =20
>>>>>>
>>>>>> I apologize for attaching the patch, I should have known better!
>>>>>> =20
>>>>>
>>>>> np :)
>>>>> =20
>>>>>>> =20
>>>>>>>> We have found an issue in the 9p implementation of QEMU, with ho=
w qid paths are generated, which can cause qid path collisions and severa=
l issues caused by them. In our use case (running containers under VMs) t=
hese have proven to be critical.
>>>>>>>> =20
>>>>>>>
>>>>>>> Ouch...
>>>>>>> =20
>>>>>>>> In particular, stat_to_qid in hw/9pfs/9p.c generates a qid path =
using the inode number of the file as input. According to the 9p spec the=
 path should be able to uniquely identify a file, distinct files should n=
ot share a path value.
>>>>>>>>
>>>>>>>> The current implementation that defines qid.path =3D inode nr wo=
rks fine as long as there are not files from multiple partitions visible =
under the 9p share. In that case, distinct files from different devices a=
re allowed to have the same inode number. So with multiple partitions, we=
 have a very high probability of qid path collisions.
>>>>>>>>
>>>>>>>> How to demonstrate the issue:
>>>>>>>> 1) Prepare a problematic share:
>>>>>>>> =C2=A0- mount one partition under share/p1/ with some files insi=
de
>>>>>>>> =C2=A0- mount another one *with identical contents* under share/=
p2/
>>>>>>>> =C2=A0- confirm that both partitions have files with same inode =
nr, size, etc
>>>>>>>> 2) Demonstrate breakage:
>>>>>>>> =C2=A0- start a VM with a virtio-9p pointing to the share
>>>>>>>> =C2=A0- mount 9p share with FSCACHE on
>>>>>>>> =C2=A0- keep open share/p1/file
>>>>>>>> =C2=A0- open and write to share/p2/file
>>>>>>>>
>>>>>>>> What should happen is, the guest will consider share/p1/file and=
 share/p2/file to be the same file, and since we are using the cache it w=
ill not reopen it. We intended to write to partition 2, but we just wrote=
 to partition 1. This is just one example on how the guest may rely on qi=
d paths being unique.
>>>>>>>>
>>>>>>>> In the use case of containers where we commonly have a few conta=
iners per VM, all based on similar images, these kind of qid path collisi=
ons are very common and they seem to cause all kinds of funny behavior (s=
ometimes very subtle).
>>>>>>>>
>>>>>>>> To avoid this situation, the device id of a file needs to be als=
o taken as input for generating a qid path. Unfortunately, the size of bo=
th inode nr + device id together would be 96 bits, while we have only 64 =
bits for the qid path, so we can't just append them and call it a day :(
>>>>>>>>
>>>>>>>> We have thought of a few approaches, but we would definitely lik=
e to hear what the upstream maintainers and community think:
>>>>>>>>
>>>>>>>> * Full fix: Change the 9p protocol
>>>>>>>>
>>>>>>>> We would need to support a longer qid path, based on a virtio fe=
ature flag. This would take reworking of host and guest parts of virtio-9=
p, so both QEMU and Linux for most users.
>>>>>>>> =20
>>>>>>>
>>>>>>> I agree for a longer qid path, but we shouldn't tie it to a virti=
o flag since
>>>>>>> 9p is transport agnostic. And it happens to be used with a variet=
y of transports.
>>>>>>> QEMU has both virtio-9p and a Xen backend for example.
>>>>>>> =20
>>>>>>>> * Fallback and/or interim solutions
>>>>>>>>
>>>>>>>> A virtio feature flag may be refused by the guest, so we think w=
e still need to make collisions less likely even with 64 bit paths. E.g. =
=20
>>>>>>>
>>>>>>> In all cases, we would need a fallback solution to support curren=
t
>>>>>>> guest setups. Also there are several 9p server implementations ou=
t
>>>>>>> there (ganesha, diod, kvmtool) that are currently used with linux
>>>>>>> clients... it will take some time to get everyone in sync :-\
>>>>>>> =20
>>>>>>>> 1. XOR the device id with inode nr to produce the qid path (we a=
ttach a proof of concept patch) =20
>>>>>>>
>>>>>>> Hmm... this would still allow collisions. Not good for fallback.
>>>>>>> =20
>>>>>>>> 2. 64 bit hash of device id and inode nr =20
>>>>>>>
>>>>>>> Same here.
>>>>>>> =20
>>>>>>>> 3. other ideas, such as allocating new qid paths and keep a look=
 up table of some sorts (possibly too expensive)
>>>>>>>> =20
>>>>>>>
>>>>>>> This would be acceptable for fallback. =20
>>>>>>
>>>>>> Maybe we can use the QEMU hash table (https://github.com/qemu/qemu=
/blob/master/util/qht.c) but I wonder if it scales to millions of entries=
. Do you think it is appropriate in this case?
>>>>>> =20
>>>>>
>>>>> I don't know QHT, hence Cc'ing Emilio for insights.
>>>>> =20
>>>>>> I was thinking on how to implement something like this, without ha=
ving to maintain millions of entries... One option we could consider is t=
o split the bits into a directly-mapped part, and a lookup part. For exam=
ple:
>>>>>>
>>>>>> Inode =3D
>>>>>> [ 10 first bits ] + [ 54 lowest bits ]
>>>>>>
>>>>>> A hash table maps [ inode 10 first bits ] + [ device id ] =3D> [ 1=
0 bit prefix ]
>>>>>> The prefix is uniquely allocated for each input.
>>>>>>
>>>>>> Qid path =3D
>>>>>> [ 10 bit prefix ] + [ inode 54 lowest bits ]
>>>>>>
>>>>>> Since inodes are not completely random, and we usually have a hand=
ful of device IDs, we get a much smaller number of entries to track in th=
e hash table.
>>>>>>
>>>>>> So what this would give:
>>>>>> (1)=C2=A0=C2=A0=C2=A0 Would be faster and take less memory than ma=
pping the full inode_nr,devi_id tuple to unique QID paths
>>>>>> (2)=C2=A0=C2=A0=C2=A0 Guaranteed not to run out of bits when inode=
 numbers stay below the lowest 54 bits and we have less than 1024 devices=
.
>>>>>> (3)=C2=A0=C2=A0=C2=A0 When we get beyond this this limit, there is=
 a chance we run out of bits to allocate new QID paths, but we can detect=
 this and refuse to serve the offending files instead of allowing a colli=
sion.
>>>>>>
>>>>>> We could tweak the prefix size to match the scenarios that we cons=
ider more likely, but I think close to 10-16 bits sounds reasonable enoug=
h. What do you think?
>>>>>> =20
>>>>>
>>>>> I think that should work. Please send a patchset :) =20
>>>>
>>>> Hi Greg,
>>>>
>>>> This is based on the assumption that high bits of inode numbers are
>>>> always zero, which is unacceptable from my standpoint. Inode numbers
>>>> allocator is a per-volume file system feature, so there may appear
>>>> allocators, which don't use simple increment and assign inode number
>>>> with non-zero high bits even for the first file of a volume.
>>>>
>>>> As I understand, the problem is that the guest doesn't have enough
>>>> information for proper files identification (in our case share/p1/fi=
le
>>>> and share/p2/file are wrongly identified as the same file). It seems
>>>> that we need to transmit device ID to the guest, and not in the high=
 bits of the inode number.
>>>>
>>>> AFAIK Slava has patches for such transmission, I hope that he will s=
end
>>>> it eventually. =20
>>>
>>> They're pretty trivial, however it'll require great effort and coordi=
nation
>>> for all parties involved, as they break backwards compatibility (QID =
becomes
>>> bigger and, thus, breaks "Q" transmission).
>>>
>>> I'd like to raise another issue - it seems that st_dev and i_no aren'=
t
>>> enough:
>>>
>>> mkdir -p /tmp/mounted
>>> touch /tmp/mounted/file
>>> mount -o bind /tmp/mounted t1
>>> mount -o bind /tmp/mounted t2
>>> stat t{1,2}/file  | grep Inode
>>> Device: 805h/2053d      Inode: 42729487    Links: 3
>>> Device: 805h/2053d      Inode: 42729487    Links: 3
>>>
>>> In that case, even with the patch applied, we'll still have the issue=
 of
>>> colliding QIDs guest-side - so, for example, after umount t1, t2/file
>>> becomes unaccessible, as the inode points to t1...
>>>
>>
>> t1/file and t2/file really point to the same file on the server, so
>> it is expected they have the same QIDs.
>>
>>> I'm not sure how to fix this one. Ideas?
>>
>> fscache bug ?
>=20
> I've reproduced it today without fscache:
>=20
> host:
> mount -o bind /tmp/mounted t1
> mount -o bind /tmp/mounted t2
>=20
> guest:
> / # tail -f t1/file &
> / # 321
>=20
> / # cat t2/file
> 321
> / #
>=20
> host:
> mv t1/file t1/file_moved
>=20
> guest:
> / # cat t2/file
> cat: can't open 't2/file': No such file or directory
> / # mount | grep fscache
> / #

Sorry, disregard this test case, it's operating normally -
when we move the t1/file, we also move the t2/file, as they're
the same directory... Sorry, it's a brainfart after a long
discussion about the issue :).

So, it's still not reproducible without (fs)cache guest-side.


Anyway, the question below still stands - is the guest
allowed to re-use the FIDs for the files with same QIDs?

>=20
> Also, per internal discussions, we're not sure if the guest side
> is allowed to reuse the FIDs opened previously for same QID.paths.
>=20
> QEMU holds FID.path for each FID, which contains the actual FS path,
> i.e. "/path/to/file".=20
>=20
> So, if we (guest) have two "identical" (per QID.path and RFC) files
> (f1 and f2), though in different directories (host and guest), and=20
> we've accessed f1 once (FID 10, for example) - are we allowed to
> re-use FID 10 for f2, if f1's QID.path =3D=3D f2's QID.path ?
>=20
>>
>>>
>>>>
>>>> Thanks,
>>>> Eduard.
>>>>  =20
>>>>> =20
>>>>>>> =20
>>>>>>>> With our proof of concept patch, the issues caused by qid path c=
ollisions go away, so it can be seen as an interim solution of sorts. How=
ever, the chance of collisions is not eliminated, we are just replacing t=
he current strategy, which is almost guaranteed to cause collisions in ce=
rtain use cases, with one that makes them more rare. We think that a virt=
io feature flag for longer qid paths is the only way to eliminate these i=
ssues completely.
>>>>>>>>
>>>>>>>> This is the extent that we were able to analyze the issue from o=
ur side, we would like to hear if there are some better ideas, or which a=
pproach would be more appropriate for upstream.
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> =20
>>>>>>>
>>>>>>> Cheers,
>>>>>>>
>>>>>>> --=20
>>>>>>> Greg
>>>>>>> =20
>>>>>> =20
>>>>> =20
>>>>
>>>> .
>>>>  =20
>>>
>>>
>>
>> .
>>
>=20
