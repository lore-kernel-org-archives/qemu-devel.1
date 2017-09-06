Received: from eggs.gnu.org ([2001:4830:134:3::10]:57709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGr-000358-Ho
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGq-0001tC-3d
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfGp-0001s6-T7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DED6C5AFD9
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 18:41:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Sep 2017 19:41:32 +0100
Message-Id: <20170906184133.25524-8-dgilbert@redhat.com>
In-Reply-To: <20170906184133.25524-1-dgilbert@redhat.com>
References: <20170906184133.25524-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] snapshot/tests: Try loadvm twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, armbru@redhat.com, kwolf@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

It's legal to loadvm twice, modify the existing save/loadvm test
to do it twice.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170825141940.20740-3-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
