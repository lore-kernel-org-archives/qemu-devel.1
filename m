Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA095C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA55620728
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYLqHrvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA55620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQn2-00072X-HL
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYQlb-0006E4-HX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYQlZ-0006H9-Rr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604050330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=j9+co+yHNebq0st5iScvOYiGRcFH9wqN3HV3MiZmaMQ=;
 b=XYLqHrvIUjm+dTOnCH9aa+hTO43tencIs6AAqaqjz5o9Ka0NjTqS799G9glF5ae6wry0SP
 QXBs+B9efDemq2RrY6vdgd+aSDaS1OSdLV8XQViDc6CnXWMcTCFMs3+XAdjApdUunxFtPk
 MYxctiQrR1bNeBK33BNo9bx1s4zoTBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-cNCtOz6VOnSWcfnF2kaxkA-1; Fri, 30 Oct 2020 05:32:03 -0400
X-MC-Unique: cNCtOz6VOnSWcfnF2kaxkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D179F10B9CA1;
 Fri, 30 Oct 2020 09:32:01 +0000 (UTC)
Received: from thuth.com (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53E876198B;
 Fri, 30 Oct 2020 09:32:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: [PATCH] target/unicore32/translate: Add missing fallthrough
 annotations
Date: Fri, 30 Oct 2020 10:31:57 +0100
Message-Id: <20201030093157.11795-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking at the way the code is formatted here (there is an empty
line after break statements, but none where the break is missing),
the fallthrough is very likely intended here. So add a fallthrough
comment to make the it compilable with -Werror=implicit-fallthrough.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/unicore32/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index d4b06df672..962f9877a0 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1801,6 +1801,7 @@ static void disas_uc32_insn(CPUUniCore32State *env, DisasContext *s)
             do_misc(env, s, insn);
             break;
         }
+        /* fallthrough */
     case 0x1:
         if (((UCOP_OPCODES >> 2) == 2) && !UCOP_SET_S) {
             do_misc(env, s, insn);
@@ -1817,6 +1818,7 @@ static void disas_uc32_insn(CPUUniCore32State *env, DisasContext *s)
         if (UCOP_SET(8) || UCOP_SET(5)) {
             ILLEGAL;
         }
+        /* fallthrough */
     case 0x3:
         do_ldst_ir(env, s, insn);
         break;
-- 
2.18.2


