Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEABC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C211321924
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfD+6XIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C211321924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0t5-0008LV-IK
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oY-0001D3-OI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oR-0002N6-Vu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncc0cq1dLrcOLr92X5kR8wiR2zrnTvEdvBDIV8FF3A8=;
 b=GfD+6XIQy5QbewEBgZsdTK3nis3rRi9qil1oWG90FrFv78tT3I8iB5/FPlf4cTDpQ6zQjv
 t+RO1KQf15uJAGEMI5o1lNoZJAB474d2p42BmP6n89qB/k1HUhXFKDUWRLVrTBMVFIR9TC
 /wyHaSIFH2pobdYQpJaLoU5j4NGNqLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-QD9vAuhkPkaUyPVvOot4tg-1; Wed, 23 Sep 2020 05:11:37 -0400
X-MC-Unique: QD9vAuhkPkaUyPVvOot4tg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17241005E76;
 Wed, 23 Sep 2020 09:11:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50F895D9CC;
 Wed, 23 Sep 2020 09:11:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/12] configure: remove target configuration
Date: Wed, 23 Sep 2020 05:11:27 -0400
Message-Id: <20200923091131.1591563-9-pbonzini@redhat.com>
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

The config-target.mak files are small constant, we can therefore just
write them down explicitly.

This removes a pretty large part of the configure script, including the
whole logic to detect which accelerators are supported by each target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                     | 457 +-----------------
 .../targets/aarch64-linux-user.mak            |   5 +
 default-configs/targets/aarch64-softmmu.mak   |   4 +
 .../targets/aarch64_be-linux-user.mak         |   6 +
 default-configs/targets/alpha-linux-user.mak  |   6 +
 default-configs/targets/alpha-softmmu.mak     |   4 +
 default-configs/targets/arm-linux-user.mak    |   7 +
 default-configs/targets/arm-softmmu.mak       |   4 +
 default-configs/targets/armeb-linux-user.mak  |   8 +
 default-configs/targets/avr-softmmu.mak       |   3 +
 default-configs/targets/cris-linux-user.mak   |   3 +
 default-configs/targets/cris-softmmu.mak      |   2 +
 default-configs/targets/hppa-linux-user.mak   |   7 +
 default-configs/targets/hppa-softmmu.mak      |   5 +
 default-configs/targets/i386-bsd-user.mak     |   4 +
 default-configs/targets/i386-linux-user.mak   |   6 +
 default-configs/targets/i386-softmmu.mak      |   4 +
 default-configs/targets/lm32-softmmu.mak      |   3 +
 default-configs/targets/m68k-linux-user.mak   |   8 +
 default-configs/targets/m68k-softmmu.mak      |   4 +
 .../targets/microblaze-linux-user.mak         |   7 +
 .../targets/microblaze-softmmu.mak            |   4 +
 .../targets/microblazeel-linux-user.mak       |   6 +
 .../targets/microblazeel-softmmu.mak          |   3 +
 default-configs/targets/mips-linux-user.mak   |   8 +
 default-configs/targets/mips-softmmu.mak      |   5 +
 default-configs/targets/mips64-linux-user.mak |   8 +
 default-configs/targets/mips64-softmmu.mak    |   4 +
 .../targets/mips64el-linux-user.mak           |   7 +
 default-configs/targets/mips64el-softmmu.mak  |   3 +
 default-configs/targets/mipsel-linux-user.mak |   7 +
 default-configs/targets/mipsel-softmmu.mak    |   4 +
 .../targets/mipsn32-linux-user.mak            |   9 +
 .../targets/mipsn32el-linux-user.mak          |   8 +
 default-configs/targets/moxie-softmmu.mak     |   3 +
 default-configs/targets/nios2-linux-user.mak  |   3 +
 default-configs/targets/nios2-softmmu.mak     |   2 +
 default-configs/targets/or1k-linux-user.mak   |   4 +
 default-configs/targets/or1k-softmmu.mak      |   3 +
 default-configs/targets/ppc-linux-user.mak    |   7 +
 default-configs/targets/ppc-softmmu.mak       |   4 +
 default-configs/targets/ppc64-linux-user.mak  |   7 +
 default-configs/targets/ppc64-softmmu.mak     |   5 +
 .../targets/ppc64abi32-linux-user.mak         |   8 +
 .../targets/ppc64le-linux-user.mak            |   6 +
 .../targets/riscv32-linux-user.mak            |   4 +
 default-configs/targets/riscv32-softmmu.mak   |   4 +
 .../targets/riscv64-linux-user.mak            |   4 +
 default-configs/targets/riscv64-softmmu.mak   |   4 +
 default-configs/targets/rx-softmmu.mak        |   3 +
 default-configs/targets/s390x-linux-user.mak  |   7 +
 default-configs/targets/s390x-softmmu.mak     |   5 +
 default-configs/targets/sh4-linux-user.mak    |   7 +
 default-configs/targets/sh4-softmmu.mak       |   3 +
 default-configs/targets/sh4eb-linux-user.mak  |   8 +
 default-configs/targets/sh4eb-softmmu.mak     |   4 +
 default-configs/targets/sparc-bsd-user.mak    |   5 +
 default-configs/targets/sparc-linux-user.mak  |   7 +
 default-configs/targets/sparc-softmmu.mak     |   4 +
 .../targets/sparc32plus-linux-user.mak        |   8 +
 default-configs/targets/sparc64-bsd-user.mak  |   5 +
 .../targets/sparc64-linux-user.mak            |   7 +
 default-configs/targets/sparc64-softmmu.mak   |   4 +
 default-configs/targets/tilegx-linux-user.mak |   3 +
 default-configs/targets/tricore-softmmu.mak   |   2 +
 default-configs/targets/unicore32-softmmu.mak |   2 +
 default-configs/targets/x86_64-bsd-user.mak   |   4 +
 default-configs/targets/x86_64-linux-user.mak |   6 +
 default-configs/targets/x86_64-softmmu.mak    |   4 +
 default-configs/targets/xtensa-linux-user.mak |   7 +
 default-configs/targets/xtensa-softmmu.mak    |   4 +
 .../targets/xtensaeb-linux-user.mak           |   8 +
 default-configs/targets/xtensaeb-softmmu.mak  |   5 +
 meson.build                                   |  27 +-
 74 files changed, 404 insertions(+), 446 deletions(-)
 create mode 100644 default-configs/targets/aarch64-linux-user.mak
 create mode 100644 default-configs/targets/aarch64-softmmu.mak
 create mode 100644 default-configs/targets/aarch64_be-linux-user.mak
 create mode 100644 default-configs/targets/alpha-linux-user.mak
 create mode 100644 default-configs/targets/alpha-softmmu.mak
 create mode 100644 default-configs/targets/arm-linux-user.mak
 create mode 100644 default-configs/targets/arm-softmmu.mak
 create mode 100644 default-configs/targets/armeb-linux-user.mak
 create mode 100644 default-configs/targets/avr-softmmu.mak
 create mode 100644 default-configs/targets/cris-linux-user.mak
 create mode 100644 default-configs/targets/cris-softmmu.mak
 create mode 100644 default-configs/targets/hppa-linux-user.mak
 create mode 100644 default-configs/targets/hppa-softmmu.mak
 create mode 100644 default-configs/targets/i386-bsd-user.mak
 create mode 100644 default-configs/targets/i386-linux-user.mak
 create mode 100644 default-configs/targets/i386-softmmu.mak
 create mode 100644 default-configs/targets/lm32-softmmu.mak
 create mode 100644 default-configs/targets/m68k-linux-user.mak
 create mode 100644 default-configs/targets/m68k-softmmu.mak
 create mode 100644 default-configs/targets/microblaze-linux-user.mak
 create mode 100644 default-configs/targets/microblaze-softmmu.mak
 create mode 100644 default-configs/targets/microblazeel-linux-user.mak
 create mode 100644 default-configs/targets/microblazeel-softmmu.mak
 create mode 100644 default-configs/targets/mips-linux-user.mak
 create mode 100644 default-configs/targets/mips-softmmu.mak
 create mode 100644 default-configs/targets/mips64-linux-user.mak
 create mode 100644 default-configs/targets/mips64-softmmu.mak
 create mode 100644 default-configs/targets/mips64el-linux-user.mak
 create mode 100644 default-configs/targets/mips64el-softmmu.mak
 create mode 100644 default-configs/targets/mipsel-linux-user.mak
 create mode 100644 default-configs/targets/mipsel-softmmu.mak
 create mode 100644 default-configs/targets/mipsn32-linux-user.mak
 create mode 100644 default-configs/targets/mipsn32el-linux-user.mak
 create mode 100644 default-configs/targets/moxie-softmmu.mak
 create mode 100644 default-configs/targets/nios2-linux-user.mak
 create mode 100644 default-configs/targets/nios2-softmmu.mak
 create mode 100644 default-configs/targets/or1k-linux-user.mak
 create mode 100644 default-configs/targets/or1k-softmmu.mak
 create mode 100644 default-configs/targets/ppc-linux-user.mak
 create mode 100644 default-configs/targets/ppc-softmmu.mak
 create mode 100644 default-configs/targets/ppc64-linux-user.mak
 create mode 100644 default-configs/targets/ppc64-softmmu.mak
 create mode 100644 default-configs/targets/ppc64abi32-linux-user.mak
 create mode 100644 default-configs/targets/ppc64le-linux-user.mak
 create mode 100644 default-configs/targets/riscv32-linux-user.mak
 create mode 100644 default-configs/targets/riscv32-softmmu.mak
 create mode 100644 default-configs/targets/riscv64-linux-user.mak
 create mode 100644 default-configs/targets/riscv64-softmmu.mak
 create mode 100644 default-configs/targets/rx-softmmu.mak
 create mode 100644 default-configs/targets/s390x-linux-user.mak
 create mode 100644 default-configs/targets/s390x-softmmu.mak
 create mode 100644 default-configs/targets/sh4-linux-user.mak
 create mode 100644 default-configs/targets/sh4-softmmu.mak
 create mode 100644 default-configs/targets/sh4eb-linux-user.mak
 create mode 100644 default-configs/targets/sh4eb-softmmu.mak
 create mode 100644 default-configs/targets/sparc-bsd-user.mak
 create mode 100644 default-configs/targets/sparc-linux-user.mak
 create mode 100644 default-configs/targets/sparc-softmmu.mak
 create mode 100644 default-configs/targets/sparc32plus-linux-user.mak
 create mode 100644 default-configs/targets/sparc64-bsd-user.mak
 create mode 100644 default-configs/targets/sparc64-linux-user.mak
 create mode 100644 default-configs/targets/sparc64-softmmu.mak
 create mode 100644 default-configs/targets/tilegx-linux-user.mak
 create mode 100644 default-configs/targets/tricore-softmmu.mak
 create mode 100644 default-configs/targets/unicore32-softmmu.mak
 create mode 100644 default-configs/targets/x86_64-bsd-user.mak
 create mode 100644 default-configs/targets/x86_64-linux-user.mak
 create mode 100644 default-configs/targets/x86_64-softmmu.mak
 create mode 100644 default-configs/targets/xtensa-linux-user.mak
 create mode 100644 default-configs/targets/xtensa-softmmu.mak
 create mode 100644 default-configs/targets/xtensaeb-linux-user.mak
 create mode 100644 default-configs/targets/xtensaeb-softmmu.mak

