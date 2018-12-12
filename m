Received: from eggs.gnu.org ([2001:4830:134:3::10]:49009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Ue-0000u2-Na
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uc-0003NA-J0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1Uc-0003Lz-Aw
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB0C430024EF
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:38 +0100
Message-Id: <20181212101145.3496-5-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/11] monitor: check if chardev can switch
 gcontext for OOB
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Not all backends are able to switch gcontext. Those backends cannot
drive a OOB monitor (the monitor would then be blocking on main
thread).

For example, ringbuf, spice, or more esoteric input chardevs like
braille or MUX.

We already forbid MUX because not all frontends are ready to run outside
main loop.  Replace that by a context-switching feature check.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181205203737.9011-5-marcandre.lureau@redhat.com>
[Error condition simplified, commit message adjusted accordingly]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 79afe99079..a1329d8a86 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4562,9 +4562,10 @@ void monitor_init(Chardev *chr, int flags)
     bool use_oob =3D flags & MONITOR_USE_OOB;
=20
     if (use_oob) {
-        if (CHARDEV_IS_MUX(chr)) {
+        if (!qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
             error_report("Monitor out-of-band is not supported with "
-                         "MUX typed chardev backend");
+                         "%s typed chardev backend",
+                         object_get_typename(OBJECT(chr)));
             exit(1);
         }
         if (use_readline) {
--=20
2.17.2
