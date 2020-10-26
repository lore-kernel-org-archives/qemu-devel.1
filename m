Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943A0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDA622263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNcZxmy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDA622263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3lb-0006AD-4Z
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3WE-0004GU-PT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3WC-00080T-Su
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ET+rXC0AcJAQhzp2Gghq1VFYQ/vRNne+hjXiB0oh9pg=;
 b=dNcZxmy7d771NCTOEIUIX+lfNG4skNQ2K/39m/0xEQ/HfObDgMAfWsho9T10XAYtMrgkVt
 JaSGAJK58YDf9XazevuSkUX+cU7z+JvtUHZpVUrpHJ4lwun46ZZE2hmj8B+bx12jCaFOOd
 GtH8GV7hTib5vmE97E3acy/zSjWthf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-OpBy43SxMxqlAgLo_ON9cQ-1; Mon, 26 Oct 2020 10:30:37 -0400
X-MC-Unique: OpBy43SxMxqlAgLo_ON9cQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8422EC134;
 Mon, 26 Oct 2020 14:30:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26FBB5C1C2;
 Mon, 26 Oct 2020 14:30:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/15] sparc: remove bios_name
Date: Mon, 26 Oct 2020 10:30:27 -0400
Message-Id: <20201026143028.3034018-15-pbonzini@redhat.com>
In-Reply-To: <20201026143028.3034018-1-pbonzini@redhat.com>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sparc/leon3.c   | 4 +---
 hw/sparc/sun4m.c   | 2 +-
 hw/sparc64/sun4u.c | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d40b7891f6..1c50b02f81 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -185,6 +185,7 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
 static void leon3_generic_hw_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
+    const char *bios_name = machine->firmware ?: LEON3_PROM_FILENAME;
     const char *kernel_filename = machine->kernel_filename;
     SPARCCPU *cpu;
     CPUSPARCState   *env;
@@ -259,9 +260,6 @@ static void leon3_generic_hw_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET, prom);
 
     /* Load boot prom */
-    if (bios_name == NULL) {
-        bios_name = LEON3_PROM_FILENAME;
-    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
 
     if (filename) {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 38d1e0fd12..81d4ae9385 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -878,7 +878,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
                         hwdef->max_mem - machine->ram_size);
     }
 
-    prom_init(hwdef->slavio_base, bios_name);
+    prom_init(hwdef->slavio_base, machine->firmware);
 
     slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
                                        hwdef->intctl_base + 0x10000ULL,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 05e659c8a4..50230d261a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -578,7 +578,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     /* set up devices */
     ram_init(0, machine->ram_size);
 
-    prom_init(hwdef->prom_addr, bios_name);
+    prom_init(hwdef->prom_addr, machine->firmware);
 
     /* Init sabre (PCI host bridge) */
     sabre = SABRE(qdev_new(TYPE_SABRE));
-- 
2.26.2



