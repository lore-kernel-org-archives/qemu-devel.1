Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BE72242A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHAryGCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE72242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX36f-0002hy-2n
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uq-0005oj-Py
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2ud-0001m3-2K
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXYkuQn/Ktxc4Km2i4G5V85tAZmsBxISL2OROJYTnmg=;
 b=aHAryGCQef51eON0otT03JnKOGxC7UAyGDJbMkT+wQ4htvifr+k7PDr0WO7kIUeARVDJIW
 ci9VrRM+5vjJUb1jQSIiqVLMbMFWonLMlv9zL3/af4CrTlRYVnajefrFNOuHVE3du8VMYJ
 mw9rWph1QpXRWt9EZuZOMOdKQi0+cec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-K9kaxeDcMwaIinWrWZXCsg-1; Mon, 26 Oct 2020 09:51:37 -0400
X-MC-Unique: K9kaxeDcMwaIinWrWZXCsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4E78188C13A
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84EEA1043268
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/17] configure: move directory options from config-host.mak
 to meson
Date: Mon, 26 Oct 2020 09:51:24 -0400
Message-Id: <20201026135131.3006712-11-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since installation is not part of Makefiles anymore, Make need not
know the directories anymore.  Meson already knows them through
built-in options, do everything using them instead of the config_host
dictionary.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                           |  4 +++
 configure                          | 31 ++++----------------
 contrib/vhost-user-gpu/meson.build |  2 +-
 meson.build                        | 47 ++++++++++++++++++++----------
 meson_options.txt                  |  2 ++
 pc-bios/descriptors/meson.build    |  2 +-
 pc-bios/meson.build                |  2 +-
 tools/virtiofsd/meson.build        |  2 +-
 ui/icons/meson.build               |  6 ++--
 ui/meson.build                     |  2 +-
 version.texi.in                    |  2 --
 11 files changed, 51 insertions(+), 51 deletions(-)
 delete mode 100644 version.texi.in

diff --git a/Makefile b/Makefile
index 5236464d1f..4d1fa8bb3d 100644
--- a/Makefile
+++ b/Makefile
@@ -99,6 +99,10 @@ ifeq ($(wildcard build.ninja),)
 .PHONY: config-host.mak
 x := $(shell rm -rf meson-private meson-info meson-logs)
 endif
+ifeq ($(origin prefix),file)
+.PHONY: config-host.mak
+x := $(shell rm -rf meson-private meson-info meson-logs)
+endif
 
 # 1. ensure config-host.mak is up-to-date
 config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
diff --git a/configure b/configure
index c214e9b38e..29e6732f47 100755
--- a/configure
+++ b/configure
@@ -1523,11 +1523,9 @@ for opt do
   esac
 done
 
-firmwarepath="${firmwarepath:-$prefix/share/qemu-firmware}"
 libdir="${libdir:-$prefix/lib}"
 libexecdir="${libexecdir:-$prefix/libexec}"
 includedir="${includedir:-$prefix/include}"
-localedir="${localedir:-$datadir/locale}"
 
 if test "$mingw32" = "yes" ; then
     mandir="$prefix"
@@ -1535,7 +1533,7 @@ if test "$mingw32" = "yes" ; then
     docdir="$prefix"
     bindir="$prefix"
     sysconfdir="$prefix"
-    local_statedir=
+    local_statedir="$prefix"
 else
     mandir="${mandir:-$prefix/share/man}"
     datadir="${datadir:-$prefix/share}"
@@ -1544,6 +1542,8 @@ else
     sysconfdir="${sysconfdir:-$prefix/etc}"
     local_statedir="${local_statedir:-$prefix/var}"
 fi
+firmwarepath="${firmwarepath:-$datadir/qemu-firmware}"
+localedir="${localedir:-$datadir/locale}"
 
 case "$cpu" in
     ppc)
@@ -5729,12 +5729,6 @@ if test "$mingw32" = "yes" ; then
     done
 fi
 
-qemu_confdir="$sysconfdir/$qemu_suffix"
-qemu_moddir="$libdir/$qemu_suffix"
-qemu_datadir="$datadir/$qemu_suffix"
-qemu_icondir="$datadir/icons"
-qemu_desktopdir="$datadir/applications"
-
 # We can only support ivshmem if we have eventfd
 if [ "$eventfd" = "yes" ]; then
   ivshmem=yes
@@ -5901,23 +5895,6 @@ echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo >> $config_host_mak
 
 echo all: >> $config_host_mak
-echo "prefix=$prefix" >> $config_host_mak
-echo "bindir=$bindir" >> $config_host_mak
-echo "libdir=$libdir" >> $config_host_mak
-echo "libexecdir=$libexecdir" >> $config_host_mak
-echo "includedir=$includedir" >> $config_host_mak
-echo "sysconfdir=$sysconfdir" >> $config_host_mak
-echo "qemu_confdir=$qemu_confdir" >> $config_host_mak
-echo "qemu_datadir=$qemu_datadir" >> $config_host_mak
-echo "qemu_firmwarepath=$firmwarepath" >> $config_host_mak
-echo "qemu_moddir=$qemu_moddir" >> $config_host_mak
-if test "$mingw32" = "no" ; then
-  echo "qemu_localstatedir=$local_statedir" >> $config_host_mak
-fi
-echo "qemu_helperdir=$libexecdir" >> $config_host_mak
-echo "qemu_localedir=$localedir" >> $config_host_mak
-echo "qemu_icondir=$qemu_icondir" >> $config_host_mak
-echo "qemu_desktopdir=$qemu_desktopdir" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
 echo "GIT_UPDATE=$git_update" >> $config_host_mak
