Received: from eggs.gnu.org ([2001:4830:134:3::10]:55751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPV-0005qN-MA
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPQ-00052V-N7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60246
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMYPQ-00052G-Hu
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6BxFGP004166
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 07:02:40 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epdk68bd5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:02:39 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 07:02:37 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 10:02:16 -0200
In-Reply-To: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
References: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171206120217.11392-3-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/3] hmp: introduce wakeup-from-suspend-support
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This is the HMP side of 'query-wakeup-from-suspend-support', a new
QMP command that queries the guest support for system_wakeup.

This is the expected output of the new command when running a
x86 guest:

(qemu) info wakeup_from_suspend_support
wake up from suspend support: enabled
(qemu)

And when running a pseries guest:

(qemu) info wakeup_from_suspend_support
wake up from suspend support: disabled
(qemu)

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hmp-commands-info.hx | 15 +++++++++++++++
 hmp.c                | 11 +++++++++++
 hmp.h                |  1 +
 3 files changed, 27 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 54c3e5eac6..9d5e93bfcf 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -867,6 +867,21 @@ Display the amount of initially allocated and present hotpluggable (if
 enabled) memory in bytes.
 ETEXI
 
+    {
+        .name       = "wakeup_from_suspend_support",
+        .args_type  = "",
+        .params     = "",
+        .help       = "shows if the guest has support for wake up "
+                      "from suspend",
+        .cmd        = hmp_info_wakeup_from_suspend_support,
+    },
+
+STEXI
+@item info wakeup_from_suspend_support
+@findex info wakeup_from_suspend_support
+Shows if the guest has support for wake up from suspended state.
+ETEXI
+
 STEXI
 @end table
 ETEXI
diff --git a/hmp.c b/hmp.c
index 35a7041824..3b74b9ee19 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2918,3 +2918,14 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+void hmp_info_wakeup_from_suspend_support(Monitor *mon, const QDict *qdict)
+{
+    WakeupSuspendSupportInfo *info;
+
+    info = qmp_query_wakeup_from_suspend_support(NULL);
+    monitor_printf(mon, "wake up from suspend support: %s\n",
+                   info->enabled ? "enabled" : "disabled");
+
+    qapi_free_WakeupSuspendSupportInfo(info);
+}
diff --git a/hmp.h b/hmp.h
index a6f56b1f29..2d394cbec2 100644
--- a/hmp.h
+++ b/hmp.h
@@ -147,5 +147,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_wakeup_from_suspend_support(Monitor *mon, const QDict *qdict);
 
 #endif
-- 
2.13.6
