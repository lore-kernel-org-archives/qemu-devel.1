Received: from eggs.gnu.org ([2001:4830:134:3::10]:33680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkg-0005dE-QM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkg-0005MI-22
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXkf-0005M2-S9
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:45 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Jun 2017 11:59:26 +0200
Message-Id: <20170607095926.1834-8-quintela@redhat.com>
In-Reply-To: <20170607095926.1834-1-quintela@redhat.com>
References: <20170607095926.1834-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] qemu/migration: fix the double free problem
 on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

In load_snapshot, mis->from_src_file is freed twice, the first free is by
qemu_fclose, the second is by migration_incoming_state_destroy and
it causes Illegal instruction exception. The fix is just to remove the
first free.

This problem is found by qemu-iotests case 068 since commit
"660819b migration: shut src return path unconditionally". The error is:
068 1s ... - output mismatch (see 068.out.bad)
    --- tests/qemu-iotests/068.out	2017-05-06 01:00:26.417270437 +0200
    +++ 068.out.bad	2017-06-03 13:59:55.360274640 +0200
    @@ -6,6 +6,8 @@
     QEMU X.Y.Z monitor - type 'help' for more information
     (qemu) savevm 0
     (qemu) quit
    +./common.config: line 107: 242472 Illegal instruction     (core dumped) ( if [ -n "${QEMU_NEED_PID}" ]; then
    +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
    +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
     QEMU X.Y.Z monitor - type 'help' for more information
    -(qemu) quit
    -*** done
    +(qemu) *** done

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1993ca2..745caae 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2276,7 +2276,6 @@ int load_snapshot(const char *name, Error **errp)
 
     aio_context_acquire(aio_context);
     ret = qemu_loadvm_state(f);
-    qemu_fclose(f);
     aio_context_release(aio_context);
 
     migration_incoming_state_destroy();
-- 
2.9.4
