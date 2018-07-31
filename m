Received: from eggs.gnu.org ([2001:4830:134:3::10]:36086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkQ8B-0000A0-Vk
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkQ8B-00006l-6u
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:48 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fkQ8B-00006L-0U
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id k3-v6so8725334pgq.5
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 01:35:46 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 31 Jul 2018 01:35:22 -0700
Message-Id: <1533026124-6740-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] migrate: replace the cpu throttle
 percentage max with a variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, quintela@redhat.com, dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

So we can config it using qmp.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 cpus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b5844b7103..6569c73d24 100644
--- a/cpus.c
+++ b/cpus.c
@@ -83,6 +83,8 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+static unsigned int throttle_percentage_max = CPU_THROTTLE_PCT_MAX;
+
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -754,7 +756,7 @@ static void cpu_throttle_timer_tick(void *opaque)
 void cpu_throttle_set(int new_throttle_pct)
 {
     /* Ensure throttle percentage is within valid range */
-    new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
+    new_throttle_pct = MIN(new_throttle_pct, throttle_percentage_max);
     new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
 
     atomic_set(&throttle_percentage, new_throttle_pct);
-- 
2.11.0
