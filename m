Received: from eggs.gnu.org ([2001:4830:134:3::10]:38026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahf-00054o-09
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahd-0001V0-Bu
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYahd-0001U7-2w
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:41 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14761C0567B5
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 15:50:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:30 +0100
Message-Id: <1485877831-28786-11-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/11] gtk: Hardcode LC_CTYPE as C.utf-8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Commit 2cb5d2a4 removed setlocale() for everything except LC_MESSAGES in
order to avoid unwanted side effects such as using the wrong decimal
separator in generated JSON objects. However, the problem that unsetting
LC_CTYPE caused is that non-ASCII characters are considered
non-printable now and therefore the GTK menus display question marks for
accented letters, Chinese characters etc.

A first attempt to fix this [1] was rejected because even just setting
LC_CTYPE to the user's locale (and thereby modifying the semantics of
the ctype.h functions) could have unwanted effects that we're not aware
of yet.

Recently, however, glibc introduced a new locale "C.utf-8" that just
uses UTF-8 as its charset, but otherwise leaves the semantics alone.
Just setting the right character set is enough for our use case, so we
can just hardcode this one without having to be afraid of nasty side
effects.

Older systems that don't have the new locale will continue displaying
question marks, but this should fix the problem for most users.

[1] https://lists.gnu.org/archive/html/qemu-devel/2015-12/msg03591.html
    ('Re: gtk: use setlocale() for LC_MESSAGES only')

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20170131100945.8189-1-kwolf@redhat.com

[ kraxel: change C.utf-8 to C.UTF-8 ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index b734c0b..ca50772 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2258,8 +2258,12 @@ void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
 
     s->free_scale = FALSE;
 
-    /* LC_MESSAGES only. See early_gtk_display_init() for details */
+    /* Mostly LC_MESSAGES only. See early_gtk_display_init() for details. For
+     * LC_CTYPE, we need to make sure that non-ASCII characters are considered
+     * printable, but without changing any of the character classes to make
+     * sure that we don't accidentally break implicit assumptions.  */
     setlocale(LC_MESSAGES, "");
+    setlocale(LC_CTYPE, "C.UTF-8");
     bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
     textdomain("qemu");
 
-- 
1.8.3.1
