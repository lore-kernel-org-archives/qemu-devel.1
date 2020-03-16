Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D59C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C1720753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0X82ww1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C1720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvK3-0006Mq-Ds
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuph-0000t0-By
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDupg-000754-5C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDupg-0006mS-0o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTuM1yhPSP5ySruBCJxSW6noud9pHrZGrwBgDgMq278=;
 b=g0X82ww1NkuMK1gwyeWGJvkDulhLayCd/Ya3lfHseNfGSuUEcKW0+goMxKtq/k7H3qJooU
 cq+j4qBWt9cmSbnoAe1yvQy02Y5dqmWgqxvnde/qsbO+H+JyHdNcCgPfa7QWeMUsv35B+w
 H05DJAeUsoSw4Rza4FIbtBGvSQgVH4M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-8RY_omIMNRavhwS1PD0myg-1; Mon, 16 Mar 2020 14:51:17 -0400
X-MC-Unique: 8RY_omIMNRavhwS1PD0myg-1
Received: by mail-wr1-f69.google.com with SMTP id f13so3265862wro.23
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2B/8CWN/FyAeBStmkGrCPLIrt/TAmqFu9+C8I7tRrxA=;
 b=Y97GA7bZkpAkOi17iHGXKugqkuYY8BkzGfB8ACtlcIPAlBqHV0DuBlFSuKY+Cy+6eh
 YrgosB7oghaipF1EgTbmhsHu1tp7slT6+cDZs7duafRuIgI4v8P0dM9c+YepuVNWF1K9
 kboW4inTBDWyaQJMP4+Tfd11o6LzGBco6kIkiVV1ZID00Q/oPCf2Pm5WiGM+M2OsU4Kd
 wo8xh7LiNmUO8KTvuXZFXaLxo3zfYJG56LxnK7xY75AFUH1mRt/aDkCQz1gRJet4x5V7
 WunCtwr7gFtSaEDlV0Bf+PS6dbQ/FnluXQK/I1TrojW+2ZdsvSuJRetzvSde2L45moGR
 vpgw==
X-Gm-Message-State: ANhLgQ1Ww2vhB2ld1uLfME4iVAqsi44+tFTT7qWmYMBNYCx40336G2TK
 lDYkoK4IcW22ocw3+d+xlKAAth7nBdEzzmHibfPZStsKJjsECqA29qhlrKyeQO7hRsyiKeYUTEp
 aV5k1MVbSsrzsgbI=
X-Received: by 2002:a5d:6910:: with SMTP id t16mr722548wru.209.1584384676472; 
 Mon, 16 Mar 2020 11:51:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvBnXDAus51I8a8xSHRFv5byerQBu4zdjvJtF9Gjgy7GzQkS7v5UpU5DfU2gyAprWpZI+Juwg==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr722533wru.209.1584384676298; 
 Mon, 16 Mar 2020 11:51:16 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id g127sm781950wmf.10.2020.03.16.11.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 13/25] hw/sparc: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 16 Mar 2020 19:49:54 +0100
Message-Id: <20200316185006.576-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/sparc/leon3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 5fa58aa55f..8f024dab7b 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -255,8 +255,7 @@ static void leon3_generic_hw_init(MachineState *machine=
)
=20
     /* Allocate BIOS */
     prom_size =3D 8 * MiB;
-    memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fat=
al);
-    memory_region_set_readonly(prom, true);
+    memory_region_init_rom(prom, NULL, "Leon3.bios", prom_size, &error_fat=
al);
     memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET, prom=
);
=20
     /* Load boot prom */
--=20
2.21.1


