Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C47DC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B33F205C9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzpRU1tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B33F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUVzm-0008HQ-Ft
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 09:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leobras.c@gmail.com>) id 1jUOe1-0008MA-F0
 for qemu-devel@nongnu.org; Fri, 01 May 2020 01:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <leobras.c@gmail.com>) id 1jUOdz-0001kB-A9
 for qemu-devel@nongnu.org; Fri, 01 May 2020 01:55:29 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jUOdy-0001gQ-Sg
 for qemu-devel@nongnu.org; Fri, 01 May 2020 01:55:26 -0400
Received: by mail-qt1-x841.google.com with SMTP id x12so7219940qts.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 22:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JsQN2/VkTGWt3fEGMBVqHYnPkuZqVM77AdnxwiOX2dc=;
 b=IzpRU1tj8QWxoBCxeom4lZAv4CnxuCdmKbkSpi1mqkhZaeqfEKkTgUwcoh0b/vJB2r
 6KjhH3LHau9SEXHtz2F5dA7l3xMyqT9E2U1WXj8U0q1uSD4i/kq7dc+o+UMZclAIaR7W
 vz2fygL0f0rVpsxnfMFXm1TkBBGL44wXIKBlLyVrXc8hT+k47if3uidrB+iQ07sL0OvU
 Cr7ByYs7n7q18JJ9/XRI7AZ+UCZKB7eW4zvUzMzfI3RHIQG4I5AUAWtJ24oauRnt/ZH4
 +ZBt6a0V5Il+6PdpT4LewbiWL59uv9rX6nsIyPu1GN057d+58IiBmovNQtGTtvSwy407
 H2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JsQN2/VkTGWt3fEGMBVqHYnPkuZqVM77AdnxwiOX2dc=;
 b=FGFLRxedCQlMzYJq+hqJMBi5dK97PXd8jQUEta9AaIgrOmLPp15efmFQf/nxpaKnKC
 9kzZCjHirxAVvwqS+IjkSHYwOM3MowOPRfwvx2BBxzYJX5zdAOf9JKSpv7TvmMgMXzX3
 vD57E66Cx60K4qQBhASm1AkbgaGqWMjyliIC1cHHPDTPLOHavwdsXyb2Ew7w3w1lENTv
 /6n/CKGZWaSVAus5TeNr0UFkRvGq8oxH7ULZ/jjjEYAadOsjwVUwsoOFTvOFaXqpjhmx
 cXJVwLSh26lsNN6C0ancCaPi3jNicAUo45LlhN3y+0Jm73XAmGmNn4sAHyUoFcz0B05y
 RkSA==
X-Gm-Message-State: AGi0PuaaWcuUBkXDOyUUqz6mmB2Ip/tVcePnPNZZFpBgoQWpj8lzaOSO
 gJL1k7kUjroxxNCCl3FAJuo=
X-Google-Smtp-Source: APiQypKRzH6hKf24tjJt4zWathWwXWdFdnCvUFTMmLoQqf1Ucu47RiG0CslCnVZdRWseE18WYzvIBw==
X-Received: by 2002:ac8:6902:: with SMTP id e2mr2122282qtr.214.1588312525953; 
 Thu, 30 Apr 2020 22:55:25 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com
 (179-125-207-208.dynamic.desktop.com.br. [179.125.207.208])
 by smtp.gmail.com with ESMTPSA id m33sm1944312qte.17.2020.04.30.22.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 22:55:25 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 1/1] vfio/nvlink: Remove exec permission to avoid SELinux AVCs
Date: Fri,  1 May 2020 02:54:49 -0300
Message-Id: <20200501055448.286518-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=leobras.c@gmail.com; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::841
X-Mailman-Approved-At: Fri, 01 May 2020 09:45:19 -0400
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
Cc: Leonardo Bras <leobras.c@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If SELinux is setup without 'execmem' permission for qemu, all mmap
with (PROT_WRITE | PROT_EXEC) will fail and print a warning in
SELinux log.

If "nvlink2-mr" memory allocation fails (fist diff), it will cause
guest NUMA nodes to not be correctly configured (V100 memory will
not be visible for guest, nor its NUMA nodes).

Not having 'execmem' permission is intesting for virtual machines to
avoid buffer-overflow based attacks, and it's adopted in distros
like RHEL.

So, removing the PROT_EXEC flag seems the right thing to do.

Browsing some other code that mmaps memory for usage with
memory_region_init_ram_device_ptr, I could notice it's usual to
not have PROT_EXEC (only PROT_READ | PROT_WRITE), so it should be
no problem around this.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 hw/vfio/pci-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 2d348f8237..124d4f57e1 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1620,7 +1620,7 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
     }
     cap = (void *) hdr;
 
-    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
+    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE,
              MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
     if (p == MAP_FAILED) {
         ret = -errno;
@@ -1680,7 +1680,7 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
 
     /* Some NVLink bridges may not have assigned ATSD */
     if (atsdreg->size) {
-        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
+        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE,
                  MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
         if (p == MAP_FAILED) {
             ret = -errno;
-- 
2.25.4


