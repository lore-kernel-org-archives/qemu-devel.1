Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D546C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D04A206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDuC+tXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D04A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYrc-0000EN-Q2
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLL-0000CC-LZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLK-0002CL-Iu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:07 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:32895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLK-0002C3-Fe
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:06 -0400
Received: by mail-qv1-xf44.google.com with SMTP id p19so3718437qve.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1Q+PIOyWcMQmBhTsnZIFuAor/C++2Bjd3Zt2sBVNt6Q=;
 b=GDuC+tXaw6A9r5ShqlJOFuGTnKALBxlZi4EPhvU+jINj1KY2Kn2q0GMh6ZFzqDiKDu
 V2C6wh09IJFk/EWAGI6wkwOjK4WWQMV7Ga+7dK5Meg7hOKq1GXcVngkSMxhh9/MTyzI6
 hVvtpzFAcunVYdVxHb20avbHlsgr+9QTK74YVzZQ0Jq22AMqbqclJRWdkB6qGleJb20C
 EMEuAN+QxHoMjPxH/gs1S2D6iNjf3fRHWCM79PdT8+12rrOfWIG0dJcseEPIua113pJd
 mpSCPhal1Vbfi3PDvaD/gVOgDD9ib1YXCvXGm5EZjNPKhi4BmaJ6sL37oo+Pzw8ZvSMs
 K0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1Q+PIOyWcMQmBhTsnZIFuAor/C++2Bjd3Zt2sBVNt6Q=;
 b=iBX9lny4OdenNdF3TkUYeeKJxL63nuah4HcSf4x6pHsjhHiWOkNg2Apb9y/n7bC3X2
 yrOUyGLy08gfR/Io0VTiKczQ5GN/fmWesIZPw3H8lPqL5oKBn3XE6ECTB4507gZ2pRYY
 VeVXbym09htVXJ2hd3h4ej92piMo80nAOg+2WKvpT2a6NFlsSPZhQvm3DM4SxeS3DRIp
 0Y0EFuyvfbt1jM7fWk6FsZxx7RkJqV55M2k6VT7zPyKpeRtqsZqOhqiuJzJR8uNBq38E
 yto0ZnjaUv4vPIHUuvxU0unapmPghTpi94Xy+q/hio9YKpHmuXVbLUHYi1S8vOpO1/vb
 Dfzg==
X-Gm-Message-State: ANhLgQ0m8nCbouqE5PjYpcYZYHfpMjrE6JkZ0AsciiytqKcLk5maDIb3
 ElZ50Fm1loogspMkNDGkHchk50pQu6nBsA==
X-Google-Smtp-Source: ADFU+vuumrrfjDrtHzH9OB0OvVuUnWspOdEhU1fBr4FyOhyWrQaH7vKfNtc0gQBD+4vjJfrWGAOwIA==
X-Received: by 2002:ad4:53a2:: with SMTP id j2mr10105749qvv.145.1585251545718; 
 Thu, 26 Mar 2020 12:39:05 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:05 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 66/74] s390x: convert to cpu_has_work_with_iothread_lock
Date: Thu, 26 Mar 2020 15:31:48 -0400
Message-Id: <20200326193156.4322-67-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
 qemu-s390x@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/s390x/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f1f206c763..04fd87026d 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -58,6 +58,8 @@ static bool s390_cpu_has_work(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /* STOPPED cpus can never wake up */
     if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
         s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
@@ -482,7 +484,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     scc->reset = s390_cpu_reset;
     cc->class_by_name = s390_cpu_class_by_name,
-    cc->has_work = s390_cpu_has_work;
+    cc->has_work_with_iothread_lock = s390_cpu_has_work;
 #ifdef CONFIG_TCG
     cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
-- 
2.17.1