diff --git a/configure b/configure
index 5e15b5e1ad..7cff5c0b7a 100755
--- a/configure
+++ b/configure
@@ -220,108 +220,6 @@ glob() {
     eval test -z '"${1#'"$2"'}"'
 }
 
-supported_hax_target() {
-    test "$hax" = "enabled" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}" in
-        i386|x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_kvm_target() {
-    test "$kvm" = "enabled" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}:$cpu" in
-        aarch64:aarch64 | \
-        i386:i386 | i386:x86_64 | i386:x32 | \
-        x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
-        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
-        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
-        s390x:s390x)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_xen_target() {
-    test "$xen" = "enabled" || return 1
-    glob "$1" "*-softmmu" || return 1
-    # Only i386 and x86_64 provide the xenpv machine.
-    case "${1%-softmmu}" in
-        i386|x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_hvf_target() {
-    test "$hvf" = "enabled" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}" in
-        x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_whpx_target() {
-    test "$whpx" = "enabled" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}" in
-        i386|x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user,lm32-softmmu,unicore32-softmmu
-deprecated_features=""
-
-supported_target() {
-    case "$1" in
-        *-softmmu)
-            ;;
-        *-linux-user)
-            if test "$linux" != "yes"; then
-                print_error "Target '$target' is only available on a Linux host"
-                return 1
-            fi
-            ;;
-        *-bsd-user)
-            if test "$bsd" != "yes"; then
-                print_error "Target '$target' is only available on a BSD host"
-                return 1
-            fi
-            ;;
-        *)
-            print_error "Invalid target name '$target'"
-            return 1
-            ;;
-    esac
-
-    # if a deprecated target is enabled we note it here
-    if echo "$deprecated_targets_list" | grep -q "$1"; then
-        add_to deprecated_features $1
-    fi
-
-    test "$tcg" = "enabled" && return 0
-    supported_kvm_target "$1" && return 0
-    supported_xen_target "$1" && return 0
-    supported_hax_target "$1" && return 0
-    supported_hvf_target "$1" && return 0
-    supported_whpx_target "$1" && return 0
-    print_error "TCG disabled, but hardware accelerator not available for '$target'"
-    return 1
-}
-
-
 ld_has() {
     $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
 }
@@ -1705,7 +1603,8 @@ if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
 fi
 
 default_target_list=""
-
+deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user,lm32-softmmu,unicore32-softmmu
+deprecated_features=""
 mak_wilds=""
 
 if [ "$softmmu" = "yes" ]; then
@@ -2033,16 +1932,6 @@ if ! compile_prog ; then
     error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
 fi
 
-# Now we have handled --enable-tcg-interpreter and know we're not just
-# printing the help message, bail out if the host CPU isn't supported.
-if test "$ARCH" = "unknown"; then
-    if test "$tcg_interpreter" = "yes" ; then
-        echo "Unsupported CPU = $cpu, will use TCG with TCI (experimental)"
-    else
-        error_exit "Unsupported CPU = $cpu, try --enable-tcg-interpreter"
-    fi
-fi
-
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
@@ -2294,12 +2183,13 @@ if test "$solaris" = "yes" ; then
 fi
 
 if test -z "${target_list+xxx}" ; then
