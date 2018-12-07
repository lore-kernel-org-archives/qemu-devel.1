Received: from eggs.gnu.org ([2001:4830:134:3::10]:36022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gVFOB-0007f4-Pv
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gVFO7-00029J-Pq
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:37:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gVFO7-00028Y-Hy
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:37:47 -0500
From: Jason Wang <jasowang@redhat.com>
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
	<CAHyh4xjNU2ZTvBTqRhVn17SpcqXcKnKvK90oGFeA72t_h3-REw@mail.gmail.com>
	<7cc73aeb-5eee-8b4f-c005-aee64dfb1bf8@redhat.com>
	<CAHyh4xhysVpEEiwmYU4cyMZaXwzHZfEyMD4=_4QiNbr9HtKGzA@mail.gmail.com>
	<356e7f1d-e95a-a090-4a79-c1cf5a37d50f@redhat.com>
Message-ID: <1c2e9828-467f-1120-f200-6a1d18f93c89@redhat.com>
Date: Fri, 7 Dec 2018 20:37:39 +0800
MIME-Version: 1.0
In-Reply-To: <356e7f1d-e95a-a090-4a79-c1cf5a37d50f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>


On 2018/12/6 =E4=B8=8B=E5=8D=888:44, Jason Wang wrote:
>
> On 2018/12/6 =E4=B8=8B=E5=8D=888:11, Jintack Lim wrote:
>> On Thu, Dec 6, 2018 at 2:33 AM Jason Wang <jasowang@redhat.com> wrote:
>>>
>>> On 2018/12/5 =E4=B8=8B=E5=8D=8810:47, Jintack Lim wrote:
>>>> On Tue, Dec 4, 2018 at 8:30 PM Jason Wang <jasowang@redhat.com> wrot=
e:
>>>>> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm wondering how the current implementation works when logging=20
>>>>>> dirty
>>>>>> pages during migration from vhost-net (in kernel) when used vIOMMU=
.
>>>>>>
>>>>>> I understand how vhost-net logs GPAs when not using vIOMMU. But wh=
en
>>>>>> we use vhost with vIOMMU, then shouldn't vhost-net need to log the
>>>>>> translated address (GPA) instead of the address written in the
>>>>>> descriptor (IOVA) ? The current implementation looks like vhost-ne=
t
>>>>>> just logs IOVA without translation in vhost_get_vq_desc() in
>>>>>> drivers/vhost/net.c. It seems like QEMU doesn't do any further
>>>>>> translation of the dirty log when syncing.
>>>>>>
>>>>>> I might be missing something. Could somebody shed some light on=20
>>>>>> this?
>>>>> Good catch. It looks like a bug to me. Want to post a patch for thi=
s?
>>>> Thanks for the confirmation.
>>>>
>>>> What would be a good setup to catch this kind of migration bug? I
>>>> tried to observe it in the VM expecting to see network applications
>>>> not getting data correctly on the destination, but it was not
>>>> successful (i.e. the VM on the destination just worked fine.) I didn=
't
>>>> even see anything going wrong when I disabled the vhost logging
>>>> completely without using vIOMMU.
>>>>
>>>> What I did is I ran multiple network benchmarks (e.g. netperf tcp
>>>> stream and my own one to check correctness of received data) in a VM
>>>> without vhost dirty page logging, and the benchmarks just ran fine i=
n
>>>> the destination. I checked the used ring at the time the VM is stopp=
ed
>>>> in the source for migration, and it had multiple descriptors that is
>>>> (probably) not processed in the VM yet. Do you have any insight how =
it
>>>> could just work and what would be a good setup to catch this?
>>>
>>> According to past experience, it could be reproduced by doing scp fro=
m
>>> host to guest during migration.
>>>
>> Thanks. I actually tried that, but didn't see any problem either - I
>> copied a large file during migration from host to guest (the copy
>> continued on the destination), and checked md5 hashes using md5sum,
>> but the copied file had the same checksum as the one in the host.
>>
>> Do you recall what kind of symptom you observed when the dirty pages
>> were not migrated correctly with scp?
>
>
> Yes,=C2=A0 the point is to make the migration converge before the end o=
f=20
> scp (e.g set migration speed to a very big value). If scp end before=20
> migration, we won't catch the bug. And it's better to do several=20
> rounds of migration during scp.
>
> Anyway, let me try to reproduce it tomorrow.
>

Looks like I can reproduce this, scp give the following error to me:

scp /home/file root@192.168.100.4:/home
file=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 63% 1301MB 58.1MB/s=C2=A0=C2=A0=20
00:12 ETAReceived disconnect from 192.168.100.4: 2: Packet corrupt
lost connection

FYI, I use the following cli:

numactl --cpunodebind 0 --membind 0 $qemu_path $img_path \
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -netdev tap=
,id=3Dhn0,vhost=3Don \
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device ioh=
3420,id=3Droot.1,chassis=3D1 \
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device=20
virtio-net-pci,bus=3Droot.1,netdev=3Dhn0,ats=3Don,disable-legacy=3Don,dis=
able-modern=3Doff,iommu_platform=3Don=20
\
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device int=
el-iommu,device-iotlb=3Don \
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -M q35 -m 4=
G -enable-kvm -cpu host -smp 2 $@

Thanks


> Thanks
