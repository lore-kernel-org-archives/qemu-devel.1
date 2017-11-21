Received: from eggs.gnu.org ([2001:4830:134:3::10]:33044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHDaH-0002wJ-PP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHDaG-0007Qi-KY
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHDaG-0007QY-C0
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:47:48 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 21 Nov 2017 19:47:38 +0100
Message-Id: <20171121184738.8502-3-quintela@redhat.com>
In-Reply-To: <20171121184738.8502-1-quintela@redhat.com>
References: <20171121184738.8502-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] migration/ram.c: do not set
 'postcopy_running' in POSTCOPY_INCOMING_END
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

When migrating a VM with 'migrate_set_capability postcopy-ram on'
a postcopy_state is set during the process, ending up with the
state POSTCOPY_INCOMING_END when the migration is over. This
postcopy_state is taken into account inside ram_load to check
how it will load the memory pages. This same ram_load is called when
in a loadvm command.

Inside ram_load, the logic to see if we're at postcopy_running state
is:

postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING

postcopy_state_get() returns this enum type:

typedef enum {
    POSTCOPY_INCOMING_NONE = 0,
    POSTCOPY_INCOMING_ADVISE,
    POSTCOPY_INCOMING_DISCARD,
    POSTCOPY_INCOMING_LISTENING,
    POSTCOPY_INCOMING_RUNNING,
    POSTCOPY_INCOMING_END
} PostcopyState;

In the case where ram_load is executed and postcopy_state is
POSTCOPY_INCOMING_END, postcopy_running will be set to 'true' and
ram_load will behave like a postcopy is in progress. This scenario isn't
achievable in a migration but it is reproducible when executing
savevm/loadvm after migrating with 'postcopy-ram on', causing loadvm
to fail with Error -22:

Source:

(qemu) migrate_set_capability postcopy-ram on
(qemu) migrate tcp:127.0.0.1:4444

Dest:

(qemu) migrate_set_capability postcopy-ram on
(qemu)
ubuntu1704-intel login:
Ubuntu 17.04 ubuntu1704-intel ttyS0

ubuntu1704-intel login: (qemu)
(qemu) savevm test1
(qemu) loadvm test1
Unknown combination of migration flags: 0x4 (postcopy mode)
error while loading state for instance 0x0 of device 'ram'
Error -22 while loading VM state
(qemu)

This patch fixes this problem by changing a bit the semantics
of postcopy_running inside ram_load, verifying first if
we're not in the POSTCOPY_INCOMING_END state. In this case,
postcopy_running is set to 'false'.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8620aa400a..43ed719668 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2803,13 +2803,21 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     int flags = 0, ret = 0, invalid_flags = 0;
     static uint64_t seq_iter;
     int len = 0;
-    /*
-     * If system is running in postcopy mode, page inserts to host memory must
-     * be atomic
-     */
-    bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
-    /* ADVISE is earlier, it shows the source has the postcopy capability on */
-    bool postcopy_advised = postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE;
+    bool postcopy_advised = false, postcopy_running = false;
+    uint8_t postcopy_state = postcopy_state_get();
+
+    if (postcopy_state != POSTCOPY_INCOMING_END) {
+        /*
+         * If system is running in postcopy mode, page inserts to host memory
+         * must be atomic
+         */
+        postcopy_running = postcopy_state >= POSTCOPY_INCOMING_LISTENING;
+
+        /* ADVISE is earlier, it shows the source has the postcopy
+         * capability on
+         */
+        postcopy_advised = postcopy_state >= POSTCOPY_INCOMING_ADVISE;
+    }
 
     seq_iter++;
 
-- 
2.13.6
