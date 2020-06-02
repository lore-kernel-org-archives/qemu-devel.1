Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A494C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFD320734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPaaM5Pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFD320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg2h7-00057C-Nm
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jg2fS-0003DH-F3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:53:06 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:45381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jg2fQ-00061y-00
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:53:04 -0400
Received: by mail-ej1-x629.google.com with SMTP id o15so11923518ejm.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7RsWRH+NVe5DOvl9MNs88tfeGa1fiNcLtaKe6eJYEcw=;
 b=dPaaM5PqOlnbv+7IesvtVlZEIswcs5nkTHjz/xF2S7JHYN1qAWZSEmdvvzXa9rVp/D
 POrstj6o1EaJuP4qzAhu/3QTfz/fTc4FWq0IZ3sNlw2bgi0PgMvX0xEpkm+t1wSmgn1H
 AzZiboxTXoF85Yg3nONsFbxReHgJ8nNp5LM2crqDjHXA9BLr0SkQ4q4Oqmt4EmSQ/Ykb
 noNoTZbXZu6zdWBw7Qyexi4/49jh8Za/K90VhsXYJtDtorEAYAmUl0YElFiI+pCfiXvp
 tRE0rtW+OJFkTSzjTAK1jJJpvIFAoYNLL43rGCjxvl/du80bvX4YodCVoPp7PcAF+5qe
 mfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7RsWRH+NVe5DOvl9MNs88tfeGa1fiNcLtaKe6eJYEcw=;
 b=Z5p/OAXS9IGh3eMhv7OaN2qtezfE2scR2MyRsX1yji55Tvui0y2VSUchxkQeZLRM8K
 QAZlnkwAszMH4sKH9jqjO/AP2ysc1nElwslLqFKj3PeGOTcCZLKr5pLkbPxn2R2KEqbC
 yEcuf78J2b863sAemeO5wkVr6m485hmFXhCsBzGR3dPSE7BY+mHZeYoQeSYjbCCzOrwx
 vL7+Nsly8uF9JNgHtOV3EiQmn+/VYovwYwEvaWFFbL1ijpTt+ALLVcw4hBTQJl3stvmW
 QVkMRToqPJrJVPgvJEQqt0TO8/ipbf1uEkVocAgIIwVQIiJdoXz7uFP0ExwDH31qZJkr
 ki2w==
X-Gm-Message-State: AOAM533PWq1QNSt4ahf6EX2F+JdPXBlBTK2TaxBvlVkaIbCVJfS3Qlae
 ng4N5X9i2uyWzzPCZk5wfiXd8b1Xe4E=
X-Google-Smtp-Source: ABdhPJzEhOsOAWtuQkqkva08ROjGBCRpqreo+JkF9sIqhQsyTl1+qGCjElUUgBVxqmlpoC/ZVKTjlw==
X-Received: by 2002:a17:906:8614:: with SMTP id
 o20mr946939ejx.444.1591087982475; 
 Tue, 02 Jun 2020 01:53:02 -0700 (PDT)
Received: from localhost.localdomain (net202-35-245-109.mbb.telenor.rs.
 [109.245.35.202])
 by smtp.gmail.com with ESMTPSA id qp15sm1363601ejb.69.2020.06.02.01.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 01:53:02 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] mailmap: Change email address of Stefan Brankovic
Date: Tue,  2 Jun 2020 10:52:15 +0200
Message-Id: <20200602085215.12585-3-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602085215.12585-1-aleksandar.qemu.devel@gmail.com>
References: <20200602085215.12585-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com,
 Stefan Brankovic <stefan.brankovic@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Brankovic wants to use his new email address for his future
work in QEMU.

CC: Stefan Brankovic <stefan.brankovic@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9f2a3a55f9..84f36592ba 100644
--- a/.mailmap
+++ b/.mailmap
@@ -52,6 +52,7 @@ Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
+Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
-- 
2.20.1


