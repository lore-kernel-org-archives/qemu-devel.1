Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72937C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D29720663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5OeceMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D29720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDshx-0001Dc-2S
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqhm-0007Nw-9H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqhl-00005A-AR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:26:58 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqhh-00082R-SZ; Mon, 16 Mar 2020 10:26:54 -0400
Received: by mail-pj1-x1043.google.com with SMTP id nu11so5546603pjb.1;
 Mon, 16 Mar 2020 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i5D0yWQL9Fea9nHxAcnwd4Pw7HLyVMj68QCZAf63FYA=;
 b=e5OeceMGPC6F5sYOBXp2yqPDd8sVtEEkb0D/70PQx0/AxzH6t7k0FkvRBfLIAdXxv5
 974S6/eUm25qFMExIWf3uW9HGAZa9a28+C9RyCoXE+tJE3pbuIBSZ/Ndwft3ICWG4iaT
 CrtUwnP6ZCbtA8bJ47tZBsLjXNfzhkZ6UxJ2qoXnUxW8JWebsd7gImiDvmLp0L8yxeQM
 M9SxVqABIomzRP4hx1L4JL18VEblfkDjdRmKAc56LWzOblCl+KhhT0iYeuZfnH/aZ0MC
 rcz2vZwybU5O5mp3rz9bAObtGQ/9AeYFegXf1L6PvVcszl/xIJV8D1lFtkVO5HUR5drJ
 Wh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i5D0yWQL9Fea9nHxAcnwd4Pw7HLyVMj68QCZAf63FYA=;
 b=O/WttuuqdTjGJIeL/IBnu/0cHbwAHvG5bHob5u9ly+sicMcP799ScL/dOQKVTP6Kfb
 YYWRZ1MINursJnCkXzJb3YCy5zlAxGDhzdbUZeoCeZsvnPV8h7QryDrlZzGWSSFIp/ab
 wcHoBCZ5R243170HpLZ5uKlT//zXzmD9BYQPsjL/Mr+6QRYOtjHvvAeYC+RbwO6IlESl
 cKet+/BrEv11S77+5RWvzMljKxJKX6Eval6XcaPxbs35cNkLQ+jy/2BURh5bd1+Nd7Xi
 PQeU4zbsK0befAoEKoW1ft2Xh+mYQZPuzpoUW9gM84fBR3hi9Br3pyym5VIw/66CRXUs
 B24A==
X-Gm-Message-State: ANhLgQ2ZAwGcokbgi0GlukJW5yUVa8eEEWhKWXvv/k/HEHAuzv6vBHAX
 L6TvslFWpfN3P/yCbQdBQkSl7fLr
X-Google-Smtp-Source: ADFU+vvF8PBfhOCqdJxtRSDuQsLB4LMWKdtsU0WLMN27Q3lMNCmYWUFgGVNyy6yrIew/R9AlL/rDMQ==
X-Received: by 2002:a17:902:b582:: with SMTP id
 a2mr6018199pls.176.1584368811804; 
 Mon, 16 Mar 2020 07:26:51 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:26:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 0/8] FWNMI fixes / changes
Date: Tue, 17 Mar 2020 00:26:05 +1000
Message-Id: <20200316142613.121089-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Since v1, I fixed the intermediate compile error spotted by Greg, and
rediffed the series on top of ppc-for-5.0, plus Alexey's patch
("spapr/rtas: Reserve space for RTAS blob and log").

The first 6 patches are otherwise unchanged since last posting.

Patch 7 implements fwnim sreset interrupts now in a way that's
compatible with existing Linux guests (which doesn't necessarily quite
match PAPR, but does match PowerVM behaviour).

Patch 8 isn't required but it papers over Linux warning messages caused
by another quirk.

Thanks,
Nick

Nicholas Piggin (8):
  ppc/spapr: Fix FWNMI machine check failure handling
  ppc/spapr: Change FWNMI names
  ppc/spapr: Add FWNMI System Reset state
  ppc/spapr: Fix FWNMI machine check interrupt delivery
  ppc/spapr: Allow FWNMI on TCG
  target/ppc: Allow ppc_cpu_do_system_reset to take an alternate vector
  ppc/spapr: Implement FWNMI System Reset delivery
  ppc/spapr: Ignore common "ibm,nmi-interlock" Linux bug

 hw/ppc/spapr.c                    | 76 ++++++++++++++++++++++-------
 hw/ppc/spapr_caps.c               | 19 ++++----
 hw/ppc/spapr_events.c             | 38 ++++-----------
 hw/ppc/spapr_rtas.c               | 43 +++++++++++++----
 include/hw/ppc/spapr.h            | 28 +++++++----
 target/ppc/cpu.h                  |  3 +-
 target/ppc/excp_helper.c          | 79 ++++++++++++++++++++++---------
 tests/qtest/libqos/libqos-spapr.h |  2 +-
 8 files changed, 188 insertions(+), 100 deletions(-)

-- 
2.23.0


