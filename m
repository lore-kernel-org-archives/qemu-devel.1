Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AAEC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E96206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BtfV+qHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E96206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuJL-00083c-9u
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:26:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1K-0006Rx-Vf
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1J-0005ed-Vs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:38 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47081 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu1J-00051z-IY; Fri, 26 Apr 2019 02:07:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tq4TZ6z9sNr; Fri, 26 Apr 2019 16:06:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258799;
	bh=M9tGNO0CMBlakuYj8vyjTCfUIkj2mawnuCKyR78PxHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtfV+qHJqaUc0YgHAp7Do9Hzehx3XGJwIlwAKAoZJ9nyj5WyQcE88YUWOxsYNMIoc
	ov33HhDnAdTNzuWwWX9ZJ+0GEKfrjuZXdc73Jv8OIsBwDTH502YKgj8+6/JIZ5VKHk
	ujRta+8jYUzi5LqzjVxJ9tJgQNTYQ7Cflt34UfD0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:27 +1000
Message-Id: <20190426060627.18153-37-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 36/36] target/ppc: improve performance of large
 BAT invalidations
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	clg@kaod.org, qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060627._Dt89SnUGkArRZSV4akj5MWCTfQkoZyp9lPN6hsECGM@z>

From: Artyom Tarasenko <atar4qemu@gmail.com>

Performing a complete flush is ~ 100 times faster than flushing
256MiB of 4KiB pages. Set a limit of 1024 pages and perform a complete
flush afterwards.

This patch significantly speeds up AIX 5.1 and NetBSD-ofppc.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index d226b35739..1dbc9acb75 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1820,6 +1820,13 @@ static inline void do_invalidate_BAT(CPUPPCState *=
env, target_ulong BATu,
=20
     base =3D BATu & ~0x0001FFFF;
     end =3D base + mask + 0x00020000;
+    if (((end - base) >> TARGET_PAGE_BITS) > 1024) {
+        /* Flushing 1024 4K pages is slower than a complete flush */
+        LOG_BATS("Flush all BATs\n");
+        tlb_flush(CPU(cs));
+        LOG_BATS("Flush done\n");
+        return;
+    }
     LOG_BATS("Flush BAT from " TARGET_FMT_lx " to " TARGET_FMT_lx " ("
              TARGET_FMT_lx ")\n", base, end, mask);
     for (page =3D base; page !=3D end; page +=3D TARGET_PAGE_SIZE) {
--=20
2.20.1


