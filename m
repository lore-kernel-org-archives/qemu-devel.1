Received: from eggs.gnu.org ([2001:4830:134:3::10]:49986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gKOyl-0001Fi-2m
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gKOyg-0001kY-QC
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gKOyg-0001eR-H9
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:38:42 -0500
References: <20181016132327.121839-1-xiao.w.wang@intel.com>
	<2e010e02-f7a2-d009-ac7a-fdc266f99254@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBC9415@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e516b798-ecf3-030c-621b-468250bcc7d3@redhat.com>
Date: Wed, 7 Nov 2018 22:38:21 +0800
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34EBC9415@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] vhost-vfio: introduce mdev based HW
 vhost backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "mst@redhat.com" <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Ye,
	Xiaolong" <xiaolong.ye@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Daly, Dan" <dan.daly@intel.com>


On 2018/11/7 =E4=B8=8B=E5=8D=888:26, Liang, Cunming wrote:
>
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Tuesday, November 6, 2018 4:18 AM
>> To: Wang, Xiao W <xiao.w.wang@intel.com>; mst@redhat.com;
>> alex.williamson@redhat.com
>> Cc: qemu-devel@nongnu.org; Bie, Tiwei <tiwei.bie@intel.com>; Liang, Cu=
nming
>> <cunming.liang@intel.com>; Ye, Xiaolong <xiaolong.ye@intel.com>; Wang,=
 Zhihong
>> <zhihong.wang@intel.com>; Daly, Dan <dan.daly@intel.com>
>> Subject: Re: [RFC 0/2] vhost-vfio: introduce mdev based HW vhost backe=
nd
>>
>>
>> On 2018/10/16 =E4=B8=8B=E5=8D=889:23, Xiao Wang wrote:
>>> What's this
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Following the patch (vhost: introduce mdev based hardware vhost
>>> backend) https://lwn.net/Articles/750770/, which defines a generic
>>> mdev device for vhost data path acceleration (aliased as vDPA mdev
>>> below), this patch set introduces a new net client type: vhost-vfio.
>>
>> Thanks a lot for a such interesting series. Some generic questions:
>>
>>
>> If we consider to use software backend (e.g vhost-kernel or a rely of =
virito-vhost-
>> user or other cases) as well in the future, maybe vhost-mdev is better=
 which mean it
>> does not tie to VFIO anyway.
> [LC] The initial thought of using term of '-vfio' due to the VFIO UAPI =
being used as interface, which is the only available mdev bus driver. It =
causes to use the term of 'vhost-vfio' in qemu, while using term of 'vhos=
t-mdev' which represents a helper in kernel for vhost messages via mdev.
>
>>
>>> Currently we have 2 types of vhost backends in QEMU: vhost kernel
>>> (tap) and vhost-user (e.g. DPDK vhost), in order to have a kernel
>>> space HW vhost acceleration framework, the vDPA mdev device works as =
a
>>> generic configuring channel.
>>
>> Does "generic" configuring channel means dpdk will also go for this wa=
y?
>> E.g it will have a vhost mdev pmd?
> [LC] We don't plan to have a vhost-mdev pmd, but thinking to have consi=
stent virtio PMD running on top of vhost-mdev.  Virtio PMD supports pci b=
us and vdev (by virtio-user) bus today. Vhost-mdev most likely would be i=
ntroduced as another bus (mdev bus) provider.


This seems could be eliminated if you keep use the vhost-kernel ioctl=20
API. Then you can use virtio-user.


>   mdev bus DPDK support is in backlog.
>
>>
>>>    It exposes to user space a non-vendor-specific configuration
>>> interface for setting up a vhost HW accelerator,
>>
>> Or even a software translation layer on top of exist hardware.
>>
>>
>>> based on this, this patch
>>> set introduces a third vhost backend called vhost-vfio.
>>>
>>> How does it work
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> The vDPA mdev defines 2 BAR regions, BAR0 and BAR1. BAR0 is the main
>>> device interface, vhost messages can be written to or read from this
>>> region following below format. All the regular vhost messages about
>>> vring addr, negotiated features, etc., are written to this region dir=
ectly.
>>
>> If I understand this correctly, the mdev was not used for passed throu=
gh to guest
>> directly. So what's the reason of inventing a PCI like device here? I'=
m asking since:
> [LC] mdev uses mandatory attribute of 'device_api' to identify the layo=
ut. We pick up one available from pci, platform, amba and ccw. It works i=
f defining a new one for this transport.
>
>> - vhost protocol is transport indepedent, we should consider to suppor=
t transport
>> other than PCI. I know we can even do it with the exist design but it =
looks rather odd
>> if we do e.g ccw device with a PCI like mediated device.
>>
>> - can we try to reuse vhost-kernel ioctl? Less API means less bugs and=
 code reusing.
>> E.g virtio-user can benefit from the vhost kernel ioctl API almost wit=
h no changes I
>> believe.
> [LC] Agreed, so it reuses CMD defined by vhost-kernel ioctl. But VFIO p=
rovides device specific things (e.g. DMAR, INTR and etc.) which is the ex=
tra APIs being introduced by this transport.


I'm not quite sure I understand here. I think having vhost-kernel=20
compatible ioctl does not conflict of using VFIO ioctl like DMA or INTR?

Btw, VFIO DMA ioctl is even not a must from my point of view, vhost-mdev=20
can forward the mem table information to device driver and let it call=20
DMA API to map/umap pages.

Thanks
