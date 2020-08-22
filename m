Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204A4C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 21:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C5720FC3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="PH6FdTK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C5720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ayB-0007rZ-4q
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 17:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k9axJ-0006a0-6P
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 17:21:41 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55290 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k9axF-0002sM-U2
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 17:21:40 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 7971F574FE
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1598131294; x=1599945695; bh=cU87q7VjSQ7DT4SSAI1PFtzSa3ilhdRsc8F
 iQiUp/RM=; b=PH6FdTK50ZaH2nL07g1mk/6AK7y547r+G0x0oEJO95+k7ceeblF
 EfJydjLIe/9qgQL1lkKUl73qwGRpiOGcAq70D7GzwZJmMRJ2ofy7RvtAVNHQDjs+
 Zq/d2ZxsZtks6n/1VSiuSSlm8SOXiZBkSJeap065vjuLrn82v73sPm24=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SKiDktXMx_P for <qemu-devel@nongnu.org>;
 Sun, 23 Aug 2020 00:21:34 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 3E55E57500
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 00:21:34 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 23
 Aug 2020 00:21:34 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 3/4] configure: Prefer gmake on darwin
Date: Sun, 23 Aug 2020 00:21:28 +0300
Message-ID: <20200822212129.97758-4-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822212129.97758-1-r.bolshakov@yadro.com>
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 17:21:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New meson/make build requires GNU make 3.82+ but macOS ships 3.81 even
on Big Sur while homebrew provides GNU make 4.3 as 'gmake' in $PATH.

With the change, 'make' switches over to gmake implicitly.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 configure | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/configure b/configure
index 9e0d505067..90b02b7271 100755
--- a/configure
+++ b/configure
@@ -903,6 +903,7 @@ Darwin)
   darwin="yes"
   hax="yes"
   hvf="yes"
+  make="${MAKE-gmake}"
   LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
@@ -916,6 +917,27 @@ Darwin)
   # won't work when we're compiling with gcc as a C compiler.
   QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
   HOST_VARIANT_DIR="darwin"
+  cat > GNUmakefile <<'EOF'
+# This file is auto-generated by configure to implicitly switch from a 'make'
+# invocation to 'gmake'
+
+OLD_MAKE := $(MAKE)
+
+include config-host.mak
+
+ifeq ($(MAKECMDGOALS),)
+recurse: all
+endif
+
+.NOTPARALLEL: %
+%: force
+	@echo 'Switch from $(OLD_MAKE) to $(MAKE)'
+	@$(MAKE) -f Makefile $(MAKECMDGOALS)
+force: ;
+.PHONY: force
+GNUmakefile: ;
+
+EOF
 ;;
 SunOS)
   solaris="yes"
-- 
2.28.0


