Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F384C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2677220738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gu8CisHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2677220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfOW-0003r3-6f
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJi-0006jO-SG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJg-0007Dr-CD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5T4b3uR4sPUBIFjdhNd72M+5jlOJeIdLDswdJQ0sTY=;
 b=gu8CisHykX+emQxAml9sN63b2v25Fr0JzG5aGUS0AeQG/fWTovMhC4AefHYVCWKbcmwezA
 cNwvPchzVoQ/CZSaODQn53YU/HSLzf1xgzin30HvPDOVIEK8NUlHEaVXz2JbMmpU/squi2
 t74oMfI5/U1OD+Sap9Pn23Tj3MwBZPc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-dDUopM0_ODuZpEn5x4upUg-1; Wed, 30 Sep 2020 12:50:53 -0400
X-MC-Unique: dDUopM0_ODuZpEn5x4upUg-1
Received: by mail-wr1-f69.google.com with SMTP id a12so826066wrg.13
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p5T4b3uR4sPUBIFjdhNd72M+5jlOJeIdLDswdJQ0sTY=;
 b=hJU6evC67B98vpAVog5Zqk1GnX3a9wwsDpIZUMjJf2z4wPpbAzD/1NdUbvp3/YGuIt
 kY/FWR0UYBvxUMyEcKpBDOKrAKycUsXBBNmOy4b+dK7ADG3yPR1yaY2T74UsYcVdT61h
 3Yc+SDT4s2+aVX4dCYGdurqs03qbTFv2DMRDd6cYuRFDjLdq6fM1IRE6T2NvjfskRkdB
 HOZv2cu5/ETqbOkSQbkShkH624sXllIZoCkOlbdwFYsQFx3FRkQZdfOdGKIs/+rqCC6q
 l7cyN9f1ouaNkjIGewnFFQR9CpBMq/XRaYA253LChQd4hHJ68ERqm/dW8T7IreGE5z8T
 GCsQ==
X-Gm-Message-State: AOAM532Yjl0iDB+7Ba3KAgkgdwDI8g+E74gOa4oPEUvhp9h+d2PO6tx0
 sN2sXP4z9yW90aJrWylbMkCZSYKZL2857dULBulBLraLgNwO92zj1UxpdcIz3PWuZ6F3Z+QwqYH
 bbAHrVgVSm3qkhR8=
X-Received: by 2002:adf:fd12:: with SMTP id e18mr4250015wrr.96.1601484651954; 
 Wed, 30 Sep 2020 09:50:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuTX+OJeaabPNkTWh+q+FjuxodYFwPUOAG87v3IdLMLDqovciEEHHgoWcyYIPkOeVRu0X9fw==
X-Received: by 2002:adf:fd12:: with SMTP id e18mr4249995wrr.96.1601484651786; 
 Wed, 30 Sep 2020 09:50:51 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t4sm4250032wrr.26.2020.09.30.09.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 11/11] qapi: Restrict code generated for user-mode
Date: Wed, 30 Sep 2020 18:49:49 +0200
Message-Id: <20200930164949.1425294-12-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A lot of QAPI generated code is never used by user-mode.

Split out qapi_system_modules and qapi_system_or_tools_modules
from the qapi_all_modules array. We now have 3 groups:
- always used
- use by system-mode or tools (usually by the block layer)
- only used by system-mode

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Resetting due to Meson update:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 qapi/meson.build | 51 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 7c4a89a882..ba9677ba97 100644
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
+  'machine',
+  'migration',
+  'misc-target',
+  'net',
+  'pci',
+  'qdev',
+  'rdma',
+  'rocker',
+  'tpm',
+  'trace',
+]
+
+# system or tools
+qapi_block_modules = [
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
+elif have_user
+  # Temporary kludge because X86CPUFeatureWordInfo is not
+  # restricted to system-mode. This should be removed (along
+  # with target/i386/feature-stub.c) once target/i386/cpu.c
+  # has been cleaned.
+  qapi_all_modules += ['machine-target']
+endif
+
+if have_block
+  qapi_all_modules += qapi_block_modules
+endif
+
 qapi_storage_daemon_modules = [
   'block-core',
   'char',
-- 
2.26.2


