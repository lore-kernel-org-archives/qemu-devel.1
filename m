Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC01C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F7720825
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K75oSbZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F7720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gzZ-0004a8-5X
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKH-0002jo-3a
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKF-0006pn-7D
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6IcjMD7wz7lT8tuax07AyeIM3dMjwWq36Mk98KP+2C0=;
 b=K75oSbZpC/W7TQm2BlzBQ8yHDt0ipZDXLY5Y48Nfq4AioAewPw5QDKE7qQXu4H2M+ec7vE
 DJ4YCTbuwRwXg4+yA4a6qmOepZHJnwshCfOV6gXCu+/XsdHmkclw+e+AImuad9PMVvvLHj
 RSUmKrshMhdGacPPZ0Iw1Ok0puVK6PI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-jeqF8-ZsOaCUq0y0c307lw-1; Mon, 17 Aug 2020 10:41:24 -0400
X-MC-Unique: jeqF8-ZsOaCUq0y0c307lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1FB6801AC3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:23 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1BBA756AB;
 Mon, 17 Aug 2020 14:41:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 108/150] meson: convert hw/isa
Date: Mon, 17 Aug 2020 16:40:11 +0200
Message-Id: <20200817144053.345107-13-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
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
 hw/Makefile.objs     |  1 -
 hw/isa/Makefile.objs | 11 -----------
 hw/isa/meson.build   | 11 +++++++++++
 hw/meson.build       |  1 +
 4 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 hw/isa/Makefile.objs
 create mode 100644 hw/isa/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ac8278edf7..a28e211e78 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -16,7 +16,6 @@ devices-dirs-y += input/
 devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
-devices-dirs-y += isa/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
deleted file mode 100644
index 8e73960a75..0000000000
--- a/hw/isa/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_SUPERIO) += isa-superio.o
-common-obj-$(CONFIG_APM) += apm.o
-common-obj-$(CONFIG_I82378) += i82378.o
-common-obj-$(CONFIG_PC87312) += pc87312.o
-common-obj-$(CONFIG_PIIX3) += piix3.o
-common-obj-$(CONFIG_PIIX4) += piix4.o
-common-obj-$(CONFIG_VT82C686) += vt82c686.o
-common-obj-$(CONFIG_SMC37C669) += smc37c669-superio.o
-
-obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
new file mode 100644
index 0000000000..8bf678ca0a
--- /dev/null
+++ b/hw/isa/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(when: 'CONFIG_APM', if_true: files('apm.c'))
+softmmu_ss.add(when: 'CONFIG_I82378', if_true: files('i82378.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
+softmmu_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
+softmmu_ss.add(when: 'CONFIG_PIIX3', if_true: files('piix3.c'))
+softmmu_ss.add(when: 'CONFIG_PIIX4', if_true: files('piix4.c'))
+softmmu_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
+softmmu_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
+
+specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 6ca82b0375..86598544e6 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('isa')
 subdir('mem')
 subdir('misc')
 subdir('net')
-- 
2.26.2



