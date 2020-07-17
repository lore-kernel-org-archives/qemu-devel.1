Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2012070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="NR61HUuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2012070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMoL-0004yX-0I
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jwMm5-0001UI-Jh
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:35:25 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36956 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jwMm3-0005Wr-Dp
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:35:25 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 1068A4C919;
 Fri, 17 Jul 2020 09:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1594978520; x=1596792921; bh=OIBev7tJN2yXZVTSi5iPRsUWR852a+rEpUS
 oCeiR7go=; b=NR61HUuEuH1c7ywj5QwQDOnrl2JsI4lnbf1GZroDazFxe7K7Sol
 8iDKwEEwz1HuXFwEdSiATa5DHzP/frGdhtMVYWj9PFt1W311hODZMltZDxUqL96P
 TSSGwV1LjMYqzY76oY+12ulSFgVJaFTsR5ARYGw+xSDXPQS8567htOjA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BF4eOIyWp-gl; Fri, 17 Jul 2020 12:35:20 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 7DF184C914;
 Fri, 17 Jul 2020 12:35:20 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 17
 Jul 2020 12:35:20 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/4] scripts/tracetool: Use void pointer for vcpu
Date: Fri, 17 Jul 2020 12:35:15 +0300
Message-ID: <20200717093517.73397-3-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200717093517.73397-1-r.bolshakov@yadro.com>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:35:20
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dtrace on macOS complains that CPUState * is used for a few probes:

  dtrace: failed to compile script trace-dtrace-root.dtrace: line 130: syntax error near "CPUState"

A comment in scripts/tracetool/__init__.py mentions that:

  We only want to allow standard C types or fixed sized
  integer types. We don't want QEMU specific types
  as we can't assume trace backends can resolve all the
  typedefs

Fixes: 3d211d9f4dbee ("trace: Add 'vcpu' event property to trace guest vCPU")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 scripts/tracetool/vcpu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracetool/vcpu.py b/scripts/tracetool/vcpu.py
index b54e4f4e7a..868b4cb04c 100644
--- a/scripts/tracetool/vcpu.py
+++ b/scripts/tracetool/vcpu.py
@@ -24,7 +24,7 @@ def transform_event(event):
         assert "tcg-trans" not in event.properties
         assert "tcg-exec" not in event.properties
 
-        event.args = Arguments([("CPUState *", "__cpu"), event.args])
+        event.args = Arguments([("void *", "__cpu"), event.args])
         if "tcg" in event.properties:
             fmt = "\"cpu=%p \""
             event.fmt = [fmt + event.fmt[0],
-- 
2.26.1


