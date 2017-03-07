Received: from eggs.gnu.org ([2001:4830:134:3::10]:34650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGv1-0003Uw-G5
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGuv-0003Kd-9V
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clGuv-0003KO-3z
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:49 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA0583A76A6
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 15:20:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 772722D655
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 15:20:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 16:20:22 +0100
Message-Id: <1488900045-26344-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1488900045-26344-1-git-send-email-armbru@redhat.com>
References: <1488900045-26344-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v4 01/24] test-qemu-opts: Cover
 qemu_opts_parse() of "no"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qemu_opts_parse() interprets "no" as negated empty key.  Consistent
with its acceptance of empty keys elsewhere, whatever that's worth.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-2-git-send-email-armbru@redhat.com>
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
