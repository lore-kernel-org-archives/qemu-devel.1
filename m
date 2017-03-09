Received: from eggs.gnu.org ([2001:4830:134:3::10]:35969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cluqL-0007SS-PS
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cluqI-0001dR-Ho
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:58:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cluqI-0001dD-Bm
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:58:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DC8381253
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 09:58:42 +0000 (UTC)
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
	<7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
	<20170308174043.10c2f056@nial.brq.redhat.com>
	<322da7ca-793c-fe83-9b9b-aded87742c18@redhat.com>
	<20170309102849.1db72ad5@nial.brq.redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <925a58ec-2a6a-6709-8139-db492af7800c@redhat.com>
Date: Thu, 9 Mar 2017 17:58:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170309102849.1db72ad5@nial.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3] virtio: do not require IOMMU to be
 created in advance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com



On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 17:28, Igor Mammedov wrote:
> On Thu, 9 Mar 2017 10:32:44 +0800
> Jason Wang<jasowang@redhat.com>  wrote:
>
>> On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 00:40, Igor Mammedov wrote:
>>> On Tue, 7 Mar 2017 14:47:30 +0200
>>> Marcel Apfelbaum<marcel@redhat.com>   wrote:
>>>  =20
>>>> On 03/07/2017 11:09 AM, Jason Wang wrote:
>>>>> After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
>>>>> after caching ring translations"), IOMMU was required to be created=
 in
>>>>> advance. This is because we can only get the correct dma_as after p=
ci
>>>>> IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
>>>>> inconvenient for user. This patch releases this by:
>>>>>
>>>>> - introduce a bus_master_ready method for PCIDeviceClass and trigge=
r
>>>>>     this during pci_init_bus_master
>>>>> - implement virtio-pci method and 1) reset the dma_as 2) re-registe=
r
>>>>>     the memory listener to the new dma_as
> Instead of trying to fix up later it's possible to refuse
> adding iommu device if other devices has been added before
> it with -device/device_add.
> That would match current CLI semantics where device that
> others depend on should be listed on CLI before that others
> are listed.

Yes, but it works by chance in the past for the device that does not=20
want bus_master_as in their realize. This change may surprise their users=
.

Thanks
