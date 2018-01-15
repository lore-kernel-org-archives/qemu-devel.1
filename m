Received: from eggs.gnu.org ([2001:4830:134:3::10]:57204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eav9t-0006gG-Md
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eav9o-0002u2-MS
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:10:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eav9o-0002t3-E3
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:09:56 -0500
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<E182254E98A5DA4EB1E657AC7CB9BD2A8B023E3B@BGSMSX101.gar.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a92a5335-005e-0d54-869d-0f01106c37df@redhat.com>
Date: Mon, 15 Jan 2018 11:09:46 +0800
MIME-Version: 1.0
In-Reply-To: <E182254E98A5DA4EB1E657AC7CB9BD2A8B023E3B@BGSMSX101.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Yang, Zhiyong" <zhiyong.yang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 13:20, Yang, Zhiyong wrote:
>>>    Both vhost-pci and virtio-vhost-user work using shared memory acce=
ss
>>> to the guest RAM of the other VM.  Therefore they can poll virtqueues
>>> and avoid vmexit.  They do also support cross-VM interrupts, thanks t=
o
>>> QEMU setting up irqfd/ioeventfd appropriately on the host.
>>>
>>> Stefan
>> So in conclusion, consider the complexity, I would suggest to figure o=
ut
>> whether or not this (either vhost-pci or virito-vhost-user) is really =
required
>> before moving ahead. E.g, for VM2VM direct network path, this looks si=
mply
>> an issue of network topology instead of the problem of device, so ther=
e's a
>> lot of trick, for vhost-user one can easily image to write an applicat=
ion (or use
>> testpmd) to build a zerocopied VM2VM datapath, isn't this not sufficie=
nt for
>> the case?
> As far as I know,  dequeue zero copied feature of vhost user PMD can't =
help improve throughput for small packest ,such as 64 bytes.
> On the contrary, it causes perf drop.  The feature mainly helps large p=
ackets throughput.

Can you explain why? And what's the number of:

1) 64B/1500B zerocopy
2) 64B/1500B datacopy
3) 64B/1500B vhost-pci

It makes make feel that vhost-pci is dedicated for small bytes? We=20
probably don't want a solution for just a specific size of packets.

>    =20
> Vhostpci can bring the following advantages compared to traditional sol=
ution(vhost/virtio PMD pairs)
> 1.  higher throughput for two VMs. ( Let us see the following  case,  i=
f we use NIC passthrough way to two 2 VMs,  vhostpci RX or TX is handled =
 running 1 single core in VM1,  virtio PMD  is similar on VM2,
> Only RX or TX is handled running on one single core.
> for traditional solution,  except each virtio PMD is running inside eac=
h VM,  at least one extra core is needed for vhost user RX and TX as an m=
ediator.
> In this case, the bottleneck lies in the two vhost user ports running o=
n one single core, which has double workload.

Does this still make sense for packet size other than 64 byte (e.g 1500B)=
?

>  =20
>
> 2. Low latencies (have shorter data path than tradition soluton, doesn'=
t need to pass host OS any more by vhost user)

Is this still true if you do busy polling on both sides?

>
> 3. reduce nearly 50% cores  because  OVS is not involved again if we ap=
ply vhostpci/virtio to VMs-chain case.

Well the differences to me is, copy in guest vs copy in host.

- vhost-pci move the copy from host process to pmd in guest, it probably=20
save cores but sacrifice the performance of pmd which needs do copy now
- exist OVS may occupy more cores in host, but if saves the ability of=20
guest pmd

 From the view of performance, it looks to me that copy in host is=20
faster since it has less overhead e.g vmexits. Vhost-pci probably needs=20
more vcpus to compete with current solution.

Thanks

>
> Thanks
> Zhiyong
>
