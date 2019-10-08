Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26685C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED11A20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED11A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnnc-00056L-NB
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iHnk8-0001nW-8j
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iHnk7-0001Sn-5t
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:33:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iHnk7-0001RJ-0B; Tue, 08 Oct 2019 07:33:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5258910C0946;
 Tue,  8 Oct 2019 11:33:25 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 069BA60BE0;
 Tue,  8 Oct 2019 11:33:22 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] eliminate remaining places that abuse
 memory_region_allocate_system_memory() 
Date: Tue,  8 Oct 2019 07:33:15 -0400
Message-Id: <20191008113318.7012-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 08 Oct 2019 11:33:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, hpoussin@reactos.org,
 qemu-ppc@nongnu.org, rth@twiddle.net, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Series cleans up remaining boards that call memory_region_allocate_system_memory()
multiple times, violating interface contract (the function should be called only
once).

With that cleaned up, it should be possible to switch from adhoc RAM allocation
in memory_region_allocate_system_memory()->allocate_system_memory_nonnuma() to
memory-backend based allocation, remaining roadblock for doing it is deprecated
-mem-path fallback to RAM allocation, which is scheduled for removal at 4.3
merge window. So remaining patches to consolidate system RAM allocation around
memory-backends and aliasing -mem-path/mem-prealloc to it are postponed till
then.


Igor Mammedov (3):
  sparc64: use memory_region_allocate_system_memory() only for '-m'
    specified RAM
  ppc: rs6000_mc: drop usage of memory_region_allocate_system_memory()
  hppa: drop usage of memory_region_allocate_system_memory() for ROM

 hw/hppa/machine.c    |  5 ++---
 hw/ppc/rs6000_mc.c   | 15 ++++++++++-----
 hw/sparc64/niagara.c | 25 +++++++++++++------------
 3 files changed, 25 insertions(+), 20 deletions(-)

-- 
2.18.1


