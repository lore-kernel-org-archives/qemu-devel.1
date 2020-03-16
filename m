Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D85C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4A4205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiluiQQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4A4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDta6-00079K-8Q
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsGp-0004GV-3w
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsGn-0000vQ-Uu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsGn-0000tR-R0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qw8ssmMAy8/C4B18gVc/ltfDqHgs0GK3VzA8PNnWZBA=;
 b=NiluiQQRhy4IsibDxDeQRpgGakY/VfVxrjGRCUpxCkHthbJc/hEf+L8czJIXB+4EXQYyDK
 oO/u4VbYXvk/xpYn+n6/RnAz7/sutYKANSd2E+HFEi3qYMFTg3RX8LTMgXHrdTsv1yNiHl
 im8iRCfT2c5GVxfCiCLpDWnbYqNfPqI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-D_eaYjCJN3eWzZyezs1ITQ-1; Mon, 16 Mar 2020 12:07:10 -0400
X-MC-Unique: D_eaYjCJN3eWzZyezs1ITQ-1
Received: by mail-ed1-f71.google.com with SMTP id y10so15625718edw.23
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ro+HCuhG/U1g3lYErsu/yY3mato6cTL6YgdKcF/Jx28=;
 b=daztEUmy8pwYFdMpN5r+2Qk22MfXuwTzzArr+rVJlBeQ4W9tlOI364E2E4jb62pLz1
 UqRNDpQ5AKT9YBtNfIGROSHXAuaqex0dB+59KHCAgxLaRUukLKGlKSQ6FgFJZTJt1bMT
 8f0fAsduT8q6u8WQUfJGLrgI+l0GyfIq07GTfbQ+mjVqK1Sp14pBK0CkaYv+vpWokaW2
 Uerhbi7rDBOnodhNkZ4bbdJvGJHU8nkQht9Wyq3AuMGQPSjuC5UvzaJvJp7d7p+LqaQ6
 mwJw6wGovZ9Qr0MOxAsgWHrPYAwR6jNrMrS0szmn0JnQVOiLaTLIqJrdb2eqED3Ft3ny
 hd1Q==
X-Gm-Message-State: ANhLgQ1KBsr2VU9Hq33SYZjkuSf8V3mgLjAHuvTV/iICqPQWur0+bY/6
 +dvFiIR+/9JJNlK1gohQGmARUdeyGEfmfmAVkS/tdbDXppnVZ9ouApq1lFw/mTD0K+/L/45B/Rg
 41eGhzSRP8JMgDdI=
X-Received: by 2002:a17:906:33d0:: with SMTP id
 w16mr19391061eja.257.1584374825528; 
 Mon, 16 Mar 2020 09:07:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtV7veg30cCQ3j3SAt9xjtSLJOa94Pxt9UeVCoRu/dTyjd6KIDS5xdnx353O9uNorBrl6JTdw==
X-Received: by 2002:a17:906:33d0:: with SMTP id
 w16mr19391034eja.257.1584374825290; 
 Mon, 16 Mar 2020 09:07:05 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id 31sm14913edc.26.2020.03.16.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/19] target/arm: Restrict Virtualization Host Extensions
 instructions to TCG
Date: Mon, 16 Mar 2020 17:06:20 +0100
Message-Id: <20200316160634.3386-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Under KVM the ARMv8.1-VHE instruction will trap.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a5280c091b..ce6778283d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2897,16 +2897,6 @@ static void gt_virt_ctl_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_VIRT, value);
 }
=20
-static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                              uint64_t value)
-{
-    ARMCPU *cpu =3D env_archcpu(env);
-
-    trace_arm_gt_cntvoff_write(value);
-    raw_write(env, ri, value);
-    gt_recalc_timer(cpu, GTIMER_VIRT);
-}
-
 static uint64_t gt_virt_redir_cval_read(CPUARMState *env,
                                         const ARMCPRegInfo *ri)
 {
@@ -2949,6 +2939,17 @@ static void gt_virt_redir_ctl_write(CPUARMState *env=
, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, timeridx, value);
 }
=20
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    ARMCPU *cpu =3D env_archcpu(env);
+
+    trace_arm_gt_cntvoff_write(value);
+    raw_write(env, ri, value);
+    gt_recalc_timer(cpu, GTIMER_VIRT);
+}
+
 static void gt_hyp_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_HYP);
@@ -2976,6 +2977,7 @@ static void gt_hyp_ctl_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
 {
     gt_ctl_write(env, ri, GTIMER_HYP, value);
 }
+#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
=20
 static void gt_sec_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
--=20
2.21.1


