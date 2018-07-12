Received: from eggs.gnu.org ([2001:4830:134:3::10]:47859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWN-00077L-OJ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWL-0006px-J4
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWL-0006ow-DX
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EDD4C12AD
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:13 +0200
Message-Id: <20180712111221.20326-13-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 12/20] cpu-plug-test: Don't pass integers as
 strings to device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

test_plug_with_device_add_x86() plugs Haswell-i386-cpu and
Haswell-x86_64-cpu with device_add.  It passes socket-id, core-id,
thread-id as JSON strings.  The properties are actually integers.

test_plug_with_device_add_coreid() plugs power8_v2.0-spapr-cpu-core
and qemu-s390x-cpu with device_add.  It passes core-id as JSON string.
The properties are actually integers.

Passing JSON string values to integer properties works only due to
device_add implementation accidents.  Fix the test to pass JSON
numbers.  While there, use %u rather than %i with unsigned int.

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/cpu-plug-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 5f39ba0df3..ab3bf6df90 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -88,8 +88,8 @@ static void test_plug_with_device_add_x86(gconstpointer data)
         for (c = 0; c < td->cores; c++) {
             for (t = 0; t < td->threads; t++) {
                 char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
-                qtest_qmp_device_add(td->device_model, id, "'socket-id':'%i', "
-                                     "'core-id':'%i', 'thread-id':'%i'",
+                qtest_qmp_device_add(td->device_model, id, "'socket-id':%u, "
+                                     "'core-id':%u, 'thread-id':%u",
                                      s, c, t);
                 g_free(id);
             }
@@ -114,7 +114,7 @@ static void test_plug_with_device_add_coreid(gconstpointer data)
 
     for (c = td->cores; c < td->maxcpus / td->sockets / td->threads; c++) {
         char *id = g_strdup_printf("id-%i", c);
-        qtest_qmp_device_add(td->device_model, id, "'core-id':'%i'", c);
+        qtest_qmp_device_add(td->device_model, id, "'core-id':%u", c);
         g_free(id);
     }
 
-- 
2.17.1
