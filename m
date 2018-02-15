Received: from eggs.gnu.org ([2001:4830:134:3::10]:47404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2f-0005qK-Pj
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2c-0000lq-K7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1emR2c-0000jd-ES
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1CFA84250
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 21:26:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Feb 2018 22:25:48 +0100
Message-Id: <20180215212552.26997-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180215212552.26997-1-marcandre.lureau@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] lockable: workaround GCC link issue with
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
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Current GCC has an optimization bug when compiling with ASAN.

See also GCC bug:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84307

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/lockable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index b6ed6c89ec..84ea794bcf 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -28,7 +28,7 @@ struct QemuLockable {
  * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-cod=
e elimination
  * from the compiler, and give the errors already at link time.
  */
-#ifdef __OPTIMIZE__
+#if defined(__OPTIMIZE__) && !defined(__SANITIZE_ADDRESS__)
 void unknown_lock_type(void *);
 #else
 static inline void unknown_lock_type(void *unused)
--=20
2.16.1.73.g5832b7e9f2
