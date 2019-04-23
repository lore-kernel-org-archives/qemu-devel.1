Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBC0C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC08208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC08208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2vo-000738-O2
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:26:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sl-0004Yp-9n
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sf-0007mc-Ll
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJ2sZ-0007hs-EB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:23:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82289307D98D;
	Tue, 23 Apr 2019 21:22:59 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FA6E1001E7D;
	Tue, 23 Apr 2019 21:22:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 18:22:46 -0300
Message-Id: <20190423212246.3542-4-ehabkost@redhat.com>
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 23 Apr 2019 21:22:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] qmp: Add deprecation information to
 query-machines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423212246.TbPWAJG8uzy7X6jizFFqWHMOI3ORopSNlOp_7K0CziY@z>

Export machine type deprecation information through the
query-machines QMP command.  With this, libvirt and management
software will be able to show this information to users and/or
suggest changes to VM configuration to avoid deprecated machines.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/misc.json                     |  5 ++++-
 vl.c                               |  6 ++++++
 tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/query_machines.py

diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..941d251d17 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2018,12 +2018,15 @@
 #
 # @hotpluggable-cpus: cpu hotplug via -device is supported (since 2.7.0)
 #
+# @support-status: Support/deprecation status information (since 4.1.0)
+#
 # Since: 1.2.0
 ##
 { 'struct': 'MachineInfo',
   'data': { 'name': 'str', '*alias': 'str',
             '*is-default': 'bool', 'cpu-max': 'int',
-            'hotpluggable-cpus': 'bool'} }
+            'hotpluggable-cpus': 'bool',
+            'support-status': 'SupportStatusInfo' } }
 
 ##
 # @query-machines:
diff --git a/vl.c b/vl.c
index 99b857ed2a..ca23d2a404 100644
--- a/vl.c
+++ b/vl.c
@@ -1530,6 +1530,12 @@ MachineInfoList *qmp_query_machines(Error **errp)
         info->name = g_strdup(mc->name);
         info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
         info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
+        assert(!mc->support_status.status_message ||
+               mc->support_status.has_status_message);
+        assert(!mc->support_status.suggested_alternative ||
+               mc->support_status.has_suggested_alternative);
+        info->support_status =
+            QAPI_CLONE(SupportStatusInfo, &mc->support_status);
 
         entry = g_malloc0(sizeof(*entry));
         entry->value = info;
diff --git a/tests/acceptance/query_machines.py b/tests/acceptance/query_machines.py
new file mode 100644
index 0000000000..23a56ea617
--- /dev/null
+++ b/tests/acceptance/query_machines.py
@@ -0,0 +1,27 @@
+# Sanity check query-machines QMP command results
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado_qemu import Test
+
+class QueryMachines(Test):
+    def test(self):
+        self.vm.launch()
+        machines = self.vm.command('query-machines')
+        machinesdict = dict((m['name'], m) for m in machines)
+        machinesdict.update((m['alias'], m) for m in machines if 'alias' in m)
+        for machine in machines:
+            status = machine['support-status']
+            if status['deprecated']:
+                self.assertTrue(status.get('status-message') or \
+                                status.get('suggested-alternative'),
+                                "Deprecated machine (%s) must have status-message or suggested-alternative" % (machine['name']))
+            if 'suggested-alternative' in status:
+                self.assertTrue(status['suggested-alternative'] in machinesdict,
+                                "suggested-alternative of %s must point to a valid machine type" % (machine['name']))
-- 
2.18.0.rc1.1.g3f1ff2140


