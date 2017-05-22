Received: from eggs.gnu.org ([2001:4830:134:3::10]:50253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCd7T-0007Qj-TW
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCd7Q-0002T3-Pv
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:30:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCd7Q-0002Sr-J8
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:30:48 -0400
References: <1495163989-9994-1-git-send-email-peterx@redhat.com>
	<1495163989-9994-11-git-send-email-peterx@redhat.com>
	<20170519195349-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <733a24fb-1f9f-4ab0-b1a5-ba2caefa4962@redhat.com>
Date: Mon, 22 May 2017 10:30:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170519195349-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/10] vhost: iommu: cache static
 mapping if there is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>



On 2017=E5=B9=B405=E6=9C=8820=E6=97=A5 00:55, Michael S. Tsirkin wrote:
> On Fri, May 19, 2017 at 11:19:49AM +0800, Peter Xu wrote:
>> This patch pre-heat vhost iotlb cache when passthrough mode enabled.
>>
>> Sometimes, even if user specified iommu_platform for vhost devices,
>> IOMMU might still be disabled. One case is passthrough mode in VT-d
>> implementation. We can detect this by observing iommu_list. If it's
>> empty, it means IOMMU translation is disabled, then we can actually
>> pre-heat the translation (it'll be static mapping then) by first
>> invalidating all IOTLB, then cache existing memory ranges into vhost
>> backend iotlb using 1:1 mapping.
>>
>> Signed-off-by: Peter Xu<peterx@redhat.com>
> I don't really understand. Is this a performance optimization?
> Can you post some #s please?
>
> Also, if it's PT, can't we bypass iommu altogether?

The problem is, since device could be moved between domains, which means=20
we need new notifier to notify vhost to enable or disable IOMMU_PLATFORM.

> That would be
> even faster ...
>

Should be the same (except for the first access in no CM mode), we pass=20
and use vhost_memory_regions as what we've used for non iommu case.

Thanks
