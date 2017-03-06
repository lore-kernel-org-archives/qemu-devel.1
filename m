Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckmxv-0003z4-TN
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckmxr-0001ie-VZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:21:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ckmxr-0001hk-Pg
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:21:51 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3A8B8553C
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 07:21:51 +0000 (UTC)
References: <1488531980-13235-1-git-send-email-jasowang@redhat.com>
	<ac184515-683c-afe0-2597-283abc2f895c@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce83be51-93d9-12e3-09c5-52d5eab81308@redhat.com>
Date: Mon, 6 Mar 2017 15:21:46 +0800
MIME-Version: 1.0
In-Reply-To: <ac184515-683c-afe0-2597-283abc2f895c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virito: unbreak virtio device behinds
 IOMMU with region cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: marcel@redhat.com, peterx@redhat.com



On 2017=E5=B9=B403=E6=9C=8803=E6=97=A5 20:56, Paolo Bonzini wrote:
>
> On 03/03/2017 10:06, Jason Wang wrote:
>> Commit c611c76417f5 ("virtio: add MemoryListener to cache ring
>> translations") registers a memory listener to dma_as. This may not
>> work when IOMMU is enabled: dma_as(bus_master_as) were correctly
>> initialized in pcibus_machine_done() after virtio_realize() where we
>> try to register listener and initialize address space cache.
>>
>> Fixing this by:
>>
>> - delay the listener register to status set
>> - reset dma_as before trying to initialize address spaces to make sure
>>    it works even IOMMU were created after virtio device
>>
>> Fixes: c611c76417f5 ("virtio: add MemoryListener to cache ring transla=
tions")
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> For virtio 0.9 it is valid to use the virtio device while the status is=
 0.
>
> You can add a function virtio_set_dma_as to generic virtio that does a
> MemoryListener unregister+register, then PCI can call it when the
> AddressSpace is ready.
>
> Paolo
>
>

Ok, will post a new version.

Thanks
