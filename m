Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE1C2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuKmFsNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE1C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82qs-0002Kj-7k
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kz-0004W3-5a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48236
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Ks-0007Sq-7l
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oC0Ae4vV4d9FKcrgLCXkMmOiIlKmUqM6HeeNJGlSGTE=;
 b=JuKmFsNKGXK72H6VAMO1STwaphs291n0w6MG7oPhm2G34siABMJC1N8tGw4iHulXbPYefO
 pXhlGq3WGufLPtx+5hlggk1JzaUQRAbQRABlynSenovaX5fku1bxWPKXN12by0A0wr96gv
 rxZpj00C5W4KxxmgeadyMyYQBtr34Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-cv2dJZJfNQWU0bwobwZp5Q-1; Tue, 18 Aug 2020 10:11:30 -0400
X-MC-Unique: cv2dJZJfNQWU0bwobwZp5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1900C100A955
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC48B5D757;
 Tue, 18 Aug 2020 14:11:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 063/150] meson: convert chardev directory to Meson (tools part)
Date: Tue, 18 Aug 2020 10:08:58 -0400
Message-Id: <20200818141025.21608-64-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  1 -
 Makefile.objs         |  4 ++--
 Makefile.target       |  2 +-
 chardev/Makefile.objs | 19 -------------------
 chardev/meson.build   | 32 ++++++++++++++++++++++++++++++++
 meson.build           |  1 +
 6 files changed, 36 insertions(+), 23 deletions(-)
 create mode 100644 chardev/meson.build

diff --git a/Makefile b/Makefile
index a126963ab0..aaa0c3156b 100644
--- a/Makefile
+++ b/Makefile
@@ -173,7 +173,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
                 storage-daemon-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 0920cdb40c..297bd5beeb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -7,8 +7,6 @@ qom-obj-y = qom/libqom.fa
 
 ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
 
-chardev-obj-y = chardev/
-
 authz-obj-y = authz/libauthz.fa
 authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
@@ -19,6 +17,8 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
+chardev-obj-y = chardev/libchardev.fa
+
 crypto-obj-y = crypto/libcrypto.fa
 
 io-obj-y = io/libio.fa
diff --git a/Makefile.target b/Makefile.target
index d1d8906b4d..6b9de09df5 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -199,13 +199,13 @@ common-obj-m :=
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
+              chardev-obj-y \
               crypto-obj-y \
               io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
-               chardev-obj-y \
                common-obj-y \
                common-obj-m)
 all-obj-y += $(common-obj-y)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 3783dadc4c..6662d0df41 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,23 +1,4 @@
-chardev-obj-y += char.o
 chardev-obj-$(CONFIG_SOFTMMU) += chardev-sysemu.o
-chardev-obj-$(CONFIG_WIN32) += char-console.o
-chardev-obj-$(CONFIG_POSIX) += char-fd.o
-chardev-obj-y += char-fe.o
-chardev-obj-y += char-file.o
-chardev-obj-y += char-io.o
-chardev-obj-y += char-mux.o
-chardev-obj-y += char-null.o
-chardev-obj-$(CONFIG_POSIX) += char-parallel.o
-chardev-obj-y += char-pipe.o
-chardev-obj-$(CONFIG_POSIX) += char-pty.o
-chardev-obj-y += char-ringbuf.o
-chardev-obj-y += char-serial.o
-chardev-obj-y += char-socket.o
-chardev-obj-y += char-stdio.o
-chardev-obj-y += char-udp.o
-chardev-obj-$(CONFIG_WIN32) += char-win.o
-chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
-
 common-obj-$(CONFIG_SOFTMMU) += msmouse.o wctablet.o testdev.o
 
 ifeq ($(CONFIG_BRLAPI),y)
diff --git a/chardev/meson.build b/chardev/meson.build
new file mode 100644
index 0000000000..a2e671ddfc
--- /dev/null
+++ b/chardev/meson.build
@@ -0,0 +1,32 @@
+chardev_ss = ss.source_set()
+chardev_ss.add(files(
+  'char-fe.c',
+  'char-file.c',
+  'char-io.c',
+  'char-mux.c',
+  'char-null.c',
+  'char-pipe.c',
+  'char-ringbuf.c',
+  'char-serial.c',
+  'char-socket.c',
+  'char-stdio.c',
+  'char-udp.c',
+  'char.c',
+))
+chardev_ss.add(when: 'CONFIG_POSIX', if_true: files(
+  'char-fd.c',
+  'char-parallel.c',
+  'char-pty.c',
+))
+chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
+  'char-console.c',
+  'char-win-stdio.c',
+  'char-win.c',
+))
+
+chardev_ss = chardev_ss.apply(config_host, strict: false)
+libchardev = static_library('chardev', chardev_ss.sources(),
+                            name_suffix: 'fa',
+                            build_by_default: false)
+
+chardev = declare_dependency(link_whole: libchardev)
diff --git a/meson.build b/meson.build
index bbb691ffa9..11ece643fc 100644
--- a/meson.build
+++ b/meson.build
@@ -451,6 +451,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
 subdir('io')
+subdir('chardev')
 subdir('fsdev')
 subdir('target')
 
-- 
2.26.2



