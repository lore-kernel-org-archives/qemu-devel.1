Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC60C76186
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 00:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2193B20693
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 00:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4UY/hOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2193B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hozn8-0005FE-8X
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 20:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44368)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hozmy-0004oZ-5B
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hozmx-0004dh-4S
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:33:20 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hozmw-0004co-Rg
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:33:19 -0400
Received: by mail-ed1-x541.google.com with SMTP id k8so37598601eds.7
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xoHBVs1hETvx26UMisYCCOo5LujAzxv/mRB+ZfIC8VI=;
 b=p4UY/hOtA2iqlRPTyO3EWdcHLsJK2MuLFzLn9yfm4EYvwhjJm2II7ANmM0KUp/MJYa
 jUWJWHiTJCAD664N1N1N6QGx4+dLZEiv14Si+LppCOqlnuFrpxZaMs6M9U7M26Nt/8ph
 z4LjkNlOdD3KKhJVqQ6RNOxf7WAil2vastvAohhx+FtqL1jsoX9tQkynWDJXkPHVQ3X9
 z4annfHPnqxQaV79eeADNrfM7sGZObopZ2L0pvEb8ufrZc6kEK6kUjsA4LWSFEid2Ydn
 pzfqV6+umprMIhnV8hOap7pIxHhr7tlB8mTUgtrzpBLwCI1HZZONIh/haSBnE/pacP+M
 ulpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=xoHBVs1hETvx26UMisYCCOo5LujAzxv/mRB+ZfIC8VI=;
 b=CAUwCIrz31Ud8ZePhui3mjDGIiAXlQi/xm9pE7vs9CImzn07EHOdwu+oFOdvsTwFRz
 ONIKo/wENWh5QyIWZNQSwbBW/isxHkrHY+98SjGwY2vxAmOyotW6JnoXyDjs1Db0Cuaf
 HeFaNl6lVekWEV0u99wai9kzUat9hTcqeHR7Sap1k9cRA54TBReMvNCzpstKC8nW5P2S
 G3GJtyWjcoP3fc4cPqPG7WoYljnBiGWlwwoOJqHIsPPWsh2/ZgfVayke8InVRBCRMfne
 ReGKsuOSqIx1D8waqbWFh1frWt06ErHB22Lx1/0I/V6I9bSHlQdLvPokkVhQUPNgLrCV
 CMTQ==
X-Gm-Message-State: APjAAAV9dLvZyp37X0hi/sJD5iLjq2aDsXrmxnZnEbRhAZSqATn9tjcS
 yyGtBWMhgzZnptxyziLlgt0=
X-Google-Smtp-Source: APXvYqwCh3DlVURQKScCAphXpxZqPoZrIDEXcFJRNaG0THqGbfyGF3tnUOYS7yv/C9Ekr7iNRapxPA==
X-Received: by 2002:a17:906:fd5:: with SMTP id
 c21mr47346432ejk.135.1563669197612; 
 Sat, 20 Jul 2019 17:33:17 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id p15sm5042117ejr.1.2019.07.20.17.33.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 20 Jul 2019 17:33:16 -0700 (PDT)
Date: Sun, 21 Jul 2019 00:33:16 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190721003316.dosnhlbawuezpryb@master>
References: <20190718010456.4234-1-richardw.yang@linux.intel.com>
 <20190718010456.4234-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718010456.4234-2-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 1/2] bitmap: get last word mask from nr
 directly
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de,
 qemu-devel@nongnu.org, peterx@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 18, 2019 at 09:04:55AM +0800, Wei Yang wrote:
>The value left in nr is the number of bits for the last word, which
>could be calculate the last word mask directly.
>
>Remove the unnecessary size.
>

May I ask why Patch 2 is picked up, but this one is not?

>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>---
>v2: refine bitmap_set_atomic too, suggested from Peter
>---
> util/bitmap.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/util/bitmap.c b/util/bitmap.c
>index 1753ff7f5b..5b15249796 100644
>--- a/util/bitmap.c
>+++ b/util/bitmap.c
>@@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> void bitmap_set(unsigned long *map, long start, long nr)
> {
>     unsigned long *p = map + BIT_WORD(start);
>-    const long size = start + nr;
>     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
> 
>@@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
>         p++;
>     }
>     if (nr) {
>-        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>+        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>         *p |= mask_to_set;
>     }
> }
>@@ -182,7 +181,6 @@ void bitmap_set(unsigned long *map, long start, long nr)
> void bitmap_set_atomic(unsigned long *map, long start, long nr)
> {
>     unsigned long *p = map + BIT_WORD(start);
>-    const long size = start + nr;
>     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
> 
>@@ -208,7 +206,7 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
> 
>     /* Last word */
>     if (nr) {
>-        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>+        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>         atomic_or(p, mask_to_set);
>     } else {
>         /* If we avoided the full barrier in atomic_or(), issue a
>@@ -221,7 +219,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
> void bitmap_clear(unsigned long *map, long start, long nr)
> {
>     unsigned long *p = map + BIT_WORD(start);
>-    const long size = start + nr;
>     int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>     unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> 
>@@ -235,7 +232,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>         p++;
>     }
>     if (nr) {
>-        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>+        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>         *p &= ~mask_to_clear;
>     }
> }
>-- 
>2.17.1
>

-- 
Wei Yang
Help you, Help me

