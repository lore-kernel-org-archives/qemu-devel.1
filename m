Received: from eggs.gnu.org ([2001:4830:134:3::10]:44873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5m5-00077T-Ae
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5m4-0003YE-BZ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5m4-0003Y0-5u
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:20 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43332D7808
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:59:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:59:06 +0100
Message-Id: <20161222155915.7232-3-pbonzini@redhat.com>
In-Reply-To: <20161222155915.7232-1-pbonzini@redhat.com>
References: <20161222155915.7232-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/11] stubs: move smbios stubs to hw/smbios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

No need to include them in libqemustub.a, since only system emulators
need them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/smbios/Makefile.objs                                   | 11 ++++++++---
 stubs/smbios_type_38.c => hw/smbios/smbios_type_38-stub.c |  0
 stubs/Makefile.objs                                       |  1 -
 3 files changed, 8 insertions(+), 4 deletions(-)
 rename stubs/smbios_type_38.c => hw/smbios/smbios_type_38-stub.c (100%)

diff --git a/hw/smbios/Makefile.objs b/hw/smbios/Makefile.objs
index ee0712b..23bb2ba 100644
--- a/hw/smbios/Makefile.objs
+++ b/hw/smbios/Makefile.objs
@@ -1,5 +1,10 @@
-common-obj-$(CONFIG_SMBIOS) += smbios.o
-common-obj-$(call land,$(CONFIG_SMBIOS),$(CONFIG_IPMI)) += smbios_type_38.o
+ifeq ($(CONFIG_SMBIOS),y)
+common-obj-y += smbios.o
+common-obj-$(CONFIG_IPMI) += smbios_type_38.o
+common-obj-$(call lnot,$(CONFIG_IPMI)) += smbios_type_38-stub.o
+else
+common-obj-y += smbios-stub.o
+endif
 
-common-obj-$(call lnot,$(CONFIG_SMBIOS)) += smbios-stub.o
 common-obj-$(CONFIG_ALL) += smbios-stub.o
+common-obj-$(CONFIG_ALL) += smbios_type_38-stub.o
diff --git a/stubs/smbios_type_38.c b/hw/smbios/smbios_type_38-stub.c
similarity index 100%
rename from stubs/smbios_type_38.c
rename to hw/smbios/smbios_type_38-stub.c
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 9fc373e..13c5d45 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -44,7 +44,6 @@ stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += vhost.o
 stub-obj-y += iohandler.o
-stub-obj-y += smbios_type_38.o
 stub-obj-y += ipmi.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += migration-colo.o
-- 
2.9.3
