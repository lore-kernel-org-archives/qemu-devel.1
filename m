Received: from eggs.gnu.org ([2001:4830:134:3::10]:51354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB1-0000Gb-Fd
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAx-0001qc-Q8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAx-0001Fi-CD
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25A7467EC2
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:27:00 +0200
Message-Id: <20181017082702.5581-37-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 36/38] block: Clean up bdrv_img_create()'s
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

bdrv_img_create() takes an Error ** argument and uses it in the
conventional way, except for one place: when qemu_opts_do_parse()
fails, it first reports its error to stderr or the HMP monitor with
error_report_err(), then error_setg()'s a generic error.

When the caller reports that second error similarly, this produces two
consecutive error messages on stderr or the HMP monitor.

When the caller does something else with it, such as send it via QMP,
the first error still goes to stderr or the HMP monitor.  Fortunately,
no such caller exists.

Simply use the first error as is.  Update expected output of
qemu-iotest 049 accordingly.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                    |  3 ---
 tests/qemu-iotests/049.out | 12 ++++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 5d51419d21..08d64cdc61 100644
--- a/block.c
+++ b/block.c
@@ -4803,9 +4803,6 @@ void bdrv_img_create(const char *filename, const char *fmt,
     if (options) {
         qemu_opts_do_parse(opts, options, NULL, &local_err);
         if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-            error_setg(errp, "Invalid options for file format '%s'", fmt);
             goto out;
         }
     }
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 0871bff564..6b505408dd 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -95,35 +95,31 @@ qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
 qemu-img: Image size must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
-qemu-img: Value '-1024' is out of range for parameter 'size'
-qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
+qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
 qemu-img: Image size must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
-qemu-img: Value '-1k' is out of range for parameter 'size'
-qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
+qemu-img: TEST_DIR/t.qcow2: Value '-1k' is out of range for parameter 'size'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
 qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a non-negative number below 2^64
+qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
 Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
-qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
 qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a non-negative number below 2^64
+qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
 Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
-qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 == Check correct interpretation of suffixes for cluster size ==
 
-- 
2.17.1
