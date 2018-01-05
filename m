Received: from eggs.gnu.org ([2001:4830:134:3::10]:54889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eXNWk-0004pG-M7
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eXNWh-0006yS-AP
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:38:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eXNWg-0006wt-Ou
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:38:54 -0500
References: <20171222064151.29266-1-tiwei.bie@intel.com>
	<fcf3858e-6643-350c-37b9-71698f1d26a5@redhat.com>
	<20180104061853.jkdzbueashv2klka@debian-xvivbkq.sh.intel.com>
	<aca10596-f8d4-417e-26b6-ed09ef766552@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E845FAD@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a1319915-6492-af8d-a35d-5aedad61eb76@redhat.com>
Date: Fri, 5 Jan 2018 16:38:35 +0800
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E845FAD@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] [RFC 0/3] Extend vhost-user to
 support VFIO based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>
Cc: "Tan, Jianfeng" <jianfeng.tan@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Daly,
	Dan" <dan.daly@intel.com>



On 2018=E5=B9=B401=E6=9C=8805=E6=97=A5 14:58, Liang, Cunming wrote:
>> Thanks for the pointer. Looks rather interesting.
>>
>>> We're also working on it (including defining a standard device for
>>> vhost data path acceleration based on mdev to hide vendor specific
>>> details).
>> This is exactly what I mean. Form my point of view, there's no need fo=
r any
>> extension for vhost protocol, we just need to reuse qemu iothread to
>> implement a userspace vhost dataplane and do the mdev inside that thre=
ad.
> On functional perspective, it makes sense to have qemu native support o=
f those certain usage. However, qemu doesn't have to take responsibility =
for dataplane. There're already huge amounts of codes for different devic=
es emulation, leveraging external dataplane library is an effective way t=
o introduce more.

This does not mean to drop external dataplane library. Actually, you can=20
link dpdk to qemu directly.

> The beauty of vhost_user is to open a door for variable userland worklo=
ads(e.g. vswitch). The dataplane connected with VM usually need to be clo=
se integrated with those userland workloads, a control place interface(vh=
ost-user) is better than a datapath interface(e.g. provided by dataplace =
in qemu iothread).

Do we really need vswitch for vDPA?

>   On workloads point of view, it's not excited to be part of qemu proce=
ss.

Don't see why, qemu have dataplane for virtio-blk/scsi.

> That comes up with the idea of vhost-user extension. Userland workloads=
 decides to enable accelerators or not, qemu provides the common control =
plane infrastructure.

It brings extra complexity: endless new types of messages and a huge=20
brunch of bugs. And what's more important, the split model tends to be=20
less efficient in some cases, e.g guest IOMMU integration. I'm pretty=20
sure we will meet more in the future.

>>> And IMO it's also not a bad idea to extend vhost-user protocol
>>> to support the accelerators if possible. And it could be more
>>> flexible because it could support (for example) below things
>>> easily without introducing any complex command line options or
>>> monitor commands to QEMU:
>> Maybe I was wrong but I don't think we care about the complexity of
>> command line or monitor command in this case.
>>
>>> - the switching among different accelerators and software version
>>>     can be done at runtime in vhost process;
>>> - use different accelerators to accelerate different queue pairs
>>>     or just accelerate some (instead of all) queue pairs;
>> Well, technically, if we want, these could be implemented in qemu too.
> You're right if just considering I/O. The ways to consume those I/O is =
another perspective.
> Simply 1:1 associating guest virtio-net and accelerator w/ SW datapath =
fallback is not the whole picture.

Pay attention:

1) What I mean is not a fallback here. You can still do a lot of tricks=20
e.g offloading datapath to hardware or doorbell map.
2) Qemu supports (very old and inefficient) a split model of device=20
emulation and network backend. This means we can switch between backends=20
(though not implemented).

>   It's variable usages on workload side to abstract the device (e.g. po=
rt re-presenter for vswitch) and etc. I don't think qemu is interested fo=
r all bunch of things there.
>

Again, you can link any dataplane to qemu directly instead of using=20
vhost-user if vhost-user tends to be less useful in some cases (vDPA is=20
one of the case I think).

Thanks
