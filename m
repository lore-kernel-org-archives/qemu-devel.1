Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D347DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7EB204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOAlpN1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7EB204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WRh-0001tR-Rt
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnL-0006q9-Bi
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39378
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnH-00032J-W9
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zJ/gMBs+ekLNo528KUwmyOGqZXXOiNxoFGixHsiJLc=;
 b=BOAlpN1maQZZkuS+LmAeT0WX+9NUEktoSNPbEyr1jVEOQGu91O0JTH5/9o3GfyCVkFAB0o
 k5fLpjIgwwR8JuFtgh8VBwgA4jA3aUJeFt2uCAfNFFOctfj+SZKtG+7j6XwMNG378rMMEA
 h03Xca75WA4vPM7YKXYnNpraQU2/E04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-HiYUV5nGMA-99B7Y8wZGWw-1; Fri, 14 Aug 2020 05:14:33 -0400
X-MC-Unique: HiYUV5nGMA-99B7Y8wZGWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 611291015DBF
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1221E600E4;
 Fri, 14 Aug 2020 09:14:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 089/150] meson: convert hw/smbios
Date: Fri, 14 Aug 2020 05:12:25 -0400
Message-Id: <20200814091326.16173-90-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:30
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs        |  1 -
 hw/meson.build          |  1 +
 hw/smbios/Makefile.objs | 10 ----------
 hw/smbios/meson.build   | 13 +++++++++++++
 4 files changed, 14 insertions(+), 11 deletions(-)
 delete mode 100644 hw/smbios/Makefile.objs
 create mode 100644 hw/smbios/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 86bc201a55..73c49ddd3b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-y += smbios/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 03ef30212e..dccc2d19a6 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
 subdir('nubus')
 subdir('semihosting')
+subdir('smbios')
 subdir('xen')
diff --git a/hw/smbios/Makefile.objs b/hw/smbios/Makefile.objs
deleted file mode 100644
index 23bb2bac07..0000000000
--- a/hw/smbios/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-ifeq ($(CONFIG_SMBIOS),y)
-common-obj-y += smbios.o
-common-obj-$(CONFIG_IPMI) += smbios_type_38.o
-common-obj-$(call lnot,$(CONFIG_IPMI)) += smbios_type_38-stub.o
-else
-common-obj-y += smbios-stub.o
-endif
-
-common-obj-$(CONFIG_ALL) += smbios-stub.o
-common-obj-$(CONFIG_ALL) += smbios_type_38-stub.o
diff --git a/hw/smbios/meson.build b/hw/smbios/meson.build
new file mode 100644
index 0000000000..9e762c7108
--- /dev/null
+++ b/hw/smbios/meson.build
@@ -0,0 +1,13 @@
+smbios_ss = ss.source_set()
+smbios_ss.add(files('smbios.c'))
+smbios_ss.add(when: 'CONFIG_IPMI',
+              if_true: files('smbios_type_38.c'),
+              if_false: files('smbios_type_38-stub.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_SMBIOS', if_true: smbios_ss)
+softmmu_ss.add(when: 'CONFIG_SMBIOS', if_false: files('smbios-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files(
+  'smbios-stub.c',
+  'smbios_type_38-stub.c',
+))
-- 
2.26.2



