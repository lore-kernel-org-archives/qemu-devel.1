Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98756C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193EB2168B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aB6XbuTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193EB2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3gm-0008Hf-0v
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3WB-00048J-FF
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W8-0007z9-6J
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONUppsAWFdB2ocGm/TxWIPzW/UrNtelTjJmplh/WUcg=;
 b=aB6XbuTKO8lkv2iKOoOFRj1GZu2JfI0MzX3oYgJ7oRtfigYNPxj/jk+vqTEOwtFT+wrRNK
 JqnRju9WrJb3p2bYqKt7GJQrR3PxkdeEGp0GZJVZCZdyu3IgyRVwf35IQw1FgP+ZV+1mih
 JsAJLCZE5eGj2DAIsIoN1vn26dJmbXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-63z2rjjBNsixKGfX4bS6wQ-1; Mon, 26 Oct 2020 10:30:33 -0400
X-MC-Unique: 63z2rjjBNsixKGfX4bS6wQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24BD2CFF3C;
 Mon, 26 Oct 2020 14:30:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACF1C1002391;
 Mon, 26 Oct 2020 14:30:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/15] lm32: remove bios_name
Date: Mon, 26 Oct 2020 10:30:19 -0400
Message-Id: <20201026143028.3034018-7-pbonzini@redhat.com>
In-Reply-To: <20201026143028.3034018-1-pbonzini@redhat.com>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: Michael Walle <michael@walle.cc>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/lm32/milkymist.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 9f8fe9fef1..c5d3d77a2b 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -108,6 +108,7 @@ static void
 milkymist_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const char *bios_name = machine->firmware ? BIOS_FILENAME:
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -162,9 +163,6 @@ milkymist_init(MachineState *machine)
     }
 
     /* load bios rom */
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
     bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
 
     if (bios_filename) {
-- 
2.26.2



