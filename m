Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259A9C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B6720714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J31RywKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B6720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYaA-0003Ev-Vm
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL3-0007i6-Jn
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL2-00022y-Dt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:49 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b]:35749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYL2-00022h-Ad
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:48 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id q73so3706414qvq.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cL3PcCCKPMmATpq2MJ8kQxP0SD3wsdiwI8ulUrzN/bE=;
 b=J31RywKQeAphVm0NnXJ17NcjEYeUOnZ2kK6MKnoRizXkmQRnLRiosS4Cp55YzMV1xd
 qe6/AuVK8Suc6ONZBNu00NCWg1vI6yEEwz2IAWiz6AsaQR6sRAxmbXTtix5QNxfREMqs
 EhOsyLqABGoS2kwOuE1Ov8CVuLk4aOY2T0ILt+svePUl1iHhPe2Zcm6vMlN15Zkp0ugb
 rFQsrYkFA3rgIp6sKnx5pceBW4Mtja/9YF5E5PjlS94UISGMaq2vaaocnRV2LbmGXVV7
 RuhWsJLsvRfHLkqlgoBjzYmWvP3vsvjPWvppRDz63RVu5lh5fm2t7FXWhcsbqAHZbB9f
 WwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cL3PcCCKPMmATpq2MJ8kQxP0SD3wsdiwI8ulUrzN/bE=;
 b=IQ+laGQCbK9bQd2qyuulV0ZxLz/DbQM6527ZTo8Y4OPlAiFIHLJEEtpMx2MbyznTd+
 01UhGXo7l6LJUrXpUNKe41AXyaQ0jdDsfpVVU7nkp99ckQMjrMvIOrm4z0QZbrJ7Fo1c
 2LfY76sB3bCqOh/P9Ru75zF/2/+Bo5yJJ91WplFk/LXvWqUpH/NPDW5+7MpzTPw14SlA
 qRNVXAYK+0OZYoOLmKmGUBqLqqWCYbCv6WuU7SmkpIMQIMoYy4NbN+UIpgfraoOsWiWV
 zQiLkktaBKmNYp4lbwQ2jUkhCb5heG3vao2Umy0gIdF34JicHWwUSRW+IZwzRANNsek8
 RFPg==
X-Gm-Message-State: ANhLgQ3Je3RtU974ryQowfdwAhJI3275xVAYVLybdDXRrAqTwi8GKJ15
 +bW1rsMXuNDN6jRTGUCtSc9QarJHfpAtew==
X-Google-Smtp-Source: ADFU+vvdWIodKWXEa0c+GGL2E+M2HfrRqeQrrWl10DzUoODfHXKr3YeQbquuhn+01g7Uvho93o+vhw==
X-Received: by 2002:a05:6214:10c2:: with SMTP id
 r2mr10350656qvs.83.1585251527485; 
 Thu, 26 Mar 2020 12:38:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 53/74] s390x: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:35 -0400
Message-Id: <20200326193156.4322-54-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f2b
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
Cc: robert.foley@linaro.org, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/intc/s390_flic.c | 2 +-
 target/s390x/cpu.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 9db3a4258c..ebf3fac965 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -191,7 +191,7 @@ static void qemu_s390_flic_notify(uint32_t type)
     CPU_FOREACH(cs) {
         S390CPU *cpu = S390_CPU(cs);
 
-        cs->interrupt_request |= CPU_INTERRUPT_HARD;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_HARD);
 
         /* ignore CPUs that are not sleeping */
         if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 7910deed35..f1f206c763 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -64,7 +64,7 @@ static bool s390_cpu_has_work(CPUState *cs)
         return false;
     }
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
         return false;
     }
 
-- 
2.17.1


