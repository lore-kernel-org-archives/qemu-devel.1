Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB2C2168B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTlmmZOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB2C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMAwp-0001nf-4X
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 10:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAoh-0000bb-4i
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:47 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:36446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAob-0005NB-8Z
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:46 -0400
Received: by mail-pl1-x630.google.com with SMTP id s19so892178plp.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BWpwCwB/QGi8FwsUUfmydg2qWbBTs6uwVfATSkHaPOs=;
 b=fTlmmZOV2rvBou7efz8i1UfgQtFlJzBOn2/qyyzdZzcsik4aHzTSXUC9ZqSsEWEPbn
 9MpanfLFixcid1EnB5kBQW/4cgnW6oL32KTAM8AXbWzjCMaTLyZdLXFJgWjD7x1TA6I2
 h4nrRrxi2G5y8CCYRq3Py0oB1tmffIGxgLpSACgZeesOxwR4BGvFq2SsbJjDc3K+CBc8
 vtzrdBZdOZKIMm92U2nqIAelYoE+iKtRVwPHa2leuD28HbSFa4t/3EYXy55GIBUlCtYS
 azIxTCNjWc3pkENZY9HdW5Vhvd+GDttsqKD3q1myRvw3NPQKdKY+F0D7qLvP3+UMBiLb
 /ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWpwCwB/QGi8FwsUUfmydg2qWbBTs6uwVfATSkHaPOs=;
 b=XMVk4kBQ/hSX8CYgogLarnLc0xQ6rAq6tiWwFiirS8369EwmQXKlMCrZE2RpWhaG+D
 +hkBSqIQEQlv22r2uVKIKjM2v7B7FH+un0yEPvs3pOZOUhGQNfyT4GBP3GEEGAb7Wlv8
 ktt0nQjzU3C73IiUXGRFxOvm76ii5WXpqemYMFkSLSxD23dKI4PtpbNyGUdeLVeCbzTB
 sWf+KJjCTY46BqLw8grL9R4nvSUw7aDP8EokKaTS6mQ2gNih0UAqNI8a9brh5Cxo7G/5
 tpH1lJt593qjMrWH8sLuzwMXBjQDeUXxrIWaHxvnndU43HwubmWDWCcMAEiuLVaPjBTX
 ASmA==
X-Gm-Message-State: AOAM531fSJh6tq11Sq+GNc77Rg5rqslCg/SK1V8RQ5fO+8wpzs+JKIlz
 vWtuSuvdFcISZh86QMlFmB0t3Qj7haQ+Op15
X-Google-Smtp-Source: ABdhPJxxGfotzT0VmaNA3f19FBgOQiz9bBOOYLrz+Xq1/Ol93v3cwVu43XUsBHd2+SNcHIutKqY7iQ==
X-Received: by 2002:a17:902:778e:b029:d2:8046:efe2 with SMTP id
 o14-20020a170902778eb02900d28046efe2mr2152098pll.44.1601129078713; 
 Sat, 26 Sep 2020 07:04:38 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k3sm6091109pfp.41.2020.09.26.07.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 07:04:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] Getting qemu-plugin works under win32.
Date: Sat, 26 Sep 2020 22:04:14 +0800
Message-Id: <20200926140415.1286-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200926140415.1286-1-luoyonggang@gmail.com>
References: <20200926140415.1286-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 Makefile                     |   1 -
 configure                    |  71 --------------
 contrib/plugins/hotblocks.c  |   2 +
 contrib/plugins/hotpages.c   |   2 +
 contrib/plugins/howvec.c     |   2 +
 contrib/plugins/lockstep.c   |   2 +
 include/qemu/qemu-plugin.h   | 184 ++++++++++++++++++++++++++---------
 meson.build                  |   6 +-
 plugins/api.c                |  65 +++++++------
 plugins/core.c               |   7 +-
 plugins/loader.c             |  20 ++++
 plugins/meson.build          |  10 +-
 plugins/qemu-plugins.symbols |  40 --------
 tests/plugin/bb.c            |   2 +
 tests/plugin/empty.c         |   2 +
 tests/plugin/insn.c          |   2 +
 tests/plugin/mem.c           |   2 +
 17 files changed, 218 insertions(+), 202 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols

