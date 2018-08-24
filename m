Received: from eggs.gnu.org ([2001:4830:134:3::10]:39120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003Mr-8r
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxN-0001BF-0w
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxM-0001AE-Nc
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 526CE40241C3
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FC982026E1A
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:32:02 +0200
Message-Id: <20180824193206.25475-55-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 54/58] tests/drive_del-test: Fix harmless JSON
 interpolation bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

test_after_failed_device_add() does this:

    response = qmp("{'execute': 'device_add',"
                   " 'arguments': {"
                   "   'driver': 'virtio-blk-%s',"
                   "   'drive': 'drive0'"
                   "}}", qvirtio_get_dev_type());

Wrong.  An interpolation specification must be a JSON token, it
doesn't work within JSON string tokens.  The code above doesn't use
the value of qvirtio_get_dev_type(), and sends arguments

    {"driver": "virtio-blk-%s", "drive": "drive0"}}

The command fails because there is no driver named "virtio-blk-%".
Harmless, since the test wants the command to fail.  Screwed up in
commit 2f84a92ec63.

Fix the obvious way.  The command now fails because the drive is
empty, like it did before commit 2f84a92ec63.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-55-armbru@redhat.com>
---
 tests/drive_del-test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 2d0b176b36..673c10140f 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -65,9 +65,13 @@ static void test_drive_without_dev(void)
 
 static void test_after_failed_device_add(void)
 {
+    char driver[32];
     QDict *response;
     QDict *error;
 
+    snprintf(driver, sizeof(driver), "virtio-blk-%s",
+             qvirtio_get_dev_type());
+
     qtest_start("-drive if=none,id=drive0");
 
     /* Make device_add fail. If this leaks the virtio-blk device then a
@@ -75,9 +79,9 @@ static void test_after_failed_device_add(void)
      */
     response = qmp("{'execute': 'device_add',"
                    " 'arguments': {"
-                   "   'driver': 'virtio-blk-%s',"
+                   "   'driver': %s,"
                    "   'drive': 'drive0'"
-                   "}}", qvirtio_get_dev_type());
+                   "}}", driver);
     g_assert(response);
     error = qdict_get_qdict(response, "error");
     g_assert_cmpstr(qdict_get_try_str(error, "class"), ==, "GenericError");
-- 
2.17.1
