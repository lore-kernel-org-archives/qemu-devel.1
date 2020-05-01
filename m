Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48855C47259
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B592166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIsV0dRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B592166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUQos-0001Ee-6d
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 04:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leobras.c@gmail.com>) id 1jUQoH-0000lG-Bt
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <leobras.c@gmail.com>) id 1jUQoG-0004q5-5i
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:14:13 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:38339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jUQoF-0004mP-Om
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:14:11 -0400
Received: by mail-qv1-xf44.google.com with SMTP id t8so4413966qvw.5
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yqdQSm5HKFMcNAbMy3ZH3ZLdi0ilQskpltu3/v0pGdo=;
 b=SIsV0dRYibhlVMxHxtV2tdFckFHDsr8ZwAGHcpkM0Pd5+m/MDw3e0Oi0ZzR94lBraw
 SS5uuBUTUZ7lEmuthfQJRXByRSdgLL9jl3fQgTgk0uTtlUvYdnY2zc5Z3p35P/dfDBmM
 2Hd+C/Qih4pGnktebMiFF3OFD0w6p/OV2p7fHljLp/KIYuG0fBG8wQzJCQXgZ64xBQhl
 PwKaWyYTkEzqsv2KhuJxIFl5jV7ETVJHEsq1kjAKIjTdUntvs13UMOLA5fgXPLgtuInd
 qwQ/0MaZ8c5vBc9knMMxMFIOWZtJVfHEU4H09PDPrf5YgF6f6tTUP1QZAX2np1ElMmNH
 TLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yqdQSm5HKFMcNAbMy3ZH3ZLdi0ilQskpltu3/v0pGdo=;
 b=e1QGi+zFbHl7WTmLqexRGM4kE7nuLhcdOHw99qpzf8tscLWZnYCZQ0uImANgPnukGD
 0tp8It66LfsR1smCOo6ch10V/uU+WCbjGJryah7CmyCBcR8zTwDyqPOmc9xfYZxr0mjF
 yXJZadEErLg1X9MQdinFWyG33DsbwiJtNM0bWjZX3MMNRRC91CTMe8XZQc2AKFLM+4DP
 bQ7f9crBAUzommgV9IJgV9p9ZDSg2+DFbpNWO7eRg8mmHaVIhwB6HgxwtIgSdTBSv5O1
 xucFBZdMx4tILHz2ebsCtNgFqu35ml0NnP80Kk88QVYSQDcByDPkpaur+n5bZVFBP6xK
 IruQ==
X-Gm-Message-State: AGi0PubaGzgvS8NA7SDdg+NQDguGH3LM3OZ/vP06q6EdgpKZ6q64SkKu
 1Opo/zZTklWyOf9enc7JsNI=
X-Google-Smtp-Source: APiQypJmcT8bMJRL56txtCLAw0rmD12iBPV5x1ESqwsuQTfZ5YMihaDH3t1zkF8suWtalPovt1MyNA==
X-Received: by 2002:a05:6214:493:: with SMTP id
 ay19mr2738626qvb.152.1588320850885; 
 Fri, 01 May 2020 01:14:10 -0700 (PDT)
Received: from localhost.localdomain (179-125-207-208.dynamic.desktop.com.br.
 [179.125.207.208])
 by smtp.gmail.com with ESMTPSA id j90sm2067405qte.20.2020.05.01.01.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 01:14:10 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [RESEND PATCH 1/1] vfio/nvlink: Remove exec permission to avoid
 SELinux AVCs
Date: Fri,  1 May 2020 05:11:24 -0300
Message-Id: <20200501081123.290414-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=leobras.c@gmail.com; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::f44
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
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

---
- Resend because it, for some reason, did not hit the list.
- Alexey's review is here: https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg00006.html

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


