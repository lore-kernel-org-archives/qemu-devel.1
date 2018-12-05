Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdw6-0007ZI-0V
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdw4-0002cw-6i
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUdw4-0002cV-0Q
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:20 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Dec 2018 00:37:34 +0400
Message-Id: <20181205203737.9011-5-marcandre.lureau@redhat.com>
In-Reply-To: <20181205203737.9011-1-marcandre.lureau@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v4 4/7] monitor: check if chardev can
 switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Not all backends are able to switch gcontext. Those backends cannot
drive a OOB monitor (the monitor would then be blocking on main
thread).

For example, ringbuf, spice, or more esoteric input chardevs like
braille or MUX.

We currently forbid MUX because not all frontends are ready to run
outside main loop. Extend to add a context-switching feature check.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 79afe99079..25cf4223e8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4562,9 +4562,11 @@ void monitor_init(Chardev *chr, int flags)
     bool use_oob =3D flags & MONITOR_USE_OOB;
=20
     if (use_oob) {
-        if (CHARDEV_IS_MUX(chr)) {
+        if (CHARDEV_IS_MUX(chr) ||
+            !qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
             error_report("Monitor out-of-band is not supported with "
-                         "MUX typed chardev backend");
+                         "%s typed chardev backend",
+                         object_get_typename(OBJECT(chr)));
             exit(1);
         }
         if (use_readline) {
--=20
2.20.0.rc1
