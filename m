Received: from eggs.gnu.org ([209.51.188.92]:55393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3LoD-0000WZ-Dz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Lar-00079C-E1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:07:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3Lar-00078a-5C
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:07:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F35D830833BE
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:07:51 +0000 (UTC)
References: <871s3dg3si.fsf@redhat.com>
	<3fd4f68a-9ce4-7e54-a763-ccdcf844890e@redhat.com>
	<87zhq1ed33.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21d96d05-b600-b115-3649-8d488aeec82b@redhat.com>
Date: Mon, 11 Mar 2019 15:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <87zhq1ed33.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Flatview rendering scalability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On 11/03/19 14:48, Sergio Lopez wrote:
>> The initialization is O(n^2) because the guest initializes one device =
at
>> a time, so you rebuild the FlatView first with 0 devices, then 1, then
>> 2, etc.  This is very hard to fix, if at all possible.
>>
>> However, each FlatView creation should be O(n) where n is the number o=
f
>> devices currently configured.  Please check with "info mtree -f" that
>> you only have a fixed number of FlatViews.  Old versions had one per d=
evice.
> I'm seeing 9 FVs with 1 PCI, and 119 with 100 PCIs.

With

$ eval qemu-system-x86_64 -M q35 \
    -device\ e1000,id=3Dn{1,2,3,4,5,6,7,8}{1,2,3}

I only see 4 flat views ("system", "io", "memory", "(none)").

Probably you are using intel-iommu?  Peter, it should be possible to
reorganize the VT-d memory regions like this:

    intel_iommu_ir (MMIO, not added to any container)

    vtd_root_dmar (container)
      intel_iommu_dmar (IOMMU), priority 0
      alias to intel_iommu_ir, priority 1

    vtd_root_nodmar
      alias to get_system_memory(), priority 0
      alias to intel_iommu_ir, priority 1

    vtd_root_0 memory region (container)
        vtd_root_dmar             # only one of these is enabled
        vtd_root_nodmar

where the vtd_root_dmar and vtd_root_nodmar memory regions are created
in vtd_init once and for all.  Because all vtd_root_* memory regions
have only one child, memory.c will recognize that they represent the
same memory, and create at most two FlatViews (one for vtd_root_dmar,
one for vtd_root_nodmar).

Paolo
