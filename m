Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 00:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97F42075D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 00:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97F42075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jobn9-0003fc-0U
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 20:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jobkf-0002T7-WF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 19:57:54 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:7874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jobkd-0001K2-Py
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 19:57:53 -0400
IronPort-SDR: aDEKSapLTGe1aVDuTMqBj1K84F73VJPJR9d8AFLCWjsgpZhLa7BP6HvxE3/LvCfGvKJSEhM6ie
 MUnA8/FzkyioRzPOOLKNxmPGaCe5C+zheFSKxlMXSOpxOgWHbCyTfw5gtzeFyLDDFnAX0MYkFE
 hy61GwNPH98yNQyGyD47T+Hs3nuH8dlgPSXD3+UGu8tQxmb/x8zd0Q2H1Tz0GhFbA6SPTKoB3v
 n9JbB5vFye23V48cHmBJElWyv76KNT0l1JULZE0p91lSjSt2jn8ReKs8lrexlOmpo2aAIjua3P
 nC4=
X-IronPort-AV: E=Sophos;i="5.75,281,1589270400"; d="scan'208";a="50332679"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 25 Jun 2020 15:57:49 -0800
IronPort-SDR: WNt7BuIQ6juNauqa6WyUyv2kR95Jf8O/tKapbJ534X7aSKzaR5125uVQdWhHRlBexBgqZoFuBa
 2JFMwDIJ8ipOmrFxpSc/QICzIUq70OybZyfUGnp3L56BnghhTlv0WUerFvXElU2Xh3Bo17i9kR
 4M8LXBsS22xL6vHKNjIkOFuHA/6+fxVUYF0rMm8mweC19ESBy1lWQ8DTooD7O/fl02ZKMgKV/A
 fm+wFyo4n/xVj00aNAUbPe0IQQFy8SDbLbSfkz5apgPdJZ6QgpAfr+OjqCiPYbX4iBsAiKjTZU
 ZF8=
Date: Thu, 25 Jun 2020 23:57:44 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 1/2] target/i386: set SSE FTZ in correct floating-point state
In-Reply-To: <alpine.DEB.2.21.2006252355430.3832@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006252357170.3832@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006252355430.3832@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 19:57:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code to set floating-point state when MXCSR changes calls
set_flush_to_zero on &env->fp_status, so affecting the x87
floating-point state rather than the SSE state.  Fix to call it for
&env->sse_status instead.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 8ef5b463ea..6590ce482f 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1830,7 +1830,7 @@ void update_mxcsr_status(CPUX86State *env)
     set_flush_inputs_to_zero((mxcsr & SSE_DAZ) ? 1 : 0, &env->sse_status);
 
     /* set flush to zero */
-    set_flush_to_zero((mxcsr & SSE_FZ) ? 1 : 0, &env->fp_status);
+    set_flush_to_zero((mxcsr & SSE_FZ) ? 1 : 0, &env->sse_status);
 }
 
 void helper_ldmxcsr(CPUX86State *env, uint32_t val)
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