+    default_targets=yes
     for target in $default_target_list; do
-        supported_target $target 2>/dev/null && \
-            target_list="$target_list $target"
+        target_list="$target_list $target"
     done
     target_list="${target_list# }"
 else
+    default_targets=no
     target_list=$(echo "$target_list" | sed -e 's/,/ /g')
     for target in $target_list; do
         # Check that we recognised the target name; this allows a more
@@ -2311,10 +2201,16 @@ else
                 error_exit "Unknown target name '$target'"
                 ;;
         esac
-        supported_target $target || exit 1
     done
 fi
 
+for target in $target_list; do
+    # if a deprecated target is enabled we note it here
+    if echo "$deprecated_targets_list" | grep -q "$target"; then
+        add_to deprecated_features $target
+    fi
+done
+
 # see if system emulation was really requested
 case " $target_list " in
   *"-softmmu "*) softmmu=yes
@@ -2655,28 +2551,6 @@ if test "$seccomp" != "no" ; then
     fi
 fi
 
-##########################################
-# simple accelerator probes
-
-if test "$kvm" != "disabled" ; then
-  if test "$linux" = yes ; then
-    kvm=enabled
-  else
-    if test "$kvm" = "enabled" ; then
-      feature_not_found "kvm" "KVM is only available on Linux"
-    fi
-    kvm=disabled
-  fi
-fi
-
-if test "$hax" = "auto" ; then
-  if test "$mingw" = yes || test "$darwin" = yes || test "$targetos" = NetBSD; then
-    hax=enabled
-  else
-    hax=disabled
-  fi
-fi
-
 ##########################################
 # xen probe
 
@@ -2995,23 +2869,6 @@ if test "$xen_pci_passthrough" != "disabled"; then
   fi
 fi
 
-##########################################
-# Windows Hypervisor Platform accelerator (WHPX) check
-if test "$whpx" != "disabled"; then
-    if test "$mingw32" = yes && test "$ARCH" = "x86_64" &&
-            check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
-        whpx="enabled"
-    else
-        if test "$whpx" = "enabled"; then
-            if test "$ARCH" != "x86_64"; then
-                error_exit "WHPX requires 64-bit host"
-            fi
-            feature_not_found "WinHvPlatform" "WinHvEmulation is not installed"
-        fi
-        whpx="disabled"
-    fi
-fi
-
 ##########################################
 # gettext probe
 if test "$gettext" != "false" ; then
@@ -5835,23 +5692,6 @@ fi
 
 
 #################################################
-# Check to see if we have the Hypervisor framework
-if [ "$hvf" != "disabled" ] ; then
-  cat > $TMPC << EOF
-#include <Hypervisor/hv.h>
-int main() { return 0;}
-EOF
-  if test "$darwin" = yes && compile_object ""; then
-    hvf='enabled'
-  else
-    if test "$hvf" = "enabled"; then
-	error_exit "Hypervisor.framework not available"
-    fi
-    hvf='disabled'
-  fi
-fi
-
-##########################################
 # check for sysmacros.h
 
 have_sysmacros=no
@@ -7386,283 +7226,13 @@ fi
 
 for target in $target_list; do
 target_dir="$target"
-config_target_mak=$target_dir/config-target.mak
 target_name=$(echo $target | cut -d '-' -f 1)
-target_aligned_only="no"
-case "$target_name" in
-  alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|sparc64|sparc32plus|xtensa|xtensaeb)
-  target_aligned_only="yes"
-  ;;
-esac
-target_bigendian="no"
-case "$target_name" in
-  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
-  target_bigendian="yes"
-  ;;
-esac
-target_softmmu="no"
-target_user_only="no"
-target_linux_user="no"
-target_bsd_user="no"
-case "$target" in
-  ${target_name}-softmmu)
-    target_softmmu="yes"
-    ;;
-  ${target_name}-linux-user)
-    target_user_only="yes"
-    target_linux_user="yes"
-    ;;
-  ${target_name}-bsd-user)
-    target_user_only="yes"
-    target_bsd_user="yes"
-    ;;
-  *)
-    error_exit "Target '$target' not recognised"
-    exit 1
-    ;;
-esac
-
 mkdir -p $target_dir
