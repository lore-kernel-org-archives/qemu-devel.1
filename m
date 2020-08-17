Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0939623D4E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a35PHzUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0939623D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h6m-0002Br-57
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKN-0002oz-5w
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37501
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKK-0006qK-8X
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9FavuJqmxsGLhsOxpQUaI0es2WjXRSahOLPo6Hf8MQ=;
 b=a35PHzUfF+68fh8FMkc5vU7imgc/btEfgpWGwIrq/nC8bFC7tDignIfSebnVTqPpr25AGe
 28FjTvDc+RAEeNDvKgHvYRvkswbjK+5v5oVKt+2JZAeZnJDQBGALnx4vJvCnfNv2W89yAV
 xVP2aFzM8Tjb5l81jRmHC+S3omZxZdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-69-KUK-wNUqzOAuxdHVkjA-1; Mon, 17 Aug 2020 10:41:29 -0400
X-MC-Unique: 69-KUK-wNUqzOAuxdHVkjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEFDE185E524
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:28 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41C1570C3D;
 Mon, 17 Aug 2020 14:41:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 112/150] meson: convert hw/input
Date: Mon, 17 Aug 2020 16:40:15 +0200
Message-Id: <20200817144053.345107-17-pbonzini@redhat.com>
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
 hw/Makefile.objs       |  1 -
 hw/input/Makefile.objs | 18 ------------------
 hw/input/meson.build   | 18 ++++++++++++++++++
 hw/meson.build         |  1 +
 4 files changed, 19 insertions(+), 19 deletions(-)
 delete mode 100644 hw/input/Makefile.objs
 create mode 100644 hw/input/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 80b104168a..3feccd83d7 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -12,7 +12,6 @@ devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
-devices-dirs-y += input/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
deleted file mode 100644
index abc1ff03c0..0000000000
--- a/hw/input/Makefile.objs
+++ /dev/null
@@ -1,18 +0,0 @@
-common-obj-$(CONFIG_ADB) += adb.o adb-mouse.o adb-kbd.o
-common-obj-y += hid.o
-common-obj-$(CONFIG_LM832X) += lm832x.o
-common-obj-$(CONFIG_PCKBD) += pckbd.o
-common-obj-$(CONFIG_PL050) += pl050.o
-common-obj-$(CONFIG_PS2) += ps2.o
-common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
-common-obj-$(CONFIG_TSC2005) += tsc2005.o
-
-common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input.o
-common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-hid.o
-common-obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host.o
-common-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input.o
-
-common-obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
-common-obj-$(CONFIG_PXA2XX) += pxa2xx_keypad.o
-common-obj-$(CONFIG_TSC210X) += tsc210x.o
-common-obj-$(CONFIG_LASIPS2) += lasips2.o
diff --git a/hw/input/meson.build b/hw/input/meson.build
new file mode 100644
index 0000000000..e7285b15ae
--- /dev/null
+++ b/hw/input/meson.build
@@ -0,0 +1,18 @@
+softmmu_ss.add(files('hid.c'))
+softmmu_ss.add(when: 'CONFIG_ADB', if_true: files('adb.c', 'adb-mouse.c', 'adb-kbd.c'))
+softmmu_ss.add(when: 'CONFIG_LM832X', if_true: files('lm832x.c'))
+softmmu_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
+softmmu_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
+softmmu_ss.add(when: 'CONFIG_PS2', if_true: files('ps2.c'))
+softmmu_ss.add(when: 'CONFIG_STELLARIS_INPUT', if_true: files('stellaris_input.c'))
+softmmu_ss.add(when: 'CONFIG_TSC2005', if_true: files('tsc2005.c'))
+
+softmmu_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-hid.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host.c'))
+softmmu_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
+
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-softusb.c'))
+softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_keypad.c'))
+softmmu_ss.add(when: 'CONFIG_TSC210X', if_true: files('tsc210x.c'))
+softmmu_ss.add(when: 'CONFIG_LASIPS2', if_true: files('lasips2.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 986e710287..b15c8d0970 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('input')
 subdir('intc')
 subdir('ipack')
 subdir('ipmi')
-- 
2.26.2



