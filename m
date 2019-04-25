Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC13BC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42378206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42378206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33317 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJigq-000434-Qt
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:01:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicP-0000HQ-VF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicO-0004wo-Tm
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJicO-0004wA-L1
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFAF136887;
	Thu, 25 Apr 2019 17:57:07 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 720A760C70;
	Thu, 25 Apr 2019 17:57:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 25 Apr 2019 14:56:51 -0300
Message-Id: <20190425175659.24876-4-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
References: <20190425175659.24876-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 25 Apr 2019 17:57:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/11] vl.c: allocate TYPE_MACHINE list once
 during bootup
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
Cc: Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425175651.06fJ4-05OMVfi6Ta-DHRWCi3UokvlS4NJRmt24ZD_Qc@z>

From: Wei Yang <richardw.yang@linux.intel.com>

Now all the functions used to select machine is local and the call flow
looks like below:

    select_machine()
        find_default_machine()
        machine_parse()
            find_machine()

All these related function will need a GSList for TYPE_MACHINE.
Currently we allocate this list each time we use it, while this is not
necessary to do so because we don't need to modify this.

This patch make the TYPE_MACHINE list allocation in select_machine and
pass this to its child for use.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190405064121.23662-3-richardw.yang@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/vl.c b/vl.c
index c237c9a0ac..fb8c8eda2a 100644
--- a/vl.c
+++ b/vl.c
@@ -1465,9 +1465,9 @@ static int usb_parse(const char *cmdline)
 
 MachineState *current_machine;
 
-static MachineClass *find_machine(const char *name)
+static MachineClass *find_machine(const char *name, GSList *machines)
 {
-    GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el;
     MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
@@ -1484,13 +1484,12 @@ static MachineClass *find_machine(const char *name)
         }
     }
 
-    g_slist_free(machines);
     return mc;
 }
 
-static MachineClass *find_default_machine(void)
+static MachineClass *find_default_machine(GSList *machines)
 {
-    GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el;
     MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
@@ -1502,7 +1501,6 @@ static MachineClass *find_default_machine(void)
         }
     }
 
-    g_slist_free(machines);
     return mc;
 }
 
@@ -2585,16 +2583,15 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
                   object_class_get_name(OBJECT_CLASS(mc1)));
 }
 
- static MachineClass *machine_parse(const char *name)
+static MachineClass *machine_parse(const char *name, GSList *machines)
 {
     MachineClass *mc = NULL;
-    GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el;
 
     if (name) {
-        mc = find_machine(name);
+        mc = find_machine(name, machines);
     }
     if (mc) {
-        g_slist_free(machines);
         return mc;
     }
     if (name && !is_help_option(name)) {
@@ -2614,7 +2611,6 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
         }
     }
 
-    g_slist_free(machines);
     exit(!name || !is_help_option(name));
 }
 
@@ -2706,7 +2702,8 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
 
 static MachineClass *select_machine(void)
 {
-    MachineClass *machine_class = find_default_machine();
+    GSList *machines = object_class_get_list(TYPE_MACHINE, false);
+    MachineClass *machine_class = find_default_machine(machines);
     const char *optarg;
     QemuOpts *opts;
     Location loc;
@@ -2718,7 +2715,7 @@ static MachineClass *select_machine(void)
 
     optarg = qemu_opt_get(opts, "type");
     if (optarg) {
-        machine_class = machine_parse(optarg);
+        machine_class = machine_parse(optarg, machines);
     }
 
     if (!machine_class) {
@@ -2728,6 +2725,7 @@ static MachineClass *select_machine(void)
     }
 
     loc_pop(&loc);
+    g_slist_free(machines);
     return machine_class;
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140


