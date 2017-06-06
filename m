Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBlP-0006j4-ER
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIBlO-00063S-Hb
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIBlO-00063D-Bq
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:31:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F30E80F6C
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:31:01 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Jun 2017 18:30:39 +0800
Message-Id: <1496745042-2379-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1496745042-2379-1-git-send-email-peterx@redhat.com>
References: <1496745042-2379-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] migration: use compat bit for global_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Removing two callers of global_state_set_optional() since now we can use
HW_COMPAT_2_3. However there is still one more caller (xen_init), so we
still need to keep the function until it disappears.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c   | 1 -
 hw/ppc/spapr.c      | 1 -
 include/hw/compat.h | 4 ++++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2234bd0..c83cec5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -317,7 +317,6 @@ static void pc_compat_2_3(MachineState *machine)
     if (kvm_enabled()) {
         pcms->smm = ON_OFF_AUTO_OFF;
     }
-    global_state_set_optional();
     savevm_skip_configuration();
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab3aab1..3e78bb9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3593,7 +3593,6 @@ static void spapr_machine_2_3_instance_options(MachineState *machine)
 {
     spapr_machine_2_4_instance_options(machine);
     savevm_skip_section_footers();
-    global_state_set_optional();
     savevm_skip_configuration();
 }
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 400c64b..5b5c8de 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -177,6 +177,10 @@
         .driver   = TYPE_PCI_DEVICE,\
         .property = "x-pcie-lnksta-dllla",\
         .value    = "off",\
+    },{\
+        .driver   = "migration",\
+        .property = "store-global-state",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_2 \
-- 
2.7.4
