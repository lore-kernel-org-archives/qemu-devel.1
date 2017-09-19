Received: from eggs.gnu.org ([2001:4830:134:3::10]:44128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duJGV-0005Eo-2P
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duJGR-0003ow-Nf
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:12:43 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duJGR-0003oK-F1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:12:39 -0400
Received: by mail-pg0-x241.google.com with SMTP id i130so2123981pgc.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:12:39 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
	<2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
	<a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
	<bdd220a9-7773-74c5-f924-112a6134d13b@redhat.com>
	<9c707630-570a-d7a1-76a4-3ddd5ae0f9b6@ozlabs.ru>
	<bb0004db-6e35-0181-552a-62e133eb7f76@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2f185edf-3281-e01f-5859-cc43a5df413e@ozlabs.ru>
Date: Wed, 20 Sep 2017 00:12:33 +1000
MIME-Version: 1.0
In-Reply-To: <bb0004db-6e35-0181-552a-62e133eb7f76@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 01/13] memory: Postpone flatview
 and dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 19/09/17 20:47, Paolo Bonzini wrote:
> On 19/09/2017 12:39, Alexey Kardashevskiy wrote:
>>> No, there's still
>>>
>>>     as->dispatch = NULL;
>>>     memory_region_update_pending |= root->enabled;
>>>     memory_region_transaction_commit();
>>>
>>> when creating the address space, which touches all address spaces.
>>
>> This does not seem helping a lot - my test without such an optimization
>> allocates 2966044 FVs and 2388768 with it, which is just 25%, i.e. worth
>> making a patch but yet getting rid of those nasty virtio-modern address
>> spaces will do a lot better job.
> 
> Have you tried resolving aliases that are implemented with containers
> and one subregion?

Yes, for 10 virtio-net and 8 cpus it looks like below, #5 is that shared
thing. And if I use Intel e1000 instead, it is just 4 FVs.


(qemu) info mtree -f -d
FlatView #0
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #1
 AS "I/O", root: io
 Root memory region: io

FlatView #2
 AS "pci@800000020000000", root: pci@800000020000000.iommu-root
 Root memory region: pci@800000020000000.iommu-root

FlatView #3
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #4
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #5
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 AS "virtio-net-pci", root: bus master container
 Root memory region: (none)
  No rendered FlatView

FlatView #6
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #7
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #8
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #9
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #10
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #11
 AS "memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 Root memory region: system

FlatView #12
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci

FlatView #13
 AS "virtio-pci-cfg-as", root: virtio-pci-cfg, alias virtio-pci
 Root memory region: virtio-pci


>> What is the exact concern about the "[PATCH qemu v3 01/13] memory: Postpone
>> flatview and dispatch tree building till all devices are added"? Is it that
>> you missed that modern AS thing in virtio and thought we can do well even
>> without it?
> 
> I am afraid that some of the special sysbus devices (not PCI, those go
> through the bus master DMA region and it's empty on startup) might write
> to memory during initialization.


And somehow QEMU guarantees that all RAM MRs are rendered to FlatViews even
though some might be added via -device (can they btw?)?



> 
> Thanks,
> 
> Paolo
> 
>> Or there is something wrong with the approach?
> 


-- 
Alexey
