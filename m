Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D793C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA4B206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="iqo6Ro0/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wou//Cyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA4B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i67U1-0003hq-NB
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 02:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1i67SY-0002UB-RW
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1i67SX-0003jF-OC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52513)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1i67SX-0003iy-KZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:01 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 698C921FA7;
 Fri,  6 Sep 2019 02:11:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 06 Sep 2019 02:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
 jyRveru0QqdLTJB7DWF/j5mPF0ZWpnIR0PdUBneWBbg=; b=iqo6Ro0/0hQGk0Vz
 j3GG9VvzmiMok1XWM6jra2m6vFcbNlagZVgVmmpGQKyH6S8kfAm4xTJeig/X3W8m
 ImU9pebrGel7I0yr80oq47Rb9RsHYPbOQeEUN7gbqRsgplBPqTOGmpfl+JIFnfWt
 AftDOHI5rLq3nBndiH/30oHoi1a1tUwVdo+g4dcDbMWzYz66FEOZOFkU0l3VnznG
 iUM3/5hCaWFbKwEJT30RudCNDbJjSdJLDZrrnHmewuhuDCJmLiZnp0hGBLHnZT2U
 WXQ5C+IBAc3wowpRtJAKnNkB/fiFI+9ALRwT53aIE8aMU071QeTgr8I43HcyBFSf
 nUNzbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=jyRveru0QqdLTJB7DWF/j5mPF0ZWpnIR0PdUBneWB
 bg=; b=Wou//CytpZ+MquIzLpvv9pI7W9ZdabwEo5dD2B69vesI2jezl6XHXoGCh
 mkysnCQPQUyu46aYbmiFoKAdmSNUQJjKIihWaP3b34rLhILdPeN59x1wCZXsWXjf
 UYRrVGkGTLuxoP5AAAj4gPPSoYyqNOCNzioIXe/8xnoQMViOg9a57vGEzR/Zb5nA
 nW5jw+IyQYTpUv6x0PCfVFTcaEKn+qw5S+3ZrQX4G5VoqGxs7Xa0/3V836w6lMG2
 lLbscKvxyPXSv+2J1y3gNOHpHX6McyT/BEfa3RIVeInEjYvYnPY6raPgnfIGzePq
 CHZy7ZTS9FyHFzCIAEoftdDD0NByg==
X-ME-Sender: <xms:dfhxXURdW5Rs65wBgFgJhbHO3HdfKKloci2hvUfVk7gE28hk4ZUgXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtke
 ertdertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishht
 rghirhesrghlihhsthgrihhrvdefrdhmvgeqnecukfhppeejfedrleefrdekgedrvddtke
 enucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdv
 fedrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:dfhxXeG6DPVAMT6ke1B0KyYw1YMfm97duZ-lUAsW9e7gBDtI-gJbzw>
 <xmx:dfhxXUnBvDods2DUVxjXPAtUKwZpcVBCgmQP50-20hg0WEAstp_ebQ>
 <xmx:dfhxXZ2B5e3l9ltg36KETF6m9hnqaHIXkqWap0BaHpCxlW0HkPoh7w>
 <xmx:dfhxXXGC7A4W_ErBt7VTNuTzLz5pPEPT3pGB2T8c-KVVsGMKOAYStg>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id BA9B1D60057;
 Fri,  6 Sep 2019 02:11:00 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Thu,  5 Sep 2019 23:11:00 -0700
Message-Id: <f67393406c16d561f6a046c2ddb050c6955a1b7e.1567750222.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567750222.git.alistair@alistair23.me>
References: <cover.1567750222.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: [Qemu-devel] [PATCH v4 1/6] armv7m: Allow entry information to be
 returned
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the kernel's entry point information to be returned when loading a
kernel.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/armv7m.c       | 4 +++-
 include/hw/arm/boot.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7a3c48f002..40755d77db 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -306,7 +306,7 @@ static void armv7m_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
+uint64_t armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
 {
     int image_size;
     uint64_t entry;
@@ -353,6 +353,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
      * board must call this function!
      */
     qemu_register_reset(armv7m_reset, cpu);
+
+    return entry;
 }
 
 static Property bitband_properties[] = {
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 7f4d0ca7cd..e35b83c0d2 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -27,11 +27,13 @@ typedef enum {
  * @kernel_filename: file to load
  * @mem_size: mem_size: maximum image size to load
  *
+ * returns: location of the kernel's entry point
+ *
  * Load the guest image for an ARMv7M system. This must be called by
  * any ARMv7M board. (This is necessary to ensure that the CPU resets
  * correctly on system reset, as well as for kernel loading.)
  */
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
+uint64_t armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
 
 /* arm_boot.c */
 struct arm_boot_info {
-- 
2.22.0


