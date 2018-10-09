Received: from eggs.gnu.org ([2001:4830:134:3::10]:49904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpV-0006Li-LT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpV-0002qg-1q
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g9rpU-0002pw-RY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C39F3001BDD
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 13:13:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Oct 2018 17:12:49 +0400
Message-Id: <20181009131251.721-5-marcandre.lureau@redhat.com>
In-Reply-To: <20181009131251.721-1-marcandre.lureau@redhat.com>
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] monitor: check if chardev can switch
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Note: this patch will conflict with Peter "[PATCH v9 3/6] monitor:
remove "x-oob", turn oob on by default", but can be trivially updated.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index a25514490a..c175cf6f0d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4550,9 +4550,10 @@ void monitor_init(Chardev *chr, int flags)
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
2.19.0.271.gfe8321ec05
