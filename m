Received: from eggs.gnu.org ([2001:4830:134:3::10]:57748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9o-0003WQ-OZ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9k-0005sf-Se
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:36 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:39 +0100
Message-Id: <20180123140201.31163-8-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/29] tests/ahci: Switch tray and medium
 commands to @id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Currently, the tray and medium commands in the AHCI test use the
deprecated @device parameter.  This patch switches all invocations over
to use @id.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171110224302.14424-3-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/ahci-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index cb84edc8fb..3635ea6d41 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1578,9 +1578,9 @@ static void test_atapi_tray(void)
     QDict *rsp;
 
     fd = prepare_iso(iso_size, &tx, &iso);
-    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,format=raw "
+    ahci = ahci_boot_and_enable("-blockdev node-name=drive0,driver=file,filename=%s "
                                 "-M q35 "
-                                "-device ide-cd,drive=drive0 ", iso);
+                                "-device ide-cd,id=cd0,drive=drive0 ", iso);
     port = ahci_port_select(ahci);
 
     ahci_atapi_eject(ahci, port);
@@ -1591,13 +1591,13 @@ static void test_atapi_tray(void)
 
     /* Remove media */
     qmp_async("{'execute': 'blockdev-open-tray', "
-               "'arguments': {'device': 'drive0'}}");
+               "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(true);
     rsp = qmp_receive();
     QDECREF(rsp);
 
     qmp_discard_response("{'execute': 'x-blockdev-remove-medium', "
-                         "'arguments': {'device': 'drive0'}}");
+                         "'arguments': {'id': 'cd0'}}");
 
     /* Test the tray without a medium */
     ahci_atapi_load(ahci, port);
@@ -1613,12 +1613,12 @@ static void test_atapi_tray(void)
                                         "'file': { 'driver': 'file', "
                                                   "'filename': %s }}}", iso);
     qmp_discard_response("{'execute': 'x-blockdev-insert-medium',"
-                          "'arguments': { 'device': 'drive0', "
+                          "'arguments': { 'id': 'cd0', "
                                          "'node-name': 'node0' }}");
 
     /* Again, the event shows up first */
     qmp_async("{'execute': 'blockdev-close-tray', "
-               "'arguments': {'device': 'drive0'}}");
+               "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(false);
     rsp = qmp_receive();
     QDECREF(rsp);
-- 
2.13.6
