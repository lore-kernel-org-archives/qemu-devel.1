Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D90C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26AD02083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TejuTH99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AD02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeh8-0000Og-4J
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaece-0003PY-BU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:44:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaecb-0000o1-Jx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604580248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbMTJ3ao+EWjH5At6//uqbDIysge1ZWepFJJby54Ojc=;
 b=TejuTH9920bcI7T+xcFaDVuWStu4stW0pKpoeEuDTbJL9OuNMHUShwug78YHqxeb0qzws+
 KjmHMYmkkbeJ1CQjWdkAAzMLYQ4qTYvOFerT24v5QvQWwdHKT09blqDcCIWEkdXiWlkGpM
 vw7P/jaCpKRlqkmRflJxnLqQZoiWux4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-1wHUrP3KO2K2t2iaEqwpLQ-1; Thu, 05 Nov 2020 07:44:03 -0500
X-MC-Unique: 1wHUrP3KO2K2t2iaEqwpLQ-1
Received: by mail-wr1-f69.google.com with SMTP id w6so683436wrk.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QbMTJ3ao+EWjH5At6//uqbDIysge1ZWepFJJby54Ojc=;
 b=o7ZURse8V3HaZl8REv1rI2s5ODJZzQKtyl4LdCUyo/4zcyNmUSkv1k2Ob4TH5K6htZ
 gHF1LRv0zk41p0PKZpY33BDDU/lNpsP1eliDmmseIq4IPbbxIbiBXkT5WcbrU8fcs6BG
 JyTPEYMSm2/LPZen/TFdbTfMV0GqKyc+uwaJduqiA3ANAllnapmvAqXc2vKHjuXGpGRr
 KdbgQwue51tT3I+sHo+kzqaptQEGVoInQJSMdARORVZSXO++QZWXh5Abj2Idk1PpJWK+
 fW0WlFyfq/aFd+URKKaKJxwqZz/MODJsooZeoQG+1eTqefKP4QHSiCJI01GsZt76vWq6
 gWCQ==
X-Gm-Message-State: AOAM5301nvd6v+eoiN9CWvx7n3AEZ3sIPrZrCDN0sp0EMeLuu/SN2d8z
 Ylci8QejnXdo20UvpNKGtJNSulliEG/SeTlMtqRnddfTPUVLnf3BP9MNJ+T+MsB8GYCEfwSkwHY
 Q+NW8F4WHyWLNhFU=
X-Received: by 2002:adf:f285:: with SMTP id k5mr2710331wro.299.1604580241680; 
 Thu, 05 Nov 2020 04:44:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDBKXqoZGV6QVR06D/ZHdIYvVnb7Xr/YHMllDCX1Blc96HXFdWLgRfsrKSWKsSK/e2UxC/qA==
X-Received: by 2002:adf:f285:: with SMTP id k5mr2710301wro.299.1604580241450; 
 Thu, 05 Nov 2020 04:44:01 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e5sm2170548wrw.93.2020.11.05.04.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:44:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 1/3] hw/virtio: Add configure switch to disable legacy
 VIRTIO
Date: Thu,  5 Nov 2020 13:43:51 +0100
Message-Id: <20201105124353.3680057-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105124353.3680057-1-philmd@redhat.com>
References: <20201105124353.3680057-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per [1] (Terminology):

  Legacy interfaces are not required; ie. don’t implement them
  unless you have a need for backwards compatibility!

[2] (Version 1.0):

  The device configuration space uses the little-endian format
  for multi-byte fields.

and [3] (Legacy Interface):

  for legacy interfaces, device configuration space is generally
  the guest’s native endian, rather than PCI’s little-endian.
  The correct endian-ness is documented for each device.

Add the --disable-virtio-legacy configure flag to produce builds
with VIRTIO 1.0 only, and the --enable-virtio-legacy to include
legacy VIRTIO support (supporting legacy VIRTIO is the default).

[1] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-60001
[2] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-170003
[3] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-200003

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure                         | 10 ++++++++++
 meson.build                       |  1 +
 include/hw/virtio/virtio-access.h | 19 +++++--------------
 hw/virtio/virtio-legacy.c         | 29 +++++++++++++++++++++++++++++
 hw/virtio/meson.build             |  1 +
 5 files changed, 46 insertions(+), 14 deletions(-)
 create mode 100644 hw/virtio/virtio-legacy.c

