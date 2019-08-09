Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA269C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9087E2166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9087E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyi3-0002hP-SX
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvyfx-0000pq-J1
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvyfw-0001gp-Cf
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyfw-0001gD-30
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:46:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CD5F59451
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:46:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19BAB5D9CC;
 Fri,  9 Aug 2019 06:46:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E47A11385D4; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:20 +0200
Message-Id: <20190809064645.22656-5-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 09 Aug 2019 06:46:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 04/29] memory: Fix type of
 IOMMUMemoryRegionClass member @parent_class
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_IOMMU_MEMORY_REGION is a direct subtype of TYPE_MEMORY_REGION.
Its instance struct is IOMMUMemoryRegion, and its first member is a
MemoryRegion.  Correct.  Its class struct is IOMMUMemoryRegionClass,
and its first member is a DeviceClass.  Wrong.  Messed up when commit
1221a474676 introduced the QOM type.  It even included hw/qdev-core.h
just for that.

TYPE_MEMORY_REGION doesn't bother to define a class struct.  This is
fine, it simply defaults to its super-type TYPE_OBJECT's class struct
ObjectClass.  Changing IOMMUMemoryRegionClass's first member's type to
ObjectClass would be a minimal fix, if a bit brittle: if
TYPE_MEMORY_REGION ever acquired own class struct, we'd have to update
IOMMUMemoryRegionClass to use it.

Fix it the clean and robust way instead: give TYPE_MEMORY_REGION its
own class struct MemoryRegionClass now, and use it for
IOMMUMemoryRegionClass's first member.

Revert the include of hw/qdev-core.h, and fix the few files that have
come to rely on it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga-isa-mm.c |  1 +
 hw/net/pcnet.h          |  1 +
 include/exec/memory.h   | 10 ++++++++--
 memory.c                |  1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index 215e649719..a790f69b6d 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/display/vga.h"
diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
index 40831a7845..28d19a5c6f 100644
--- a/hw/net/pcnet.h
+++ b/hw/net/pcnet.h
@@ -8,6 +8,7 @@
 #define PCNET_LOOPTEST_NOCRC	2
=20
 #include "exec/memory.h"
+#include "hw/irq.h"
=20
 /* BUS CONFIGURATION REGISTERS */
 #define BCR_MSRDA    0
diff --git a/include/exec/memory.h b/include/exec/memory.h
index bb0961ddb9..d99eb25d2e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -20,12 +20,12 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 #include "exec/ramlist.h"
+#include "qemu/bswap.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
 #include "qemu/notify.h"
 #include "qom/object.h"
 #include "qemu/rcu.h"
-#include "hw/qdev-core.h"
=20
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
=20
@@ -205,6 +205,12 @@ struct MemoryRegionOps {
     } impl;
 };
=20
+typedef struct MemoryRegionClass {
+    /* private */
+    ObjectClass parent_class;
+} MemoryRegionClass;
+
+
 enum IOMMUMemoryRegionAttr {
     IOMMU_ATTR_SPAPR_TCE_FD
 };
@@ -237,7 +243,7 @@ enum IOMMUMemoryRegionAttr {
  */
 typedef struct IOMMUMemoryRegionClass {
     /* private */
-    struct DeviceClass parent_class;
+    MemoryRegionClass parent_class;
=20
     /*
      * Return a TLB entry that contains a given address.
diff --git a/memory.c b/memory.c
index 5d8c9a9234..09d9b254fd 100644
--- a/memory.c
+++ b/memory.c
@@ -3245,6 +3245,7 @@ void memory_region_init_rom_device(MemoryRegion *mr=
,
 static const TypeInfo memory_region_info =3D {
     .parent             =3D TYPE_OBJECT,
     .name               =3D TYPE_MEMORY_REGION,
+    .class_size         =3D sizeof(MemoryRegionClass),
     .instance_size      =3D sizeof(MemoryRegion),
     .instance_init      =3D memory_region_initfn,
     .instance_finalize  =3D memory_region_finalize,
--=20
2.21.0