@@ -7000,8 +6977,10 @@ NINJA=$ninja $meson setup \
         --datadir "$datadir" \
         --mandir "$mandir" \
         --sysconfdir "$sysconfdir" \
+        --localedir "$localedir" \
         --localstatedir "$local_statedir" \
         -Ddocdir="$docdir" \
+        -Dqemu_firmwarepath="$firmwarepath" \
         -Dqemu_suffix="$qemu_suffix" \
         -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
index 7d9b29da8b..37ecca13ca 100644
--- a/contrib/vhost-user-gpu/meson.build
+++ b/contrib/vhost-user-gpu/meson.build
@@ -9,6 +9,6 @@ if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
 
   configure_file(input: '50-qemu-gpu.json.in',
                  output: '50-qemu-gpu.json',
-                 configuration: config_host,
+                 configuration: { 'libexecdir' : get_option('libexecdir') },
                  install_dir: qemu_datadir / 'vhost-user')
 endif
diff --git a/meson.build b/meson.build
index 0edde14ad7..4b6cca9238 100644
--- a/meson.build
+++ b/meson.build
@@ -29,8 +29,14 @@ if get_option('qemu_suffix').startswith('/')
   error('qemu_suffix cannot start with a /')
 endif
 
+qemu_confdir = get_option('sysconfdir') / get_option('qemu_suffix')
 qemu_datadir = get_option('datadir') / get_option('qemu_suffix')
 qemu_docdir = get_option('docdir') / get_option('qemu_suffix')
+qemu_moddir = get_option('libdir') / get_option('qemu_suffix')
+
+qemu_desktopdir = get_option('datadir') / 'applications'
+qemu_icondir = get_option('datadir') / 'icons'
+
 config_host_data = configuration_data()
 genh = []
 
@@ -734,6 +740,19 @@ endif
 # config-host.h #
 #################
 
+config_host_data.set_quoted('CONFIG_BINDIR', get_option('prefix') / get_option('bindir'))
+config_host_data.set_quoted('CONFIG_PREFIX', get_option('prefix'))
+config_host_data.set_quoted('CONFIG_QEMU_CONFDIR', get_option('prefix') / qemu_confdir)
+config_host_data.set_quoted('CONFIG_QEMU_DATADIR', get_option('prefix') / qemu_datadir)
+config_host_data.set_quoted('CONFIG_QEMU_DESKTOPDIR', get_option('prefix') / qemu_desktopdir)
+config_host_data.set_quoted('CONFIG_QEMU_FIRMWAREPATH', get_option('qemu_firmwarepath'))
+config_host_data.set_quoted('CONFIG_QEMU_HELPERDIR', get_option('prefix') / get_option('libexecdir'))
+config_host_data.set_quoted('CONFIG_QEMU_ICONDIR', get_option('prefix') / qemu_icondir)
+config_host_data.set_quoted('CONFIG_QEMU_LOCALEDIR', get_option('prefix') / get_option('localedir'))
+config_host_data.set_quoted('CONFIG_QEMU_LOCALSTATEDIR', get_option('prefix') / get_option('localstatedir'))
+config_host_data.set_quoted('CONFIG_QEMU_MODDIR', get_option('prefix') / qemu_moddir)
+config_host_data.set_quoted('CONFIG_SYSCONFDIR', get_option('prefix') / get_option('sysconfdir'))
+
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
@@ -756,9 +775,7 @@ config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('.')[2]
 
 ignored = ['CONFIG_QEMU_INTERP_PREFIX'] # actually per-target
 arrays = ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BDRV_RO_WHITELIST']
-strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'bindir', 'prefix', 'qemu_confdir', 'qemu_datadir',
-           'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_localedir',
-           'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath', 'sysconfdir']
+strings = ['HOST_DSOSUF', 'CONFIG_IASL']
 foreach k, v: config_host
   if ignored.contains(k)
     # do nothing
@@ -1639,7 +1656,7 @@ foreach m : block_mods + softmmu_mods
                 name_prefix: '',
                 link_whole: m,
                 install: true,
-                install_dir: config_host['qemu_moddir'])
+                install_dir: qemu_moddir)
 endforeach
 
 softmmu_ss.add(authz, block, chardev, crypto, io, qmp)
@@ -1800,7 +1817,7 @@ foreach target : target_dirs
                       output: exe['name'] + stp['ext'],
                       capture: true,
                       install: stp['install'],
