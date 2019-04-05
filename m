Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3442C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A6A206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A6A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCIbw-0006Ls-0g
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 02:46:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY9-0003fR-1w
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY8-0004YY-6V
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:40758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCIY7-0004O6-TF
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Apr 2019 23:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; d="scan'208";a="128814036"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga007.jf.intel.com with ESMTP; 04 Apr 2019 23:42:02 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Apr 2019 14:41:21 +0800
Message-Id: <20190405064121.23662-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190405064121.23662-1-richardw.yang@linux.intel.com>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [PATCH v2 4/4] vl: Simplify machine_parse()
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405064121.qVW7PRsZh69enxItyBu0TiIO6_ZZvMMzRtqnxaoEf9M@z>

From: Markus Armbruster <armbru@redhat.com>

Exploit that argument @name is nerver null.  Check is_help_option()
first, because that's what we do elsewhere.  If we (foolishly!)
defined a machine named "help", -machine help would now print help
instead of selecting the machine named "help".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
---
 vl.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/vl.c b/vl.c
index 99f9cb2533..4f4d440bc4 100644
--- a/vl.c
+++ b/vl.c
@@ -2529,19 +2529,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
 
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
@@ -2553,9 +2544,16 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
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
2.19.1


