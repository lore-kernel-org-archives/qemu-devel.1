Received: from eggs.gnu.org ([2001:4830:134:3::10]:53531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqv-0002WW-Ec
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqu-0003BE-N4
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:29 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqu-0003As-GD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:28 -0400
Received: by mail-wr0-x22f.google.com with SMTP id o21so119855304wrb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:24 +0100
Message-Id: <20170410125524.21008-12-alex.bennee@linaro.org>
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/11] replay: assert time only goes forward
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

If we find ourselves trying to add an event to the log where time has
gone backwards it is because a vCPU event has occurred and the
main-loop is not yet aware of time moving forward. This should not
happen and if it does its better to fail early than generate a log
that will have weird behaviour.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