diff --git a/Makefile b/Makefile
index 897246d77c..3dd74205b5 100644
--- a/Makefile
+++ b/Makefile
@@ -105,7 +105,6 @@ config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
 
 # Force configure to re-run if the API symbols are updated
 ifeq ($(CONFIG_PLUGIN),y)
-config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
 
 .PHONY: plugins
 plugins:
diff --git a/configure b/configure
index 49169ce289..5b1bc7850b 100755
--- a/configure
+++ b/configure
@@ -5434,61 +5434,6 @@ if compile_prog "" "" ; then
   atomic64=yes
 fi
 
-#########################################
-# See if --dynamic-list is supported by the linker
-ld_dynamic_list="no"
-if test "$static" = "no" ; then
-    cat > $TMPTXT <<EOF
-{
-  foo;
-};
-EOF
-
-    cat > $TMPC <<EOF
-#include <stdio.h>
-void foo(void);
-
-void foo(void)
-{
-  printf("foo\n");
-}
-
-int main(void)
-{
-  foo();
-  return 0;
-}
-EOF
-
-    if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
-        ld_dynamic_list="yes"
-    fi
-fi
-
-#########################################
-# See if -exported_symbols_list is supported by the linker
-
-ld_exported_symbols_list="no"
-if test "$static" = "no" ; then
-    cat > $TMPTXT <<EOF
-  _foo
-EOF
-
-    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
-        ld_exported_symbols_list="yes"
-    fi
-fi
-
-if  test "$plugins" = "yes" &&
-    test "$ld_dynamic_list" = "no" &&
-    test "$ld_exported_symbols_list" = "no" ; then
-  error_exit \
-      "Plugin support requires dynamic linking and specifying a set of symbols " \
-      "that are exported to plugins. Unfortunately your linker doesn't " \
-      "support the flag (--dynamic-list or -exported_symbols_list) used " \
-      "for this purpose. You can't build with --static."
-fi
-
 ########################################
 # See if __attribute__((alias)) is supported.
 # This false for Xcode 9, but has been remedied for Xcode 10.
@@ -7080,22 +7025,6 @@ fi
 
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
-    # Copy the export object list to the build dir
-    if test "$ld_dynamic_list" = "yes" ; then
-	echo "CONFIG_HAS_LD_DYNAMIC_LIST=yes" >> $config_host_mak
-	ld_symbols=qemu-plugins-ld.symbols
-	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
-    elif test "$ld_exported_symbols_list" = "yes" ; then
-	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=yes" >> $config_host_mak
-	ld64_symbols=qemu-plugins-ld64.symbols
-	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
-	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g' | \
-	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
-    else
-	error_exit \
-	    "If \$plugins=yes, either \$ld_dynamic_list or " \
-	    "\$ld_exported_symbols_list should have been set to 'yes'."
-    fi
 fi
 
 if test -n "$gdb_bin" ; then
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 37435a3fc7..286ebdd497 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -136,6 +137,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     if (argc && strcmp(argv[0], "inline") == 0) {
         do_inline = true;
     }
