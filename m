Received: from eggs.gnu.org ([2001:4830:134:3::10]:54658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkw0-0004iy-Dd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvz-0000M2-Fy
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:16 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvkvz-0000La-90
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:15 -0400
Received: by mail-wr0-x233.google.com with SMTP id w11so13738593wrc.3
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 06:25:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  5 Apr 2017 14:25:03 +0100
Message-Id: <20170405132503.32125-13-alex.bennee@linaro.org>
In-Reply-To: <20170405132503.32125-1-alex.bennee@linaro.org>
References: <20170405132503.32125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/12] replay: assert time only goes forward
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

If we find ourselves trying to add an event to the log where time has
gone backwards it is because a vCPU event has occurred and the
main-loop is not yet aware of time moving forward. This should not
happen and if it does its better to fail early than generate a log
that will have weird behaviour.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.c | 4 ++++
 replay/replay.c          | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index bea7b4aa6b..fca8514012 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -195,6 +195,10 @@ void replay_save_instructions(void)
     if (replay_file && replay_mode == REPLAY_MODE_RECORD) {
         replay_mutex_lock();
         int diff = (int)(replay_get_current_step() - replay_state.current_step);
+
+        /* Time can only go forward */
+        assert(diff >= 0);
+
         if (diff > 0) {
             replay_put_event(EVENT_INSTRUCTION);
             replay_put_dword(diff);
diff --git a/replay/replay.c b/replay/replay.c
index 9e0724e756..f810628cac 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -84,6 +84,10 @@ void replay_account_executed_instructions(void)
         if (replay_state.instructions_count > 0) {
             int count = (int)(replay_get_current_step()
                               - replay_state.current_step);
+
+            /* Time can only go forward */
+            assert(count >= 0);
+
             replay_state.instructions_count -= count;
             replay_state.current_step += count;
             if (replay_state.instructions_count == 0) {
-- 
2.11.0
