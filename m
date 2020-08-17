Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661E4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317B223A51
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuhCq1pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317B223A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h2J-0001mt-C7
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gK3-0002Cr-LE
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gK1-0006oc-Lv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsKD/IZ/ybi+/QCUoBcf65hoizOPZc27Qg+cQlKIV4c=;
 b=XuhCq1pPngHLAh+DnHD97/9RhhoYlJSqwCOe0GHt3DVZ3/Gdv6lZ6FdCp936In0rDwPUon
 FxIHpZ10qAxJRhAN3j3s8kKBve1V227OTs+BXAnCjov9JfDNgtj3ndMm98Bg4Q180q1Fn9
 oOhbXMDxMlgbC2jFVguzocomq/l9dco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-D1_y8iPwMtqKvpLA7bx-Ag-1; Mon, 17 Aug 2020 10:41:11 -0400
X-MC-Unique: D1_y8iPwMtqKvpLA7bx-Ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B869F801ADB
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:09 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF80470C3D;
 Mon, 17 Aug 2020 14:41:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 104/150] meson: convert hw/nvram
Date: Mon, 17 Aug 2020 16:40:07 +0200
Message-Id: <20200817144053.345107-9-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs       | 1 -
 hw/meson.build         | 1 +
 hw/nvram/Makefile.objs | 8 --------
 hw/nvram/meson.build   | 9 +++++++++
 4 files changed, 10 insertions(+), 9 deletions(-)
 delete mode 100644 hw/nvram/Makefile.objs
 create mode 100644 hw/nvram/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 20832841d2..78860ae9c7 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -20,7 +20,6 @@ devices-dirs-y += isa/
 devices-dirs-y += misc/
 devices-dirs-y += net/
 devices-dirs-y += rdma/
-devices-dirs-y += nvram/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 53c347c395..0bdd6a2613 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('nvram')
 subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
deleted file mode 100644
index f3ad921382..0000000000
--- a/hw/nvram/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-common-obj-$(CONFIG_DS1225Y) += ds1225y.o
-common-obj-$(CONFIG_NMC93XX_EEPROM) += eeprom93xx.o
-common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
-common-obj-y += fw_cfg.o
-common-obj-$(CONFIG_CHRP_NVRAM) += chrp_nvram.o
-common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
-common-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
-obj-$(CONFIG_PSERIES) += spapr_nvram.o
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
new file mode 100644
index 0000000000..ba214558ac
--- /dev/null
+++ b/hw/nvram/meson.build
@@ -0,0 +1,9 @@
+softmmu_ss.add(files('fw_cfg.c'))
+softmmu_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
+softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
+softmmu_ss.add(when: 'CONFIG_NMC93XX_EEPROM', if_true: files('eeprom93xx.c'))
+softmmu_ss.add(when: 'CONFIG_AT24C', if_true: files('eeprom_at24c.c'))
+softmmu_ss.add(when: 'CONFIG_MAC_NVRAM', if_true: files('mac_nvram.c'))
+softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_nvm.c'))
+
+specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
-- 
2.26.2



