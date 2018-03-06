Received: from eggs.gnu.org ([2001:4830:134:3::10]:48052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVR-0004qI-D1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVQ-0006Hu-DB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVQ-0006HF-5y
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:48 -0500
Received: by mail-wm0-x241.google.com with SMTP id q83so22817436wme.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:07 +0100
Message-Id: <1520342370-123606-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/34] lockable: workaround GCC link issue with
 ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Current GCC has an optimization bug when compiling with ASAN.

See also GCC bug:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84307

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180215212552.26997-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/lockable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index b6ed6c8..84ea794 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -28,7 +28,7 @@ struct QemuLockable {
  * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-code elimination
  * from the compiler, and give the errors already at link time.
  */
-#ifdef __OPTIMIZE__
+#if defined(__OPTIMIZE__) && !defined(__SANITIZE_ADDRESS__)
 void unknown_lock_type(void *);
 #else
 static inline void unknown_lock_type(void *unused)
-- 
1.8.3.1
