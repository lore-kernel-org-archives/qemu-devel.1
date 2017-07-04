Received: from eggs.gnu.org ([2001:4830:134:3::10]:41753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZN-0004A3-OJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZM-00037L-PY
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZM-00036t-IS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81D2961E48
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:19 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:40 +0800
Message-Id: <20170704064347.7022-14-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/20] armv7m: Convert armv7m.memory to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/arm/armv7m.c         | 10 +++-------
 include/hw/arm/armv7m.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 3a13d82..3b0ada0 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -132,12 +132,6 @@ static void armv7m_instance_init(Object *obj)
 
     /* Can't init the cpu here, we don't yet know which model to use */
 
-    object_property_add_link(obj, "memory",
-                             TYPE_MEMORY_REGION,
-                             (Object **)&s->board_memory,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
     memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
 
     object_initialize(&s->nvic, sizeof(s->nvic), "armv7m_nvic");
@@ -167,7 +161,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
+    memory_region_add_subregion_overlap(&s->container, 0,
+                                        MEMORY_REGION(s->board_memory), -1);
 
     cpustr = g_strsplit(s->cpu_model, ",", 2);
 
@@ -248,6 +243,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
 static Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
+    DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 1b4ce5b..1640199 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -58,7 +58,7 @@ typedef struct ARMv7MState {
     /* Properties */
     char *cpu_model;
     /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
-    MemoryRegion *board_memory;
+    Object *board_memory;
 } ARMv7MState;
 
 #endif
-- 
2.9.4
