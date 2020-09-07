Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9202145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaAAp/LU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9202145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNB2-0008M7-Hp
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNA8-000744-S7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:46243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNA7-0006d4-6J
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id b124so9069730pfg.13
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iJ6QI4m7DsgRi/lAvD95Zw1TA6Kk8bxB1iMoGihMwx0=;
 b=SaAAp/LUHHDEj9yOLRAq0uMXnY8SognxdUA4r7PemLgHKV3qRDF44uAeLWhV48XQY8
 STZ0uZSX4rk47WmfZNgPO4KG1X7y7J1vL0ZjKQ24VGdtKFhZ858UeFebA3fD0AIeJB8n
 RBCArDbp6TsqnRnUGp3dCYh9RYKCskVlhe/CMpd+6kwQVw26avpjudvuZXoSgey6R3Oc
 IYIdi4VaMo/ie2UcvW7QtCR1ZyxLxXcPvcaAI5vcOJAbFYubWS9sBDyBCBaQWo/2x7PZ
 Y6QDUZGjT8fxGDgeR0F3dxornVdc2TmJxYfrfAWhzNEFKtIYe7yU31uCn/A3AWvT8Jti
 /O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iJ6QI4m7DsgRi/lAvD95Zw1TA6Kk8bxB1iMoGihMwx0=;
 b=ngD6q6LHep4mpHXYLxfIGJHA3fcziKKRljfVgGvPHVheYcLfhDn3RmJDUsPIGa59Mt
 TjXDV4at/oU/yQAMg8CpCd370qgYCt806EN+rAnd7eZ2leOsrXsWJ4KP88saB6B8pdl8
 sXuxYAMO/0NAfRNUSZx/G7SyhXnJGYfse+2+Bd4YFjwMGS3J0jXasm/2i+HEa7zMkf7j
 9Xtg9+Q4KGeW5C9cpYBxrnlQiQFIcunNRQmyHuMZgydr1jzwN1AoEW5VTc+wkKKnXq+U
 P2RhIEVFNUHBx6nJp6O1p3QVwgeUQ2PaB8599jim5cdmexrOOw9QwiEtveZtF177jjJB
 FWKw==
X-Gm-Message-State: AOAM533Rrh2e5XH2WnxEm0uBO54SK72WsUFQpuTfxgywLjgFCmNwO1Sc
 HfFsOwMCCdcsiw60qSqiKYZj5gpG/hmq5ZkN
X-Google-Smtp-Source: ABdhPJz+vpIejBWOOoB76rSgtAlAEkcABYnIqbTyj/BhNtVDBCvsI2YnriD0lkJwkfLqdrpk5/YnLQ==
X-Received: by 2002:a17:902:aa89:: with SMTP id
 d9mr21032751plr.192.1599508245224; 
 Mon, 07 Sep 2020 12:50:45 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id ev19sm4818990pjb.42.2020.09.07.12.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 12:50:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] meson: Fixes jemalloc and tcmalloc can not building.
Date: Tue,  8 Sep 2020 03:50:23 +0800
Message-Id: <20200907195025.2308-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200907195025.2308-1-luoyonggang@gmail.com>
References: <20200907195025.2308-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42c.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, the LIBS are not exposed to meson and meson didn't use that
Use base_lib = declare_dependency(link_args: config_host['LIBS'].split())
to force use it


Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure   | 9 +++++++++
 meson.build | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 823756f4a4..7b2f3d64b0 100755
--- a/configure
+++ b/configure
@@ -7245,6 +7245,14 @@ if test "$libxml2" = "yes" ; then
   echo "LIBXML2_LIBS=$libxml2_libs" >> $config_host_mak
 fi
 
+if test "$tcmalloc" = "yes" ; then
+  echo "CONFIG_TCMALLOC=y" >> $config_host_mak
+fi
+
+if test "$jemalloc" = "yes" ; then
+  echo "CONFIG_JEMALLOC=y" >> $config_host_mak
+fi
+
 if test "$replication" = "yes" ; then
   echo "CONFIG_REPLICATION=y" >> $config_host_mak
 fi
@@ -7416,6 +7424,7 @@ echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
+echo "LIBS=$LIBS" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 5421eca66a..6e909213ee 100644
--- a/meson.build
+++ b/meson.build
@@ -116,6 +116,9 @@ endif
 # grandfathered in from the QEMU Makefiles.
 add_project_arguments(config_host['GLIB_CFLAGS'].split(),
                       native: false, language: ['c', 'cpp', 'objc'])
+
+base_lib = declare_dependency(link_args: config_host['LIBS'].split())
+
 glib = declare_dependency(link_args: config_host['GLIB_LIBS'].split())
 gio = not_found
 if 'CONFIG_GIO' in config_host
@@ -818,7 +821,7 @@ util_ss.add_all(trace_ss)
 util_ss = util_ss.apply(config_all, strict: false)
 libqemuutil = static_library('qemuutil',
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), m, glib, socket])
+                             dependencies: [util_ss.dependencies(), m, base_lib, glib, socket])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
-- 
2.28.0.windows.1


