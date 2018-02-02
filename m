Received: from eggs.gnu.org ([2001:4830:134:3::10]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehe10-0006YA-S0
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehdzw-0007Z3-Pf
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:16:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ehdzw-0007YC-5O
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:15:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27588C0AA0
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 12:40:04 +0000 (UTC)
References: <20180201112028.23552-1-peterx@redhat.com>
	<20180201195131.GO2457@work-vm> <20180202095643.GA4666@xz-mi>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <b1ba0462-96ec-463e-f7fa-062e1b04638f@redhat.com>
Date: Fri, 2 Feb 2018 14:39:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180202095643.GA4666@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pcie-root-port: let it has higher migrate
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 02/02/2018 11:56, Peter Xu wrote:
> On Thu, Feb 01, 2018 at 07:51:31PM +0000, Dr. David Alan Gilbert wrote:
>> * Peter Xu (peterx@redhat.com) wrote:
>>> In the past, we prioritized IOMMU migration so that we have such a
>>> priority order:
>>>
>>>     IOMMU > PCI Devices
>>>
>>> When migrating a guest with both vIOMMU and pcie-root-port, we'll always
>>> migrate vIOMMU first, since pcie-root-port will be seen to have the same
>>> priority of general PCI devices.
>>>
>>> That's problematic.
>>>
>>> The thing is that PCI bus number information is stored in the root port,
>>> and that is needed by vIOMMU during post_load(), e.g., to figure out
>>> context entry for a device.  If we don't have correct bus numbers for
>>> devices, we won't be able to recover device state of the DMAR memory
>>> regions, and things will be messed up.
>>>
>>> So let's boost the PCIe root ports to be even with higher priority:
>>>
>>>    PCIe Root Port > IOMMU > PCI Devices
>>>
>>> A smoke test shows that this patch fixes bug 1538953.
>>
>> Two questions (partially overlapping with what I replied to Michaels):
>>   a) What happens with multiple IOMMUs?
> 
> If there are more IOMMUs, then the patch will let all the vIOMMUs be
> migrated after pcie root ports.
> 
> But a more true answer is that: I don't really know. :)
> 
> Because I even don't know how multiple vIOMMUs will coop with each
> other, especially nested. 

I am not aware of "nested" IOMMUs. Multiple IOMMUs work together
by dividing the bus ranges, when each of them declares in the
corresponding ACPI table the bus/device/range is in charge of.

However there was a kernel bug some time ago preventing several
IOMMUs to work together, I am not sure the problem is solved yet.


 In nested case, maybe there will be
> dependency between vIOMMUs, but I'll avoid thinking about that until
> we support more than one vIOMMUs.
> 
>>   b) What happens with multiple root ports?
> 
> Same answer as previous one: all of them will be migrated before any
> vIOMMUs.
> 
> Note that IMHO we don't care which pcie root port is migrated first -
> IMHO they should not depend on each other, but Marcel may correct me.
> 

Right, each Root Port is independent from each other.

Thanks,
Marcel

>>   c) How correct is this ordering on different implementations 
>>     (e.g. ARM/Power/etc)
> 
> Currently it won't affect since Intel IOMMU is the only user for
> MIG_PRI_IOMMU.  After SMMU is merged it may affect (if it uses this
> bit), but IMHO it's fine too as long as pcie root ports won't depend
> on anything related to SMMU.
> 
> Thanks,
> 
