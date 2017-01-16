Received: from eggs.gnu.org ([2001:4830:134:3::10]:57933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcw-0000hn-EN
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcv-0008VT-Oj
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAcv-0008VC-JF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7AA84D6A5
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:25 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGUr001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:25 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:50 +0100
Message-Id: <20170116165916.8575-7-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/32] stubs: move smbios stubs to hw/smbios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
