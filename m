Received: from eggs.gnu.org ([2001:4830:134:3::10]:58670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsii-0006Mh-Cn
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsih-00049M-Bw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:36 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsih-00048O-6J
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:35 -0400
Received: by mail-wm0-x244.google.com with SMTP id 139so881430wmn.2
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:09 +0100
Message-Id: <20180313224719.4954-60-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 59/69] replay/replay-internal.c: track holding
 of replay_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

This is modelled after the iothread mutex lock. We keep a TLS flag to
indicate when that thread has acquired the lock and assert we don't
double-lock or release when we shouldn't have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20180227095237.1060.44661.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay-internal.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index fca8514012..0d7e1d6bc4 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -169,6 +169,8 @@ void replay_finish_event(void)
     replay_fetch_data_kind();
 }
 
+static __thread bool replay_locked;
+
 void replay_mutex_init(void)
 {
     qemu_mutex_init(&lock);
@@ -179,13 +181,22 @@ void replay_mutex_destroy(void)
     qemu_mutex_destroy(&lock);
 }
 
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
2.14.3
