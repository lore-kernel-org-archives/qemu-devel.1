Received: from eggs.gnu.org ([2001:4830:134:3::10]:52549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acO-0001kM-Ow
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acN-0006i3-Fb
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:48 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6acN-0006hm-8m
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:47 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 142so2194341wma.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:37:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 May 2017 11:38:17 +0100
Message-Id: <20170505103822.20641-5-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 4/9] replay/replay-internal.c: track
 holding of replay_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is modelled after the iothread mutex lock. We keep a TLS flag to
indicate when that thread has acquired the lock and assert we don't
double-lock or release when we shouldn't have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index fca8514012..157c863e25 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -179,13 +179,24 @@ void replay_mutex_destroy(void)
     qemu_mutex_destroy(&lock);
 }
 
+static __thread bool replay_locked;
+
+static bool replay_mutex_locked(void)
+{
+    return replay_locked;
+}
+
 void replay_mutex_lock(void)
 {
+    g_assert(!replay_mutex_locked());
     qemu_mutex_lock(&lock);
+    replay_locked = true;
 }
 
 void replay_mutex_unlock(void)
 {
+    g_assert(replay_mutex_locked());
+    replay_locked = false;
     qemu_mutex_unlock(&lock);
 }
 
-- 
2.11.0
