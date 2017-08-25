Received: from eggs.gnu.org ([2001:4830:134:3::10]:57732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlFSk-0002OI-BT
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlFSj-0002Ge-AZ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:19:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlFSj-0002GO-35
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:19:53 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 25 Aug 2017 15:19:40 +0100
Message-Id: <20170825141940.20740-3-dgilbert@redhat.com>
In-Reply-To: <20170825141940.20740-1-dgilbert@redhat.com>
References: <20170825141940.20740-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] snapshot/tests: Try loadvm twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shorne@gmail.com, quintela@redhat.com, mreitz@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

It's legal to loadvm twice, modify the existing save/loadvm test
to do it twice.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/qemu-iotests/068     | 2 +-
 tests/qemu-iotests/068.out | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index cfa0f2aed5..e7fca6a494 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -78,7 +78,7 @@ for extra_args in \
     # Give qemu some time to boot before saving the VM state
     { sleep 1; printf "savevm 0\nquit\n"; } | _qemu $extra_args
     # Now try to continue from that VM state (this should just work)
-    echo quit | _qemu $extra_args -loadvm 0
+    { sleep 1; printf "loadvm 0\nloadvm 0\nquit\n"; } | _qemu $extra_args -S
 done
 
 # success, all done
diff --git a/tests/qemu-iotests/068.out b/tests/qemu-iotests/068.out
index aa063cf711..f07a938a38 100644
--- a/tests/qemu-iotests/068.out
+++ b/tests/qemu-iotests/068.out
@@ -7,6 +7,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm 0
 (qemu) quit
 QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) loadvm 0
+(qemu) loadvm 0
 (qemu) quit
 
 === Saving and reloading a VM state to/from a qcow2 image (-object iothread,id=iothread0 -set device.hba0.iothread=iothread0) ===
@@ -16,5 +18,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm 0
 (qemu) quit
 QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) loadvm 0
+(qemu) loadvm 0
 (qemu) quit
 *** done
-- 
2.13.5
