Received: from eggs.gnu.org ([2001:4830:134:3::10]:45247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgO-000354-94
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgN-0003Ju-GM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgN-0003Jc-3M
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:39 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so334537wmi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:38 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:00 +0100
Message-Id: <1484163327-111841-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/33] stubs: move smbios stubs to hw/smbios
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
1.8.3.1
