Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FBAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8162071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Q7bErZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8162071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf65-0007Uq-6g
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrT-00057E-Rx
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrS-0003ZU-Rw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:31 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrS-0003XL-Ko
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id f129so2613150wmf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ivjz8iFRMvc+SVdpsYBWr7dQMjtFmxs9hPvui4StZIM=;
 b=n8Q7bErZI9CmlPWMT/KqNpKwm4f6wNLx/I5raQ6DuS8QSxtjP1disioZ8VQ6mk74ta
 J/3HykrYEC0hObby+PKJ7x4OalAD8V89mjBP996lG7p3m+NNPpcAPT06Jf9YCj1o7qRX
 pVrh+iqjNicFLB3jS2mVKGtpHSwZ28OO9YaGxzmQuDBeoVOvkZjkeR8Izt8A4DjypKcd
 JnhJuSq/5YD7nHPZtsj7X4pvCqLQe7wgFSC1fYzc5FOfZeneO0BKz0vO09XuSCdp1mG0
 /TOAORfBD/I2rddWZkNEHkmhONLkaq+/8CaSpz7BKRPhnY9+CJS0EgSBN2evX8bJmxma
 eiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ivjz8iFRMvc+SVdpsYBWr7dQMjtFmxs9hPvui4StZIM=;
 b=A6uXbQSL2T8Gh1KH6B1pvCjjhXiqxtk2kCvNQDXOsoUEtFTcrLeFPMaKzCwWGROB6P
 zcPNvXdQHxfMQ0GvNNGwY9nZtWvSahA0XrHGQWMvqOj4APDkdVLQviupSf1t6vPsigiX
 Ytx6zOpctysK3sNxc+Q/YVu8jHfQ/zgB/yOwtKYxEkOUgBa3sZVu4LYTdjRCwulicsvj
 fqrWiyLykvLOuBK6Pjqt+2Hw99ta+V2fII1DFgFp/DKHAXsOU0QtPYHAmSMOJfJspp+J
 g+lf5IOk5UJ+47LS08rsE9Do07ssD+LYuprTY12JBGxuIuC0AAG0/5nf7sqY3Tf0xt9i
 J9kQ==
X-Gm-Message-State: APjAAAWvC5O9/qJwx1cTtoI89aFeQXa7eHjMiuLjPXVO+v5fMksU8iWk
 mI2fMAwgdHwR8kfTcGm86Wr2WhH8
X-Google-Smtp-Source: APXvYqxHdkDyTRvX6t4qjPGYoHgDv269GRN7RdA3ICvXT4bW+315NyDW3Zon+xgnq/G+wgfC3PvMXQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr3417363wmi.116.1579787369415; 
 Thu, 23 Jan 2020 05:49:29 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/59] hw/ppc/spapr_rtas: Remove local variable
Date: Thu, 23 Jan 2020 14:48:28 +0100
Message-Id: <1579787342-27146-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We only access this variable in the RTAS_SYSPARM_SPLPAR_CHARACTERISTICS
case. Use it in place and remove the local declaration.

Suggested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200121110349.25842-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr_rtas.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 6f06e9d..85135e0 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -268,7 +268,6 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     MachineState *ms = MACHINE(spapr);
-    unsigned int max_cpus = ms->smp.max_cpus;
     target_ulong parameter = rtas_ld(args, 0);
     target_ulong buffer = rtas_ld(args, 1);
     target_ulong length = rtas_ld(args, 2);
@@ -280,10 +279,10 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           "DesMem=%" PRIu64 ","
                                           "DesProcs=%d,"
                                           "MaxPlatProcs=%d",
-                                          max_cpus,
+                                          ms->smp.max_cpus,
                                           ms->ram_size / MiB,
                                           ms->smp.cpus,
-                                          max_cpus);
+                                          ms->smp.max_cpus);
         if (pcc->n_host_threads > 0) {
             char *hostthr_val, *old = param_val;
 
-- 
1.8.3.1



