Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB21C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D7F22400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnjT6P2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D7F22400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX330-0007aN-Ay
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uo-0005ig-Hd
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uU-0001lG-Tn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDVD8INd2BvnQC7jyPFIFN9yY+eKO0gCfvc/P6cDUOQ=;
 b=gnjT6P2yYKi+/HPb8UGxsO4mJt+D+J3hJzV0+FF2Pc0X4KUO0yc/eIonqI01XNgs9T5Jqj
 IV22xj+3rROlCVB7UT8IFLq2Onxti5IVCEMHhr712GX4EQQrUIujZJKlmISHvfTxEU8PJt
 8TWnd7YLYRu68rRX7pA5kVvSgQH+Msc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-Bcfcf-2MNeu6do0WUSx75w-1; Mon, 26 Oct 2020 09:51:38 -0400
X-MC-Unique: Bcfcf-2MNeu6do0WUSx75w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69579108E1CF
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3795D1002391
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] configure: move install_blobs from configure to meson
Date: Mon, 26 Oct 2020 09:51:26 -0400
Message-Id: <20201026135131.3006712-13-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move the conditions under which edk2 blobs are decompressed
and installed to pc-bios/meson.build.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                       | 26 +++-----------------------
 meson.build                     |  2 +-
 meson_options.txt               |  2 ++
 pc-bios/descriptors/meson.build |  2 +-
 pc-bios/meson.build             | 13 +++++++------
 5 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/configure b/configure
index 6bd2cafb33..55e07c82dd 100755
--- a/configure
+++ b/configure
@@ -362,8 +362,7 @@ cocoa="auto"
 softmmu="yes"
 linux_user="no"
 bsd_user="no"
-blobs="yes"
-edk2_blobs="no"
+blobs="true"
 pkgversion=""
 pie=""
 qom_cast_debug="yes"
@@ -1205,7 +1204,7 @@ for opt do
   ;;
   --enable-membarrier) membarrier="yes"
   ;;
-  --disable-blobs) blobs="no"
+  --disable-blobs) blobs="false"
   ;;
   --with-pkgversion=*) pkgversion="$optarg"
   ;;
@@ -2221,18 +2220,6 @@ case " $target_list " in
   ;;
 esac
 
-for target in $target_list; do
-  case "$target" in
-    arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
-      edk2_blobs="yes"
-      ;;
-  esac
-done
-# The EDK2 binaries are compressed with bzip2
-if test "$edk2_blobs" = "yes" && ! has bzip2; then
-  error_exit "The bzip2 program is required for building QEMU"
-fi
-
 feature_not_found() {
   feature=$1
   remedy=$2
@@ -6276,9 +6263,6 @@ fi
 if test "$vhost_user_fs" = "yes" ; then
   echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
 fi
-if test "$blobs" = "yes" ; then
-  echo "INSTALL_BLOBS=yes" >> $config_host_mak
-fi
 if test "$iovec" = "yes" ; then
   echo "CONFIG_IOVEC=y" >> $config_host_mak
 fi
@@ -6755,10 +6739,6 @@ if test "$fuzzing" != "no"; then
 fi
 echo "FUZZ_EXE_LDFLAGS=$FUZZ_EXE_LDFLAGS" >> $config_host_mak
 
-if test "$edk2_blobs" = "yes" ; then
-  echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
-fi
-
 if test "$rng_none" = "yes"; then
   echo "CONFIG_RNG_NONE=y" >> $config_host_mak
 fi
@@ -6995,7 +6975,7 @@ NINJA=$ninja $meson setup \
         -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         -Diconv=$iconv -Dcurses=$curses -Dlibudev=$libudev\
-        -Ddocs=$docs -Dsphinx_build=$sphinx_build \
+        -Ddocs=$docs -Dsphinx_build=$sphinx_build -Dinstall_blobs=$blobs \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index 4b6cca9238..342b8bcab5 100644
--- a/meson.build
+++ b/meson.build
@@ -2052,7 +2052,7 @@ summary_info += {'netmap support':    config_host.has_key('CONFIG_NETMAP')}
 summary_info += {'Linux AIO support': config_host.has_key('CONFIG_LINUX_AIO')}
 summary_info += {'Linux io_uring support': config_host.has_key('CONFIG_LINUX_IO_URING')}
 summary_info += {'ATTR/XATTR support': config_host.has_key('CONFIG_ATTR')}
-summary_info += {'Install blobs':     config_host.has_key('INSTALL_BLOBS')}
+summary_info += {'Install blobs':     get_option('install_blobs')}
 summary_info += {'KVM support':       config_all.has_key('CONFIG_KVM')}
 summary_info += {'HAX support':       config_all.has_key('CONFIG_HAX')}
 summary_info += {'HVF support':       config_all.has_key('CONFIG_HVF')}
diff --git a/meson_options.txt b/meson_options.txt
index 02b446013a..48ab4ce7d0 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -11,6 +11,8 @@ option('docs', type : 'feature', value : 'auto',
        description: 'Documentations build support')
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
+option('install_blobs', type : 'boolean', value : true,
+       description: 'install provided firmware blobs')
 option('sparse', type : 'feature', value : 'auto',
        description: 'sparse checker')
 
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index a200e5ebc3..7040834573 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -9,6 +9,6 @@ foreach f: [
   configure_file(input: files(f),
                  output: f,
                  configuration: {'DATADIR': qemu_datadir},
-                 install: install_blobs,
+                 install: get_option('install_blobs'),
                  install_dir: qemu_datadir / 'firmware')
 endforeach
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 03df50c485..fab323af84 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -1,7 +1,8 @@
-bzip2 = find_program('bzip2')
-
-install_blobs = 'INSTALL_BLOBS' in config_host
-if 'DECOMPRESS_EDK2_BLOBS' in config_host
+if 'arm-softmmu' in target_dirs or \
+    'aarch64-softmmu' in target_dirs or \
+    'i386-softmmu' in target_dirs or \
+    'x86_64-softmmu' in target_dirs
+  bzip2 = find_program('bzip2', required: true)
   fds = [
     'edk2-aarch64-code.fd',
     'edk2-arm-code.fd',
@@ -18,7 +19,7 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
                   output: f,
                   input: '@0@.bz2'.format(f),
                   capture: true,
-                  install: install_blobs,
+                  install: get_option('install_blobs'),
                   install_dir: qemu_datadir,
                   command: [ bzip2, '-dc', '@INPUT0@' ])
   endforeach
@@ -85,7 +86,7 @@ blobs = files(
   'npcm7xx_bootrom.bin',
 )
 
-if install_blobs
+if get_option('install_blobs')
   install_data(blobs, install_dir: qemu_datadir)
 endif
 
-- 
2.26.2



