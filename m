Received: from eggs.gnu.org ([2001:4830:134:3::10]:52439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MW-0001Nx-Nb
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MV-00015V-Ra
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:36 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cv1MV-00014O-Hi
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:35 -0400
Received: by mail-wr0-x22e.google.com with SMTP id l43so169836316wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:45:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  3 Apr 2017 13:45:24 +0100
Message-Id: <20170403124524.10824-10-alex.bennee@linaro.org>
In-Reply-To: <20170403124524.10824-1-alex.bennee@linaro.org>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 9/9] replay: gracefully handle backward
 time events
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

For the purposes of record/replay time can only move forward.

It is possible for the non-vCPU thread to find time has moved from
under its feet as it goes on. This is OK as long as we don't try and
re-wind time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.c | 7 +++++++
 replay/replay.c          | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index bea7b4aa6b..9656db7102 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -199,6 +199,13 @@ void replay_save_instructions(void)
             replay_put_event(EVENT_INSTRUCTION);
             replay_put_dword(diff);
             replay_state.current_step += diff;
+        } else if (diff < 0) {
+            /* Time has caught up with us, so as far as we are
+             * concerned use now, not the past. We still put an event
+             * in the stream to keep in sync.
+             */
+            replay_put_event(EVENT_INSTRUCTION);
+            replay_put_dword(0);
         }
         replay_mutex_unlock();
     }
diff --git a/replay/replay.c b/replay/replay.c
index 9e0724e756..f4376df0fd 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -84,8 +84,13 @@ void replay_account_executed_instructions(void)
         if (replay_state.instructions_count > 0) {
             int count = (int)(replay_get_current_step()
                               - replay_state.current_step);
-            replay_state.instructions_count -= count;
-            replay_state.current_step += count;
+
+            /* Time only goes forward */
+            if (count >= 0) {
+                replay_state.instructions_count -= count;
+                replay_state.current_step += count;
+            }
+
             if (replay_state.instructions_count == 0) {
                 assert(replay_state.data_kind == EVENT_INSTRUCTION);
                 replay_finish_event();
-- 
2.11.0
