Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA04FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC462082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EI1fy+cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC462082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Ie-0008L7-J4
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mb-0002RJ-Gj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mZ-0001KQ-Lq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mZ-0001KA-Ey
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so2548970wma.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CM8rduArDqqabgd+Q5UUF66iucomwd7DJwe474OgRXM=;
 b=EI1fy+cNslWhqY31RZJBm/N1TQKD/yZFrvCP9EcqCWzIblgirdgxhSQRHTrCo505x8
 z74xQnLE8y4uw5YmdLU5dwCoi/AHKHf0I00p5eQjwHC/x/YrO1O7LQXhczwk9SpgIMbG
 PSUiPztKTuoWLxODIhUzFmzFMmj91uINyOGE/vMaBAfqd286Kk6lWsfqikytPxlabwwA
 aRfgv1EYI7iyPY9+6TsZD24iQ3JVbUtCPf6r2vUDHs4hp8X46c3z1EbhT66Xed4l+Gva
 FJtZgmjAoF7Gi5R+D7IoXyD6E0ODvwVdxGBHzZ5iKumDRQ7toEYeyWUVy4cfnYJmgz1p
 xnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CM8rduArDqqabgd+Q5UUF66iucomwd7DJwe474OgRXM=;
 b=riQ7Bi2qF68heFZwv1bQD9oC+ZlTiapbvW19qnSmw4XdJRNGjtvyaVyjxs8lRnUOV6
 zSsw5Bu4Lr11iNwuHn2PAWLyISFm4F0Rkac3lCILBGUWj8315oPIYZHc0/HgzLx5bkbM
 iqgRBy6XdKK/Jev4rISchkq31gHRndxTCN/jK3agew0gRl3uaeYu4fkQFiRuNZhEqGa2
 8Zqz1mcnrczYGwNUAeHIXiMdTDQw1Wbue336XVWqvBeA8+Q8qa9tXWao50dEBpUu0H7k
 RLsAG1Yr/Nbm3/owE7WwQN2QRoe/2Fh5DGKeWgu0CmooHVTb8x1VUA+5nQmSZ75mCnuJ
 fS9w==
X-Gm-Message-State: APjAAAXGqLOX9NGwPH7AHUBIDWkdchd1GjtKpCGIvaZRIvsIvSFVqI4Q
 GsWbHMRV4HvULVf5D5iX84P5x+Lsng0=
X-Google-Smtp-Source: APXvYqyKUGq02fZOoPTq6bImFqROhVGlVOuFWJSwNOJYbmatRj8twMwEzXUM0YTodD3sLVbyoLlryg==
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr2765271wml.129.1571318734262; 
 Thu, 17 Oct 2019 06:25:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 26sm2173721wmf.20.2019.10.17.06.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 439E21FFBB;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 36/54] plugin: add API symbols to qemu-plugins.symbols
Date: Thu, 17 Oct 2019 14:15:57 +0100
Message-Id: <20191017131615.19660-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: moved into plugins]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - moved to plugins/
  - include qemu_plugin_reset
v5
  - re-trigger configure if symbols are updated
  - wrap ld checks inside if static = no
---
 Makefile                     |  7 ++++
 configure                    | 72 ++++++++++++++++++++++++++++++++++++
 plugins/.gitignore           |  2 +
 plugins/Makefile.objs        | 14 +++++++
 plugins/qemu-plugins.symbols | 38 +++++++++++++++++++
 5 files changed, 133 insertions(+)
 create mode 100644 plugins/.gitignore
 create mode 100644 plugins/qemu-plugins.symbols

diff --git a/Makefile b/Makefile
index 15f4745cf3..370eb9ad8d 100644
--- a/Makefile
+++ b/Makefile
@@ -74,6 +74,12 @@ CONFIG_ALL=y
 config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
 	@echo $@ is out-of-date, running configure
 	@./config.status
+
+# Force configure to re-run if the API symbols are updated
+ifeq ($(CONFIG_PLUGIN),y)
+config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
+endif
+
 else
 config-host.mak:
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
@@ -730,6 +736,7 @@ distclean: clean
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
 	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
 	rm -f qemu-doc.vr qemu-doc.txt
+	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
diff --git a/configure b/configure
index 65cfd6c403..163eda23b7 100755
--- a/configure
+++ b/configure
@@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPMO="${TMPDIR1}/${TMPB}.mo"
+TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
 
@@ -5467,6 +5468,61 @@ if compile_prog "" "" ; then
   atomic64=yes
 fi
 
