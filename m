Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA1C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B952467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B952467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBazV-0005NH-0d
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jBayk-0004rx-4I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jBayi-0002rO-Ib
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:15:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3268 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jBayi-0002bP-7C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:15:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 88E969DBF840174FD901;
 Tue, 10 Mar 2020 17:15:01 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.173.228.124) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Mar 2020 17:14:54 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <pbonzini@redhat.com>, <rth@twiddle.net>
Subject: [RFC] cpus: avoid get stuck in pause_all_vcpus
Date: Tue, 10 Mar 2020 17:14:43 +0800
Message-ID: <20200310091443.1326-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr .
 David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel @ nongnu . org" <qemu-devel@nongnu.org>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, Longpeng <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Longpeng <longpeng2@huawei.com>

We find an issue when repeat reboot in guest during migration, it cause t=
he
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


Note: This patch is just for discuss this issue, I'm looking forward to
      your suggestions, thanks!

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 cpus.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index b4f8b84..15e8b21 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1857,10 +1857,30 @@ static bool all_vcpus_paused(void)
     return true;
 }
=20
+static bool all_vcpus_resumed(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->stopped) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 void pause_all_vcpus(void)
 {
     CPUState *cpu;
=20
+    /* We need to drop the replay_lock so any vCPU threads woken up
+     * can finish their replay tasks
+     */
+retry_unlock:
+    replay_mutex_unlock();
+
+retry_pause:
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
         if (qemu_cpu_is_self(cpu)) {
@@ -1871,13 +1891,17 @@ void pause_all_vcpus(void)
         }
     }
=20
-    /* We need to drop the replay_lock so any vCPU threads woken up
-     * can finish their replay tasks
-     */
-    replay_mutex_unlock();
-
     while (!all_vcpus_paused()) {
         qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
+        /*
+         * All of the vcpus maybe resumed due to the race with other
+         * threads that doing pause && resume, and we'll stuck as a
+         * result. So we need to request again if the race occurs.
+         */
+        if (all_vcpus_resumed()) {
+            goto retry_pause;
+        }
+
         CPU_FOREACH(cpu) {
             qemu_cpu_kick(cpu);
         }
@@ -1886,6 +1910,13 @@ void pause_all_vcpus(void)
     qemu_mutex_unlock_iothread();
     replay_mutex_lock();
     qemu_mutex_lock_iothread();
+    /*
+     * The vcpus maybe resumed during the mutex is unlocking, we must
+     * make sure all of the vcpus are paused before return.
+     */
+    if (!all_vcpus_paused()) {
+        goto retry_unlock;
+    }
 }
=20
 void cpu_resume(CPUState *cpu)
--=20
1.8.3.1


