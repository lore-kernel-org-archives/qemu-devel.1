Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E71C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD42C21D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/pXmZHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD42C21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL12u-0002DG-SU
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oc-0001G0-HP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oS-0002N9-K2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRuenM6xg1JBEEE11oXj+Vx3RalsCmbiYZ8kHQa3v2A=;
 b=N/pXmZHn/oEFxdOKIeRrh7XgVZ5s5EPx9P37RjsttfambsfXVDZcJAUgx2/UfF4xlYj4R3
 v46acubBFsiJQDO7gMB+WqcEploKlLEejtB9LejmUKLlLqiaWzp8hPtoGKPs9/NKOfiy1L
 awSzHgwTLQs9mdNeaDwVI+2sQ/a3Kik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-RDL2NQNfOiWn7dgtffhP1Q-1; Wed, 23 Sep 2020 05:11:36 -0400
X-MC-Unique: RDL2NQNfOiWn7dgtffhP1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A1441074641;
 Wed, 23 Sep 2020 09:11:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F3945D9CC;
 Wed, 23 Sep 2020 09:11:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/12] configure: compute derivatives of target name in meson
Date: Wed, 23 Sep 2020 05:11:25 -0400
Message-Id: <20200923091131.1591563-7-pbonzini@redhat.com>
In-Reply-To: <20200923091131.1591563-1-pbonzini@redhat.com>
References: <20200923091131.1591563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Several CONFIG_* symbols in config-target.mak are easily computed from just
the target name.  We do not need them in config-target.mak, and can instead
place them in the config_target dictionary only.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure   | 11 +----------
 meson.build | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 903bbcbc46..2bd4336369 100755
--- a/configure
+++ b/configure
@@ -7622,7 +7622,6 @@ upper() {
 
 target_arch_name="$(upper $TARGET_ARCH)"
 echo "TARGET_$target_arch_name=y" >> $config_target_mak
-echo "TARGET_NAME=$target_name" >> $config_target_mak
 echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
 if [ "$TARGET_ABI_DIR" = "" ]; then
   TARGET_ABI_DIR=$TARGET_ARCH
@@ -7640,21 +7639,15 @@ if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
 if test "$target_softmmu" = "yes" ; then
-  echo "CONFIG_SOFTMMU=y" >> $config_target_mak
   if test "$mttcg" = "yes" ; then
     echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
   fi
 fi
 if test "$target_user_only" = "yes" ; then
-  echo "CONFIG_USER_ONLY=y" >> $config_target_mak
-  echo "CONFIG_QEMU_INTERP_PREFIX=\"$interp_prefix1\"" >> $config_target_mak
   symlink "../qemu-$target_name" "$target_dir/qemu-$target_name"
 else
   symlink "../qemu-system-$target_name" "$target_dir/qemu-system-$target_name"
 fi
-if test "$target_linux_user" = "yes" ; then
-  echo "CONFIG_LINUX_USER=y" >> $config_target_mak
-fi
 list=""
 if test ! -z "$gdb_xml_files" ; then
   for x in $gdb_xml_files; do
@@ -7666,9 +7659,6 @@ fi
 if test "$target_user_only" = "yes" && test "$bflt" = "yes"; then
   echo "TARGET_HAS_BFLT=y" >> $config_target_mak
 fi
-if test "$target_bsd_user" = "yes" ; then
-  echo "CONFIG_BSD_USER=y" >> $config_target_mak
-fi
 
 done # for target in $targets
 
@@ -7678,6 +7668,7 @@ fi
 if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
   subdirs="$subdirs capstone"
 fi
+echo "CONFIG_QEMU_INTERP_PREFIX=$interp_prefix" | sed 's/%M/@0@/' >> $config_host_mak
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 if test -n "$LIBCAPSTONE"; then
   echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 641378c1d9..3bd8cbacb7 100644
--- a/meson.build
+++ b/meson.build
@@ -638,12 +638,15 @@ config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0]
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
 config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('.')[2])
 
+ignored = ['CONFIG_QEMU_INTERP_PREFIX'] # actually per-target
 arrays = ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BDRV_RO_WHITELIST']
 strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'bindir', 'prefix', 'qemu_confdir', 'qemu_datadir',
            'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_localedir',
            'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath', 'sysconfdir']
 foreach k, v: config_host
-  if arrays.contains(k)
+  if ignored.contains(k)
+    # do nothing
+  elif arrays.contains(k)
     if v != ''
       v = '"' + '", "'.join(v.split()) + '", '
     endif
@@ -719,7 +722,23 @@ kconfig_external_symbols = [
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 
 foreach target : target_dirs
-  config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
+  config_target = { 'TARGET_NAME': target.split('-')[0] }
+  if target.endswith('linux-user')
+    assert(targetos == 'linux')
+    config_target += { 'CONFIG_LINUX_USER': 'y' }
+  elif target.endswith('bsd-user')
+    assert('CONFIG_BSD' in config_host)
+    config_target += { 'CONFIG_BSD_USER': 'y' }
+  elif target.endswith('softmmu')
+    config_target += { 'CONFIG_SOFTMMU': 'y' }
+  endif
+  if target.endswith('-user')
+    config_target += {
+      'CONFIG_USER_ONLY': 'y',
+      'CONFIG_QEMU_INTERP_PREFIX':
+        config_host['CONFIG_QEMU_INTERP_PREFIX'].format(config_target['TARGET_NAME'])
+    }
+  endif
 
   have_accel = false
   foreach sym: accelerators
@@ -734,6 +753,8 @@ foreach target : target_dirs
   endforeach
   assert(have_accel)
 
+  config_target += keyval.load('default-configs/targets' / target + '.mak')
+
   foreach k, v: disassemblers
     if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
       foreach sym: v
@@ -751,7 +772,7 @@ foreach target : target_dirs
       # do nothing
     elif k == 'TARGET_BASE_ARCH'
       config_target_data.set('TARGET_' + v.to_upper(), 1)
-    elif k == 'TARGET_NAME'
+    elif k == 'TARGET_NAME' or k == 'CONFIG_QEMU_INTERP_PREFIX'
       config_target_data.set_quoted(k, v)
     elif v == 'y'
       config_target_data.set(k, 1)
-- 
2.26.2



