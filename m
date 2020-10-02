Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D248C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92420206C1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7ghXEfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92420206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFdy-0001aH-M3
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOFcI-0000Ja-GU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOFcG-0003nK-Rg
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601624192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGIdYV7MY+96XYcLdL6EIBAcSLF+M4Q8s5/QnOUrGIA=;
 b=F7ghXEfOksAWgkAOQzWdvYfR91jtTYPJZM9GHl2lTvej+XXj2yLiISTxfEN7LhQZMd9MWo
 M3ppUEufIGDVMi8KCqzlx3jzkofwlB8fZrzRJoQlpGtalLwZ2K2aFMosolBlW097Y30vQn
 XEg/XZqLJn0F8j6FvBj3hQG/4O1ExjA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-vN8BupmIP32dDnGlFzwZBA-1; Fri, 02 Oct 2020 03:36:30 -0400
X-MC-Unique: vN8BupmIP32dDnGlFzwZBA-1
Received: by mail-wm1-f71.google.com with SMTP id m25so237091wmi.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 00:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qGIdYV7MY+96XYcLdL6EIBAcSLF+M4Q8s5/QnOUrGIA=;
 b=SgvoyA5d900tSh3cNuZxMFqvSW9SeGqbpST+gh7cGN540xU2PziwcoXc1NJdX57S4Z
 p+AVIkwK/V8Ft5dTc2k7H1uU8gPnIkjFcSOQs6Rj7KID4Ckqt0aPcm90Nw69JpbAkCxB
 UU6HxEY/jkPKL+D81ox1QWWlZBchUVAFngECujL8x3UnRdIedYuE+RE7MEJ77rM/FC7v
 qGrDlf4AL4qXQCCVUY2SABYGYrDJVyfOLXP7qgwBDMGn/sq/uK3usjmBrxqireGb6Xk6
 FAtPSpMRg7Ggn/B0o9NHeVMVRMapF209jDas84jDZDJ7n13FyYha5egmvfU5XC4mCtV7
 r6Dw==
X-Gm-Message-State: AOAM533YrUHEMbfWDqBBNVDESIYIC5XiAX5jxdnqoJ9lKdFzF4ikSiLz
 K9mAbkLiKgVIh+WuOaXQdk43RNyANF2yw5WkY32ILNtoGeZV2+FtfnLTjjLJ58QcbxK8WsAvkXr
 BMXi5XNp1I/T/6do=
X-Received: by 2002:a5d:5306:: with SMTP id e6mr1475606wrv.156.1601624189352; 
 Fri, 02 Oct 2020 00:36:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyyIIpVim4lLi37ar85jV86Yzn8xaO1ecsHVFOH1go+IO4UrZLVjI/R1WqlpBxr40olppc4w==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr1475577wrv.156.1601624189112; 
 Fri, 02 Oct 2020 00:36:29 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d9sm722367wmb.30.2020.10.02.00.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 00:36:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/1] qapi: Restrict code generated for user-mode
Date: Fri,  2 Oct 2020 09:36:21 +0200
Message-Id: <20201002073621.1653924-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002073621.1653924-1-philmd@redhat.com>
References: <20201002073621.1653924-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A lot of QAPI generated code is never used by user-mode.

Split out qapi_system_modules and qapi_system_or_tools_modules
from the qapi_all_modules array. We now have 4 groups:
- always used
- only used by system-mode
- not used by user-mode
- not used by tools

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/meson.build | 51 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 7c4a89a882..10cf01ef65 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -14,39 +14,60 @@ util_ss.add(files(
 ))
 
 qapi_all_modules = [
+  'common',
+  'introspect',
+  'misc',
+]
+
+qapi_system_modules = [
   'acpi',
   'audio',
+  'dump',
+  'machine-target',
+  'migration',
+  'misc-target',
+  'net',
+  'pci',
+  'rdma',
+  'rocker',
+  'tpm',
+  'trace',
+]
+
+qapi_system_or_user_modules = [
+  'machine', # X86CPUFeatureWordInfo
+  'qdev',
+]
+
+qapi_system_or_tools_modules = [
   'authz',
   'block-core',
   'block',
   'char',
-  'common',
   'control',
   'crypto',
-  'dump',
   'error',
-  'introspect',
   'job',
-  'machine',
-  'machine-target',
-  'migration',
-  'misc',
-  'misc-target',
-  'net',
   'pragma',
-  'qdev',
-  'pci',
   'qom',
-  'rdma',
-  'rocker',
   'run-state',
   'sockets',
-  'tpm',
-  'trace',
   'transaction',
   'ui',
 ]
 
+if have_system
+  qapi_all_modules += qapi_system_modules
+endif
+
+if have_system or have_user
+  qapi_all_modules += qapi_system_or_user_modules
+endif
+
+if have_system or have_tools
+  qapi_all_modules += qapi_system_or_tools_modules
+endif
+
 qapi_storage_daemon_modules = [
   'block-core',
   'char',
-- 
2.26.2


