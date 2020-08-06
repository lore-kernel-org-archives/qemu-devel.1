Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A89C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4665B2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPKzrJgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4665B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3m0p-0003B4-2N
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPw-0008O7-10
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28905
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPu-0006hu-4L
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=lMOKj2JUkDjiKQzhyDxdSKswLl4CNUMxR1j4M1JHaXA=;
 b=FPKzrJgR9+BA18bzNs6u03VVXFNZ39waYB4qx2unzvKlP/fbRmjz0lXUBNZ6e4yhfR2j9a
 XQjGFv/ZchZFdiw7sIHYBunnTFRjwahgbujtOtW+sy2LBZSorX6gYEwlzUtJk9AEj3UPx2
 BNiag7LM9skMtqsZGM+pikX6Xabps5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-V2w65rgkPmmbtSSSZiKsUQ-1; Thu, 06 Aug 2020 15:19:03 -0400
X-MC-Unique: V2w65rgkPmmbtSSSZiKsUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12171DE2
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:19:02 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05F345F9DC
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:19:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 093/143] meson: convert hw/rtc
Date: Thu,  6 Aug 2020 21:15:29 +0200
Message-Id: <1596741379-12902-94-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/rtc/Makefile.objs | 15 ---------------
 hw/rtc/meson.build   | 16 ++++++++++++++++
 4 files changed, 17 insertions(+), 16 deletions(-)
 delete mode 100644 hw/rtc/Makefile.objs
 create mode 100644 hw/rtc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 70ecaa8..f60fd01 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -24,7 +24,6 @@ devices-dirs-y += nvram/
 devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
-devices-dirs-y += rtc/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
diff --git a/hw/meson.build b/hw/meson.build
index 50b26db..1fb1687 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('rtc')
 subdir('semihosting')
 subdir('smbios')
 subdir('timer')
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
deleted file mode 100644
index e4c1b86..0000000
--- a/hw/rtc/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-common-obj-$(CONFIG_DS1338) += ds1338.o
-common-obj-$(CONFIG_M41T80) += m41t80.o
-common-obj-$(CONFIG_M48T59) += m48t59.o
-ifeq ($(CONFIG_ISA_BUS),y)
-common-obj-$(CONFIG_M48T59) += m48t59-isa.o
-endif
-common-obj-$(CONFIG_PL031) += pl031.o
-common-obj-$(CONFIG_TWL92230) += twl92230.o
-common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
-obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
-common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_rtc.o
-common-obj-$(CONFIG_GOLDFISH_RTC) += goldfish_rtc.o
-common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-rtc.o
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
new file mode 100644
index 0000000..7cecdee
--- /dev/null
+++ b/hw/rtc/meson.build
@@ -0,0 +1,16 @@
+
+softmmu_ss.add(when: 'CONFIG_DS1338', if_true: files('ds1338.c'))
+softmmu_ss.add(when: 'CONFIG_M41T80', if_true: files('m41t80.c'))
+softmmu_ss.add(when: 'CONFIG_M48T59', if_true: files('m48t59.c'))
+softmmu_ss.add(when: 'CONFIG_PL031', if_true: files('pl031.c'))
+softmmu_ss.add(when: 'CONFIG_TWL92230', if_true: files('twl92230.c'))
+softmmu_ss.add(when: ['CONFIG_ISA_BUS', 'CONFIG_M48T59'], if_true: files('m48t59-isa.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-rtc.c'))
+
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_rtc.c'))
+softmmu_ss.add(when: 'CONFIG_SUN4V_RTC', if_true: files('sun4v-rtc.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_rtc.c'))
+softmmu_ss.add(when: 'CONFIG_GOLDFISH_RTC', if_true: files('goldfish_rtc.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
+
+specific_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
-- 
1.8.3.1



