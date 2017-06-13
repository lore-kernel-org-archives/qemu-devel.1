Received: from eggs.gnu.org ([2001:4830:134:3::10]:57139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUC-0001Dp-Ae
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU6-0003Lp-Dd
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiU6-0003Li-5Z
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29E59C003400
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:12 +0200
Message-Id: <20170613095120.11373-7-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/14] migration: Move self_announce_delay() to
 misc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/virtio-net.c         |  1 +
 include/migration/misc.h    | 10 ++++++++++
 include/migration/vmstate.h | 10 ----------
 migration/savevm.c          |  1 +
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9a3d769..91eddaf 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -25,6 +25,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi-event.h"
 #include "hw/virtio/virtio-access.h"
+#include "migration/misc.h"
=20
 #define VIRTIO_NET_VM_VERSION    11
=20
diff --git a/include/migration/misc.h b/include/migration/misc.h
index d7892b7..60486d4 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -26,4 +26,14 @@ void blk_mig_init(void);
 static inline void blk_mig_init(void) {}
 #endif
=20
+#define SELF_ANNOUNCE_ROUNDS 5
+
+static inline
+int64_t self_announce_delay(int round)
+{
+    assert(round < SELF_ANNOUNCE_ROUNDS && round > 0);
+    /* delay 50ms, 150ms, 250ms, ... */
+    return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
+}
+
 #endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8a3e9e6..ee91dff 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1010,8 +1010,6 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_END_OF_LIST()                                         \
     {}
=20
-#define SELF_ANNOUNCE_ROUNDS 5
-
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
 void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
@@ -1043,14 +1041,6 @@ void vmstate_register_ram(struct MemoryRegion *mem=
ory, DeviceState *dev);
 void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *de=
v);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
=20
-static inline
-int64_t self_announce_delay(int round)
-{
-    assert(round < SELF_ANNOUNCE_ROUNDS && round > 0);
-    /* delay 50ms, 150ms, 250ms, ... */
-    return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
-}
-
 void dump_vmstate_json_to_file(FILE *out_fp);
=20
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
diff --git a/migration/savevm.c b/migration/savevm.c
index 745caae..cc8e4e1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -36,6 +36,7 @@
 #include "qemu/timer.h"
 #include "migration/migration.h"
 #include "migration/snapshot.h"
+#include "migration/misc.h"
 #include "ram.h"
 #include "qemu-file-channel.h"
 #include "qemu-file.h"
--=20
2.9.4
