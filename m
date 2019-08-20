Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55360C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A01F216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A01F216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzySa-0005wb-3t
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8u-0005ws-Gr
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8s-0003jz-Uv
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8m-0003cA-59
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4C8119AD50A;
 Tue, 20 Aug 2019 07:01:09 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE1F060F88;
 Tue, 20 Aug 2019 07:01:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:49 +0200
Message-Id: <1566284395-30287-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 20 Aug 2019 07:01:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 30/36] cpus-common: assert BQL nesting within
 cpu-exclusive sections
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

Assert that the cpu-exclusive sections are never entered/left with the
BQL taken.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20190523105440.27045-3-rkagan@virtuozzo.com>
---
 cpus-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cpus-common.c b/cpus-common.c
index 023cfeb..9aa75fe 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -174,6 +174,7 @@ void start_exclusive(void)
     CPUState *other_cpu;
     int running_cpus;
 
+    assert(!qemu_mutex_iothread_locked());
     qemu_mutex_lock(&qemu_cpu_list_lock);
     exclusive_idle();
 
@@ -205,6 +206,7 @@ void start_exclusive(void)
 /* Finish an exclusive operation.  */
 void end_exclusive(void)
 {
+    assert(!qemu_mutex_iothread_locked());
     qemu_mutex_lock(&qemu_cpu_list_lock);
     atomic_set(&pending_cpus, 0);
     qemu_cond_broadcast(&exclusive_resume);
@@ -214,6 +216,7 @@ void end_exclusive(void)
 /* Wait for exclusive ops to finish, and begin cpu execution.  */
 void cpu_exec_start(CPUState *cpu)
 {
+    assert(!qemu_mutex_iothread_locked());
     atomic_set(&cpu->running, true);
 
     /* Write cpu->running before reading pending_cpus.  */
@@ -255,6 +258,7 @@ void cpu_exec_start(CPUState *cpu)
 /* Mark cpu as not executing, and release pending exclusive ops.  */
 void cpu_exec_end(CPUState *cpu)
 {
+    assert(!qemu_mutex_iothread_locked());
     atomic_set(&cpu->running, false);
 
     /* Write cpu->running before reading pending_cpus.  */
-- 
1.8.3.1