+    qemu_plugin_init(info);
 
     plugin_init();
 
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index ecd6c18732..941554439b 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -16,6 +16,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -166,6 +167,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                         int argc, char **argv)
 {
     int i;
+    qemu_plugin_init(info);
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 3b9a6939f2..d832be9bef 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -320,6 +321,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            int argc, char **argv)
 {
     int i;
+    qemu_plugin_init(info);
 
     /* Select a class table appropriate to the guest architecture */
     for (i = 0; i < ARRAY_SIZE(class_tables); i++) {
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index a696673dff..5090aa8b10 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -31,6 +31,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -316,6 +317,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            int argc, char **argv)
 {
     int i;
+    qemu_plugin_init(info);
 
     if (!argc || !argv[0]) {
         qemu_plugin_outs("Need a socket path to talk to other instance.");
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index bab8b0d4b3..83477b42e5 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -21,11 +21,7 @@
  *   https://gcc.gnu.org/wiki/Visibility
  */
 #if defined _WIN32 || defined __CYGWIN__
-  #ifdef BUILDING_DLL
-    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
-  #else
-    #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
-  #endif
+  #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
   #define QEMU_PLUGIN_LOCAL
 #else
   #if __GNUC__ >= 4
@@ -54,6 +50,8 @@ extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
 #define QEMU_PLUGIN_VERSION 0
 
+typedef void *(*qemu_plugin_global_dlsym_t)(void* context, const char *name);
+
 typedef struct {
     /* string describing architecture */
     const char *target_name;
@@ -73,6 +71,8 @@ typedef struct {
             int max_vcpus;
         } system;
     };
+    void *context;
+    qemu_plugin_global_dlsym_t dlsym;
 } qemu_info_t;
 
 /**
@@ -96,6 +96,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv);
 
+int qemu_plugin_init(const qemu_info_t *info);
+
 /*
  * Prototypes for the various callback styles we will be registering
  * in the following functions.
@@ -121,7 +123,7 @@ typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
  *
  * Note: Calling this function from qemu_plugin_install() is a bug.
  */
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+typedef void (*qemu_plugin_uninstall_t)(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
  * qemu_plugin_reset() - Reset a plugin
@@ -134,7 +136,7 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  * Plugins are reset asynchronously, and therefore the given plugin receives
  * callbacks until @cb is called.
  */
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+typedef void (*qemu_plugin_reset_t)(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
@@ -145,7 +147,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  *
  * See also: qemu_plugin_register_vcpu_exit_cb()
  */
-void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_init_cb_t)(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
 /**
@@ -157,7 +159,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
-void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_exit_cb_t)(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
 /**
@@ -167,7 +169,7 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU idles.
  */
-void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_idle_cb_t)(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
 /**
@@ -177,7 +179,7 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
-void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_resume_cb_t)(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
 /*
@@ -214,11 +216,11 @@ enum qemu_plugin_mem_rw {
 typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
                                                struct qemu_plugin_tb *tb);
 
-void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb);
 
 /**
- * qemu_plugin_register_vcpu_tb_trans_exec_cb() - register execution callback
+ * qemu_plugin_register_vcpu_tb_exec_cb() - register execution callback
  * @tb: the opaque qemu_plugin_tb handle for the translation
  * @cb: callback function
  * @flags: does the plugin read or write the CPU's registers?
@@ -226,7 +228,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a translated unit executes.
  */
-void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+typedef void (*qemu_plugin_register_vcpu_tb_exec_cb_t)(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
                                           void *userdata);
@@ -236,7 +238,7 @@ enum qemu_plugin_op {
 };
 
 /**
- * qemu_plugin_register_vcpu_tb_trans_exec_inline() - execution inline op
+ * qemu_plugin_register_vcpu_tb_exec_inline() - execution inline op
  * @tb: the opaque qemu_plugin_tb handle for the translation
  * @op: the type of qemu_plugin_op (e.g. ADD_U64)
  * @ptr: the target memory location for the op
@@ -246,7 +248,7 @@ enum qemu_plugin_op {
  * Useful if you just want to increment a single counter somewhere in
  * memory.
  */
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+typedef void (*qemu_plugin_register_vcpu_tb_exec_inline_t)(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
 
@@ -259,7 +261,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
  *
  * The @cb function is called every time an instruction is executed
  */
-void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_insn_exec_cb_t)(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
                                             void *userdata);
@@ -275,26 +277,26 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
  * Insert an inline op to every time an instruction executes. Useful
  * if you just want to increment a single counter somewhere in memory.
  */
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_insn_exec_inline_t)(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
 
 /*
  * Helpers to query information about the instructions in a block
  */
-size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
+typedef size_t (*qemu_plugin_tb_n_insns_t)(const struct qemu_plugin_tb *tb);
 
-uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
+typedef uint64_t (*qemu_plugin_tb_vaddr_t)(const struct qemu_plugin_tb *tb);
 
-struct qemu_plugin_insn *
-qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
+typedef struct qemu_plugin_insn *
+(*qemu_plugin_tb_get_insn_t)(const struct qemu_plugin_tb *tb, size_t idx);
 
-const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
+typedef const void *(*qemu_plugin_insn_data_t)(const struct qemu_plugin_insn *insn);
 
-size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
+typedef size_t (*qemu_plugin_insn_size_t)(const struct qemu_plugin_insn *insn);
 
-uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
-void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
+typedef uint64_t (*qemu_plugin_insn_vaddr_t)(const struct qemu_plugin_insn *insn);
+typedef void *(*qemu_plugin_insn_haddr_t)(const struct qemu_plugin_insn *insn);
 
 /*
  * Memory Instrumentation
@@ -307,10 +309,10 @@ typedef uint32_t qemu_plugin_meminfo_t;
 struct qemu_plugin_hwaddr;
 
 /* meminfo queries */
-unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
-bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
-bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
-bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
+typedef unsigned int (*qemu_plugin_mem_size_shift_t)(qemu_plugin_meminfo_t info);
+typedef bool (*qemu_plugin_mem_is_sign_extended_t)(qemu_plugin_meminfo_t info);
+typedef bool (*qemu_plugin_mem_is_big_endian_t)(qemu_plugin_meminfo_t info);
+typedef bool (*qemu_plugin_mem_is_store_t)(qemu_plugin_meminfo_t info);
 
 /*
  * qemu_plugin_get_hwaddr():
@@ -324,7 +326,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
  * information about the handle should be recovered before the
  * callback returns.
  */
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+typedef struct qemu_plugin_hwaddr *(*qemu_plugin_get_hwaddr_t)(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr);
 
 /*
@@ -332,21 +334,21 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
  * to return information about it. For non-IO accesses the device
  * offset will be into the appropriate block of RAM.
  */
-bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
-uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
+typedef bool (*qemu_plugin_hwaddr_is_io_t)(const struct qemu_plugin_hwaddr *haddr);
+typedef uint64_t (*qemu_plugin_hwaddr_device_offset_t)(const struct qemu_plugin_hwaddr *haddr);
 
 typedef void
 (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
                              qemu_plugin_meminfo_t info, uint64_t vaddr,
                              void *userdata);
 
-void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_mem_cb_t)(struct qemu_plugin_insn *insn,
                                       qemu_plugin_vcpu_mem_cb_t cb,
                                       enum qemu_plugin_cb_flags flags,
                                       enum qemu_plugin_mem_rw rw,
                                       void *userdata);
 
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_mem_inline_t)(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm);
@@ -359,15 +361,15 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
 
-void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_syscall_cb_t)(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
 
 typedef void
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
                                      int64_t num, int64_t ret);
 
-void
-qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
+typedef void
+(*qemu_plugin_register_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
 
@@ -378,7 +380,7 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
  * Returns an allocated string containing the disassembly
  */
 
-char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
+typedef char *(*qemu_plugin_insn_disas_t)(const struct qemu_plugin_insn *insn);
 
 /**
  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
@@ -389,25 +391,117 @@ char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
-void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_vcpu_for_each_t)(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb);
 
-void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_flush_cb_t)(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb);
 
-void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_atexit_cb_t)(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
 /* returns -1 in user-mode */
-int qemu_plugin_n_vcpus(void);
+typedef int (*qemu_plugin_n_vcpus_t)(void);
 
 /* returns -1 in user-mode */
-int qemu_plugin_n_max_vcpus(void);
+typedef int (*qemu_plugin_n_max_vcpus_t)(void);
 
 /**
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
  */
-void qemu_plugin_outs(const char *string);
+typedef void (*qemu_plugin_outs_t)(const char *string);
+
+#if !defined(QEMU_PLUGIN_API_IMPLEMENTATION)
+#if defined(QEMU_PLUGIN_IMPLEMENTATION)
+#define QEMU_PLUGIN_EXTERN
+#else
+#define QEMU_PLUGIN_EXTERN extern
+#endif
+
+QEMU_PLUGIN_EXTERN qemu_plugin_uninstall_t qemu_plugin_uninstall;
+QEMU_PLUGIN_EXTERN qemu_plugin_reset_t qemu_plugin_reset;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_init_cb_t qemu_plugin_register_vcpu_init_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_exit_cb_t qemu_plugin_register_vcpu_exit_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_idle_cb_t qemu_plugin_register_vcpu_idle_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_resume_cb_t qemu_plugin_register_vcpu_resume_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_tb_trans_cb_t qemu_plugin_register_vcpu_tb_trans_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_tb_exec_cb_t qemu_plugin_register_vcpu_tb_exec_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_tb_exec_inline_t qemu_plugin_register_vcpu_tb_exec_inline;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_insn_exec_cb_t qemu_plugin_register_vcpu_insn_exec_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_insn_exec_inline_t qemu_plugin_register_vcpu_insn_exec_inline;
+QEMU_PLUGIN_EXTERN qemu_plugin_tb_n_insns_t qemu_plugin_tb_n_insns;
+QEMU_PLUGIN_EXTERN qemu_plugin_tb_vaddr_t qemu_plugin_tb_vaddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_tb_get_insn_t qemu_plugin_tb_get_insn;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_data_t qemu_plugin_insn_data;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_size_t qemu_plugin_insn_size;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_vaddr_t qemu_plugin_insn_vaddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_haddr_t qemu_plugin_insn_haddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_size_shift_t qemu_plugin_mem_size_shift;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_is_sign_extended_t qemu_plugin_mem_is_sign_extended;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_is_big_endian_t qemu_plugin_mem_is_big_endian;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_is_store_t qemu_plugin_mem_is_store;
+QEMU_PLUGIN_EXTERN qemu_plugin_get_hwaddr_t qemu_plugin_get_hwaddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_hwaddr_is_io_t qemu_plugin_hwaddr_is_io;
+QEMU_PLUGIN_EXTERN qemu_plugin_hwaddr_device_offset_t qemu_plugin_hwaddr_device_offset;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_mem_cb_t qemu_plugin_register_vcpu_mem_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_mem_inline_t qemu_plugin_register_vcpu_mem_inline;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_syscall_cb_t qemu_plugin_register_vcpu_syscall_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_syscall_ret_cb_t qemu_plugin_register_vcpu_syscall_ret_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_disas_t qemu_plugin_insn_disas;
+QEMU_PLUGIN_EXTERN qemu_plugin_vcpu_for_each_t qemu_plugin_vcpu_for_each;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_flush_cb_t qemu_plugin_register_flush_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_atexit_cb_t qemu_plugin_register_atexit_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_n_vcpus_t qemu_plugin_n_vcpus;
+QEMU_PLUGIN_EXTERN qemu_plugin_n_max_vcpus_t qemu_plugin_n_max_vcpus;
+QEMU_PLUGIN_EXTERN qemu_plugin_outs_t qemu_plugin_outs;
+
+#if defined(QEMU_PLUGIN_IMPLEMENTATION)
+
+int qemu_plugin_init(const qemu_info_t *info)
+{
+    qemu_plugin_uninstall = info->dlsym(info->context, "qemu_plugin_uninstall");
+    qemu_plugin_reset = info->dlsym(info->context, "qemu_plugin_reset");
+    qemu_plugin_register_vcpu_init_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_init_cb");
+    qemu_plugin_register_vcpu_exit_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_exit_cb");
+    qemu_plugin_register_vcpu_idle_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_idle_cb");
+    qemu_plugin_register_vcpu_resume_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_resume_cb");
+    qemu_plugin_register_vcpu_tb_trans_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_tb_trans_cb");
+    qemu_plugin_register_vcpu_tb_exec_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_tb_exec_cb");
+    qemu_plugin_register_vcpu_tb_exec_inline = info->dlsym(info->context, "qemu_plugin_register_vcpu_tb_exec_inline");
+    qemu_plugin_register_vcpu_insn_exec_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_insn_exec_cb");
+    qemu_plugin_register_vcpu_insn_exec_inline = info->dlsym(info->context, "qemu_plugin_register_vcpu_insn_exec_inline");
+    qemu_plugin_tb_n_insns = info->dlsym(info->context, "qemu_plugin_tb_n_insns");
+    qemu_plugin_tb_vaddr = info->dlsym(info->context, "qemu_plugin_tb_vaddr");
+    qemu_plugin_tb_get_insn = info->dlsym(info->context, "qemu_plugin_tb_get_insn");
+    qemu_plugin_insn_data = info->dlsym(info->context, "qemu_plugin_insn_data");
+    qemu_plugin_insn_size = info->dlsym(info->context, "qemu_plugin_insn_size");
+    qemu_plugin_insn_vaddr = info->dlsym(info->context, "qemu_plugin_insn_vaddr");
+    qemu_plugin_insn_haddr = info->dlsym(info->context, "qemu_plugin_insn_haddr");
+    qemu_plugin_mem_size_shift = info->dlsym(info->context, "qemu_plugin_mem_size_shift");
+    qemu_plugin_mem_is_sign_extended = info->dlsym(info->context, "qemu_plugin_mem_is_sign_extended");
+    qemu_plugin_mem_is_big_endian = info->dlsym(info->context, "qemu_plugin_mem_is_big_endian");
+    qemu_plugin_mem_is_store = info->dlsym(info->context, "qemu_plugin_mem_is_store");
+    qemu_plugin_get_hwaddr = info->dlsym(info->context, "qemu_plugin_get_hwaddr");
+    qemu_plugin_hwaddr_is_io = info->dlsym(info->context, "qemu_plugin_hwaddr_is_io");
+    qemu_plugin_hwaddr_device_offset = info->dlsym(info->context, "qemu_plugin_hwaddr_device_offset");
+    qemu_plugin_register_vcpu_mem_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_mem_cb");
+    qemu_plugin_register_vcpu_mem_inline = info->dlsym(info->context, "qemu_plugin_register_vcpu_mem_inline");
+    qemu_plugin_register_vcpu_syscall_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_syscall_cb");
+    qemu_plugin_register_vcpu_syscall_ret_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_syscall_ret_cb");
+    qemu_plugin_insn_disas = info->dlsym(info->context, "qemu_plugin_insn_disas");
+    qemu_plugin_vcpu_for_each = info->dlsym(info->context, "qemu_plugin_vcpu_for_each");
+    qemu_plugin_register_flush_cb = info->dlsym(info->context, "qemu_plugin_register_flush_cb");
+    qemu_plugin_register_atexit_cb = info->dlsym(info->context, "qemu_plugin_register_atexit_cb");
+    qemu_plugin_n_vcpus = info->dlsym(info->context, "qemu_plugin_n_vcpus");
+    qemu_plugin_n_max_vcpus = info->dlsym(info->context, "qemu_plugin_n_max_vcpus");
+    qemu_plugin_outs = info->dlsym(info->context, "qemu_plugin_outs");
+    return 0;
+}
+
+#endif
+
+#endif /* QEMU_PLUGIN_API_IMPLEMENTATION */
+
 
 #endif /* QEMU_PLUGIN_API_H */
diff --git a/meson.build b/meson.build
index 822aac0825..d79ff96bf7 100644
--- a/meson.build
+++ b/meson.build
@@ -243,7 +243,11 @@ endif
 rt = cc.find_library('rt', required: false)
 libdl = not_found
 if 'CONFIG_PLUGIN' in config_host
-  libdl = cc.find_library('dl', required: true)
+  if targetos == 'windows'
+    libdl = declare_dependency(compile_args: [], link_args: [])
+  else
+    libdl = cc.find_library('dl', required: true)
+  endif
 endif
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
diff --git a/plugins/api.c b/plugins/api.c
index bbdc5a4eb4..99e393fba0 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -35,6 +35,7 @@
  */
 
 #include "qemu/osdep.h"
+#define QEMU_PLUGIN_API_IMPLEMENTATION
 #include "qemu/plugin.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
@@ -50,12 +51,12 @@
 
 /* Uninstall and Reset handlers */
 
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+QEMU_PLUGIN_EXPORT void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
 {
     plugin_reset_uninstall(id, cb, false);
 }
 
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+QEMU_PLUGIN_EXPORT void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
 {
     plugin_reset_uninstall(id, cb, true);
 }
@@ -67,19 +68,19 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
  * during the translation.
  */
 
-void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
 }
 
-void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
 }
 
