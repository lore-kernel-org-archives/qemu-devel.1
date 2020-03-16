Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6060620658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6060620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmBe-0003eC-0s
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jDlGZ-0007Dt-Jx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jDlGY-0003to-GC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:38:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43088 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jDlGX-0002XN-Ns
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:38:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8CD24C56B6550B5CA07B;
 Mon, 16 Mar 2020 16:38:22 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.173.228.124) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 16:38:16 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] cpus: avoid stucking in pause_all_vcpus due to race
Date: Mon, 16 Mar 2020 16:37:32 +0800
Message-ID: <20200316083732.2010-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 Longpeng <longpeng2@huawei.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Longpeng <longpeng2@huawei.com>

We found an issue when repeat reboot in guest during migration, it cause =
the
migration thread never be waken up again.

<main loop>                        |<migration_thread>
                                   |
LOCK BQL                           |
...                                |
main_loop_should_exit              |
 pause_all_vcpus                   |
  1. set all cpus ->stop=3Dtrue      |
     and then kick                 |
  2. return if all cpus is paused  |
     (by '->stopped =3D=3D true'), else|
  3. qemu_cond_wait [BQL UNLOCK]   |
                                   |LOCK BQL
                                   |...
                                   |do_vm_stop
                                   | pause_all_vcpus
                                   |  (A)set all cpus ->stop=3Dtrue
                                   |     and then kick
                                   |  (B)return if all cpus is paused
                                   |     (by '->stopped =3D=3D true'), el=
se
                                   |  (C)qemu_cond_wait [BQL UNLOCK]
  4. be waken up and LOCK BQL      |  (D)be waken up BUT wait for  BQL
  5. goto 2.                       |
 (BQL is still LOCKed)             |
 resume_all_vcpus                  |
  1. set all cpus ->stop=3Dfalse     |
     and ->stopped=3Dfalse           |
...                                |
BQL UNLOCK                         |  (E)LOCK BQL
                                   |  (F)goto B. [but stopped is false no=
w!]
                                   |Finally, sleep at step 3 forever.

As suggested by Paolo, resume_all_vcpus should notice this race, so we ne=
ed
to move the change of runstate before pause_all_vcpus in do_vm_stop() and
ignore the resume request if runstate is not running.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dr . David Alan Gilbert <dgilbert@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 cpus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b4f8b84..ef441bd 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1026,9 +1026,9 @@ static int do_vm_stop(RunState state, bool send_sto=
p)
     int ret =3D 0;
=20
     if (runstate_is_running()) {
+        runstate_set(state);
         cpu_disable_ticks();
         pause_all_vcpus();
-        runstate_set(state);
         vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();
@@ -1899,6 +1899,10 @@ void resume_all_vcpus(void)
 {
     CPUState *cpu;
=20
+    if (!runstate_is_running()) {
+        return;
+    }
+
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
     CPU_FOREACH(cpu) {
         cpu_resume(cpu);
--=20
1.8.3.1


