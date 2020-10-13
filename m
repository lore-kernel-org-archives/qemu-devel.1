Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D8C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E6E21D40
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqgbfBaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E6E21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTOk-00005o-EJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTME-0006N4-2c
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTMB-0003Z3-L2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602630322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pbjp8f4ua9Togwl/XXJ68jdNd0x8gpeRQ3cf/ImZEDY=;
 b=YqgbfBaIStQCFm+/uxrjY4vW+sbuhV1PJemDtLrpMSRt46NXHwzcbMvZa322I9J5sUrOWW
 Jy1P3p4ryFys0lsOO7nZj8X1OYHkR5lLt9r2u9K9DuzzwOjvAyT/FBDvT9oJj7BXWmqS+R
 wDqyJ1bXEXGASOPVVv2MyrNrRMwJg7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-dXmLI0e-OO2haLkoXTIlfg-1; Tue, 13 Oct 2020 19:05:20 -0400
X-MC-Unique: dXmLI0e-OO2haLkoXTIlfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C2A8802B4B;
 Tue, 13 Oct 2020 23:05:18 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72B772C31E;
 Tue, 13 Oct 2020 23:05:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] machine: machine_find_class() function
Date: Tue, 13 Oct 2020 19:04:51 -0400
Message-Id: <20201013230457.150630-2-ehabkost@redhat.com>
In-Reply-To: <20201013230457.150630-1-ehabkost@redhat.com>
References: <20201013230457.150630-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 19:05:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move find_machine() from vl.c to core/machine.c and rename it to
machine_find_class(), so it can be reused by other code.

The function won't reuse the results of the previous
object_class_get_list() call like it did in vl.c, but this
shouldn't be a problem because the function is expected to be
called only once during regular QEMU usage.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  2 ++
 hw/core/machine.c   | 16 ++++++++++++++++
 softmmu/vl.c        | 17 +----------------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index bf53e8a16e..922b710be3 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -43,6 +43,8 @@ void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
 MemoryRegion *machine_consume_memdev(MachineState *machine,
                                      HostMemoryBackend *backend);
 
+MachineClass *machine_find_class(const char *name);
+
 /**
  * CPUArchId:
  * @arch_id - architecture-dependent CPU ID of present or possible CPU
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7e2f4ec08e..879a596643 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1136,6 +1136,22 @@ void machine_run_board_init(MachineState *machine)
     machine_class->init(machine);
 }
 
+MachineClass *machine_find_class(const char *name)
+{
+    g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el;
+
+    for (el = machines; el; el = el->next) {
+        MachineClass *mc = el->data;
+
+        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            return mc;
+        }
+    }
+
+    return NULL;
+}
+
 static const TypeInfo machine_info = {
     .name = TYPE_MACHINE,
     .parent = TYPE_OBJECT,
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 254ee5e525..b74f377a1c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1159,21 +1159,6 @@ static int usb_parse(const char *cmdline)
 
 MachineState *current_machine;
 
-static MachineClass *find_machine(const char *name, GSList *machines)
-{
-    GSList *el;
-
-    for (el = machines; el; el = el->next) {
-        MachineClass *mc = el->data;
-
-        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
-            return mc;
-        }
-    }
-
-    return NULL;
-}
-
 static MachineClass *find_default_machine(GSList *machines)
 {
     GSList *el;
@@ -2341,7 +2326,7 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
         exit(0);
     }
 
-    mc = find_machine(name, machines);
+    mc = machine_find_class(name);
     if (!mc) {
         error_report("unsupported machine type");
         error_printf("Use -machine help to list supported machines\n");
-- 
2.28.0


