Received: from eggs.gnu.org ([2001:4830:134:3::10]:44643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMW-00066Y-2z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMT-00011Z-TL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:27 +0100
Message-Id: <1488194450-28056-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/24] test-qemu-opts: Cover qemu_opts_parse()
 of "no"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

qemu_opts_parse() interprets "no" as negated empty key.  Consistent
with its acceptance of empty keys elsewhere, whatever that's worth.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qemu-opts.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index c46ef31..f6310b3 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -532,6 +532,11 @@ static void test_opts_parse(void)
     g_assert_cmpstr(qemu_opt_get(opts, "aus"), ==, "off");
     g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
 
+    /* Implied value, negated empty key */
+    opts = qemu_opts_parse(&opts_list_03, "no", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "off");
+
     /* Implied key */
     opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=", true,
                            &error_abort);
-- 
2.7.4
