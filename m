Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDt-00056d-VN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDq-0000WB-Iq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDq-0000Ve-DS
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:18 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8270280B22
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SMQHBt017503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:26:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:25:52 +0100
Message-Id: <1488320775-9849-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 01/24] test-qemu-opts: Cover qemu_opts_parse()
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