+#########################################
+# See if --dynamic-list is supported by the linker
+ld_dynamic_list="no"
+if test "$static" = "no" ; then
+    cat > $TMPTXT <<EOF
+{
+  foo;
+};
+EOF
+
+    cat > $TMPC <<EOF
+#include <stdio.h>
+void foo(void);
+
+void foo(void)
+{
+  printf("foo\n");
+}
+
+int main(void)
+{
+  foo();
+  return 0;
+}
+EOF
+
+    if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
+        ld_dynamic_list="yes"
+    fi
+fi
+
+#########################################
+# See if -exported_symbols_list is supported by the linker
+
+ld_exported_symbols_list="no"
+if test "$static" = "no" ; then
+    cat > $TMPTXT <<EOF
+  _foo
+EOF
+
+    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
+        ld_exported_symbols_list="yes"
+    fi
+fi
+
+if  test "$plugins" = "yes" &&
+    test "$ld_dynamic_list" = "no" &&
+    test "$ld_exported_symbols_list" = "no" ; then
+  error_exit \
+      "Plugin support requires dynamic linking and specifying a set of symbols " \
+      "that are exported to plugins. Unfortunately your linker doesn't " \
+      "support the flag (--dynamic-list or -exported_symbols_list) used " \
+      "for this purpose. You can't build with --static."
+fi
+
 ########################################
 # See if 16-byte vector operations are supported.
 # Even without a vector unit the compiler may expand these.
@@ -7270,6 +7326,22 @@ fi
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
     LIBS="-ldl $LIBS"
+    # Copy the export object list to the build dir
+    if test "$ld_dynamic_list" = "yes" ; then
+	echo "CONFIG_HAS_LD_DYNAMIC_LIST=yes" >> $config_host_mak
+	ld_symbols=qemu-plugins-ld.symbols
+	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
+    elif test "$ld_exported_symbols_list" = "yes" ; then
+	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=yes" >> $config_host_mak
+	ld64_symbols=qemu-plugins-ld64.symbols
+	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
+	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g' | \
+	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
+    else
+	error_exit \
+	    "If \$plugins=yes, either \$ld_dynamic_list or " \
+	    "\$ld_exported_symbols_list should have been set to 'yes'."
+    fi
 fi
 
 if test "$tcg_interpreter" = "yes"; then
diff --git a/plugins/.gitignore b/plugins/.gitignore
new file mode 100644
index 0000000000..7b8aaa1f10
--- /dev/null
+++ b/plugins/.gitignore
@@ -0,0 +1,2 @@
+qemu-plugins-ld.symbols
+qemu-plugins-ld64.symbols
diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
index 95baabf3d2..6f14d91ccb 100644
--- a/plugins/Makefile.objs
+++ b/plugins/Makefile.objs
@@ -5,3 +5,17 @@
 obj-y += loader.o
 obj-y += core.o
 obj-y += api.o
+
+# Abuse -libs suffix to only link with --dynamic-list/-exported_symbols_list
+# when the final binary includes the plugin object.
+#
+# Note that simply setting LDFLAGS is not enough: we build binaries that
+# never link plugin.o, and the linker might fail (at least ld64 does)
+# if the symbols in the list are not in the output binary.
+ifdef CONFIG_HAS_LD_DYNAMIC_LIST
+api.o-libs := -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
+else
+ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
+api.o-libs := -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
+endif
+endif
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
new file mode 100644
index 0000000000..40c0d1abd2
--- /dev/null
+++ b/plugins/qemu-plugins.symbols
@@ -0,0 +1,38 @@
+{
+  qemu_plugin_uninstall;
+  qemu_plugin_reset;
+  qemu_plugin_register_vcpu_init_cb;
+  qemu_plugin_register_vcpu_exit_cb;
+  qemu_plugin_register_vcpu_idle_cb;
+  qemu_plugin_register_vcpu_resume_cb;
+  qemu_plugin_register_vcpu_insn_exec_cb;
+  qemu_plugin_register_vcpu_insn_exec_inline;
+  qemu_plugin_register_vcpu_mem_cb;
+  qemu_plugin_register_vcpu_mem_haddr_cb;
+  qemu_plugin_register_vcpu_mem_inline;
+  qemu_plugin_ram_addr_from_host;
+  qemu_plugin_register_vcpu_tb_trans_cb;
+  qemu_plugin_register_vcpu_tb_exec_cb;
+  qemu_plugin_register_vcpu_tb_exec_inline;
+  qemu_plugin_register_flush_cb;
+  qemu_plugin_register_vcpu_syscall_cb;
+  qemu_plugin_register_vcpu_syscall_ret_cb;
+  qemu_plugin_register_atexit_cb;
+  qemu_plugin_tb_n_insns;
+  qemu_plugin_tb_get_insn;
+  qemu_plugin_tb_vaddr;
+  qemu_plugin_insn_data;
+  qemu_plugin_insn_size;
+  qemu_plugin_insn_vaddr;
+  qemu_plugin_insn_haddr;
+  qemu_plugin_mem_size_shift;
+  qemu_plugin_mem_is_sign_extended;
+  qemu_plugin_mem_is_big_endian;
+  qemu_plugin_mem_is_store;
+  qemu_plugin_get_hwaddr;
+  qemu_plugin_hwaddr_is_io;
+  qemu_plugin_hwaddr_to_raddr;
+  qemu_plugin_vcpu_for_each;
+  qemu_plugin_n_vcpus;
+  qemu_plugin_n_max_vcpus;
+};
-- 
2.20.1


