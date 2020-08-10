Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454A3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007A522CF6
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EY9TrVPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007A522CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bjv-00057D-5B
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BK1-0000CB-C2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJz-000328-9l
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBsIv/N8xjVu6qt5Ue0OAE7NqVFKHkJbIndev6SmYrk=;
 b=EY9TrVPP4CExvkfq9sgW5ASkU6M+XFtig3sldmN/jU7+p+tY83qCL20YRGOjb95Oxrut3M
 FxkM8UtLTIQSxIz1W9v+LgX5tPQ5PZRj1vOOYgWfqnS28+HusB0jPXXVU8STpMC8Bcrrgt
 oNl50+sjPalVXE3aLiAUoIIfUlITHOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-HfftLunhNRmWC25K5MHl2Q-1; Mon, 10 Aug 2020 13:10:48 -0400
X-MC-Unique: HfftLunhNRmWC25K5MHl2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDC04100CCC6
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:47 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAFE65F1E9;
 Mon, 10 Aug 2020 17:10:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 060/147] meson: convert chardev directory to Meson (tools part)
Date: Mon, 10 Aug 2020 19:07:38 +0200
Message-Id: <1597079345-42801-61-git-send-email-pbonzini@redhat.com>
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
index 6d58b43..bd54901 100644
--- a/Makefile
+++ b/Makefile
@@ -166,7 +166,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
                 storage-daemon-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 0920cdb..297bd5b 100644
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
index d1d8906..6b9de09 100644
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
index 3783dad..6662d0d 100644
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
index 0000000..a2e671d
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
index ccf5a63..aa813a2 100644
--- a/meson.build
+++ b/meson.build
@@ -442,6 +442,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
 subdir('io')
+subdir('chardev')
 subdir('fsdev')
 subdir('target')
 
-- 
1.8.3.1



