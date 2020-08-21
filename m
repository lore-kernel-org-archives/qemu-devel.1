Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11949C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D158420738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0ZYjVp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D158420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94o2-0002WV-2X
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94E7-0002sN-Qb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94E0-0001hu-TA
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W646OUFQe73NK6Qe29Sh2VHx68bFqqG2GnS2YPXijAA=;
 b=R0ZYjVp1Yn1LIvIkWW4fFBB3aK6OPXy1+Cbh3/4BHHXSb9hclGTbSpw6SIKtHXZ51bsSAN
 7pyu6mcie7Qy0FX0uNZyF5feudPNnwrACxGbaAivKKHmp2pGDET6KHErKtPhAJIP7lUx30
 pmGAoupzo5QGkjJWyOql5E4CKSLlxh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-gDzFqIyNNeOcHIBNckRHEw-1; Fri, 21 Aug 2020 06:24:42 -0400
X-MC-Unique: gDzFqIyNNeOcHIBNckRHEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751911009440
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 267007E31F;
 Fri, 21 Aug 2020 10:24:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 086/152] meson: convert hw/xen
Date: Fri, 21 Aug 2020 06:22:23 -0400
Message-Id: <20200821102329.29777-87-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
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
 configure            |  7 +++++--
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/xen/Makefile.objs |  7 -------
 hw/xen/meson.build   | 20 ++++++++++++++++++++
 meson.build          |  6 ++++++
 6 files changed, 32 insertions(+), 10 deletions(-)
 create mode 100644 hw/meson.build
 delete mode 100644 hw/xen/Makefile.objs
 create mode 100644 hw/xen/meson.build

diff --git a/configure b/configure
index 3018da6336..f84dcac468 100755
--- a/configure
+++ b/configure
@@ -2736,6 +2736,8 @@ if test "$xen" != "no" ; then
     fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
+    xen_cflags="$($pkg_config --cflags $xen_pc)"
+    xen_libs="$($pkg_config --libs $xen_pc)"
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
@@ -3016,9 +3018,8 @@ EOF
 
     if test "$xen" = yes; then
       if test $xen_ctrl_version -ge 40701  ; then
-        libs_softmmu="$xen_stable_libs $libs_softmmu"
+        xen_libs="$xen_libs $xen_stable_libs "
       fi
-      libs_softmmu="$xen_libs $libs_softmmu"
     fi
   fi
 fi
@@ -7309,6 +7310,8 @@ fi
 if test "$xen" = "yes" ; then
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
+  echo "XEN_CFLAGS=$xen_cflags" >> $config_host_mak
+  echo "XEN_LIBS=$xen_libs" >> $config_host_mak
 fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 14b7ea4eb6..d204a906af 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-$(CONFIG_XEN) += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += semihosting/
diff --git a/hw/meson.build b/hw/meson.build
new file mode 100644
index 0000000000..08112a5e4b
--- /dev/null
+++ b/hw/meson.build
@@ -0,0 +1 @@
+subdir('xen')
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
deleted file mode 100644
index 502b32d877..0000000000
--- a/hw/xen/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-# xen backend driver support
-common-obj-y += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-bus-helper.o xen-backend.o
-
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
-obj-$(call lnot,$(CONFIG_XEN_PCI_PASSTHROUGH)) += xen_pt_stub.o
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
new file mode 100644
index 0000000000..076954b89c
--- /dev/null
+++ b/hw/xen/meson.build
@@ -0,0 +1,20 @@
+softmmu_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+  'xen-backend.c',
+  'xen-bus-helper.c',
+  'xen-bus.c',
+  'xen-legacy-backend.c',
+  'xen_devconfig.c',
+  'xen_pvdev.c',
+))
+
+xen_specific_ss = ss.source_set()
+xen_specific_ss.add(when: 'CONFIG_XEN_PCI_PASSTHROUGH', if_true: files(
+  'xen-host-pci-device.c',
+  'xen_pt.c',
+  'xen_pt_config_init.c',
+  'xen_pt_graphics.c',
+  'xen_pt_load_rom.c',
+  'xen_pt_msi.c',
+), if_false: files('xen_pt_stub.c'))
+
+specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
diff --git a/meson.build b/meson.build
index edb635347c..aa715e5428 100644
--- a/meson.build
+++ b/meson.build
@@ -325,6 +325,11 @@ numa = not_found
 if 'CONFIG_NUMA' in config_host
   numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
 endif
+xen = not_found
+if 'CONFIG_XEN_BACKEND' in config_host
+  xen = declare_dependency(compile_args: config_host['XEN_CFLAGS'].split(),
+                           link_args: config_host['XEN_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -678,6 +683,7 @@ subdir('migration')
 subdir('monitor')
 subdir('net')
 subdir('replay')
+subdir('hw')
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
-- 
2.26.2



