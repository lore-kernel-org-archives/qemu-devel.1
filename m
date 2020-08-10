Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEDEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFD92065C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PirhrkPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFD92065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bgf-0005yf-8N
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJr-0008HT-U7
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJp-00030D-UI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2P8D7Lc7ZtZoGC3w4qeh3vy0JHVE2eHklOeBmAj68Zc=;
 b=PirhrkPw6HHIPTYYZ7GPCRTgu51sb76wfdOnNOnQcpvgkq0kolJqZoLFPWuZsueiYF3F1S
 ix3iaSEgWwGKlQwnjrocCAoMmu6UUHcCHMvxQifYu/aTQ6bVfg2u3KBF9pUe08AgyokbiX
 5/GeMdV3BDzgb+YNHdMwYHJpqzQmHvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-2dCq8jJ5PumnjLxyiXwhvQ-1; Mon, 10 Aug 2020 13:10:39 -0400
X-MC-Unique: 2dCq8jJ5PumnjLxyiXwhvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A4B291299
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:38 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3762D8BD67;
 Mon, 10 Aug 2020 17:10:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 055/147] meson: convert io directory to Meson
Date: Mon, 10 Aug 2020 19:07:33 +0200
Message-Id: <1597079345-42801-56-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
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
 Makefile         |  1 -
 Makefile.objs    |  2 +-
 Makefile.target  |  2 +-
 io/Makefile.objs | 12 ------------
 io/meson.build   | 25 +++++++++++++++++++++++++
 meson.build      |  1 +
 6 files changed, 28 insertions(+), 15 deletions(-)
 delete mode 100644 io/Makefile.objs
 create mode 100644 io/meson.build

diff --git a/Makefile b/Makefile
index d26ad4c..8fe446b 100644
--- a/Makefile
+++ b/Makefile
@@ -230,7 +230,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-m \
                 storage-daemon-obj-y \
                 storage-daemon-obj-m \
-                io-obj-y \
                 common-obj-y \
                 common-obj-m)
 
diff --git a/Makefile.objs b/Makefile.objs
index 018338d..0920cdb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,7 +21,7 @@ block-obj-m = block/
 
 crypto-obj-y = crypto/libcrypto.fa
 
-io-obj-y = io/
+io-obj-y = io/libio.fa
 
 endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 
diff --git a/Makefile.target b/Makefile.target
index b213955..f6b7a86 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -194,12 +194,12 @@ include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
               crypto-obj-y \
+              io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
-               io-obj-y \
                common-obj-y \
                common-obj-m)
 all-obj-y += $(common-obj-y)
diff --git a/io/Makefile.objs b/io/Makefile.objs
deleted file mode 100644
index 9a20fce..0000000
--- a/io/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-io-obj-y = channel.o
-io-obj-y += channel-buffer.o
-io-obj-y += channel-command.o
-io-obj-y += channel-file.o
-io-obj-y += channel-socket.o
-io-obj-y += channel-tls.o
-io-obj-y += channel-watch.o
-io-obj-y += channel-websock.o
-io-obj-y += channel-util.o
-io-obj-y += dns-resolver.o
-io-obj-y += net-listener.o
-io-obj-y += task.o
diff --git a/io/meson.build b/io/meson.build
new file mode 100644
index 0000000..062e011
--- /dev/null
+++ b/io/meson.build
@@ -0,0 +1,25 @@
+io_ss = ss.source_set()
+io_ss.add(genh)
+io_ss.add(files(
+  'channel-buffer.c',
+  'channel-command.c',
+  'channel-file.c',
+  'channel-socket.c',
+  'channel-tls.c',
+  'channel-util.c',
+  'channel-watch.c',
+  'channel-websock.c',
+  'channel.c',
+  'dns-resolver.c',
+  'net-listener.c',
+  'task.c',
+))
+
+io_ss = io_ss.apply(config_host, strict: false)
+libio = static_library('io', io_ss.sources(),
+                       dependencies: [io_ss.dependencies()],
+                       link_with: libqemuutil,
+                       name_suffix: 'fa',
+                       build_by_default: false)
+
+io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
diff --git a/meson.build b/meson.build
index 8d46944..5c4bf16 100644
--- a/meson.build
+++ b/meson.build
@@ -325,6 +325,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+subdir('io')
 subdir('fsdev')
 
 # Other build targets
-- 
1.8.3.1



