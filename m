Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F6C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61AC2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61AC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyVY-0002El-Qa
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8n-0005t3-Aw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8j-0003cH-Vx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8j-0003aF-MZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42340309BDA1;
 Tue, 20 Aug 2019 07:01:08 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2AE60BE2;
 Tue, 20 Aug 2019 07:01:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:48 +0200
Message-Id: <1566284395-30287-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 20 Aug 2019 07:01:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 29/36] cpus-common: nuke finish_safe_work
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
Cc: Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rkagan@virtuozzo.com>

It was introduced in commit ab129972c8b41e15b0521895a46fd9c752b68a5e,
with the following motivation:

  Because start_exclusive uses CPU_FOREACH, merge exclusive_lock with
  qemu_cpu_list_lock: together with a call to exclusive_idle (via
  cpu_exec_start/end) in cpu_list_add, this protects exclusive work
  against concurrent CPU addition and removal.

However, it seems to be redundant, because the cpu-exclusive
infrastructure provides suffificent protection against the newly added
CPU starting execution while the cpu-exclusive work is running, and the
aforementioned traversing of the cpu list is protected by
qemu_cpu_list_lock.

Besides, this appears to be the only place where the cpu-exclusive
section is entered with the BQL taken, which has been found to trigger
AB-BA deadlock as follows:

    vCPU thread                             main thread
    -----------                             -----------
async_safe_run_on_cpu(self,
                      async_synic_update)
...                                         [cpu hot-add]
process_queued_cpu_work()
  qemu_mutex_unlock_iothread()
                                            [grab BQL]
  start_exclusive()                         cpu_list_add()
  async_synic_update()                        finish_safe_work()
    qemu_mutex_lock_iothread()                  cpu_exec_start()

So remove it.  This paves the way to establishing a strict nesting rule
of never entering the exclusive section with the BQL taken.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20190523105440.27045-2-rkagan@virtuozzo.com>
---
 cpus-common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 3ca58c6..023cfeb 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -69,12 +69,6 @@ static int cpu_get_free_index(void)
     return cpu_index;
 }
 
-static void finish_safe_work(CPUState *cpu)
-{
-    cpu_exec_start(cpu);
-    cpu_exec_end(cpu);
-}
-
 void cpu_list_add(CPUState *cpu)
 {
     qemu_mutex_lock(&qemu_cpu_list_lock);
@@ -86,8 +80,6 @@ void cpu_list_add(CPUState *cpu)
     }
     QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
     qemu_mutex_unlock(&qemu_cpu_list_lock);
-
-    finish_safe_work(cpu);
 }
 
 void cpu_list_remove(CPUState *cpu)
-- 
1.8.3.1



