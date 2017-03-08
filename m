Received: from eggs.gnu.org ([2001:4830:134:3::10]:54251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYWF-0003z8-RU
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYWC-0007ZF-Lq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clYWC-0007Yt-CC
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:08:28 -0500
References: <1488425538-13785-1-git-send-email-peterx@redhat.com>
	<20170302071100-mutt-send-email-mst@kernel.org>
	<213ff4bb-b3b9-fe00-6f0e-b75114e1a5ef@redhat.com>
	<1149211275.29885713.1488962150826.JavaMail.zimbra@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d7882933-68f0-f4dd-4d1e-a16dde079ce3@redhat.com>
Date: Wed, 8 Mar 2017 18:08:18 +0800
MIME-Version: 1.0
In-Reply-To: <1149211275.29885713.1488962150826.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: yi l liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>



On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 16:35, Paolo Bonzini wrote:
>
> ----- Original Message -----
>> From: "Marcel Apfelbaum" <marcel@redhat.com>
>> To: "Michael S. Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.c=
om>
>> Cc: qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>, "yi =
l liu" <yi.l.liu@intel.com>, "Jintack Lim"
>> <jintack@cs.columbia.edu>, "Jason Wang" <jasowang@redhat.com>, "Alex W=
illiamson" <alex.williamson@redhat.com>
>> Sent: Thursday, March 2, 2017 7:24:44 AM
>> Subject: Re: [PATCH v3] intel_iommu: check misordered init when realiz=
e
>>
>> On 03/02/2017 07:13 AM, Michael S. Tsirkin wrote:
>>> On Thu, Mar 02, 2017 at 11:32:18AM +0800, Peter Xu wrote:
>>>> Intel vIOMMU devices are created with "-device" parameter, while her=
e
>>>> actually we need to make sure the dmar device be created before othe=
r
>>>> PCI devices (like vfio-pci, virtio-pci ones) so that we know iommu_f=
n
>>>> will be setup correctly before realizations of those PCI devices (it=
 is
>>>> legal that PCI device fetch these info during its realization). Now =
this
>>>> ordering yet cannot be achieved elsewhere, and devices will be creat=
ed
>>>> in the order that user specified. We need to avoid that.
>>>>
>>>> This patch tries to detect this kind of misordering issue during ini=
t of
>>>> VT-d device, then report to guest if misordering happened. In the
>>>> future, we can provide something better to solve it, e.g., to suppor=
t
>>>> device init ordering, then we can live without this patch.
>>>>
>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> Unfortunately with virtio it's a regression, as it used to
>>> work with iommu. So I'm afraid we need to look into supporting
>>> arbitrary order right now :(
>>>
>> Hi,
>>
>> A fast way to do it is to initialize iommu with a new keyword, like
>>       -iommu intel-iommu
>> Or maybe use the existing "-object" somehow ?
>>   From vl.c comments:
>>     "Initial object creation happens before all other
>>      QEMU data types are created.... "
>>
>> Another idea is to add a third run on QEMU cmd line arguments,
>> but this would affect the whole system.
>>
>> However having an ordering system beats all other ideas.
> The ordering should be explicit in the command line.  Since we do not h=
ave
> cycles, it should be possible.
>
> The best solution would have been to add something like
>
>     -device intel-iommu,id=3Droot-complex-iommu -global mch.iommu=3Droo=
t-complex-iommu
>
> but it's too late for that.
>
> Paolo
>

Yes, it's probably too late other than having workarounds for 2.9. And=20
to eliminate similar issues, we may initializing the pci devices by=20
traversing the PCI tree from root complex in level order.

Thanks
