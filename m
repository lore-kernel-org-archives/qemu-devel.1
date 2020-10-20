Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E012C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 22:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B8622256
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 22:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxgxdY0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B8622256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUzjC-0007Uq-UW
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 18:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUzhh-0006h6-SZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 18:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUzhf-0001hz-0N
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 18:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603231317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=85kHZDvL+9yoxpxYhyHX3J2IWsC8gN+DiR2A160Yq8o=;
 b=JxgxdY0KHAFGTmksx4838SjpLvQLXOafcOJdO5MTGmBd4mtL6gzgDXbCoUTUO8LZLToVUi
 PorqMZYpyWNafuZ8kpOj80HxtgYJNy/JJjr7n1bPnnnxQhLumleR5IB6s1Bkbtr7VXG+hd
 oGIMx8bndMxKRtg4XuojUQYj4A8FUkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-71972FB8Owe9wbUT1HzIOQ-1; Tue, 20 Oct 2020 18:01:53 -0400
X-MC-Unique: 71972FB8Owe9wbUT1HzIOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C4080365A;
 Tue, 20 Oct 2020 22:01:52 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7FDE6EF62;
 Tue, 20 Oct 2020 22:01:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pc: Implement -no-hpet as sugar for -machine hpet=off
Date: Tue, 20 Oct 2020 18:01:50 -0400
Message-Id: <20201020220150.1326086-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Get rid of yet another global variable.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h  |  1 +
 include/hw/i386/x86.h |  3 ---
 hw/i386/pc.c          | 21 ++++++++++++++++++++-
 hw/i386/pc_piix.c     |  2 +-
 softmmu/vl.c          |  4 ++--
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 84639d0ebc..911e460097 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -43,6 +43,7 @@ typedef struct PCMachineState {
     bool smbus_enabled;
     bool sata_enabled;
     bool pit_enabled;
+    bool hpet_enabled;
 
     /* NUMA information: */
     uint64_t numa_nodes;
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d5dcf7a07f..4e66a15ff5 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -124,7 +124,4 @@ qemu_irq x86_allocate_cpu_irq(void);
 void gsi_handler(void *opaque, int n, int level);
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
 
-/* hpet.c */
-extern int no_hpet;
-
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4e323755d0..ff863231e4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1142,7 +1142,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
      * Without KVM_CAP_PIT_STATE2, we cannot switch off the in-kernel PIT
      * when the HPET wants to take over. Thus we have to disable the latter.
      */
-    if (!no_hpet && (!kvm_irqchip_in_kernel() || kvm_has_pit_state2())) {
+    if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
+                                kvm_has_pit_state2())) {
         hpet = qdev_try_new(TYPE_HPET);
         if (hpet) {
             /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
@@ -1535,6 +1536,20 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
     pcms->pit_enabled = value;
 }
 
+static bool pc_machine_get_hpet(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->hpet_enabled;
+}
+
+static void pc_machine_set_hpet(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->hpet_enabled = value;
+}
+
 static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
@@ -1585,6 +1600,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->pit_enabled = true;
+    pcms->hpet_enabled = true;
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
@@ -1705,6 +1721,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
         pc_machine_get_pit, pc_machine_set_pit);
+
+    object_class_property_add_bool(oc, "hpet",
+        pc_machine_get_hpet, pc_machine_set_hpet);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0cf22a57ad..13d1628f13 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -216,7 +216,7 @@ static void pc_init1(MachineState *machine,
         i440fx_state = NULL;
         isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
                               &error_abort);
-        no_hpet = 1;
+        pcms->hpet_enabled = false;
     }
     isa_bus_irqs(isa_bus, x86ms->gsi);
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index cb476aa70b..c2281f45a8 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -146,7 +146,6 @@ static Chardev **serial_hds;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 int win2k_install_hack = 0;
 int singlestep = 0;
-int no_hpet = 0;
 int fd_bootchk = 1;
 static int no_reboot;
 int no_shutdown = 0;
@@ -3562,7 +3561,8 @@ void qemu_init(int argc, char **argv, char **envp)
                 qemu_opts_parse_noisily(olist, "acpi=off", false);
                 break;
             case QEMU_OPTION_no_hpet:
-                no_hpet = 1;
+                olist = qemu_find_opts("machine");
+                qemu_opts_parse_noisily(olist, "hpet=off", false);
                 break;
             case QEMU_OPTION_no_reboot:
                 no_reboot = 1;
-- 
2.28.0