-void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
                                           void *udata)
@@ -88,14 +89,14 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                   cb, flags, udata);
 }
 
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm)
 {
     plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
 }
 
-void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
                                             void *udata)
@@ -104,7 +105,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
         cb, flags, udata);
 }
 
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm)
 {
@@ -114,7 +115,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
 
 
 
-void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       qemu_plugin_vcpu_mem_cb_t cb,
                                       enum qemu_plugin_cb_flags flags,
                                       enum qemu_plugin_mem_rw rw,
@@ -124,7 +125,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                 cb, flags, rw, udata);
 }
 
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm)
@@ -133,19 +134,19 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
         rw, op, ptr, imm);
 }
 
-void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb);
 }
 
-void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
 }
 
-void
+QEMU_PLUGIN_EXPORT void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb)
 {
@@ -168,17 +169,17 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
  * each translated instruction.
  */
 
-size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
+QEMU_PLUGIN_EXPORT size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
 {
     return tb->n;
 }
 
-uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
+QEMU_PLUGIN_EXPORT uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 {
     return tb->vaddr;
 }
 
-struct qemu_plugin_insn *
+QEMU_PLUGIN_EXPORT struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
 {
     if (unlikely(idx >= tb->n)) {
@@ -194,27 +195,27 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
  * instruction being translated.
  */
 
-const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn)
 {
     return insn->data->data;
 }
 
-size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
 {
     return insn->data->len;
 }
 
-uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
 {
     return insn->vaddr;
 }
 
-void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
     return insn->haddr;
 }
 
-char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
 {
     CPUState *cpu = current_cpu;
     return plugin_disas(cpu, insn->vaddr, insn->data->len);
@@ -225,22 +226,22 @@ char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
  * memory access.
  */
 
-unsigned qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT unsigned qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info)
 {
     return info & TRACE_MEM_SZ_SHIFT_MASK;
 }
 
-bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info)
 {
     return !!(info & TRACE_MEM_SE);
 }
 
-bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info)
 {
     return !!(info & TRACE_MEM_BE);
 }
 
-bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
 {
     return !!(info & TRACE_MEM_ST);
 }
@@ -252,7 +253,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
 #ifdef CONFIG_SOFTMMU
 static __thread struct qemu_plugin_hwaddr hwaddr_info;
 
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+QEMU_PLUGIN_EXPORT struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
     CPUState *cpu = current_cpu;
@@ -268,14 +269,14 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
     return &hwaddr_info;
 }
 #else
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+QEMU_PLUGIN_EXPORT struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
     return NULL;
 }
 #endif
 
-bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 {
 #ifdef CONFIG_SOFTMMU
     return haddr->is_io;
@@ -284,7 +285,7 @@ bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 #endif
 }
 
-uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr)
+QEMU_PLUGIN_EXPORT uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr)
 {
 #ifdef CONFIG_SOFTMMU
     if (haddr) {
@@ -315,7 +316,7 @@ static MachineState * get_ms(void)
 }
 #endif
 
-int qemu_plugin_n_vcpus(void)
+QEMU_PLUGIN_EXPORT int qemu_plugin_n_vcpus(void)
 {
 #ifdef CONFIG_USER_ONLY
     return -1;
@@ -324,7 +325,7 @@ int qemu_plugin_n_vcpus(void)
 #endif
 }
 
-int qemu_plugin_n_max_vcpus(void)
+QEMU_PLUGIN_EXPORT int qemu_plugin_n_max_vcpus(void)
 {
 #ifdef CONFIG_USER_ONLY
     return -1;
@@ -336,7 +337,7 @@ int qemu_plugin_n_max_vcpus(void)
 /*
  * Plugin output
  */
-void qemu_plugin_outs(const char *string)
+QEMU_PLUGIN_EXPORT void qemu_plugin_outs(const char *string)
 {
     qemu_log_mask(CPU_LOG_PLUGIN, "%s", string);
 }
diff --git a/plugins/core.c b/plugins/core.c
index 51bfc94787..93a4b83a65 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -12,6 +12,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#define QEMU_PLUGIN_API_IMPLEMENTATION
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
@@ -233,7 +234,7 @@ static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
     args->cb(args->ctx->id, cpu_index);
 }
 
-void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb)
 {
     struct plugin_for_each_args args;
@@ -384,13 +385,13 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
 }
 
