Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95742C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0907821D91
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElHJ+OuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0907821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0sq-00084G-UB
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oS-00019H-6L
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oL-0002Mb-FK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmGhtkB1QB5kLHSLDrmo5u7rX3bh1zscfyeedYPRWx4=;
 b=ElHJ+OuE2mfdtm9aqcFwkYOnrO42O/+0x6DNO3r6wwurqYf4ixOclizJnVm6UpsErhd2WO
 I9qiZ2/vdi/IPdn1UyAXAFzp21xd1g7hJz3RHfzjAnYHgf0q4veLScUW1d95ahX7HgPfUY
 xNx9phCc+zFCmLLe1qBg90e3UQEcN2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-07791cbYMxSbHCZovwdVtQ-1; Wed, 23 Sep 2020 05:11:35 -0400
X-MC-Unique: 07791cbYMxSbHCZovwdVtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D6F107464E;
 Wed, 23 Sep 2020 09:11:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0BF75D9CC;
 Wed, 23 Sep 2020 09:11:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/12] configure: rewrite accelerator defaults as tests
Date: Wed, 23 Sep 2020 05:11:22 -0400
Message-Id: <20200923091131.1591563-4-pbonzini@redhat.com>
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

Prepare to process "auto" in meson rather than configure: standardize the
shape of the code that changes "auto" to enabled/disabled, to ease the review
when it will be moved to meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 58 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index 33bd3c4cb8..04cc25f7c8 100755
--- a/configure
+++ b/configure
@@ -429,10 +429,10 @@ vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
 vhost_user_fs=""
-kvm="disabled"
-hax="disabled"
-hvf="disabled"
-whpx="disabled"
+kvm="auto"
+hax="auto"
+hvf="auto"
+whpx="auto"
 rdma=""
 pvrdma=""
 gprof="no"
@@ -821,8 +821,6 @@ HOST_VARIANT_DIR=""
 case $targetos in
 MINGW32*)
   mingw32="yes"
-  hax="enabled"
-  whpx="auto"
   vhost_user="no"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
@@ -856,7 +854,6 @@ DragonFly)
 ;;
 NetBSD)
   bsd="yes"
-  hax="enabled"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
@@ -873,8 +870,6 @@ OpenBSD)
 Darwin)
   bsd="yes"
   darwin="yes"
-  hax="enabled"
-  hvf="auto"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
@@ -910,7 +905,6 @@ Linux)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-  kvm="enabled"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
 ;;
 esac
@@ -2668,6 +2662,29 @@ if test "$seccomp" != "no" ; then
         seccomp="no"
     fi
 fi
+
+##########################################
+# simple accelerator probes
+
+if test "$kvm" != "disabled" ; then
+  if test "$linux" = yes ; then
+    kvm=enabled
+  else
+    if test "$kvm" = "enabled" ; then
+      feature_not_found "kvm" "KVM is only available on Linux"
+    fi
+    kvm=disabled
+  fi
+fi
+
+if test "$hax" = "auto" ; then
+  if test "$mingw" = yes || test "$darwin" = yes || test "$targetos" = NetBSD; then
+    hax=enabled
+  else
+    hax=disabled
+  fi
+fi
+
 ##########################################
 # xen probe
 
@@ -2988,14 +3005,15 @@ fi
 
 ##########################################
 # Windows Hypervisor Platform accelerator (WHPX) check
-if test "$whpx" = "enabled" && test "$ARCH" != "x86_64"; then
-  error_exit "WHPX requires 64-bit host"
-fi
-if test "$whpx" != "disabled" && test "$ARCH" = "x86_64"; then
-    if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
-        whpx="yes"
+if test "$whpx" != "disabled"; then
+    if test "$mingw32" = yes && test "$ARCH" = "x86_64" &&
+            check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
+        whpx="enabled"
     else
-        if test "$whpx" = "auto"; then
+        if test "$whpx" = "enabled"; then
+            if test "$ARCH" != "x86_64"; then
+                error_exit "WHPX requires 64-bit host"
+            fi
             feature_not_found "WinHvPlatform" "WinHvEmulation is not installed"
         fi
         whpx="disabled"
@@ -5831,13 +5849,13 @@ if [ "$hvf" != "disabled" ] ; then
 #include <Hypervisor/hv.h>
 int main() { return 0;}
 EOF
-  if ! compile_object ""; then
+  if test "$darwin" = yes && compile_object ""; then
+    hvf='enabled'
+  else
     if test "$hvf" = "enabled"; then
 	error_exit "Hypervisor.framework not available"
     fi
     hvf='disabled'
-  else
-    hvf='enabled'
   fi
 fi
 
-- 
2.26.2



