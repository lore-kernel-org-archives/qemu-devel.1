Received: from eggs.gnu.org ([2001:4830:134:3::10]:40845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eFSlr-0006bM-An
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 17:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eFSlm-0003sU-Cj
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 17:36:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eFSlm-0003ro-4I
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 17:36:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGMXTSG078737
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 17:36:22 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e9ew7p69q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 17:36:22 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 16 Nov 2017 17:36:21 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 20:35:26 -0200
In-Reply-To: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171116223527.4499-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/2] migration/ram.c: do not set
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
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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

This patch fixes this problem by changing the existing logic for
postcopy_advised and postcopy_running in ram_load, making them
'false' if we're at POSTCOPY_INCOMING_END state.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 migration/ram.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8620aa400a..021d583b9b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2798,6 +2798,18 @@ static int ram_load_postcopy(QEMUFile *f)
     return ret;
 }
 
+static bool postcopy_is_advised(void)
+{
+    PostcopyState ps = postcopy_state_get();
+    return ps >= POSTCOPY_INCOMING_ADVISE && ps < POSTCOPY_INCOMING_END;
+}
+
+static bool postcopy_is_running(void)
+{
+    PostcopyState ps = postcopy_state_get();
+    return ps >= POSTCOPY_INCOMING_LISTENING && ps < POSTCOPY_INCOMING_END;
+}
+
 static int ram_load(QEMUFile *f, void *opaque, int version_id)
 {
     int flags = 0, ret = 0, invalid_flags = 0;
@@ -2807,9 +2819,9 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      * If system is running in postcopy mode, page inserts to host memory must
      * be atomic
      */
-    bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
+    bool postcopy_running = postcopy_is_running();
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
-    bool postcopy_advised = postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE;
+    bool postcopy_advised = postcopy_is_advised();
 
     seq_iter++;
 
-- 
2.13.6