-echo "# Automatically generated by configure - do not modify" > $config_target_mak
-
-bflt="no"
-mttcg="no"
-interp_prefix1=$(echo "$interp_prefix" | sed "s/%M/$target_name/g")
-gdb_xml_files=""
-
-TARGET_ARCH="$target_name"
-TARGET_BASE_ARCH=""
-TARGET_ABI_DIR=""
-TARGET_SYSTBL_ABI=""
-TARGET_SYSTBL=""
-
-case "$target_name" in
-  i386)
-    mttcg="yes"
-    gdb_xml_files="i386-32bit.xml"
-    TARGET_SYSTBL_ABI=i386
-    TARGET_SYSTBL=syscall_32.tbl
-  ;;
-  x86_64)
-    TARGET_BASE_ARCH=i386
-    TARGET_SYSTBL_ABI=common,64
-    TARGET_SYSTBL=syscall_64.tbl
-    mttcg="yes"
-    gdb_xml_files="i386-64bit.xml"
-  ;;
-  alpha)
-    mttcg="yes"
-    TARGET_SYSTBL_ABI=common
-  ;;
-  arm|armeb)
-    TARGET_ARCH=arm
-    TARGET_SYSTBL_ABI=common,oabi
-    bflt="yes"
-    mttcg="yes"
-    gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
-  ;;
-  aarch64|aarch64_be)
-    TARGET_ARCH=aarch64
-    TARGET_BASE_ARCH=arm
-    bflt="yes"
-    mttcg="yes"
-    gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
-  ;;
-  avr)
-    gdb_xml_files="avr-cpu.xml"
-    target_compiler=$cross_cc_avr
-  ;;
-  cris)
-  ;;
-  hppa)
-    mttcg="yes"
-    TARGET_SYSTBL_ABI=common,32
-  ;;
-  lm32)
-  ;;
-  m68k)
-    bflt="yes"
-    gdb_xml_files="cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
-    TARGET_SYSTBL_ABI=common
-  ;;
-  microblaze|microblazeel)
-    TARGET_ARCH=microblaze
-    TARGET_SYSTBL_ABI=common
-    mttcg="yes"
-    bflt="yes"
-  ;;
-  mips|mipsel)
-    mttcg="yes"
-    TARGET_ARCH=mips
-    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
-    TARGET_SYSTBL_ABI=o32
-    TARGET_SYSTBL=syscall_o32.tbl
-  ;;
-  mipsn32|mipsn32el)
-    mttcg="yes"
-    TARGET_ARCH=mips64
-    TARGET_BASE_ARCH=mips
-    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
-    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
-    TARGET_SYSTBL_ABI=n32
-    TARGET_SYSTBL=syscall_n32.tbl
-  ;;
-  mips64|mips64el)
-    mttcg="no"
-    TARGET_ARCH=mips64
-    TARGET_BASE_ARCH=mips
-    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
-    TARGET_SYSTBL_ABI=n64
-    TARGET_SYSTBL=syscall_n64.tbl
-  ;;
-  moxie)
-  ;;
-  nios2)
-  ;;
-  or1k)
-    TARGET_ARCH=openrisc
-    TARGET_BASE_ARCH=openrisc
-  ;;
-  ppc)
-    gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
-    TARGET_SYSTBL_ABI=common,nospu,32
-  ;;
-  ppc64)
-    TARGET_BASE_ARCH=ppc
-    TARGET_ABI_DIR=ppc
-    TARGET_SYSTBL_ABI=common,nospu,64
-    mttcg=yes
-    gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-  ;;
-  ppc64le)
-    TARGET_ARCH=ppc64
-    TARGET_BASE_ARCH=ppc
-    TARGET_ABI_DIR=ppc
-    TARGET_SYSTBL_ABI=common,nospu,64
-    mttcg=yes
-    gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-  ;;
-  ppc64abi32)
-    TARGET_ARCH=ppc64
-    TARGET_BASE_ARCH=ppc
-    TARGET_ABI_DIR=ppc
-    TARGET_SYSTBL_ABI=common,nospu,32
-    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
-    gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-  ;;
-  riscv32)
-    TARGET_BASE_ARCH=riscv
-    TARGET_ABI_DIR=riscv
-    mttcg=yes
-    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
-  ;;
-  riscv64)
-    TARGET_BASE_ARCH=riscv
-    TARGET_ABI_DIR=riscv
-    mttcg=yes
-    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
-  ;;
-  rx)
-    TARGET_ARCH=rx
-    bflt="yes"
-    target_compiler=$cross_cc_rx
-    gdb_xml_files="rx-core.xml"
-  ;;
-  sh4|sh4eb)
-    TARGET_ARCH=sh4
-    TARGET_SYSTBL_ABI=common
-    bflt="yes"
-  ;;
-  sparc)
-    TARGET_SYSTBL_ABI=common,32
-  ;;
-  sparc64)
-    TARGET_BASE_ARCH=sparc
-    TARGET_SYSTBL_ABI=common,64
-  ;;
-  sparc32plus)
-    TARGET_ARCH=sparc64
-    TARGET_BASE_ARCH=sparc
-    TARGET_ABI_DIR=sparc
-    TARGET_SYSTBL_ABI=common,32
-    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
-  ;;
-  s390x)
-    TARGET_SYSTBL_ABI=common,64
-    mttcg=yes
-    gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
-  ;;
-  tilegx)
-  ;;
-  tricore)
-  ;;
-  unicore32)
-  ;;
-  xtensa|xtensaeb)
-    TARGET_ARCH=xtensa
-    TARGET_SYSTBL_ABI=common
-    bflt="yes"
-    mttcg="yes"
-  ;;
-  *)
-    error_exit "Unsupported target CPU"
-  ;;
-esac
-# TARGET_BASE_ARCH needs to be defined after TARGET_ARCH
-if [ "$TARGET_BASE_ARCH" = "" ]; then
-  TARGET_BASE_ARCH=$TARGET_ARCH
-fi
-if [ "$TARGET_SYSTBL_ABI" != "" ] && [ "$TARGET_SYSTBL" = "" ]; then
-  TARGET_SYSTBL=syscall.tbl
-fi
-
-upper() {
-    echo "$@"| LC_ALL=C tr '[a-z]' '[A-Z]'
-}
-
-target_arch_name="$(upper $TARGET_ARCH)"
-echo "TARGET_$target_arch_name=y" >> $config_target_mak
-echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
-if test "$target_user_only" = "yes" ; then
-  if [ "$TARGET_ABI_DIR" = "" ]; then
-    TARGET_ABI_DIR=$TARGET_ARCH
-  fi
-  echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
-fi
-if test "$target_linux_user" = "yes" ; then
-  if [ "$TARGET_SYSTBL_ABI" != "" ]; then
-    echo "TARGET_SYSTBL_ABI=$TARGET_SYSTBL_ABI" >> $config_target_mak
-    echo "TARGET_SYSTBL=$TARGET_SYSTBL" >> $config_target_mak
-  fi
-fi
-if test "$target_aligned_only" = "yes" ; then
-  echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
-fi
-if test "$target_bigendian" = "yes" ; then
-  echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
-fi
-if test "$target_softmmu" = "yes" ; then
-  if test "$mttcg" = "yes" ; then
-    echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
-  fi
-fi
 if test "$target_user_only" = "yes" ; then
   symlink "../qemu-$target_name" "$target_dir/qemu-$target_name"
 else
   symlink "../qemu-system-$target_name" "$target_dir/qemu-system-$target_name"
 fi
-list=""
-if test ! -z "$gdb_xml_files" ; then
-  for x in $gdb_xml_files; do
-    list="$list gdb-xml/$x"
-  done
-  echo "TARGET_XML_FILES=$list" >> $config_target_mak
-fi
-
-if test "$target_user_only" = "yes" && test "$bflt" = "yes"; then
-  echo "TARGET_HAS_BFLT=y" >> $config_target_mak
-fi
-
 done # for target in $targets
 
 if [ "$fdt" = "git" ]; then
@@ -7672,6 +7242,9 @@ if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
   subdirs="$subdirs capstone"
 fi
 echo "CONFIG_QEMU_INTERP_PREFIX=$interp_prefix" | sed 's/%M/@0@/' >> $config_host_mak
+if test "$default_targets" = "yes"; then
+  echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
+fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 if test -n "$LIBCAPSTONE"; then
   echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
