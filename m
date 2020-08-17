Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915DFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B86622CB3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEOI1ML8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B86622CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hD5-0007gW-JW
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKk-0003EJ-R6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKj-0006sE-4x
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GR2JAOoihvMbG8M0xyCavn1TY8P5bNTcVFUjDnvW2RU=;
 b=AEOI1ML8AMkS/+bT6T0oBmQ/uKLlO0uutjD5DdsAZraF/Hf8Wt242R37L+b0z4fGvnR8Vv
 Tw7du7YSesCeKitA0Q+dHnN4QDIRrQ28EeqWPDhVo61UZ9VOQ/HqQ+mqfVR22TWSS2bCyt
 HJIIty5HQzjxujJ8A/G+o+BGOl8rtKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-3bR2_RPFMSObNsAHDlrVxQ-1; Mon, 17 Aug 2020 10:41:55 -0400
X-MC-Unique: 3bR2_RPFMSObNsAHDlrVxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2727C1800D41
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:54 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52BAD70C3E;
 Mon, 17 Aug 2020 14:41:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 122/150] meson: convert hw/audio
Date: Mon, 17 Aug 2020 16:40:25 +0200
Message-Id: <20200817144053.345107-27-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs       |  1 -
 hw/audio/Makefile.objs | 18 ------------------
 hw/audio/meson.build   | 14 ++++++++++++++
 hw/meson.build         |  1 +
 4 files changed, 15 insertions(+), 19 deletions(-)
 delete mode 100644 hw/audio/Makefile.objs
 create mode 100644 hw/audio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 9068859ef0..c0cbc0f132 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -2,7 +2,6 @@ ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-y += acpi/
 devices-dirs-y += adc/
-devices-dirs-y += audio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
deleted file mode 100644
index 63db383709..0000000000
--- a/hw/audio/Makefile.objs
+++ /dev/null
@@ -1,18 +0,0 @@
-# Sound
-common-obj-$(CONFIG_SB16) += sb16.o
-common-obj-$(CONFIG_ES1370) += es1370.o
-common-obj-$(CONFIG_AC97) += ac97.o
-common-obj-$(CONFIG_ADLIB) += fmopl.o adlib.o
-common-obj-$(CONFIG_GUS) += gus.o gusemu_hal.o gusemu_mixer.o
-common-obj-$(CONFIG_CS4231A) += cs4231a.o
-common-obj-$(CONFIG_HDA) += intel-hda.o hda-codec.o
-
-common-obj-$(CONFIG_PCSPK) += pcspk.o
-common-obj-$(CONFIG_WM8750) += wm8750.o
-common-obj-$(CONFIG_PL041) += pl041.o lm4549.o
-
-common-obj-$(CONFIG_CS4231) += cs4231.o
-common-obj-$(CONFIG_MARVELL_88W8618) += marvell_88w8618.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-ac97.o
-
-common-obj-y += soundhw.o
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
new file mode 100644
index 0000000000..549e9a0396
--- /dev/null
+++ b/hw/audio/meson.build
@@ -0,0 +1,14 @@
+softmmu_ss.add(files('soundhw.c'))
+softmmu_ss.add(when: 'CONFIG_AC97', if_true: files('ac97.c'))
+softmmu_ss.add(when: 'CONFIG_ADLIB', if_true: files('fmopl.c', 'adlib.c'))
+softmmu_ss.add(when: 'CONFIG_CS4231', if_true: files('cs4231.c'))
+softmmu_ss.add(when: 'CONFIG_CS4231A', if_true: files('cs4231a.c'))
+softmmu_ss.add(when: 'CONFIG_ES1370', if_true: files('es1370.c'))
+softmmu_ss.add(when: 'CONFIG_GUS', if_true: files('gus.c', 'gusemu_hal.c', 'gusemu_mixer.c'))
+softmmu_ss.add(when: 'CONFIG_HDA', if_true: files('intel-hda.c', 'hda-codec.c'))
+softmmu_ss.add(when: 'CONFIG_MARVELL_88W8618', if_true: files('marvell_88w8618.c'))
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-ac97.c'))
+softmmu_ss.add(when: 'CONFIG_PCSPK', if_true: files('pcspk.c'))
+softmmu_ss.add(when: 'CONFIG_PL041', if_true: files('pl041.c', 'lm4549.c'))
+softmmu_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
+softmmu_ss.add(when: 'CONFIG_WM8750', if_true: files('wm8750.c'))
diff --git a/hw/meson.build b/hw/meson.build
index f968aa8374..624335be90 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('audio')
 subdir('block')
 subdir('char')
 subdir('core')
-- 
2.26.2



