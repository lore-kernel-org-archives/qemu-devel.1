Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D2C83006
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 03:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1957920731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 03:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5oRsmOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1957920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTd5h-0003S0-7H
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 23:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTd4S-0001yM-Ar
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTd1c-0006ap-MZ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:07:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jTd1c-0006aX-AC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 23:04:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id f13so642915wrm.13
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qRzsulywIjE+sQcPoBEKngALHTHNWGcwn3UAFri5+Is=;
 b=B5oRsmOxxtULX0ELvlErFeZeY0jak0zTDw+T63dGQmt8YuEujgUo5u+ir5d7gG3q7b
 Hvri0SdTK51dwZCcRpky83W1etxumYRvsNFey41OECwRVZLsKA4Vh1iGEqcirnik+pS/
 szJVElSA3+3/MF+CVST65JqGVCfNJFJ13WZ78y/8v5YsiPP4jXZgKTGpFSV1Wm8dgxDo
 IDC+89MFvelQhTdaOtZVVm9HMmQXBv1ODxhFOQG0+xAoA1cNHLVByWacU6QBzgFMf+e4
 3FL9wXYnFlyWytZpMjh1IPXLcwyJk1D5ZiE2/nQjpoqCX5dUZG0s4VBCkquww1F21hae
 mw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qRzsulywIjE+sQcPoBEKngALHTHNWGcwn3UAFri5+Is=;
 b=gaLxYf1XvWlNcQVhcXyIjW3n5JdXG+7d4W67AJOgizJOORDsYlMXrXQnWNZYkikVmC
 R9XIPFdjy2z3rc2NdPmMI2/wyIHY/h99/jpDgpnZRpy/EUF5GcfDItwKdc/ZDnh6l9yo
 WClyI2LLebMc6SXvxKXHKvnlLOMTkoIm/F9l8ZJAIqVsRvbxpdpJ2eYGqax3QFsxnifZ
 0Yb9THf3qov6u5nVpBOvD6IoOdLC6sGs5mp76VUZvwq5r2xP0BLTfQqlhV0To+mzER1d
 bNSnuX0Gwte1xVHqnVP+XF70OsVQxUsP1JT6ux1cUwu8j1OCYxhv/UYl+Jx9plpgSb08
 1VBw==
X-Gm-Message-State: AGi0PubJPg89eW1Ifk9Tec7dZOQkrRl4gJMb1y81IIsZprAABh/AruXV
 xunX5n+RSnWIJwsOOeLC3wMgD54ZOLJBuQ==
X-Google-Smtp-Source: APiQypKtASVRZtrLSNfnMWkMLsFzDJUoGhbpBBFcLg/HpdRqjRqKpuxw46KWnaiyvF30jck0ZguBLw==
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr36701072wrs.415.1588129478643; 
 Tue, 28 Apr 2020 20:04:38 -0700 (PDT)
Received: from localhost.localdomain (public-gprs636909.centertel.pl.
 [5.184.31.46])
 by smtp.gmail.com with ESMTPSA id o6sm19713725wrw.63.2020.04.28.20.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 20:04:38 -0700 (PDT)
From: Grzegorz Uriasz <gorbak25@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] Fix undefined behaviour
Date: Wed, 29 Apr 2020 03:04:08 +0000
Message-Id: <20200429030409.9406-2-gorbak25@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200429030409.9406-1-gorbak25@gmail.com>
References: <20200429030409.9406-1-gorbak25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=gorbak25@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: artur@puzio.waw.pl, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, Grzegorz Uriasz <gorbak25@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes qemu crashes when passing through an IGD device to HVM guests under XEN. The problem is that on almost every laptop
reading the IGD ROM from SYSFS will fail, the reason for it is that the IGD rom is polymorphic and it modifies itself
during bootup - this results in an invalid rom image - the kernel checks whether the image is valid and when that's not the case
it won't allow userspace to read it. It seems that when the code was first written(xen_pt_load_rom.c) the kernel's back then didn't check
whether the rom is valid and just passed the contents to userspace - because of this qemu also tries to repair the rom later in the code.
When stating the rom the kernel isn't validating the rom contents so it is returning the proper size of the rom(32 4kb pages).

This results in undefined behaviour - pci_assign_dev_load_option_rom is creating a buffer and then writes the size of the buffer to a pointer.
In pci_assign_dev_load_option_rom under old kernels if the fstat would succeed then fread would also succeed - this means if the buffer
is allocated the size of the buffer will be set. On newer kernels this is not the case - on all laptops I've tested(spanning a few
generations of IGD) the fstat is successful and the buffer is allocated but the fread is failing - as the buffer is not deallocated
the function is returning a valid pointer without setting the size of the buffer for the caller. The caller of pci_assign_dev_load_option_rom
is holding the size of the buffer in an uninitialized variable and is just checking whether pci_assign_dev_load_option_rom returned a valid pointer.
This later results in cpu_physical_memory_write(0xc0000, result_of_pci_assign_dev_load_option_rom, unitialized_variable) which
depending on the compiler parameters, configure flags, etc... might crash qemu or might work - the xen 4.12 stable release with default configure
parameters works but changing the compiler options slightly(for instance by enabling qemu debug) results in qemu crashing ¯\_(;-;)_/¯

The only situation when the original pci_assign_dev_load_option_rom works is when the IDG is not the boot gpu - this won't happen on any laptop and
will be rare on desktops.

This patch deallocates the buffer and returns NULL if reading the VBIOS fails - the caller of the function then properly shuts down qemu.
The next patch in the series introduces a better method for getting the vbios so qemu does not exit when pci_assign_dev_load_option_rom fails -
this is the reason I've changed error_report to warn_report as whether a failure in pci_assign_dev_load_option_rom is fatal
depends on the caller.

Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
---
 hw/xen/xen_pt_load_rom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index a50a80837e..9f100dc159 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -38,12 +38,12 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     fp = fopen(rom_file, "r+");
     if (fp == NULL) {
         if (errno != ENOENT) {
-            error_report("pci-assign: Cannot open %s: %s", rom_file, strerror(errno));
+            warn_report("pci-assign: Cannot open %s: %s", rom_file, strerror(errno));
         }
         return NULL;
     }
     if (fstat(fileno(fp), &st) == -1) {
-        error_report("pci-assign: Cannot stat %s: %s", rom_file, strerror(errno));
+        warn_report("pci-assign: Cannot stat %s: %s", rom_file, strerror(errno));
         goto close_rom;
     }
 
@@ -59,10 +59,9 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     memset(ptr, 0xff, st.st_size);
 
     if (!fread(ptr, 1, st.st_size, fp)) {
-        error_report("pci-assign: Cannot read from host %s", rom_file);
-        error_printf("Device option ROM contents are probably invalid "
-                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
-                     "or load from file with romfile=\n");
+        warn_report("pci-assign: Cannot read from host %s", rom_file);
+        memory_region_unref(&dev->rom);
+        ptr = NULL;
         goto close_rom;
     }
 
-- 
2.26.1


