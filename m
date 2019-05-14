Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8250DC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BEF20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHsT1I4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BEF20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQeaR-0003HI-GQ
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:03:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV2-0007lo-HT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIk-0007c0-QL
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:32 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIj-0007V7-9h
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:30 -0400
Received: by mail-lj1-x243.google.com with SMTP id z5so471523lji.10
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jcFS5+jIJKosDV3MzdYV6crVIuBE3kgBVMwFRGOcg+I=;
	b=VHsT1I4dvW74OLvRw/avbw0DjE1VWDUevQKUqF7QRLQqInjBcwg/VH55fATvo5ivvg
	zzn/hfWoS950q8cV7b/EkOayV/qp4PdZBQCW9QJR5LLXIXmpE0Q1WDdgeT/R2eGUplSI
	3OAG5A4Zw0Si6RxndTChCe7+MwxDvVjy2y6fHP7kEkPkjRCAe5wv36rCh5JO76W/V4nW
	q6h4J4SanGKiOshIPHj1+eY0tcqr7kbuz8GYaazFwEkj5EIsAZSWzFRLIWuXkbvv0oTo
	kMnMnUfuy1x8fN2/hX2Pqw4j1rbkPyqWkAQ/rtAY5tUUUK6nDDFtB28ZVhqs4Ko6To3r
	/B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jcFS5+jIJKosDV3MzdYV6crVIuBE3kgBVMwFRGOcg+I=;
	b=AnGRh3m2pgROvS9qpVRSG9b8S69vnpWW4+Xt3Nx9R60vfgv8Crepjo4foCaHWun/y5
	Snl5KLOnB2GplCedBuFk/K80BzXY+L50qjKwQnBy7FkaF9jVnHfb1ljsKVAEX4E02MLL
	vBZHoOwP3f9O4qVbmUI6kglk1YhXy+5m8gMoumVV1w12TDUJh5pGZs7z4BFQuSRUX67q
	OPzUfpASb5KWWgqNTzF+Z+qoQj2bsUFbszSrpOfp4B5k9QwomKhIpd22EEWuZKgwoezb
	EjPT6zUdabZqVHWN8VNWtzNeSx14dQQi2lbNAL89X5gFYswsllo6M10OKIvXjszwn+8H
	o4RA==
X-Gm-Message-State: APjAAAVflMlJT4EE8a3rCcbW0MBMnkgFdH0FKBlsmCqyf4C9BxT2jPZc
	N5b9Eh6dG+1SKQ9cH7Q0vqv8DEpPl88=
X-Google-Smtp-Source: APXvYqwgwgP1I4SXag4lM6DwwTU/YV+/9bqGZtJm5cWDJmqt9q30SfeG5X547Yw0MehgHuwK74KI+Q==
X-Received: by 2002:a2e:9f41:: with SMTP id v1mr13805828ljk.66.1557866724525; 
	Tue, 14 May 2019 13:45:24 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:24 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:46 -0700
Message-Id: <20190514204447.17486-9-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: [Qemu-devel] [PATCH 8/9] target/xtensa: update list of exception
 causes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add XEA2 exception cause codes defined in recent Xtensa ISA releases.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index ba4ef2b6a729..8301923e4c4a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -280,14 +280,15 @@ enum {
     LEVEL1_INTERRUPT_CAUSE,
     ALLOCA_CAUSE,
     INTEGER_DIVIDE_BY_ZERO_CAUSE,
-    PRIVILEGED_CAUSE = 8,
+    PC_VALUE_ERROR_CAUSE,
+    PRIVILEGED_CAUSE,
     LOAD_STORE_ALIGNMENT_CAUSE,
-
-    INSTR_PIF_DATA_ERROR_CAUSE = 12,
+    EXTERNAL_REG_PRIVILEGE_CAUSE,
+    EXCLUSIVE_ERROR_CAUSE,
+    INSTR_PIF_DATA_ERROR_CAUSE,
     LOAD_STORE_PIF_DATA_ERROR_CAUSE,
     INSTR_PIF_ADDR_ERROR_CAUSE,
     LOAD_STORE_PIF_ADDR_ERROR_CAUSE,
-
     INST_TLB_MISS_CAUSE,
     INST_TLB_MULTI_HIT_CAUSE,
     INST_FETCH_PRIVILEGE_CAUSE,
-- 
2.11.0


