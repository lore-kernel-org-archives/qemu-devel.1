Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E8C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F09216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F09216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9r0T-0005rK-Fh
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 09:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i9qz0-0004uG-D0
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i9qyy-00008R-Gk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:23:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i9qyy-00008G-BE; Mon, 16 Sep 2019 09:23:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FC3E898104;
 Mon, 16 Sep 2019 13:23:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC8D91000232;
 Mon, 16 Sep 2019 13:23:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 09:23:45 -0400
Message-Id: <20190916132347.30676-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 16 Sep 2019 13:23:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 0/2] s390: stop abusing
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
Cc: pbonzini@redhat.com, thuth@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:
  since v5:
    - [1/2] fix migration that wasn't starting and make sure that KVM part
      is able to handle 1:n MemorySection:memslot arrangement
  since v3:
    - fix compilation issue
    - advance HVA along with GPA in kvm_set_phys_mem()
  since v2:
    - break migration from old QEMU (since 2.12-4.1) for guest with >8TB RAM
      and drop migratable aliases patch as was agreed during v2 review
    - drop 4.2 machines patch as it's not prerequisite anymore
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
if it's more than KVM_SLOT_MAX_BYTES. During v2 review it was agreed to ignore
migration breakage (documenting it in release notes) and leaving only KVM fix.

In order to replace these several RAM chunks with a single memdev and keep it
working with KVM memslot size limit, following was done:
   * [1/2] split too big RAM chunk inside of KVM code on several memory slots
           if necessary
   * [2/2] drop manual ram splitting in s390 code

Igor Mammedov (2):
  kvm: s390: split too big memory section on several memslots
  s390: do not call memory_region_allocate_system_memory() multiple
    times

 include/sysemu/kvm_int.h   |   1 +
 accel/kvm/kvm-all.c        | 239 ++++++++++++++++++++++---------------
 hw/s390x/s390-virtio-ccw.c |  30 +----
 target/s390x/kvm.c         |  12 ++
 4 files changed, 162 insertions(+), 120 deletions(-)

-- 
2.18.1


