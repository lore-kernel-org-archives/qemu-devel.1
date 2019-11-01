Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2465CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA7D21734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="s2sKxliX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA7D21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQaGn-0007MZ-GU
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iQaFj-0006gc-Fe
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iQaFi-0006Fo-Cp
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:58:23 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iQaFh-00069G-Sm
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:58:22 -0400
Received: by mail-pl1-x644.google.com with SMTP id w8so4629924plq.5
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=cgfp8EbdhnJcgO/OyEQ0g/ucBASe54QWB7VlCyACCvA=;
 b=s2sKxliXQzQhZV+a98pY55g3nTGHkiaUM34399+dxoZR7sUEamRTkMHstKQq38qlKi
 JSPbQY5xNdDzUcXtxZQaVw4wchEHnSUsuvfnQU1vxe5/Zm5kMfSvaSlCbQhbOWAVLLMu
 gVJZ3oj8Eiri+DkapftHXO6XxsCtnLJmKVXCxIlc+Y0q5cPcpTBCRlWjyDVS1jIFX+o7
 3Zi1TkJZjY1U9hAXdussWAVernOFYRQVP99NkVLldCrYLuoUCYnQQYSzdVFvd9uFUFSE
 RwvLs1ppUxSduCxJxzIncjknDwuovE5Wy+c0TlPVswOGD35l5Q/LzfirzUfXmaSXRLAq
 Eb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=cgfp8EbdhnJcgO/OyEQ0g/ucBASe54QWB7VlCyACCvA=;
 b=WD7xL/ZIxLbIvUEvqDj/59pF86yg7tsE2eiktAeKhKEjze2I8bm1eax3HC1rGGtZvK
 WXdyXB+xFiEqVMgWtBFz/87FEre+iCOHdgoWeBcPQ/n6+Z7ztPqMKthASAE/cJUqU/9p
 KRv5dBLKQFl4KKYKw3SYoSwW/Ql8EJLrjlF6b9TmvblqbXNfeBJ5/UYl9QB2wOVA96ru
 EbbUHX9nXbByzSedgJGkC1gRTWvTr0csagkZokMUnmPuEtPKKX1nJ6eRxw+Z6ndtchGA
 lZ613kCt0WlqcD/qhZD2u6evJvSzgX3zRbkyVI9C+X/LVg5kAAyuhSoPlay4yXlugME9
 T4dg==
X-Gm-Message-State: APjAAAUXnJdcw+L0izYBwqGu41cXLH2fRcMtj4Gy7OmgNcQ1lzHo+DEC
 jpGWTm0UGRf8yG9XWRfm3qetDyrArFg=
X-Google-Smtp-Source: APXvYqytIMmUCMsduQIJb0QRAIRM99uiG83GFAeY3oWFZ2TiyrgHXkX9D5cjpokmOWnHZegjJJeU8Q==
X-Received: by 2002:a17:902:bb8b:: with SMTP id
 m11mr13718438pls.235.1572627499876; 
 Fri, 01 Nov 2019 09:58:19 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id q15sm6844907pff.155.2019.11.01.09.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 09:58:19 -0700 (PDT)
Date: Fri, 01 Nov 2019 09:58:19 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Nov 2019 09:39:00 PDT (-0700)
Subject: Re: [PATCH] remove unnecessary ifdef TARGET_RISCV64
In-Reply-To: <20191030002318.399-1-hiroyuki.obinata@gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: hiroyuki.obinata@gmail.com
Message-ID: <mhng-7b7098a1-1195-4532-80ab-2d7c51ebd2ed@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, hiroyuki.obinata@gmail.com,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Oct 2019 17:23:18 PDT (-0700), hiroyuki.obinata@gmail.com wrote:
> From: "hiroyuki.obinata" <hiroyuki.obinata@gmail.com>
>
> Signed-off-by: Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
> ---
>  target/riscv/translate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index adeddb85f6..5c4dd21a98 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -64,12 +64,10 @@ static const int tcg_memop_lookup[8] = {
>      [0] = MO_SB,
>      [1] = MO_TESW,
>      [2] = MO_TESL,
> +    [3] = MO_TEQ,
>      [4] = MO_UB,
>      [5] = MO_TEUW,
> -#ifdef TARGET_RISCV64
> -    [3] = MO_TEQ,
>      [6] = MO_TEUL,
> -#endif
>  };
>  #endif

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

This is a non-functional change (the code in question was already wrapped in an 
"#ifdef TARGET_RISCV64", so this internal one was redundant), so I'm happy to 
include it during the soft freeze.

I've added this to the queue for my next PR.

