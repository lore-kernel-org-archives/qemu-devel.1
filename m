Received: from eggs.gnu.org ([2001:4830:134:3::10]:44583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioW5-0005VV-Er
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioW4-0007Xb-2a
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:01 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:01 +0100
Message-Id: <1488314205-16264-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/46] option: Tweak invalid size error message
 and unbreak iotest 049
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

From: Markus Armbruster <armbru@redhat.com>

Commit 75cdcd1 neglected to update tests/qemu-iotests/049.out, and
made the error message for negative size worse.  Fix that.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/049.out | 14 +++++++++-----
 util/qemu-option.c         |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 4673b67..34e66db 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -95,14 +95,14 @@ qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
 qemu-img: Image size must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a non-negative number below 2^64
+qemu-img: Value '-1024' is out of range for parameter 'size'
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
 qemu-img: Image size must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a non-negative number below 2^64
+qemu-img: Value '-1k' is out of range for parameter 'size'
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
@@ -110,15 +110,19 @@ qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+qemu-img: Parameter 'size' expects a non-negative number below 2^64
+Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
+and exabytes, respectively.
+qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
 qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
-qemu-img: Parameter 'size' expects a size
-You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes and terabytes.
+qemu-img: Parameter 'size' expects a non-negative number below 2^64
+Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
+and exabytes, respectively.
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 == Check correct interpretation of suffixes for cluster size ==
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 419f252..5ce1b5c 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -179,7 +179,7 @@ void parse_option_size(const char *name, const char *value,
 
     err = qemu_strtosz(value, NULL, &size);
     if (err == -ERANGE) {
-        error_setg(errp, "Value '%s' is too large for parameter '%s'",
+        error_setg(errp, "Value '%s' is out of range for parameter '%s'",
                    value, name);
         return;
     }
-- 
1.8.3.1
