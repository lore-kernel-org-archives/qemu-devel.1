Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA87FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A3D206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ2f23KI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A3D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorci-0001bO-17
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorSQ-0006he-0x
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:44:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorSO-00078Q-4g
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593189843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jopcFLzYJYJJslTMVzSauZtrYKoS/LSXGVIDKJZrsog=;
 b=HJ2f23KIwLF4+EjkZFYIrwj8CYbhyMY9zBcisMhCTa4+1eeD/Rp8SIx8ZOag/O3uu7Nk/q
 9eXecoH8l2/HstjVWlpt6FFjpstPnpYnosUcVy4YWnGs0LuNSGzQZiwRUEUMZG6hl3Ol4s
 MoiddkG3ma1cl44hZjA6XkYNJexMnaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-VuqSWe4OO9Or-vvCL_rZBg-1; Fri, 26 Jun 2020 12:44:02 -0400
X-MC-Unique: VuqSWe4OO9Or-vvCL_rZBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 527FA1005512;
 Fri, 26 Jun 2020 16:44:00 +0000 (UTC)
Received: from turbo.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 969A65C1BB;
 Fri, 26 Jun 2020 16:43:49 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] build: Add SPICE_CFLAGS and SPICE_LIBS to relevant files
Date: Fri, 26 Jun 2020 18:43:05 +0200
Message-Id: <20200626164307.3327380-9-dinechin@redhat.com>
In-Reply-To: <20200626164307.3327380-1-dinechin@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of adding the spice build flags to the top-level build
options, add them where they are necessary. This is a step to move the
burden of linking with spice libraries away from the top-level qemu.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 configure                |  4 ++--
 hw/display/Makefile.objs |  1 +
 hw/i386/Makefile.objs    |  1 +
 monitor/Makefile.objs    |  3 +++
 softmmu/Makefile.objs    |  2 +-
 stubs/Makefile.objs      |  2 +-
 ui/Makefile.objs         |  4 ++--
 util/module.c            | 13 +++++++++++--
 8 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 2de1715800..ac83aea242 100755
--- a/configure
+++ b/configure
@@ -5148,8 +5148,6 @@ EOF
      $pkg_config --atleast-version=0.12.3 spice-protocol && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice="yes"
-    libs_softmmu="$libs_softmmu $spice_libs"
-    QEMU_CFLAGS="$QEMU_CFLAGS $spice_cflags"
     spice_protocol_version=$($pkg_config --modversion spice-protocol)
     spice_server_version=$($pkg_config --modversion spice-server)
   else
@@ -7472,6 +7470,8 @@ fi
 
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=m" >> $config_host_mak
+  echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
+  echo "SPICE_LIBS=$spice_libs" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index f51411619b..273a956d96 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -46,6 +46,7 @@ obj-$(CONFIG_VGA) += vga.o
 
 common-obj-$(CONFIG_QXL:y=m) += qxl.mo
 qxl.mo-objs := qxl.o qxl-logger.o qxl-render.o
+qxl.mo-cflags += $(SPICE_CFLAGS)
 
 obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
 obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 6abc74551a..bf9856be2a 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -2,6 +2,7 @@ obj-$(CONFIG_KVM) += kvm/
 obj-y += e820_memory_layout.o multiboot.o
 obj-y += x86.o
 obj-$(CONFIG_PC) += pc.o pc_sysfw.o
+pc.o-cflags += $(SPICE_CFLAGS)
 obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
 obj-$(CONFIG_MICROVM) += microvm.o
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index a8533c9dd7..fd58d80195 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -2,5 +2,8 @@ obj-y += misc.o
 common-obj-y += monitor.o qmp.o hmp.o
 common-obj-y += qmp-cmds.o qmp-cmds-control.o
 common-obj-y += hmp-cmds.o
+qmp-cmds.o-cflags += $(SPICE_CFLAGS)
+hmp-cmds.o-cflags += $(SPICE_CFLAGS)
+misc.o-cflags += $(SPICE_CFLAGS)
 
 storage-daemon-obj-y += monitor.o qmp.o qmp-cmds-control.o
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index dd15c24346..0e7605bd32 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,3 +1,3 @@
 softmmu-main-y = softmmu/main.o
 obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
+vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS) $(SPICE_CFLAGS)
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f32b9e47a3..1df8bb3814 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -19,10 +19,10 @@ stub-obj-y += replay.o
 stub-obj-y += runstate-check.o
 stub-obj-$(CONFIG_SOFTMMU) += semihost.o
 stub-obj-y += set-fd-handler.o
-stub-obj-y += vmgenid.o
 stub-obj-y += sysbus.o
 stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
+stub-obj-y += vmgenid.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 1ab515e23d..6a6fda2f06 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -57,8 +57,8 @@ spice-app.mo-objs += spice-core.o spice-input.o spice-display.o
 ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),ym)
 spice-app.mo-objs += spice-app.o
 endif
-spice-app.mo-cflags := $(GIO_CFLAGS)
-spice-app.mo-libs := $(GIO_LIBS)
+spice-app.mo-cflags := $(GIO_CFLAGS) $(SPICE_CFLAGS)
+spice-app.mo-libs := $(GIO_LIBS) $(SPICE_LIBS)
 
 common-obj-$(CONFIG_OPENGL) += shader.o
 common-obj-$(CONFIG_OPENGL) += console-gl.o
diff --git a/util/module.c b/util/module.c
index 2fa93561fe..29b4806520 100644
--- a/util/module.c
+++ b/util/module.c
@@ -22,11 +22,11 @@
 #ifdef CONFIG_MODULE_UPGRADES
 #include "qemu-version.h"
 #endif
-#ifdef CONFIG_TRACE_RECORDER
 #include "trace/recorder.h"
-#endif
 
 
+RECORDER(modules, 16, "QEMU load modules");
+
 typedef struct ModuleEntry
 {
     void (*init)(void);
@@ -85,6 +85,15 @@ void register_dso_module_init(void (*fn)(void), module_init_type type)
 {
     ModuleEntry *e;
 
+#ifdef CONFIG_TRACE_RECORDER
+    static const char *name[] = {
+        "MIGRATION", "BLOCK", "OPTS", "QOM",
+        "TRACE", "XEN_BACKEND", "LIBQOS", "FUZZ_TARGET",
+        "MAX"
+    };
+#endif
+    record(modules, "Register DSO module init %p type %u %+s",
+           fn, type, name[type]);
     init_lists();
 
     e = g_malloc0(sizeof(*e));
-- 
2.26.2


