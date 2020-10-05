Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E412085B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqcKQI0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E412085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPR6u-0006bw-Kv
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyS-00078W-M7
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:35854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyQ-0000Ne-8d
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id e2so8899396wme.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gpUh9/EliZXjQLaVCeWx3yQd/gRzzOP0M3qR6kaKJGU=;
 b=sqcKQI0sM5juQaJ2tQT4/fLuxc+PFxtpch5JgyKs+/iUFekdKmlSv0luDQ9Bbz9Bmh
 pqjuE3qiSXK8Bambqw2AVS8ixKcRl512p7VHpDrb0HdK2FHZ9GLUGlHtSYmhAw+oAgh9
 8fq0EPq/fy4KucHUN7KUFDjUlrkmaejfHof1QEUPxtBCFQGgVJBYCfpGfNIJFwcpeIk3
 Ox3jAvIUFD3FRZ1MKCcuZSCdwbMYFP5C5qcU4sL9unqcp2LXceXrETJ6BUsBHfq7kx9v
 cM88BErhpzH2AWBcK5sUeyfMKKZANSPR5LD0xgpFjgkxqcuIM6dEr3o65vAKHdtMKFjc
 4xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gpUh9/EliZXjQLaVCeWx3yQd/gRzzOP0M3qR6kaKJGU=;
 b=Zemk7OaTC/ZUcDqCxJnecjk5o5URw4UoQKkDuupyhRlNwDOYMV9Ybc3Nohh21xWD6j
 GwsE1TDI7TRUZEdQOTb+E9D6KmM7KVCGVH7mOtpjkBJoDVFDxvnGhUwiU/qOjBse0uoO
 EUXUf/nMJj+H9X032KMqkH/zWdsTiLhT8kDGMbGnVQYwCUcomkbUZLxtmlNcxgaSsNhV
 ziFhx/hhQ2aasNwKUksMjhjyGtjBlx9iJwJTjEzWGEY2qRAS99tc3aZVwnOOpXpfOx0o
 XUgZ1W9c3FT4HaxwzZOj4dcsOH12YnTzNL1efIsH0E6l1YY1LQtCpwND4yUzCrcCFCom
 G7AA==
X-Gm-Message-State: AOAM532nQnX+Vqc2N9jzxE9Y0Y48SDDQQwkfCwbupy/lYJaIuTQtDPHP
 pv1F2Z49yXlzwO9WoBIv2rE+T/Xt2Xg=
X-Google-Smtp-Source: ABdhPJyBzpgyZbiQs8nUCnX+SGuSPRCzuRZ5m4OGx9PFz7V1I4Q8tkOZg4yhT4s5DVmcVbdHxFPcYw==
X-Received: by 2002:a1c:f005:: with SMTP id a5mr8088230wmb.160.1601906176630; 
 Mon, 05 Oct 2020 06:56:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id c8sm13406559wmd.18.2020.10.05.06.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 06:56:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS to
 meson
Date: Mon,  5 Oct 2020 15:56:13 +0200
Message-Id: <20201005135613.435932-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005135613.435932-1-pbonzini@redhat.com>
References: <20201005135613.435932-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Environment variables like CFLAGS are easy to accidentally change.  Meson
warns if that happens, but in a project with a lot of configuration that
is easy to lose.  It is also surprising behavior since meson caches -D
options and remembers those on reconfiguration (which we rely on,
since configure options become -D options).

By placing the user-provided CFLAGS, CXXFLAGS and LDFLAGS in the
cross file, we at least get consistent behavior.  These environment
variables are still ugly and not really recommended, but there are
distros that rely on them.  For the gory details, refer to
https://github.com/mesonbuild/meson/issues/4664.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200923092617.1593722-5-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 25 +++++++++++++++----------
 meson.build | 14 ++++++++++++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 1b173276ea..04c8cc017c 100755
--- a/configure
+++ b/configure
@@ -7130,24 +7130,29 @@ echo "export PYTHON='$python'" >> "$iotests_common_env"
 if test "$skip_meson" = no; then
 cross="config-meson.cross.new"
 meson_quote() {
-    echo "['$(echo $* | sed "s/ /','/g")']"
+    echo "'$(echo $* | sed "s/ /','/g")'"
 }
 
 echo "# Automatically generated by configure - do not modify" > $cross
 echo "[properties]" >> $cross
 test -z "$cxx" && echo "link_language = 'c'" >> $cross
+echo "[built-in options]" >> $cross
+echo "c_args = [${CFLAGS:+$(meson_quote $CFLAGS)}]" >> $cross
+echo "cpp_args = [${CXXFLAGS:+$(meson_quote $CXXFLAGS)}]" >> $cross
+echo "c_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
+echo "cpp_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
 echo "[binaries]" >> $cross
-echo "c = $(meson_quote $cc)" >> $cross
-test -n "$cxx" && echo "cpp = $(meson_quote $cxx)" >> $cross
-echo "ar = $(meson_quote $ar)" >> $cross
-echo "nm = $(meson_quote $nm)" >> $cross
-echo "pkgconfig = $(meson_quote $pkg_config_exe)" >> $cross
-echo "ranlib = $(meson_quote $ranlib)" >> $cross
+echo "c = [$(meson_quote $cc)]" >> $cross
+test -n "$cxx" && echo "cpp = [$(meson_quote $cxx)]" >> $cross
+echo "ar = [$(meson_quote $ar)]" >> $cross
+echo "nm = [$(meson_quote $nm)]" >> $cross
+echo "pkgconfig = [$(meson_quote $pkg_config_exe)]" >> $cross
+echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
 if has $sdl2_config; then
-  echo "sdl2-config = $(meson_quote $sdl2_config)" >> $cross
+  echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
 fi
-echo "strip = $(meson_quote $strip)" >> $cross
-echo "windres = $(meson_quote $windres)" >> $cross
+echo "strip = [$(meson_quote $strip)]" >> $cross
+echo "windres = [$(meson_quote $windres)]" >> $cross
 if test -n "$cross_prefix"; then
     cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
diff --git a/meson.build b/meson.build
index d9377f371d..e9122d2b90 100644
--- a/meson.build
+++ b/meson.build
@@ -1758,8 +1758,18 @@ if targetos == 'darwin'
   summary_info += {'Objective-C compiler': meson.get_compiler('objc').cmd_array()[0]}
 endif
 summary_info += {'ARFLAGS':           config_host['ARFLAGS']}
-summary_info += {'CFLAGS':            '-O' + get_option('optimization')
-                                           + (get_option('debug') ? ' -g' : '')}
+summary_info += {'CFLAGS':            ' '.join(get_option('c_args')
+                                               + ['-O' + get_option('optimization')]
+                                               + (get_option('debug') ? ['-g'] : []))}
+if link_language == 'cpp'
+  summary_info += {'CXXFLAGS':        ' '.join(get_option('cpp_args')
+                                               + ['-O' + get_option('optimization')]
+                                               + (get_option('debug') ? ['-g'] : []))}
+endif
+link_args = get_option(link_language + '_link_args')
+if link_args.length() > 0
+  summary_info += {'LDFLAGS':         ' '.join(link_args)}
+endif
 summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
-- 
2.26.2


