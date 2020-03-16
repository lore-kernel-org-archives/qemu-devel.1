Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B81CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041C92051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9TieGns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041C92051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDq3i-0008EO-7R
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoRS-00050K-5o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoRR-0007uE-3R
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoRQ-0007nN-Sa
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThCx22LN5T84wg5D9Dosi9XygA81kUt/h23r1S0DMvA=;
 b=c9TieGns74gTAbelrnTbtfL5FcMD9WFQwKd8ZDBsbTOMTrwvCZoWLpQG/qDIJkRei21c1o
 tLnV30OvCWQes3YJ1NFmhXtnW+7xzFXwoEG1ifWuMI+wdSYZNkV6+0VCem4S96dMEI8qa8
 8T430wnl1G7E9kdstIXHL/0s6fvFuek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-DNgTq3n6O3qhCs-83f8QsQ-1; Mon, 16 Mar 2020 08:01:55 -0400
X-MC-Unique: DNgTq3n6O3qhCs-83f8QsQ-1
Received: by mail-wm1-f70.google.com with SMTP id g26so4520423wmk.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q/TrjrHhXYfyq5bHXPlsvCOLySBTWSgrFuU3IZ4/ySM=;
 b=lTWTPDkTAgj4Lp9ALWTOcVjOVQQwHdtSqodvQ6AoH4J+me2uVsFBLYSxmcbFcm3F2p
 xQqSZtUGQu54yNn5te9Kr9PflaNqiSBTMbztrDzMIK0ZaghtTQHr4UKH9e9N1teBYll0
 UFisPYXB7HwHvS1bkDKO303supOC1Suk885aMFmwk6gEQCFtlO8Jt2nu5t0B7Z93Ouut
 jNmtyoYkcTl8N4/wuZTrB3Hr7wR561gq3HHVzNSTimFi1QdG1BFCrBgPlY463cor5lFD
 avebepwD49rDk47KszyJWcpQCiIBtsGB3EFLa1YbnRfZuTK8QuDDC/HukNCfR3D+FGiK
 vnfw==
X-Gm-Message-State: ANhLgQ2xj1vzEL/Udap24bnAQnNpJBwZGzIzv9LScyun8VuOPWRhZxnZ
 fJmO202WC73OtseuZjF+wU5VO4pveA2lbqlMKXet0DlgOGSa3bJLe/hBmJFP/Sms7yMRmT+Wl0y
 Y4S2obDrj/6Zeyjc=
X-Received: by 2002:a1c:9a51:: with SMTP id c78mr27725571wme.130.1584360113444; 
 Mon, 16 Mar 2020 05:01:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuf0WC5mZrj7bxvTqO/0wIAp06btYgnvdtf8msoh1ath1OGYW6q0QS0Fo85V6s9dqBobGjGOw==
X-Received: by 2002:a1c:9a51:: with SMTP id c78mr27725551wme.130.1584360113237; 
 Mon, 16 Mar 2020 05:01:53 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id n6sm19073225wmn.13.2020.03.16.05.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] hw/semihosting: Make the feature depend of TCG,
 and allow to disable it
Date: Mon, 16 Mar 2020 13:00:49 +0100
Message-Id: <20200316120049.11225-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316120049.11225-1-philmd@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The semihosting feature is only meaningful when using TCG.

So far only the ARM/MIPS/LM32 provide the semihosting feature.

Do not enable it by default, and let the few targets requiring
it to manually select it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/semihosting/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
index efe0a30734..06e9262af2 100644
--- a/hw/semihosting/Kconfig
+++ b/hw/semihosting/Kconfig
@@ -1,3 +1,5 @@
=20
 config SEMIHOSTING
-       bool
+    bool
+    depends on TCG
+    default n
--=20
2.21.1


