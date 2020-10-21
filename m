Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ACC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7624024198
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3GajrGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7624024198
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLW5-0003WF-Cu
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLB4-0005nc-A5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAx-0006gP-Cw
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0egizT1LhBTypV0Z8jUS6/aYGmVEDSIu03qH+texvk=;
 b=K3GajrGLKgcpe8xr9tiepTUUAUE1Ld6bPleBTtBd3h/cSicHgHwMlJeKZQnbmterQ3Mg/H
 u5Byf++idpzaZdlesWzUDqtDgQQs23sJeBXpZ2UtNui3sjtOZsOX1a2NtgPT5VmnDqkkYa
 fXc6fxotmmIHMTN1vZqd9T/PIaShb08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-EsPWbHgVNbKl-iQGy-ONqg-1; Wed, 21 Oct 2020 16:57:30 -0400
X-MC-Unique: EsPWbHgVNbKl-iQGy-ONqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4CA4186DD48
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 353326EF62;
 Wed, 21 Oct 2020 20:57:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/22] vl: move bios_name out of softmmu/vl.c
Date: Wed, 21 Oct 2020 16:57:06 -0400
Message-Id: <20201021205716.2359430-13-pbonzini@redhat.com>
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

bios_name is a legacy variable used by machine code.  Hide it
from softmmu/vl.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c | 5 +++++
 softmmu/vl.c      | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3c674bb05e..e4dac350d4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -212,6 +212,8 @@ GlobalProperty hw_compat_2_1[] = {
 };
 const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
 
+const char *bios_name = NULL;
+
 static char *machine_get_kernel(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -396,6 +398,9 @@ static void machine_set_firmware(Object *obj, const char *value, Error **errp)
 
     g_free(ms->firmware);
     ms->firmware = g_strdup(value);
+
+    /* HACK */
+    bios_name = ms->firmware;
 }
 
 static void machine_set_suppress_vmdesc(Object *obj, bool value, Error **errp)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 52e7d317d7..e32e209a82 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -123,7 +123,6 @@ static int data_dir_idx;
 static const char *mem_path;
 static const char *boot_order;
 static const char *boot_once;
-const char *bios_name = NULL;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
 const char* keyboard_layout = NULL;
@@ -4314,7 +4313,6 @@ void qemu_init(int argc, char **argv, char **envp)
     kernel_filename = qemu_opt_get(machine_opts, "kernel");
     initrd_filename = qemu_opt_get(machine_opts, "initrd");
     kernel_cmdline = qemu_opt_get(machine_opts, "append");
-    bios_name = qemu_opt_get(machine_opts, "firmware");
 
     opts = qemu_opts_find(qemu_find_opts("boot-opts"), NULL);
     if (opts) {
-- 
2.26.2