diff --git a/configure b/configure
index 2c3c69f1188..f46216b3788 100755
--- a/configure
+++ b/configure
@@ -302,6 +302,7 @@ fdt="auto"
 netmap="no"
 sdl="auto"
 sdl_image="auto"
+virtio_legacy="enabled"
 virtiofsd="auto"
 virtfs=""
 libudev="auto"
@@ -1001,6 +1002,10 @@ for opt do
   ;;
   --enable-libudev) libudev="enabled"
   ;;
+  --disable-virtio-legacy) virtio_legacy="disabled"
+  ;;
+  --enable-virtio-legacy) virtio_legacy="enabled"
+  ;;
   --disable-virtiofsd) virtiofsd="disabled"
   ;;
   --enable-virtiofsd) virtiofsd="enabled"
@@ -1764,6 +1769,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vnc-png         PNG compression for VNC server
   cocoa           Cocoa UI (Mac OS X only)
   virtfs          VirtFS
+  virtio-legacy   enable support for legacy virtio (before VIRTIO 1.0)
   virtiofsd       build virtiofs daemon (virtiofsd)
   libudev         Use libudev to enumerate host devices
   mpath           Multipath persistent reservation passthrough
@@ -6816,6 +6822,10 @@ if test "$safe_stack" = "yes"; then
   echo "CONFIG_SAFESTACK=y" >> $config_host_mak
 fi
 
+if test "$virtio_legacy" = "enabled"; then
+  echo "CONFIG_VIRTIO_LEGACY=y" >> $config_host_mak
+fi
+
 # If we're using a separate build tree, set it up now.
 # DIRS are directories which we simply mkdir in the build tree;
 # LINKS are things to symlink back into the source tree
diff --git a/meson.build b/meson.build
index 39ac5cf6d8a..51406c28c6e 100644
--- a/meson.build
+++ b/meson.build
@@ -2061,6 +2061,7 @@
 summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
 summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
 summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
+summary_info += {'Legacy VIRTIO support': config_host.has_key('CONFIG_VIRTIO_LEGACY')}
 summary_info += {'build virtiofs daemon': have_virtiofsd}
 summary_info += {'Multipath support': mpathpersist.found()}
 summary_info += {'VNC support':       vnc.found()}
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 6818a23a2d3..b6c060f8cc6 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -20,24 +20,15 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
+#ifdef CONFIG_VIRTIO_LEGACY
+bool virtio_access_is_big_endian(VirtIODevice *vdev);
+#else
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
-#elif defined(TARGET_WORDS_BIGENDIAN)
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
-    }
-    return true;
-#else
+    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
     return false;
-#endif
 }
+#endif
 
 static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
 {
diff --git a/hw/virtio/virtio-legacy.c b/hw/virtio/virtio-legacy.c
new file mode 100644
index 00000000000..bf28c824a25
--- /dev/null
+++ b/hw/virtio/virtio-legacy.c
@@ -0,0 +1,29 @@
+/*
+ * Legacy virtio endian helpers.
+ *
+ * Copyright Red Hat, Inc. 2020
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-access.h"
+
+#if defined(TARGET_PPC64) || defined(TARGET_ARM)
+# define LEGACY_VIRTIO_IS_BIENDIAN 1
+#endif
+
+bool virtio_access_is_big_endian(VirtIODevice *vdev)
+{
+#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
+    return virtio_is_big_endian(vdev);
+#elif defined(TARGET_WORDS_BIGENDIAN)
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+        return false;
+    }
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index fbff9bc9d4d..95415913a9a 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -11,6 +11,7 @@
 
 virtio_ss = ss.source_set()
 virtio_ss.add(files('virtio.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_LEGACY', if_true: files('virtio-legacy.c'))
 virtio_ss.add(when: 'CONFIG_VHOST', if_true: files('vhost.c', 'vhost-backend.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa.c'))
-- 
2.26.2


