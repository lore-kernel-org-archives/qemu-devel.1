Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4288C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F927206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuVdads8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F927206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ZO9-0004NK-NI
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 07:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2ZMz-0003Pn-48
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2ZMy-0005Z9-35
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:10:37 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2ZMx-0005Yt-Sr
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:10:36 -0400
Received: by mail-oi1-x242.google.com with SMTP id y8so14592724oih.10
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JPhFgEhoCfCrfd4vD3CHiB6SDrSqBJ0vDlG9DuMZSqw=;
 b=MuVdads8OwKFlDvbHKCTJkuz+wyxYA1QkQxGCVzbjaLOqKo9sjKffdb08HmeHN8k/3
 jeg8EXhzYtH361eNWP1X3cohFSwCXt8Wp+O+jxtZMauQBXLjuAVNWPJ4vdzzS828VsVM
 NpfDsvuvnHkzonM/sg8BlA4exK0IzSmOWl6pqgM6lfgG7wzmUX77HFJkIiMHBP/29Pul
 yYi75BYyzHkIosL8tMYHbmVH1uvw6fOmjh0ZoBqSdU9oVycnVc+Foa0o5rbIJU4FpLpz
 Fsu12/sMl1hzd8JDJDT2FA7PAuSK+JeTux9YQYiPxejLPBICNlab88/cGpT4s+t+2Pn1
 owjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JPhFgEhoCfCrfd4vD3CHiB6SDrSqBJ0vDlG9DuMZSqw=;
 b=nowe2R9d+SPifgKmJEXjnRd0RqGz4MePGQAbF9roUHJAV1TbrZuxP/tnXuqnQ11mPa
 RqWQFcqoWpg0ZNBfMsX1P3dRYJwLKKagco5GLjHuFvHNIHHhLBYhR4qTlzlDYmODxU/N
 qpianV9uQLShJoenWFlwnkO1l/3hSefrXw9Z5xa+p/k0jPqayAMIg9pCZLJWLFw2LXFX
 SOKJhlcLjpYLIq9DfBxG9MePXZzhan6d7XhsgeVA85hkNFRe6ITzEEkOHjOE8Gahoky3
 ymKTzUgm7X+kdx/LVHsxAsTbXmDIZ0kPDEOF20fMM5EA/5WJ7oeEx2ks6kuzWGRZkRLb
 pc2Q==
X-Gm-Message-State: APjAAAUlPzCj/CpHuyQrENLoEZBRqA5YzJ1c0DfN4gTEZFjU1y/dhAqr
 IVQzt6m9TlHiFUYY1dU46bN0ExJJ/qTyOmBBRu4Xkg==
X-Google-Smtp-Source: APXvYqxmDCa8IUomKJc4nKMgh83SR3XCm6wkocq/dXc59qdDk+Oq+z0XuXPrLFqDhZ8cNfIj5G+dyorB2BSD3d9qXa4=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr14557106oib.48.1566904235123; 
 Tue, 27 Aug 2019 04:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-22-richard.henderson@linaro.org>
 <CAFEAcA8saD6zkOA7-6nF5jQBMgKPLv0L3WXV2m0Y4WtHwVqWgw@mail.gmail.com>
 <CAFEAcA-PG1Jd2F-DLp7yKQest3aWqb3pv4FjUB9movDf4VgWgA@mail.gmail.com>
In-Reply-To: <CAFEAcA-PG1Jd2F-DLp7yKQest3aWqb3pv4FjUB9movDf4VgWgA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 12:10:24 +0100
Message-ID: <CAFEAcA82Y7xNbGB4BioUJ4G7kx5MT5TorF3HoRmKTqaE1eC2Qg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 21/68] target/arm: Convert
 Synchronization primitives
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 11:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> ...OK, not this specific function, as I just noticed it's the _a32
> one, but trans_STREXB(), trans_STREXH(), etc are wrong.

I did a quick grep through for places checking the 6K condition,
and I think these are the only ones that need changing:

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b4d53f3d37f..58e50f2d808 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8874,7 +8874,7 @@ static bool trans_STREXD_t32(DisasContext *s,
arg_STREX *a)

 static bool trans_STREXB(DisasContext *s, arg_STREX *a)
 {
-    if (!ENABLE_ARCH_6K) {
+    if (!ENABLE_ARCH_6K && !arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
     }
     return op_strex(s, a, MO_8, false);
@@ -8882,7 +8882,7 @@ static bool trans_STREXB(DisasContext *s, arg_STREX *a)

 static bool trans_STREXH(DisasContext *s, arg_STREX *a)
 {
-    if (!ENABLE_ARCH_6K) {
+    if (!ENABLE_ARCH_6K && !arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
     }
     return op_strex(s, a, MO_16, false);
@@ -9004,7 +9004,7 @@ static bool trans_LDREXD_t32(DisasContext *s,
arg_LDREX *a)

 static bool trans_LDREXB(DisasContext *s, arg_LDREX *a)
 {
-    if (!ENABLE_ARCH_6K) {
+    if (!ENABLE_ARCH_6K && !arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
     }
     return op_ldrex(s, a, MO_8, false);
@@ -9012,7 +9012,7 @@ static bool trans_LDREXB(DisasContext *s, arg_LDREX *a)

 static bool trans_LDREXH(DisasContext *s, arg_LDREX *a)
 {
-    if (!ENABLE_ARCH_6K) {
+    if (!ENABLE_ARCH_6K && !arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
     }
     return op_ldrex(s, a, MO_16, false);
@@ -10236,7 +10236,7 @@ static bool trans_CPS_v6m(DisasContext *s,
arg_CPS_v6m *a)

 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
-    if (!ENABLE_ARCH_6K) {
+    if (!ENABLE_ARCH_6K && !arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
     }
     gen_clrex(s);

thanks
-- PMM

