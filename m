Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40181C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8B82080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIRCUyxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8B82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CDN-0001t6-4r
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLc-0002wb-T2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLY-0003ID-DV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4zUtG2BrTOmP13fH7T0/kK5F7ny8mbMrnn7XYfvatdE=;
 b=EIRCUyxb49h/ZrhOHBXTyzRmpvSVn0Lp7UtjFIyePzmPQtEb/Y72S9sXDnI9ZGRu8NZ1tC
 0/ffw8RtDVB1BBCM9gT43kYhkND49OyGqvK1ZrRGwcVuOO8B5S8di+9E+4f28ZsLkw807J
 YepRQz2JiM4+7yGuV8QqwmWqhknAJb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-pQoyj3PUP6SFEaNmsOOL2A-1; Mon, 10 Aug 2020 13:12:25 -0400
X-MC-Unique: pQoyj3PUP6SFEaNmsOOL2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53C1580183C
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:24 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 612555F1E9;
 Mon, 10 Aug 2020 17:12:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 117/147] meson: convert hw/cpu
Date: Mon, 10 Aug 2020 19:08:35 +0200
Message-Id: <1597079345-42801-118-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
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
 hw/Makefile.objs     | 1 -
 hw/cpu/Makefile.objs | 5 -----
 hw/cpu/meson.build   | 6 ++++++
 hw/meson.build       | 1 +
 4 files changed, 7 insertions(+), 6 deletions(-)
 delete mode 100644 hw/cpu/Makefile.objs
 create mode 100644 hw/cpu/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6fce6a1..97ad302 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -5,7 +5,6 @@ devices-dirs-y += adc/
 devices-dirs-y += audio/
 devices-dirs-y += block/
 devices-dirs-y += char/
-devices-dirs-y += cpu/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/cpu/Makefile.objs b/hw/cpu/Makefile.objs
deleted file mode 100644
index 8db9e8a..0000000
--- a/hw/cpu/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(CONFIG_ARM11MPCORE) += arm11mpcore.o
-obj-$(CONFIG_REALVIEW) += realview_mpcore.o
-obj-$(CONFIG_A9MPCORE) += a9mpcore.o
-obj-$(CONFIG_A15MPCORE) += a15mpcore.o
-common-obj-y += core.o cluster.o
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
new file mode 100644
index 0000000..9e52fee
--- /dev/null
+++ b/hw/cpu/meson.build
@@ -0,0 +1,6 @@
+softmmu_ss.add(files('core.c', 'cluster.c'))
+
+specific_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
+specific_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
+specific_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
+specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
diff --git a/hw/meson.build b/hw/meson.build
index dacd26c..103da48 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('cpu')
 subdir('display')
 subdir('dma')
 subdir('gpio')
-- 
1.8.3.1



