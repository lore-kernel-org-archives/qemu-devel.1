Received: from eggs.gnu.org ([2001:4830:134:3::10]:34228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNw-0006q3-Dk
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNs-0002Xv-4I
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAxNr-0002X3-Tt
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FDC7307D874
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 13:21:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 15:21:33 +0200
Message-Id: <20181012132135.12313-2-kraxel@redhat.com>
In-Reply-To: <20181012132135.12313-1-kraxel@redhat.com>
References: <20181012132135.12313-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] gtk: Don't vte_terminal_set_encoding() on
 new VTE versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

The function vte_terminal_set_encoding() is deprecated since VTE 0.54,
so stop calling it from that version on. This fixes a build error
because of our use of warning flags [-Werror=deprecated-declarations].

Fixes: https://bugs.launchpad.net/bugs/1794939
Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20181011153039.2324-1-kwolf@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 3ddb5fe162..1d68276253 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1951,13 +1951,15 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     g_signal_connect(vc->vte.terminal, "commit", G_CALLBACK(gd_vc_in), vc);
 
     /* The documentation says that the default is UTF-8, but actually it is
-     * 7-bit ASCII at least in VTE 0.38.
-     */
+     * 7-bit ASCII at least in VTE 0.38. The function is deprecated since
+     * VTE 0.54 (only UTF-8 is supported now). */
+#if !VTE_CHECK_VERSION(0, 54, 0)
 #if VTE_CHECK_VERSION(0, 38, 0)
     vte_terminal_set_encoding(VTE_TERMINAL(vc->vte.terminal), "UTF-8", NULL);
 #else
     vte_terminal_set_encoding(VTE_TERMINAL(vc->vte.terminal), "UTF-8");
 #endif
+#endif
 
     vte_terminal_set_scrollback_lines(VTE_TERMINAL(vc->vte.terminal), -1);
     vte_terminal_set_size(VTE_TERMINAL(vc->vte.terminal),
-- 
2.9.3
