Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F23FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27806206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMtsiP68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27806206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv6g-00046V-RT
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihur0-0007jE-Ce
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqz-0007OA-5U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuqy-0007Kf-R9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/Ros+mNcR5fE9uxCniasjkjIaqEW1g0XSIhc7929kw=;
 b=MMtsiP68xH2ssf+sM9uOpShRdD5D/YhsWoEikWXh+VLgXEisap0qz26eT5rvuWazW5E2DB
 2UVjNUlWcz2vTkoXljS3Ha3qe+iVDGho+DXA+vf/RjZza4KeA8Ye1N00HCCxehs9/V25nr
 k4XGmTdA/zU5hIU0+fmBOJtCDJzaCMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-YgwqJ5MHNAabUA0GkAphjw-1; Thu, 19 Dec 2019 07:24:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33B47477
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:26 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 165E860C18;
 Thu, 19 Dec 2019 12:24:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 101/132] meson: convert hw/adc
Date: Thu, 19 Dec 2019 13:23:21 +0100
Message-Id: <1576758232-12439-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YgwqJ5MHNAabUA0GkAphjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/adc/Makefile.objs | 1 -
 hw/adc/meson.build   | 1 +
 hw/meson.build       | 1 +
 4 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 hw/adc/Makefile.objs
 create mode 100644 hw/adc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c69c3aa..5823867 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,7 +1,6 @@
 ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$=
(CONFIG_XEN))) +=3D 9pfs/
 devices-dirs-y +=3D acpi/
-devices-dirs-y +=3D adc/
 endif
=20
 common-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/adc/Makefile.objs b/hw/adc/Makefile.objs
deleted file mode 100644
index 3f6dfde..0000000
--- a/hw/adc/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_STM32F2XX_ADC) +=3D stm32f2xx_adc.o
diff --git a/hw/adc/meson.build b/hw/adc/meson.build
new file mode 100644
index 0000000..2e7fea9
--- /dev/null
+++ b/hw/adc/meson.build
@@ -0,0 +1 @@
+specific_ss.add(when: 'CONFIG_STM32F2XX_ADC', if_true: files('stm32f2xx_ad=
c.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 011139d..33d5f9f 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('adc')
 subdir('audio')
 subdir('block')
 subdir('bt')
--=20
1.8.3.1