-                      install_dir: qemu_datadir / '../systemtap/tapset',
+                      install_dir: get_option('datadir') / 'systemtap/tapset',
                       command: [
                         tracetool, '--group=all', '--format=' + stp['fmt'],
                         '--binary=' + stp['bin'],
@@ -1913,17 +1930,17 @@ endif
 #########################
 
 summary_info = {}
-summary_info += {'Install prefix':    config_host['prefix']}
-summary_info += {'BIOS directory':    config_host['qemu_datadir']}
-summary_info += {'firmware path':     config_host['qemu_firmwarepath']}
-summary_info += {'binary directory':  config_host['bindir']}
-summary_info += {'library directory': config_host['libdir']}
-summary_info += {'module directory':  config_host['qemu_moddir']}
-summary_info += {'libexec directory': config_host['libexecdir']}
-summary_info += {'include directory': config_host['includedir']}
-summary_info += {'config directory':  config_host['sysconfdir']}
+summary_info += {'Install prefix':    get_option('prefix')}
+summary_info += {'BIOS directory':    qemu_datadir}
+summary_info += {'firmware path':     get_option('qemu_firmwarepath')}
+summary_info += {'binary directory':  get_option('bindir')}
+summary_info += {'library directory': get_option('libdir')}
+summary_info += {'module directory':  qemu_moddir}
+summary_info += {'libexec directory': get_option('libexecdir')}
+summary_info += {'include directory': get_option('includedir')}
+summary_info += {'config directory':  get_option('sysconfdir')}
 if targetos != 'windows'
-  summary_info += {'local state directory': config_host['qemu_localstatedir']}
+  summary_info += {'local state directory': get_option('localstatedir')}
   summary_info += {'Manual directory':      get_option('mandir')}
 else
   summary_info += {'local state directory': 'queried at runtime'}
diff --git a/meson_options.txt b/meson_options.txt
index 967229b66e..02b446013a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -2,6 +2,8 @@ option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
 option('docdir', type : 'string', value : 'doc',
        description: 'Base directory for documentation installation (can be empty)')
+option('qemu_firmwarepath', type : 'string', value : '',
+       description: 'search PATH for firmware files')
 option('sphinx_build', type : 'string', value : '',
        description: 'Use specified sphinx-build [$sphinx_build] for building document (default to be empty)')
 
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index 3798d32372..a200e5ebc3 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -8,7 +8,7 @@ foreach f: [
 ]
   configure_file(input: files(f),
                  output: f,
-                 configuration: {'DATADIR': config_host['qemu_datadir']},
+                 configuration: {'DATADIR': qemu_datadir},
                  install: install_blobs,
                  install_dir: qemu_datadir / 'firmware')
 endforeach
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index a0d21be432..03df50c485 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -86,7 +86,7 @@ blobs = files(
 )
 
 if install_blobs
-  install_data(blobs, install_dir: config_host['qemu_datadir'])
+  install_data(blobs, install_dir: qemu_datadir)
 endif
 
 subdir('descriptors')
diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
index 50022ed89e..e1a4dc98d9 100644
--- a/tools/virtiofsd/meson.build
+++ b/tools/virtiofsd/meson.build
@@ -15,5 +15,5 @@ executable('virtiofsd', files(
 
 configure_file(input: '50-qemu-virtiofsd.json.in',
                output: '50-qemu-virtiofsd.json',
-               configuration: config_host,
+               configuration: { 'libexecdir' : get_option('libexecdir') },
                install_dir: qemu_datadir / 'vhost-user')
diff --git a/ui/icons/meson.build b/ui/icons/meson.build
index b6e21f6ad7..12c52080eb 100644
--- a/ui/icons/meson.build
+++ b/ui/icons/meson.build
@@ -2,12 +2,12 @@ foreach s: [16, 24, 32, 48, 64, 128, 256, 512]
   s = '@0@x@0@'.format(s.to_string())
   install_data('qemu_@0@.png'.format(s),
                rename: 'qemu.png',
-               install_dir: config_host['qemu_icondir'] / 'hicolor' / s / 'apps')
+               install_dir: qemu_icondir / 'hicolor' / s / 'apps')
 endforeach
 
 install_data('qemu_32x32.bmp',
              rename: 'qemu.bmp',
-             install_dir: config_host['qemu_icondir'] / 'hicolor' / '32x32' / 'apps')
+             install_dir: qemu_icondir / 'hicolor' / '32x32' / 'apps')
 
 install_data('qemu.svg',
-             install_dir: config_host['qemu_icondir'] / 'hicolor' / 'scalable' / 'apps')
+             install_dir: qemu_icondir / 'hicolor' / 'scalable' / 'apps')
diff --git a/ui/meson.build b/ui/meson.build
index 5d4906c023..013258a01c 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -139,7 +139,7 @@ subdir('shader')
 if have_system
   subdir('icons')
 
-  install_data('qemu.desktop', install_dir: config_host['qemu_desktopdir'])
+  install_data('qemu.desktop', install_dir: qemu_desktopdir)
 endif
 
 modules += {'ui': ui_modules}
diff --git a/version.texi.in b/version.texi.in
deleted file mode 100644
index 0a723b8be6..0000000000
--- a/version.texi.in
+++ /dev/null
@@ -1,2 +0,0 @@
-@set VERSION @VERSION@
-@set CONFDIR @qemu_confdir@
-- 
2.26.2