diff --git a/default-configs/targets/aarch64-linux-user.mak b/default-configs/targets/aarch64-linux-user.mak
new file mode 100644
index 0000000000..4495e86509
--- /dev/null
+++ b/default-configs/targets/aarch64-linux-user.mak
@@ -0,0 +1,5 @@
+TARGET_AARCH64=y
+TARGET_BASE_ARCH=arm
+TARGET_ABI_DIR=aarch64
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/aarch64-softmmu.mak b/default-configs/targets/aarch64-softmmu.mak
new file mode 100644
index 0000000000..4eff428074
--- /dev/null
+++ b/default-configs/targets/aarch64-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_AARCH64=y
+TARGET_BASE_ARCH=arm
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/aarch64_be-linux-user.mak b/default-configs/targets/aarch64_be-linux-user.mak
new file mode 100644
index 0000000000..da13693d3d
--- /dev/null
+++ b/default-configs/targets/aarch64_be-linux-user.mak
@@ -0,0 +1,6 @@
+TARGET_AARCH64=y
+TARGET_BASE_ARCH=arm
+TARGET_ABI_DIR=aarch64
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/alpha-linux-user.mak b/default-configs/targets/alpha-linux-user.mak
new file mode 100644
index 0000000000..5ff89f5d48
--- /dev/null
+++ b/default-configs/targets/alpha-linux-user.mak
@@ -0,0 +1,6 @@
+TARGET_ALPHA=y
+TARGET_BASE_ARCH=alpha
+TARGET_ABI_DIR=alpha
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/alpha-softmmu.mak b/default-configs/targets/alpha-softmmu.mak
new file mode 100644
index 0000000000..8a484c9775
--- /dev/null
+++ b/default-configs/targets/alpha-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_ALPHA=y
+TARGET_BASE_ARCH=alpha
+TARGET_ALIGNED_ONLY=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/arm-linux-user.mak b/default-configs/targets/arm-linux-user.mak
new file mode 100644
index 0000000000..7c54c3c2a2
--- /dev/null
+++ b/default-configs/targets/arm-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_ARM=y
+TARGET_BASE_ARCH=arm
+TARGET_ABI_DIR=arm
+TARGET_SYSTBL_ABI=common,oabi
+TARGET_SYSTBL=syscall.tbl
+TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/arm-softmmu.mak b/default-configs/targets/arm-softmmu.mak
new file mode 100644
index 0000000000..5923f9b203
--- /dev/null
+++ b/default-configs/targets/arm-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_ARM=y
+TARGET_BASE_ARCH=arm
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/armeb-linux-user.mak b/default-configs/targets/armeb-linux-user.mak
new file mode 100644
index 0000000000..1882aa472d
--- /dev/null
+++ b/default-configs/targets/armeb-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_ARM=y
+TARGET_BASE_ARCH=arm
+TARGET_ABI_DIR=arm
+TARGET_SYSTBL_ABI=common,oabi
+TARGET_SYSTBL=syscall.tbl
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/avr-softmmu.mak b/default-configs/targets/avr-softmmu.mak
new file mode 100644
index 0000000000..46b6da717c
--- /dev/null
+++ b/default-configs/targets/avr-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_AVR=y
+TARGET_BASE_ARCH=avr
+TARGET_XML_FILES= gdb-xml/avr-cpu.xml
diff --git a/default-configs/targets/cris-linux-user.mak b/default-configs/targets/cris-linux-user.mak
new file mode 100644
index 0000000000..ba61135172
--- /dev/null
+++ b/default-configs/targets/cris-linux-user.mak
@@ -0,0 +1,3 @@
+TARGET_CRIS=y
+TARGET_BASE_ARCH=cris
+TARGET_ABI_DIR=cris
diff --git a/default-configs/targets/cris-softmmu.mak b/default-configs/targets/cris-softmmu.mak
new file mode 100644
index 0000000000..1f7b44114b
--- /dev/null
+++ b/default-configs/targets/cris-softmmu.mak
@@ -0,0 +1,2 @@
+TARGET_CRIS=y
+TARGET_BASE_ARCH=cris
diff --git a/default-configs/targets/hppa-linux-user.mak b/default-configs/targets/hppa-linux-user.mak
new file mode 100644
index 0000000000..94222e8fc6
--- /dev/null
+++ b/default-configs/targets/hppa-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_HPPA=y
+TARGET_BASE_ARCH=hppa
+TARGET_ABI_DIR=hppa
+TARGET_SYSTBL_ABI=common,32
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/hppa-softmmu.mak b/default-configs/targets/hppa-softmmu.mak
new file mode 100644
index 0000000000..c4ee4e6c51
--- /dev/null
+++ b/default-configs/targets/hppa-softmmu.mak
@@ -0,0 +1,5 @@
+TARGET_HPPA=y
+TARGET_BASE_ARCH=hppa
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/i386-bsd-user.mak b/default-configs/targets/i386-bsd-user.mak
new file mode 100644
index 0000000000..c58db819ae
--- /dev/null
+++ b/default-configs/targets/i386-bsd-user.mak
@@ -0,0 +1,4 @@
+TARGET_I386=y
+TARGET_BASE_ARCH=i386
+TARGET_ABI_DIR=i386
+TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-linux-user.mak b/default-configs/targets/i386-linux-user.mak
new file mode 100644
index 0000000000..34b52e9ee2
--- /dev/null
+++ b/default-configs/targets/i386-linux-user.mak
@@ -0,0 +1,6 @@
+TARGET_I386=y
+TARGET_BASE_ARCH=i386
+TARGET_ABI_DIR=i386
+TARGET_SYSTBL_ABI=i386
+TARGET_SYSTBL=syscall_32.tbl
+TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-softmmu.mak b/default-configs/targets/i386-softmmu.mak
new file mode 100644
index 0000000000..4e2eb9f369
--- /dev/null
+++ b/default-configs/targets/i386-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_I386=y
+TARGET_BASE_ARCH=i386
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/lm32-softmmu.mak b/default-configs/targets/lm32-softmmu.mak
new file mode 100644
index 0000000000..2c4b8eab79
--- /dev/null
+++ b/default-configs/targets/lm32-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_LM32=y
+TARGET_BASE_ARCH=lm32
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/m68k-linux-user.mak b/default-configs/targets/m68k-linux-user.mak
new file mode 100644
index 0000000000..e7c0af5881
--- /dev/null
+++ b/default-configs/targets/m68k-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_M68K=y
+TARGET_BASE_ARCH=m68k
+TARGET_ABI_DIR=m68k
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/m68k-softmmu.mak b/default-configs/targets/m68k-softmmu.mak
new file mode 100644
index 0000000000..991e626677
--- /dev/null
+++ b/default-configs/targets/m68k-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_M68K=y
+TARGET_BASE_ARCH=m68k
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
diff --git a/default-configs/targets/microblaze-linux-user.mak b/default-configs/targets/microblaze-linux-user.mak
new file mode 100644
index 0000000000..809819424d
--- /dev/null
+++ b/default-configs/targets/microblaze-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_MICROBLAZE=y
+TARGET_BASE_ARCH=microblaze
+TARGET_ABI_DIR=microblaze
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_WORDS_BIGENDIAN=y
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/microblaze-softmmu.mak b/default-configs/targets/microblaze-softmmu.mak
new file mode 100644
index 0000000000..24594862bf
--- /dev/null
+++ b/default-configs/targets/microblaze-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_MICROBLAZE=y
+TARGET_BASE_ARCH=microblaze
+TARGET_WORDS_BIGENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/microblazeel-linux-user.mak b/default-configs/targets/microblazeel-linux-user.mak
new file mode 100644
index 0000000000..416b42eeb6
--- /dev/null
+++ b/default-configs/targets/microblazeel-linux-user.mak
@@ -0,0 +1,6 @@
+TARGET_MICROBLAZE=y
+TARGET_BASE_ARCH=microblaze
+TARGET_ABI_DIR=microblaze
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/microblazeel-softmmu.mak b/default-configs/targets/microblazeel-softmmu.mak
new file mode 100644
index 0000000000..5817a63755
--- /dev/null
+++ b/default-configs/targets/microblazeel-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_MICROBLAZE=y
+TARGET_BASE_ARCH=microblaze
+TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips-linux-user.mak b/default-configs/targets/mips-linux-user.mak
new file mode 100644
index 0000000000..bcfff16a7b
--- /dev/null
+++ b/default-configs/targets/mips-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_ABI_MIPSO32=y
+TARGET_MIPS=y
+TARGET_BASE_ARCH=mips
+TARGET_ABI_DIR=mips
+TARGET_SYSTBL_ABI=o32
+TARGET_SYSTBL=syscall_o32.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/mips-softmmu.mak b/default-configs/targets/mips-softmmu.mak
new file mode 100644
index 0000000000..1b4bba6e3b
--- /dev/null
+++ b/default-configs/targets/mips-softmmu.mak
@@ -0,0 +1,5 @@
+TARGET_MIPS=y
+TARGET_BASE_ARCH=mips
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips64-linux-user.mak b/default-configs/targets/mips64-linux-user.mak
new file mode 100644
index 0000000000..c02c5460a7
--- /dev/null
+++ b/default-configs/targets/mips64-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_ABI_MIPSN64=y
+TARGET_MIPS64=y
+TARGET_BASE_ARCH=mips
+TARGET_ABI_DIR=mips64
+TARGET_SYSTBL_ABI=n64
+TARGET_SYSTBL=syscall_n64.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/mips64-softmmu.mak b/default-configs/targets/mips64-softmmu.mak
new file mode 100644
index 0000000000..736586f01b
--- /dev/null
+++ b/default-configs/targets/mips64-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_MIPS64=y
+TARGET_BASE_ARCH=mips
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/mips64el-linux-user.mak b/default-configs/targets/mips64el-linux-user.mak
new file mode 100644
index 0000000000..8cbbc38e78
--- /dev/null
+++ b/default-configs/targets/mips64el-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_ABI_MIPSN64=y
+TARGET_MIPS64=y
+TARGET_BASE_ARCH=mips
+TARGET_ABI_DIR=mips64
+TARGET_SYSTBL_ABI=n64
+TARGET_SYSTBL=syscall_n64.tbl
+TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mips64el-softmmu.mak b/default-configs/targets/mips64el-softmmu.mak
new file mode 100644
index 0000000000..aed4fe89b0
--- /dev/null
+++ b/default-configs/targets/mips64el-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_MIPS64=y
+TARGET_BASE_ARCH=mips
+TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-linux-user.mak b/default-configs/targets/mipsel-linux-user.mak
new file mode 100644
index 0000000000..26aa9c8279
--- /dev/null
+++ b/default-configs/targets/mipsel-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_ABI_MIPSO32=y
+TARGET_MIPS=y
+TARGET_BASE_ARCH=mips
+TARGET_ABI_DIR=mips
+TARGET_SYSTBL_ABI=o32
+TARGET_SYSTBL=syscall_o32.tbl
+TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-softmmu.mak b/default-configs/targets/mipsel-softmmu.mak
new file mode 100644
index 0000000000..ca95b39d29
--- /dev/null
+++ b/default-configs/targets/mipsel-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_MIPS=y
+TARGET_BASE_ARCH=mips
+TARGET_ALIGNED_ONLY=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mipsn32-linux-user.mak b/default-configs/targets/mipsn32-linux-user.mak
new file mode 100644
index 0000000000..81d548e699
--- /dev/null
+++ b/default-configs/targets/mipsn32-linux-user.mak
@@ -0,0 +1,9 @@
+TARGET_ABI_MIPSN32=y
+TARGET_ABI32=y
+TARGET_MIPS64=y
+TARGET_BASE_ARCH=mips
+TARGET_ABI_DIR=mips64
+TARGET_SYSTBL_ABI=n32
+TARGET_SYSTBL=syscall_n32.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/mipsn32el-linux-user.mak b/default-configs/targets/mipsn32el-linux-user.mak
new file mode 100644
index 0000000000..6de47f2a79
--- /dev/null
+++ b/default-configs/targets/mipsn32el-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_ABI_MIPSN32=y
+TARGET_ABI32=y
+TARGET_MIPS64=y
+TARGET_BASE_ARCH=mips
+TARGET_ABI_DIR=mips64
+TARGET_SYSTBL_ABI=n32
+TARGET_SYSTBL=syscall_n32.tbl
+TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/moxie-softmmu.mak b/default-configs/targets/moxie-softmmu.mak
new file mode 100644
index 0000000000..ada92a6b5b
--- /dev/null
+++ b/default-configs/targets/moxie-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_MOXIE=y
+TARGET_BASE_ARCH=moxie
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/nios2-linux-user.mak b/default-configs/targets/nios2-linux-user.mak
new file mode 100644
index 0000000000..a2308a16aa
--- /dev/null
+++ b/default-configs/targets/nios2-linux-user.mak
@@ -0,0 +1,3 @@
+TARGET_NIOS2=y
+TARGET_BASE_ARCH=nios2
+TARGET_ABI_DIR=nios2
diff --git a/default-configs/targets/nios2-softmmu.mak b/default-configs/targets/nios2-softmmu.mak
new file mode 100644
index 0000000000..f10f08d0ca
--- /dev/null
+++ b/default-configs/targets/nios2-softmmu.mak
@@ -0,0 +1,2 @@
+TARGET_NIOS2=y
+TARGET_BASE_ARCH=nios2
diff --git a/default-configs/targets/or1k-linux-user.mak b/default-configs/targets/or1k-linux-user.mak
new file mode 100644
index 0000000000..2f5ff844df
--- /dev/null
+++ b/default-configs/targets/or1k-linux-user.mak
@@ -0,0 +1,4 @@
+TARGET_OPENRISC=y
+TARGET_BASE_ARCH=openrisc
+TARGET_ABI_DIR=openrisc
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/or1k-softmmu.mak b/default-configs/targets/or1k-softmmu.mak
new file mode 100644
index 0000000000..a922266a98
--- /dev/null
+++ b/default-configs/targets/or1k-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_OPENRISC=y
+TARGET_BASE_ARCH=openrisc
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/ppc-linux-user.mak b/default-configs/targets/ppc-linux-user.mak
new file mode 100644
index 0000000000..c4d912bfb1
--- /dev/null
+++ b/default-configs/targets/ppc-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_PPC=y
+TARGET_BASE_ARCH=ppc
+TARGET_ABI_DIR=ppc
+TARGET_SYSTBL_ABI=common,nospu,32
+TARGET_SYSTBL=syscall.tbl
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
diff --git a/default-configs/targets/ppc-softmmu.mak b/default-configs/targets/ppc-softmmu.mak
new file mode 100644
index 0000000000..1b6d091cfb
--- /dev/null
+++ b/default-configs/targets/ppc-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_PPC=y
+TARGET_BASE_ARCH=ppc
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
diff --git a/default-configs/targets/ppc64-linux-user.mak b/default-configs/targets/ppc64-linux-user.mak
new file mode 100644
index 0000000000..7f96ab7e9d
--- /dev/null
+++ b/default-configs/targets/ppc64-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_PPC64=y
+TARGET_BASE_ARCH=ppc
+TARGET_ABI_DIR=ppc
+TARGET_SYSTBL_ABI=common,nospu,64
+TARGET_SYSTBL=syscall.tbl
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
diff --git a/default-configs/targets/ppc64-softmmu.mak b/default-configs/targets/ppc64-softmmu.mak
new file mode 100644
index 0000000000..e431feffeb
--- /dev/null
+++ b/default-configs/targets/ppc64-softmmu.mak
@@ -0,0 +1,5 @@
+TARGET_PPC64=y
+TARGET_BASE_ARCH=ppc
+TARGET_WORDS_BIGENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
diff --git a/default-configs/targets/ppc64abi32-linux-user.mak b/default-configs/targets/ppc64abi32-linux-user.mak
new file mode 100644
index 0000000000..13a02700aa
--- /dev/null
+++ b/default-configs/targets/ppc64abi32-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_ABI32=y
+TARGET_PPC64=y
+TARGET_BASE_ARCH=ppc
+TARGET_ABI_DIR=ppc
+TARGET_SYSTBL_ABI=common,nospu,32
+TARGET_SYSTBL=syscall.tbl
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
diff --git a/default-configs/targets/ppc64le-linux-user.mak b/default-configs/targets/ppc64le-linux-user.mak
new file mode 100644
index 0000000000..3dd54b894c
--- /dev/null
+++ b/default-configs/targets/ppc64le-linux-user.mak
@@ -0,0 +1,6 @@
+TARGET_PPC64=y
+TARGET_BASE_ARCH=ppc
+TARGET_ABI_DIR=ppc
+TARGET_SYSTBL_ABI=common,nospu,64
+TARGET_SYSTBL=syscall.tbl
+TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
diff --git a/default-configs/targets/riscv32-linux-user.mak b/default-configs/targets/riscv32-linux-user.mak
new file mode 100644
index 0000000000..91d72a46b0
--- /dev/null
+++ b/default-configs/targets/riscv32-linux-user.mak
@@ -0,0 +1,4 @@
+TARGET_RISCV32=y
+TARGET_BASE_ARCH=riscv
+TARGET_ABI_DIR=riscv
+TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
diff --git a/default-configs/targets/riscv32-softmmu.mak b/default-configs/targets/riscv32-softmmu.mak
new file mode 100644
index 0000000000..caa5829af8
--- /dev/null
+++ b/default-configs/targets/riscv32-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_RISCV32=y
+TARGET_BASE_ARCH=riscv
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
diff --git a/default-configs/targets/riscv64-linux-user.mak b/default-configs/targets/riscv64-linux-user.mak
new file mode 100644
index 0000000000..9e53193cdb
--- /dev/null
+++ b/default-configs/targets/riscv64-linux-user.mak
@@ -0,0 +1,4 @@
+TARGET_RISCV64=y
+TARGET_BASE_ARCH=riscv
+TARGET_ABI_DIR=riscv
+TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
diff --git a/default-configs/targets/riscv64-softmmu.mak b/default-configs/targets/riscv64-softmmu.mak
new file mode 100644
index 0000000000..e190c0363b
--- /dev/null
+++ b/default-configs/targets/riscv64-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_RISCV64=y
+TARGET_BASE_ARCH=riscv
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
diff --git a/default-configs/targets/rx-softmmu.mak b/default-configs/targets/rx-softmmu.mak
new file mode 100644
index 0000000000..37b365475f
--- /dev/null
+++ b/default-configs/targets/rx-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_RX=y
+TARGET_BASE_ARCH=rx
+TARGET_XML_FILES= gdb-xml/rx-core.xml
diff --git a/default-configs/targets/s390x-linux-user.mak b/default-configs/targets/s390x-linux-user.mak
new file mode 100644
index 0000000000..77ebec769f
--- /dev/null
+++ b/default-configs/targets/s390x-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_S390X=y
+TARGET_BASE_ARCH=s390x
+TARGET_ABI_DIR=s390x
+TARGET_SYSTBL_ABI=common,64
+TARGET_SYSTBL=syscall.tbl
+TARGET_WORDS_BIGENDIAN=y
+TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml
diff --git a/default-configs/targets/s390x-softmmu.mak b/default-configs/targets/s390x-softmmu.mak
new file mode 100644
index 0000000000..f08d25d3c3
--- /dev/null
+++ b/default-configs/targets/s390x-softmmu.mak
@@ -0,0 +1,5 @@
+TARGET_S390X=y
+TARGET_BASE_ARCH=s390x
+TARGET_WORDS_BIGENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml
diff --git a/default-configs/targets/sh4-linux-user.mak b/default-configs/targets/sh4-linux-user.mak
new file mode 100644
index 0000000000..4292dd6128
--- /dev/null
+++ b/default-configs/targets/sh4-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_SH4=y
+TARGET_BASE_ARCH=sh4
+TARGET_ABI_DIR=sh4
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/sh4-softmmu.mak b/default-configs/targets/sh4-softmmu.mak
new file mode 100644
index 0000000000..8c7e9eaa7b
--- /dev/null
+++ b/default-configs/targets/sh4-softmmu.mak
@@ -0,0 +1,3 @@
+TARGET_SH4=y
+TARGET_BASE_ARCH=sh4
+TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4eb-linux-user.mak b/default-configs/targets/sh4eb-linux-user.mak
new file mode 100644
index 0000000000..cf9178f4ea
--- /dev/null
+++ b/default-configs/targets/sh4eb-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_SH4=y
+TARGET_BASE_ARCH=sh4
+TARGET_ABI_DIR=sh4
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/sh4eb-softmmu.mak b/default-configs/targets/sh4eb-softmmu.mak
new file mode 100644
index 0000000000..f1848b89b6
--- /dev/null
+++ b/default-configs/targets/sh4eb-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_SH4=y
+TARGET_BASE_ARCH=sh4
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-bsd-user.mak b/default-configs/targets/sparc-bsd-user.mak
new file mode 100644
index 0000000000..f478255591
--- /dev/null
+++ b/default-configs/targets/sparc-bsd-user.mak
@@ -0,0 +1,5 @@
+TARGET_SPARC=y
+TARGET_BASE_ARCH=sparc
+TARGET_ABI_DIR=sparc
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-linux-user.mak b/default-configs/targets/sparc-linux-user.mak
new file mode 100644
index 0000000000..7f2fcba978
--- /dev/null
+++ b/default-configs/targets/sparc-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_SPARC=y
+TARGET_BASE_ARCH=sparc
+TARGET_ABI_DIR=sparc
+TARGET_SYSTBL_ABI=common,32
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-softmmu.mak b/default-configs/targets/sparc-softmmu.mak
new file mode 100644
index 0000000000..fb3dbb0d61
--- /dev/null
+++ b/default-configs/targets/sparc-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_SPARC=y
+TARGET_BASE_ARCH=sparc
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc32plus-linux-user.mak b/default-configs/targets/sparc32plus-linux-user.mak
new file mode 100644
index 0000000000..f5fcb7879e
--- /dev/null
+++ b/default-configs/targets/sparc32plus-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_ABI32=y
+TARGET_SPARC64=y
+TARGET_BASE_ARCH=sparc
+TARGET_ABI_DIR=sparc
+TARGET_SYSTBL_ABI=common,32
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-bsd-user.mak b/default-configs/targets/sparc64-bsd-user.mak
new file mode 100644
index 0000000000..0ae8ea5420
--- /dev/null
+++ b/default-configs/targets/sparc64-bsd-user.mak
@@ -0,0 +1,5 @@
+TARGET_SPARC64=y
+TARGET_BASE_ARCH=sparc
+TARGET_ABI_DIR=sparc64
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-linux-user.mak b/default-configs/targets/sparc64-linux-user.mak
new file mode 100644
index 0000000000..817529e587
--- /dev/null
+++ b/default-configs/targets/sparc64-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_SPARC64=y
+TARGET_BASE_ARCH=sparc
+TARGET_ABI_DIR=sparc64
+TARGET_SYSTBL_ABI=common,64
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-softmmu.mak b/default-configs/targets/sparc64-softmmu.mak
new file mode 100644
index 0000000000..bc07bfdb0a
--- /dev/null
+++ b/default-configs/targets/sparc64-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_SPARC64=y
+TARGET_BASE_ARCH=sparc
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/tilegx-linux-user.mak b/default-configs/targets/tilegx-linux-user.mak
new file mode 100644
index 0000000000..064d3320d7
--- /dev/null
+++ b/default-configs/targets/tilegx-linux-user.mak
@@ -0,0 +1,3 @@
+TARGET_TILEGX=y
+TARGET_BASE_ARCH=tilegx
+TARGET_ABI_DIR=tilegx
diff --git a/default-configs/targets/tricore-softmmu.mak b/default-configs/targets/tricore-softmmu.mak
new file mode 100644
index 0000000000..a29aa2d6dd
--- /dev/null
+++ b/default-configs/targets/tricore-softmmu.mak
@@ -0,0 +1,2 @@
+TARGET_TRICORE=y
+TARGET_BASE_ARCH=tricore
diff --git a/default-configs/targets/unicore32-softmmu.mak b/default-configs/targets/unicore32-softmmu.mak
new file mode 100644
index 0000000000..85f37dc88f
--- /dev/null
+++ b/default-configs/targets/unicore32-softmmu.mak
@@ -0,0 +1,2 @@
+TARGET_UNICORE32=y
+TARGET_BASE_ARCH=unicore32
diff --git a/default-configs/targets/x86_64-bsd-user.mak b/default-configs/targets/x86_64-bsd-user.mak
new file mode 100644
index 0000000000..935b10e22c
--- /dev/null
+++ b/default-configs/targets/x86_64-bsd-user.mak
@@ -0,0 +1,4 @@
+TARGET_X86_64=y
+TARGET_BASE_ARCH=i386
+TARGET_ABI_DIR=x86_64
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/x86_64-linux-user.mak b/default-configs/targets/x86_64-linux-user.mak
new file mode 100644
index 0000000000..6a9418f9ff
--- /dev/null
+++ b/default-configs/targets/x86_64-linux-user.mak
@@ -0,0 +1,6 @@
+TARGET_X86_64=y
+TARGET_BASE_ARCH=i386
+TARGET_ABI_DIR=x86_64
+TARGET_SYSTBL_ABI=common,64
+TARGET_SYSTBL=syscall_64.tbl
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/x86_64-softmmu.mak b/default-configs/targets/x86_64-softmmu.mak
new file mode 100644
index 0000000000..377c63e823
--- /dev/null
+++ b/default-configs/targets/x86_64-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_X86_64=y
+TARGET_BASE_ARCH=i386
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/xtensa-linux-user.mak b/default-configs/targets/xtensa-linux-user.mak
new file mode 100644
index 0000000000..63d9cff69f
--- /dev/null
+++ b/default-configs/targets/xtensa-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_XTENSA=y
+TARGET_BASE_ARCH=xtensa
+TARGET_ABI_DIR=xtensa
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/xtensa-softmmu.mak b/default-configs/targets/xtensa-softmmu.mak
new file mode 100644
index 0000000000..96f892c4a8
--- /dev/null
+++ b/default-configs/targets/xtensa-softmmu.mak
@@ -0,0 +1,4 @@
+TARGET_XTENSA=y
+TARGET_BASE_ARCH=xtensa
+TARGET_ALIGNED_ONLY=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/xtensaeb-linux-user.mak b/default-configs/targets/xtensaeb-linux-user.mak
new file mode 100644
index 0000000000..e66b7dd0e3
--- /dev/null
+++ b/default-configs/targets/xtensaeb-linux-user.mak
@@ -0,0 +1,8 @@
+TARGET_XTENSA=y
+TARGET_BASE_ARCH=xtensa
+TARGET_ABI_DIR=xtensa
+TARGET_SYSTBL_ABI=common
+TARGET_SYSTBL=syscall.tbl
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
+TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/xtensaeb-softmmu.mak b/default-configs/targets/xtensaeb-softmmu.mak
new file mode 100644
index 0000000000..e6f53a1272
--- /dev/null
+++ b/default-configs/targets/xtensaeb-softmmu.mak
@@ -0,0 +1,5 @@
+TARGET_XTENSA=y
+TARGET_BASE_ARCH=xtensa
+TARGET_ALIGNED_ONLY=y
+TARGET_WORDS_BIGENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/meson.build b/meson.build
index 3bd8cbacb7..d25ead3ad5 100644
--- a/meson.build
+++ b/meson.build
@@ -721,13 +721,25 @@ kconfig_external_symbols = [
 ]
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 
+default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
+actual_target_dirs = []
 foreach target : target_dirs
   config_target = { 'TARGET_NAME': target.split('-')[0] }
   if target.endswith('linux-user')
