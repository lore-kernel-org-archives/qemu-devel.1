Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F1EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8EA207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwnaOIPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8EA207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi7E-0004b1-HI
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4a-0000bj-1o
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4V-0005Rh-T1
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g62JLdVzZ+lYru1vuaaHc3s3y6QR6Xc2NvMfJYPMMUA=;
 b=AwnaOIPfcLMBbnv2hUjlhT1PNBLhsuVHE6ttkqg8FIj+qAFF1zyS93uUrmRbSvW+ZWtYMO
 dS4i8T77ZocrEi1VNoCLotUAWvTPvMWap1KvXnSKWLQTm2aGqDMCVDivVTmox4LNWTK1PN
 ByBFcHIuje+u4auwK7fMVgBnFO+LIUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-ZysuvIkDNPivcUzTFJ8Owg-1; Sun, 11 Oct 2020 16:35:56 -0400
X-MC-Unique: ZysuvIkDNPivcUzTFJ8Owg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ACA52FD01
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:35:55 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC155DA30;
 Sun, 11 Oct 2020 20:35:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 03/15] build-sys: add --with-rust{-target} & basic build
 infrastructure
Date: Mon, 12 Oct 2020 00:35:01 +0400
Message-Id: <20201011203513.1621355-4-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add the build-sys infrastructure to build Rust code. Introduce a
top-level workspace, so various sub-projects (libraries, executables
etc) can be developed together, sharing the dependencies and output
directory.

If not Tier 1, many of the platforms QEMU supports are considered Tier
2: https://doc.rust-lang.org/nightly/rustc/platform-support.html

Rust is generally available on various distributions (thanks to Firefox,
I suppose). If not, it can usually be installed with rustup by
developpers.

configure will enable Rust support automatically if cargo is present.
Rust support can be disabled --without-rust. When detecting windows
cross building, it will use the $cpu-pc-windows-gnu target by
default (more default mappings could be added over time). This can be
changed with --with-rust-target=RTT.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Cargo.toml  |  2 ++
 configure   | 18 ++++++++++++++++++
 meson.build | 23 +++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 Cargo.toml

diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 0000000000..c4b464ff15
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,2 @@
+[workspace]
+members = []
diff --git a/configure b/configure
index b553288c5e..7945ceac63 100755
--- a/configure
+++ b/configure
@@ -446,6 +446,8 @@ meson=""
 ninja=""
 skip_meson=no
 gettext=""
+with_rust="auto"
+with_rust_target=""
 
 bogus_os="no"
 malloc_trim="auto"
@@ -1519,6 +1521,12 @@ for opt do
   ;;
   --disable-libdaxctl) libdaxctl=no
   ;;
+  --with-rust) with_rust=yes
+  ;;
+  --without-rust) with_rust=no
+  ;;
+  --with-rust-target=*) with_rust_target="$optarg"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1666,6 +1674,8 @@ Advanced options (experts only):
   --extra-ldflags=LDFLAGS  append extra linker flags LDFLAGS
   --cross-cc-ARCH=CC       use compiler when building ARCH guest test cases
   --cross-cc-flags-ARCH=   use compiler flags when building ARCH guest tests
+  --with-rust              enable Rust compilation
+  --with-rust-target=RTT   use the given Rust target triple
   --make=MAKE              use specified make [$make]
   --python=PYTHON          use specified python [$python]
   --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
@@ -1918,6 +1928,10 @@ if test -z "$ninja"; then
     done
 fi
 
+if test "$with_rust" = auto && has cargo; then
+    with_rust=yes
+fi
+
 # Check that the C compiler works. Doing this here before testing
 # the host CPU ensures that we had a valid CC to autodetect the
 # $cpu var (and we should bail right here if that's not the case).
@@ -7046,6 +7060,10 @@ fi
 if test "$safe_stack" = "yes"; then
   echo "CONFIG_SAFESTACK=y" >> $config_host_mak
 fi
+if test "$with_rust" = "yes" ; then
+  echo "CONFIG_WITH_RUST=y" >> $config_host_mak
+  echo "CONFIG_WITH_RUST_TARGET=$with_rust_target" >> $config_host_mak
+fi
 
 # If we're using a separate build tree, set it up now.
 # DIRS are directories which we simply mkdir in the build tree;
diff --git a/meson.build b/meson.build
index 17c89c87c6..d8526dc999 100644
--- a/meson.build
+++ b/meson.build
@@ -73,6 +73,28 @@ if cpu in ['x86', 'x86_64']
   }
 endif
 
+with_rust = 'CONFIG_WITH_RUST' in config_host
+cargo = find_program('cargo', required: with_rust)
+
+if with_rust
+  rs_target_triple = config_host['CONFIG_WITH_RUST_TARGET']
+  if meson.is_cross_build()
+    # more default target mappings may be added over time
+    if rs_target_triple == '' and targetos == 'windows'
+      rs_target_triple = host_machine.cpu() + '-pc-windows-gnu'
+    endif
+    if rs_target_triple == ''
+      error('cross-compiling, but no Rust target-triple defined.')
+    endif
+  endif
+endif
+
+if get_option('optimization') in ['0', '1', 'g']
+  rs_build_type = 'debug'
+else
+  rs_build_type = 'release'
+endif
+
 ##################
 # Compiler flags #
 ##################
@@ -1770,6 +1792,7 @@ endif
 if targetos == 'darwin'
   summary_info += {'Objective-C compiler': meson.get_compiler('objc').cmd_array()[0]}
 endif
+summary_info += {'Rust support':      with_rust}
 summary_info += {'ARFLAGS':           config_host['ARFLAGS']}
 summary_info += {'CFLAGS':            ' '.join(get_option('c_args')
                                                + ['-O' + get_option('optimization')]
-- 
2.28.0


