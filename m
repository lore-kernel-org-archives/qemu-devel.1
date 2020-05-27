Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D5FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB9E20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GtgW6IkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB9E20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdosc-0006QS-2w
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolp-0001Lq-W9; Wed, 27 May 2020 01:38:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolo-0001gD-R0; Wed, 27 May 2020 01:38:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03r67ZGz9sTS; Wed, 27 May 2020 15:38:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557896;
 bh=mTRQ3UkFdW4Cd5hGSYESFKYSCtE5pkmUVvHesx/YgEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GtgW6IkZshUDlvq31wFtyFfpHey/Pc87a5JyuHEWblXslapzaXowwsHNtSpEomWLm
 NWgyovf5iGuUe/epVT1pl3aKXT35VbwIz/IM1zqJgoUfgrNNTnZFNbB5aPMjSjgACn
 B0u8Pt12BFXYod7Cs73FIWoX8I8x/md9/gH2QIFU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/15] vfio/nvlink: Remove exec permission to avoid SELinux AVCs
Date: Wed, 27 May 2020 15:38:09 +1000
Message-Id: <20200527053809.356168-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, Leonardo Bras <leobras.c@gmail.com>,
 qemu-devel@nongnu.org, groug@kaod.org,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Leonardo Bras <leobras.c@gmail.com>

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
Message-Id: <20200501055448.286518-1-leobras.c@gmail.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/vfio/pci-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 3bd05fed12..f2155ddb1d 100644
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
2.26.2