-void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb);
 }
 
-void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
diff --git a/plugins/loader.c b/plugins/loader.c
index 8ac5dbc20f..c1d52dacc8 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -254,6 +254,17 @@ static void plugin_desc_free(struct qemu_plugin_desc *desc)
     g_free(desc);
 }
 
+static void *qemu_plugin_global_dlsym(void* context, const char *name)
+{
+    GModule *global_handle = context;
+    gpointer sym = NULL;
+    if (!g_module_symbol(global_handle, name, &sym)) {
+        error_report("%s: %s", __func__, g_module_error());
+        return NULL;
+    }
+    return sym;
+}
+
 /**
  * qemu_plugin_load_list - load a list of plugins
  * @head: head of the list of descriptors of the plugins to be loaded
@@ -267,6 +278,7 @@ int qemu_plugin_load_list(QemuPluginList *head)
 {
     struct qemu_plugin_desc *desc, *next;
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
+    GModule *global_handle = NULL;
 
     info->target_name = TARGET_NAME;
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
@@ -276,6 +288,12 @@ int qemu_plugin_load_list(QemuPluginList *head)
     info->system_emulation = true;
     info->system.smp_vcpus = ms->smp.cpus;
     info->system.max_vcpus = ms->smp.max_cpus;
+    global_handle = g_module_open(NULL, G_MODULE_BIND_LOCAL);
+    if (global_handle == NULL) {
+        goto err_dlopen;
+    }
+    info->dlsym = qemu_plugin_global_dlsym;
+    info->context = (void*)global_handle;
 #else
     info->system_emulation = false;
 #endif
@@ -289,6 +307,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
         }
         QTAILQ_REMOVE(head, desc, entry);
     }
+
+err_dlopen:
     return 0;
 }
 
diff --git a/plugins/meson.build b/plugins/meson.build
index e77723010e..16af5d7ca3 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -1,13 +1,5 @@
-if 'CONFIG_HAS_LD_DYNAMIC_LIST' in config_host
-  plugin_ldflags = ['-Wl,--dynamic-list=' + (meson.build_root() / 'qemu-plugins-ld.symbols')]
-elif 'CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST' in config_host
-  plugin_ldflags = ['-Wl,-exported_symbols_list,' + (meson.build_root() / 'qemu-plugins-ld64.symbols')]
-else
-  plugin_ldflags = []
-endif
-
 specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
   'loader.c',
   'core.c',
   'api.c',
-), declare_dependency(link_args: plugin_ldflags)])
+), declare_dependency(link_args: [], compile_args: ['-Wno-missing-prototypes'])])
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
deleted file mode 100644
index 4bdb381f48..0000000000
--- a/plugins/qemu-plugins.symbols
+++ /dev/null
@@ -1,40 +0,0 @@
-{
-  qemu_plugin_uninstall;
-  qemu_plugin_reset;
-  qemu_plugin_register_vcpu_init_cb;
-  qemu_plugin_register_vcpu_exit_cb;
-  qemu_plugin_register_vcpu_idle_cb;
-  qemu_plugin_register_vcpu_resume_cb;
-  qemu_plugin_register_vcpu_insn_exec_cb;
-  qemu_plugin_register_vcpu_insn_exec_inline;
-  qemu_plugin_register_vcpu_mem_cb;
-  qemu_plugin_register_vcpu_mem_haddr_cb;
-  qemu_plugin_register_vcpu_mem_inline;
-  qemu_plugin_ram_addr_from_host;
-  qemu_plugin_register_vcpu_tb_trans_cb;
-  qemu_plugin_register_vcpu_tb_exec_cb;
-  qemu_plugin_register_vcpu_tb_exec_inline;
-  qemu_plugin_register_flush_cb;
-  qemu_plugin_register_vcpu_syscall_cb;
-  qemu_plugin_register_vcpu_syscall_ret_cb;
-  qemu_plugin_register_atexit_cb;
-  qemu_plugin_tb_n_insns;
-  qemu_plugin_tb_get_insn;
-  qemu_plugin_tb_vaddr;
-  qemu_plugin_insn_data;
-  qemu_plugin_insn_size;
-  qemu_plugin_insn_vaddr;
-  qemu_plugin_insn_haddr;
-  qemu_plugin_insn_disas;
-  qemu_plugin_mem_size_shift;
-  qemu_plugin_mem_is_sign_extended;
-  qemu_plugin_mem_is_big_endian;
-  qemu_plugin_mem_is_store;
-  qemu_plugin_get_hwaddr;
-  qemu_plugin_hwaddr_is_io;
-  qemu_plugin_hwaddr_to_raddr;
-  qemu_plugin_vcpu_for_each;
-  qemu_plugin_n_vcpus;
-  qemu_plugin_n_max_vcpus;
-  qemu_plugin_outs;
-};
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index ef784be78f..5ee0bce39d 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -101,6 +102,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            int argc, char **argv)
 {
     int i;
+    qemu_plugin_init(info);
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
index 8fa6bacd93..9e1e683fd6 100644
--- a/tests/plugin/empty.c
+++ b/tests/plugin/empty.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -27,6 +28,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    qemu_plugin_init(info);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     return 0;
 }
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index a9a6e41237..ea848036bc 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -52,6 +53,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    qemu_plugin_init(info);
     if (argc && !strcmp(argv[0], "inline")) {
         do_inline = true;
     }
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 4725bd851d..ba3ce3a713 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -73,6 +74,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    qemu_plugin_init(info);
     if (argc) {
         if (argc >= 3) {
             if (!strcmp(argv[2], "haddr")) {
-- 
2.28.0.windows.1


