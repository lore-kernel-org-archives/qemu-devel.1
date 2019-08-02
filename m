Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC00C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8792086A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8792086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htU2J-000869-7x
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55576)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1htU1h-0006zC-Ny
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1htU1g-0000wA-Hi
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:39:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1htU1g-0000vi-AC; Fri, 02 Aug 2019 05:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F03F92EF169;
 Fri,  2 Aug 2019 09:39:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EDCE19C70;
 Fri,  2 Aug 2019 09:38:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:38:50 -0400
Message-Id: <20190802093854.5343-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 02 Aug 2019 09:39:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC v2 0/4] s390: stop abusing
 memory_region_allocate_system_memory()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:
  since v1:
    - include 4.2 machines patch for adding compat RAM layout on top
    - 2/4 add missing in v1 patch for splitting too big MemorySection on
          several memslots
    - 3/4 amend code path on alias destruction to ensure that RAMBlock is
          cleaned properly
    - 4/4 add compat machine code to keep old layout (migration-wise) for
          4.1 and older machines 


While looking into unifying guest RAM allocation to use hostmem backends
for initial RAM (especially when -mempath is used) and retiring
memory_region_allocate_system_memory() API, leaving only single hostmem backend,
I was inspecting how currently it is used by boards and it turns out several
boards abuse it by calling the function several times (despite documented contract
forbiding it).

s390 is one of such boards where KVM limitation on memslot size got propagated
to board design and memory_region_allocate_system_memory() was abused to satisfy
KVM requirement for max RAM chunk where memory region alias would suffice.

Unfortunately, memory_region_allocate_system_memory() usage created migration
dependency where guest RAM is transferred in migration stream as several RAMBlocks
if it's more than KVM_SLOT_MAX_BYTES.

In order to replace these several RAM chunks with a single memdev and keep it
working with KVM memslot size limit and migration compatible, following was done:
   * [2/4] split too big RAM chunk inside of KVM code on several memory slots
           if necessary
   * [4/4] use memory region aliases to partition hostmem backend RAM on
           KVM_SLOT_MAX_BYTES chunks, which should keep KVM side working
   * [3/4] hacked memory region aliases (to ram memory regions only) to have
           its own RAMBlocks pointing to RAM chunks owned by aliased memory
           region. While it's admittedly a hack, but it's relatively simple and
           allows board code re-shape migration stream as necessary

           I haven't tried to use migratable aliases on x86 machines, but with it
           it could be possible to drop legacy RAM allocation and compat knob
           (cd5ff8333a) dropping '-numa node,mem' completely even for old machines.

PS:
   Tested with ping pong cross version migration on s390 machine and x86 pc/q35
   (with reduced KVM_SLOT_MAX_BYTES since I don't have access to large
    enough host)

CC: pbonzini@redhat.com
CC: qemu-s390x@nongnu.org
CC: borntraeger@de.ibm.com
CC: thuth@redhat.com
CC: david@redhat.com
CC: cohuck@redhat.com


Cornelia Huck (1):
  hw: add compat machines for 4.2

Igor Mammedov (3):
  kvm: s390: split too big memory section on several memslots
  memory: make MemoryRegion alias migratable
  s390: do not call memory_region_allocate_system_memory() multiple
    times

 include/hw/boards.h                |  3 ++
 include/hw/i386/pc.h               |  3 ++
 include/hw/s390x/s390-virtio-ccw.h | 14 ++++++
 include/sysemu/kvm_int.h           |  1 +
 accel/kvm/kvm-all.c                | 77 +++++++++++++++++------------
 exec.c                             |  9 ++--
 hw/arm/virt.c                      |  9 +++-
 hw/core/machine.c                  |  3 ++
 hw/i386/pc.c                       |  3 ++
 hw/i386/pc_piix.c                  | 14 +++++-
 hw/i386/pc_q35.c                   | 13 ++++-
 hw/ppc/spapr.c                     | 15 +++++-
 hw/s390x/s390-virtio-ccw.c         | 79 ++++++++++++++++++++----------
 memory.c                           |  6 +++
 target/s390x/kvm.c                 |  1 +
 15 files changed, 183 insertions(+), 67 deletions(-)

-- 
2.18.1


