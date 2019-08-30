Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D52C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E607523407
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItOKUmoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E607523407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3hmR-0005qV-4Y
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 10:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3hXH-0005i3-OT
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3hXG-0002HK-Cp
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:05:55 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3hXG-00025Q-2j
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:05:54 -0400
Received: by mail-qk1-x743.google.com with SMTP id m2so6181839qkd.10
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n5K+/jgCN5Vl1Y5P2Wq4YmrdggUNqrnMnKcI9mMTaeY=;
 b=ItOKUmoiWbO4UHbsSe53u+ojH3OQfZ/XVbmKASjPTGpyao9wFSkDVGdW2Rp/t3NTrr
 /8CqITuwIG7fpJ/ItpwpeOSbFfZS6vUVeSbav+CAUPwW3pk0UEdb1+1JORBo86uBuD0i
 jcMh48YdMoDmEF+VFJbfZWb+LR0f+P5dLvcM1awLi5aqi4W0QHKFU08sSlpkNpp/CfgV
 GzXh1dviLTv3awcCeYcwAZvZBmtDiZ97LIgpN1MTSLIAcY4byXjXK1wfW3yZQ8k0f2C/
 NYxzHg//ju7um2vLkZ6Yp2Ct0OVvE+6IuqwNrcvlwPaYAFnj85O2FRjzmOFtxMicB5g5
 Gmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n5K+/jgCN5Vl1Y5P2Wq4YmrdggUNqrnMnKcI9mMTaeY=;
 b=EAsEmqnlP8gPkzZiMgR9gWI4JUmvRNujxWLl4xRvRei6HNb34G9+3qVI7UjyttOkP1
 6BgTVsiXj3qEl2QpIflaKRyOiMrJvEUK115lHBh6lJ7RNaYP7NT+Lob5f9aVaNIRf1Mv
 iLUEPiBWxHIHTtFxTS7zRz4TImV9BdSoOcLR5aeC1irjhqxdu6QxhBBSBXMty8t3OWj/
 jTrIhEu7n1em+os6RvqZ0khEkNfKSIiZX/08YlaI28otmqUNUFRubwBq3lNnWY7YyzQT
 lmtES1U/CgIkqLkbtAL3Qf6W3IVtjxyeoihfehpL141WTaQOGMjWnVOEz8F1bIQUK2dg
 XB0A==
X-Gm-Message-State: APjAAAVrshF4QunnMszq3CFH3i3OVLUNSywZQzZNLhJO8dBbaCNHz1Mx
 xf3PLOFoUR+4/Ay2jWAGyrGezqHAtBt0Kw==
X-Google-Smtp-Source: APXvYqznWkG/Jjkq3oxJrlj9tfzP9mgk/N2vDo2OF72PpeOAWCUVUN2svd7q9Qlp/tkG8id5gSnRrA==
X-Received: by 2002:a05:620a:142e:: with SMTP id
 k14mr14669937qkj.336.1567167553472; 
 Fri, 30 Aug 2019 05:19:13 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166]) by smtp.googlemail.com with ESMTPSA id
 o127sm3001299qkd.104.2019.08.30.05.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 05:19:12 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 09:19:01 -0300
Message-Id: <20190830121903.17585-1-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: [Qemu-devel] [PATCH v2 0/2] Integrating qemu to Linux Perf
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is part of Google Summer of Code (GSoC) 2019.
More about the project can be found in:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality

This adds --perf command-line option to dump Linux Perf
jitdump files. These files are used to enhant Perf report
and to be able to analyze and dump JITed code with perf.

Example of use:
 perf record -k 1 qemu-x86_64 -perf ./a.out
 perf inject -j -i perf.data -o perf.data.jitted
 perf report -i perf.data.jitted

vandersonmr (2):
  accel/tcg: adding integration with linux perf
  tb-stats: adding TBStatistics info into perf dump

 accel/tcg/Makefile.objs      |   1 +
 accel/tcg/perf/Makefile.objs |   1 +
 accel/tcg/perf/jitdump.c     | 206 +++++++++++++++++++++++++++++++++++
 accel/tcg/perf/jitdump.h     |  36 ++++++
 accel/tcg/translate-all.c    |  14 +++
 include/qemu-common.h        |   3 +
 linux-user/main.c            |   7 ++
 os-posix.c                   |   3 +
 qemu-options.hx              |  11 ++
 9 files changed, 282 insertions(+)
 create mode 100644 accel/tcg/perf/Makefile.objs
 create mode 100644 accel/tcg/perf/jitdump.c
 create mode 100644 accel/tcg/perf/jitdump.h

-- 
2.22.0


