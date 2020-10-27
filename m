Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6888DC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F24206E5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQIZ0Plk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F24206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTkF-0007HF-PD
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbq-0004Dm-Ty
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbh-00030z-8F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXC1IPs99vGL1famTeAG4H9kQs2d4Dh6bMygSLxFw0Q=;
 b=CQIZ0PlkBpZdhFeU9qpBwGz303ktW5lGHm+9/gFFjemN+Q2suqycC6/7JC+V4ecqYzu1AP
 51D/ex1zUX1NBcM9XeggROFe7ntlZGPMRsQcYon+zsZKfyKZF1usvJlfOG2/Q1fOEytVSh
 NPPQLo+DT1h0qdvla+udGKaKOy2IuOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-9ktxRULiP5SUnuECBl6M6g-1; Tue, 27 Oct 2020 14:22:02 -0400
X-MC-Unique: 9ktxRULiP5SUnuECBl6M6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A83018CB73E
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F3385D9E8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/29] vl: move semihosting command line fallback to
 qemu_finish_machine_init
Date: Tue, 27 Oct 2020 14:21:29 -0400
Message-Id: <20201027182144.3315885-15-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move more sane parts of the huge qemu_init function out of it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 53d53ef206..bc85318b23 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3072,6 +3072,11 @@ static void qemu_finish_machine_init(void)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
 
+    if (semihosting_enabled() && !semihosting_get_argc() && current_machine->kernel_filename) {
+        /* fall back to the -kernel/-append */
+        semihosting_arg_fallback(current_machine->kernel_filename, current_machine->kernel_cmdline);
+    }
+
     if (machine_class->default_ram_id && current_machine->ram_size &&
         numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
         create_default_memdev(current_machine, mem_path);
@@ -4389,13 +4394,6 @@ void qemu_init(int argc, char **argv, char **envp)
         boot_order = machine_class->default_boot_order;
     }
 
-    if (semihosting_enabled() && !semihosting_get_argc()) {
-        const char *kernel_filename = qemu_opt_get(machine_opts, "kernel");
-        const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
-        /* fall back to the -kernel/-append */
-        semihosting_arg_fallback(kernel_filename, kernel_cmdline);
-    }
-
     if (net_init_clients(&err) < 0) {
         error_report_err(err);
         exit(1);
-- 
2.26.2