-    assert(targetos == 'linux')
+    if targetos != 'linux'
+      if default_targets
+        continue
+      endif
+      error('Target @0@ is only available on a Linux host'.format(target))
+    endif
     config_target += { 'CONFIG_LINUX_USER': 'y' }
   elif target.endswith('bsd-user')
-    assert('CONFIG_BSD' in config_host)
+    if not 'CONFIG_BSD' in config_host
+      if default_targets
+        continue
+      endif
+      error('Target @0@ is only available on a BSD host'.format(target))
+    endif
     config_target += { 'CONFIG_BSD_USER': 'y' }
   elif target.endswith('softmmu')
     config_target += { 'CONFIG_SOFTMMU': 'y' }
@@ -751,8 +763,14 @@ foreach target : target_dirs
     endif
     have_accel = true
   endforeach
-  assert(have_accel)
+  if not have_accel
+    if default_targets
+      continue
+    endif
+    error('No accelerator available for target @0@'.format(target))
+  endif
 
+  actual_target_dirs += target
   config_target += keyval.load('default-configs/targets' / target + '.mak')
 
   foreach k, v: disassemblers
@@ -814,6 +832,7 @@ foreach target : target_dirs
   endif
   config_target_mak += {target: config_target}
 endforeach
+target_dirs = actual_target_dirs
 
 # This configuration is used to build files that are shared by
 # multiple binaries, and then extracted out of the "common"
@@ -1599,7 +1618,7 @@ if config_host.has_key('CONFIG_MODULES')
 endif
 summary_info += {'host CPU':          cpu}
 summary_info += {'host endianness':   build_machine.endian()}
-summary_info += {'target list':       config_host['TARGET_DIRS']}
+summary_info += {'target list':       ' '.join(target_dirs)}
 summary_info += {'gprof enabled':     config_host.has_key('CONFIG_GPROF')}
 summary_info += {'sparse enabled':    meson.get_compiler('c').cmd_array().contains('cgcc')}
 summary_info += {'strip binaries':    get_option('strip')}
-- 
2.26.2



