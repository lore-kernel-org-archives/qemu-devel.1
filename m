Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADBDC4321B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E357A20717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E357A20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJijO-00069E-Ha
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:04:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicT-0000Lf-SZ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicS-00050K-T6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJicS-0004zy-Lc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBAD5308A11C;
	Thu, 25 Apr 2019 17:57:11 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D2E519729;
	Thu, 25 Apr 2019 17:57:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 25 Apr 2019 14:56:53 -0300
Message-Id: <20190425175659.24876-6-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
References: <20190425175659.24876-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 25 Apr 2019 17:57:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/11] vl: Simplify machine_parse()
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425175653.uD1DEchPatk38oNBbPV6rp97qRgvqCCyenmMACspWbs@z>

From: Markus Armbruster <armbru@redhat.com>

Exploit that argument @name is nerver null.  Check is_help_option()
first, because that's what we do elsewhere.  If we (foolishly!)
defined a machine named "help", -machine help would now print help
instead of selecting the machine named "help".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190405064121.23662-5-richardw.yang@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/vl.c b/vl.c
index 69c530a920..4c794f2bf6 100644
--- a/vl.c
+++ b/vl.c
@@ -2576,19 +2576,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
 
 static MachineClass *machine_parse(const char *name, GSList *machines)
 {
-    MachineClass *mc = NULL;
+    MachineClass *mc;
     GSList *el;
 
-    if (name) {
-        mc = find_machine(name, machines);
-    }
-    if (mc) {
-        return mc;
-    }
-    if (name && !is_help_option(name)) {
-        error_report("unsupported machine type");
-        error_printf("Use -machine help to list supported machines\n");
-    } else {
+    if (is_help_option(name)) {
         printf("Supported machines are:\n");
         machines = g_slist_sort(machines, machine_class_cmp);
         for (el = machines; el; el = el->next) {
@@ -2600,9 +2591,16 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
                    mc->is_default ? " (default)" : "",
                    mc->deprecation_reason ? " (deprecated)" : "");
         }
+        exit(0);
     }
 
-    exit(!name || !is_help_option(name));
+    mc = find_machine(name, machines);
+    if (!mc) {
+        error_report("unsupported machine type");
+        error_printf("Use -machine help to list supported machines\n");
+        exit(1);
+    }
+    return mc;
 }
 
 void qemu_add_exit_notifier(Notifier *notify)
-- 
2.18.0.rc1.1.g3f1ff2140


