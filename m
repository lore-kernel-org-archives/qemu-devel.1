Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52148C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F622071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NREcEN6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F622071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyP5p-0002Wm-Bo
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3W9kYXwMKCnAgQkUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--scw.bounces.google.com>)
 id 1jyP4p-0001hR-1f
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:27:11 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:56152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3W9kYXwMKCnAgQkUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--scw.bounces.google.com>)
 id 1jyP4n-00035I-Hx
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:27:10 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id h194so4426362ybg.22
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=Sk/1dhRJdyGFY/ZXAB2amd3chsommc+oi+T6QAGUc0M=;
 b=NREcEN6WBoN/Rj4wtdem9OCb+eLzPYUINA6A/bGmD+oEzm3Thd+gBHIjy4beogZyKl
 0JusghEafXI5dRQkCgyKt+ZZ0S9XZXcvbWNS0+bugM5WdKC/AIHySpIu2PYSvwErsVDX
 9xxHhFYerivsrOAp7sEXXqMOk272i8xF5e+Ax/nU3eOo7YSLzDkBWs9uz2DZhLCD83N7
 WujAO93Wiot2jrlSWoLVwnz12fFz7HimrmNBsNNAFC+pNRqPtTQCt3+wl2A+Ys/sK7dL
 3SxQh6iLag2vhtDMh0A401h6XzdH7ZFR+hKDvSsxyWxnr1qHRFNCVG2FAV8dtBceXQSB
 dBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=Sk/1dhRJdyGFY/ZXAB2amd3chsommc+oi+T6QAGUc0M=;
 b=qUlq3LGr7YN6K/0VCacm/sWvz/nSAAAWX6cstsB/mWFu8cJ5F/HRtbXgoIY7jywpE+
 2QIF6Ui16X7ujhFxaw5n3E+Jt/zt8bhQ126gXjvv35AYHSTp6AYpYvBkkKo9WWmX22oy
 3ubpzW38D2CvVLr/ehhhneHLTMy0WCJ8GCvjQeaAkwHd4NMOBEfDq55hXcVBVMgUQWc9
 VW+nRB74OSfTc6AK5jpQhCjDanaudyPr+ctqfZIS3k1edA1JM0dzw5ygVXWfo9jQt+Pr
 iiMVXTmRQwfOpHyv1ttr+HP/8EsvzoNYt6d1jY9zhCAJDOJyZKMDRUVc0SHRZNEBRxX4
 Peug==
X-Gm-Message-State: AOAM531JkhnkP7h7RslAV5x3j0uhRQAHNdrFIg3lL75q/+w5zsmvUQS0
 JGE7uWyzccu2s6PuOhwCFcJ1Gns=
X-Google-Smtp-Source: ABdhPJxtn7decsNj255WAAtCwmF8LZx2Fe65z+m9tAiPkCL+3slQX9MBzGm8kuIQ+W2Hchejwxzucsc=
X-Received: by 2002:a25:ddc3:: with SMTP id u186mr3226089ybg.152.1595464027831; 
 Wed, 22 Jul 2020 17:27:07 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:27:03 -0700
Message-Id: <cover.1595463707.git.scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 0/2] Instruction set detection for clang.
From: Shu-Chun Weng <scw@google.com>
To: rth@twiddle.net
Cc: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3W9kYXwMKCnAgQkUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently when configuring QEMU with clang, AVX2, AVX512F, ATOMIC64, and
ATOMIC128 are all disabled because the detection code is GCC-only. With these
two patches, I am able to configure, build, and run tests with clang with all of
the above enabled.

Shu-Chun Weng (2):
  configure: avx2 and avx512f detection for clang
  configure: atomic64/128 detection for clang

 configure           | 34 +++++++++++++++++++++++-----------
 util/bufferiszero.c | 33 +++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog


