Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E54FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BAD20738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGsLWnqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BAD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94qa-00075a-Go
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94EE-00037S-Ee
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94E8-0001ja-Ts
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6T+Fp5nse2UFE2qjL4ASZPlrj+hnm8DBvwFbw6WgtmQ=;
 b=BGsLWnqXBzpXWAoM3qSiXxcGj/CdjYVAY6KrYrhO8O/mM/RxzsmmpZd04RhbRN5ko5lDB5
 cg/4jZ6vTBi926lHJWC7I3ma7R6WNNQ29vXfRPG7qReqoTyh3Ig83NfPKuV+tMKJhtzM48
 WTycFv/FBmaspglB0GW6FT2T/JmWOlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-XP56TcNKNZC-n4OmwY4e9Q-1; Fri, 21 Aug 2020 06:24:50 -0400
X-MC-Unique: XP56TcNKNZC-n4OmwY4e9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFBDD100CF71
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF9BC795AE
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 098/152] meson: convert hw/rtc
Date: Fri, 21 Aug 2020 06:22:35 -0400
Message-Id: <20200821102329.29777-99-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index 70ecaa8135..f60fd019ac 100644
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
index 50b26db852..1fb1687e1e 100644
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
index e4c1b8617c..0000000000
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
index 0000000000..7cecdee5dd
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
2.26.2



