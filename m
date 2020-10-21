Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2C9C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3403D21481
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYB5ofy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3403D21481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLIF-000637-63
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLB1-0005fc-C8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAv-0006hM-J0
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdzKqU40Mrkt2ehEsXWNYxvEj9MX/Xb2GS8n9gTpND4=;
 b=CYB5ofy/ioQiDaAvEzwjkCKCaF1Vw1qm6PjZQl2jd+bJ1G9qnM360aN2ucIgkJfZmUSm1K
 zb2Qh306WdvtUSPSlNS2s4HiJS6mEpvwGOcWtyR1jykmQhhnJJmIFEvJCAvCtQobbdWuMA
 5NxbP5qHS12ldAM2t236mbSCG3kLvnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-9VBGNAs1OxmaGqDCZxfwDQ-1; Wed, 21 Oct 2020 16:57:32 -0400
X-MC-Unique: 9VBGNAs1OxmaGqDCZxfwDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 096641006C94
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 796196EF62;
 Wed, 21 Oct 2020 20:57:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/22] vl: load plugins as late as possible
Date: Wed, 21 Oct 2020 16:57:11 -0400
Message-Id: <20201021205716.2359430-18-pbonzini@redhat.com>
In-Reply-To: <20201021205716.2359430-1-pbonzini@redhat.com>
References: <20201021205716.2359430-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: jsnow@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no need to load plugins in the middle of default device processing,
move -plugin handling just before preconfig is entered.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 8577667b8f..75e57133ad 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -125,6 +125,7 @@ static const char *boot_order;
 static const char *boot_once;
 static const char *incoming;
 static const char *loadvm;
+static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int mem_prealloc; /* force preallocation of physical target memory */
 int display_opengl;
@@ -3064,12 +3065,18 @@ void qemu_finish_machine_init(void)
     MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
     DisplayState *ds;
 
+    /* from here on runstate is RUN_STATE_PRELAUNCH */
+
     if (machine_class->default_ram_id && current_machine->ram_size &&
         numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
         create_default_memdev(current_machine, mem_path);
     }
 
-    /* from here on runstate is RUN_STATE_PRELAUNCH */
+    /* process plugin before CPUs are created, but once -smp has been parsed */
+    if (qemu_plugin_load_list(&plugin_list)) {
+        exit(1);
+    }
+
     machine_run_board_init(current_machine);
 
     /*
@@ -3196,7 +3203,6 @@ void qemu_init(int argc, char **argv, char **envp)
     Error *err = NULL;
     bool have_custom_ram_size;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
-    QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -4164,11 +4170,6 @@ void qemu_init(int argc, char **argv, char **envp)
                                machine_class->default_machine_opts, 0);
     }
 
-    /* process plugin before CPUs are created, but once -smp has been parsed */
-    if (qemu_plugin_load_list(&plugin_list)) {
-        exit(1);
-    }
-
     qemu_opts_foreach(qemu_find_opts("device"),
                       default_driver_check, NULL, NULL);
     qemu_opts_foreach(qemu_find_opts("global"),
-- 
2.26.2



