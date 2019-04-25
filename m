Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7555C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF69206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF69206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33319 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJigp-00043J-P2
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:01:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicR-0000Jf-Rh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicQ-0004yp-RK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJicQ-0004xw-LM
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E589581258;
	Thu, 25 Apr 2019 17:57:09 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7310A17A87;
	Thu, 25 Apr 2019 17:57:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 25 Apr 2019 14:56:52 -0300
Message-Id: <20190425175659.24876-5-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
References: <20190425175659.24876-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 25 Apr 2019 17:57:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/11] vl: Clean up after previous commit
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
Message-ID: <20190425175652.ufPi0qWZ2ymfUDA9U48OCxwS7bYiYBWZ1WbkxPGbH0s@z>

From: Markus Armbruster <armbru@redhat.com>

Since the previous commit, find_machine() and find_default_machine()
don't have to deallocate on return.  This permits further
simplifications.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190405064121.23662-4-richardw.yang@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/vl.c b/vl.c
index fb8c8eda2a..69c530a920 100644
--- a/vl.c
+++ b/vl.c
@@ -1468,40 +1468,31 @@ MachineState *current_machine;
 static MachineClass *find_machine(const char *name, GSList *machines)
 {
     GSList *el;
-    MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
-        MachineClass *temp = el->data;
+        MachineClass *mc = el->data;
 
-        if (!strcmp(temp->name, name)) {
-            mc = temp;
-            break;
-        }
-        if (temp->alias &&
-            !strcmp(temp->alias, name)) {
-            mc = temp;
-            break;
+        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            return mc;
         }
     }
 
-    return mc;
+    return NULL;
 }
 
 static MachineClass *find_default_machine(GSList *machines)
 {
     GSList *el;
-    MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
-        MachineClass *temp = el->data;
+        MachineClass *mc = el->data;
 
-        if (temp->is_default) {
-            mc = temp;
-            break;
+        if (mc->is_default) {
+            return mc;
         }
     }
 
-    return mc;
+    return NULL;
 }
 
 MachineInfoList *qmp_query_machines(Error **errp)
-- 
2.18.0.rc1.1.g3f1ff2140


