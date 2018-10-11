Received: from eggs.gnu.org ([2001:4830:134:3::10]:36641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAcvY-0007cy-PX
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAcvU-0006u2-Gw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gAcvU-0006tg-Ac
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:31:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Oct 2018 17:30:39 +0200
Message-Id: <20181011153039.2324-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] gtk: Don't vte_terminal_set_encoding() on new
 VTE versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, kraxel@redhat.com, kbastian@mail.uni-paderborn.de

The function vte_terminal_set_encoding() is deprecated since VTE 0.54,
so stop calling it from that version on. This fixes a build error
because of our use of warning flags [-Werror=3Ddeprecated-declarations].

Fixes: https://bugs.launchpad.net/bugs/1794939
Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 ui/gtk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 3ddb5fe162..1d68276253 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1951,12 +1951,14 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s,=
 VirtualConsole *vc,
     g_signal_connect(vc->vte.terminal, "commit", G_CALLBACK(gd_vc_in), v=
c);
=20
     /* The documentation says that the default is UTF-8, but actually it=
 is
-     * 7-bit ASCII at least in VTE 0.38.
-     */
+     * 7-bit ASCII at least in VTE 0.38. The function is deprecated sinc=
e
+     * VTE 0.54 (only UTF-8 is supported now). */
+#if !VTE_CHECK_VERSION(0, 54, 0)
 #if VTE_CHECK_VERSION(0, 38, 0)
     vte_terminal_set_encoding(VTE_TERMINAL(vc->vte.terminal), "UTF-8", N=
ULL);
 #else
     vte_terminal_set_encoding(VTE_TERMINAL(vc->vte.terminal), "UTF-8");
+#endif
 #endif
=20
     vte_terminal_set_scrollback_lines(VTE_TERMINAL(vc->vte.terminal), -1=
);
--=20
2.19.1
