Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68424C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355AF2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYTLeb7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355AF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TNX-0003Hj-AW
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TKC-0008JZ-4r
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TKB-00056D-8k
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:43:20 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TKB-00055x-3P
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:43:19 -0400
Received: by mail-pf1-x443.google.com with SMTP id b24so13292605pfp.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TQv+ti99nn6QcjzMpDYmQHnFsyEGeexnezIGZ/VzKZc=;
 b=bYTLeb7MM2AtabzgUN/9ioC/Gt3RB79VY6KL2pJiCc0ukxbjT0LexobgkTdLUIG4j/
 Y0mXgpMIFENY+atmOOesJM2Wzouz9341mpBpB5EaeghWdL6b/w8mstwN1sjAGutsEU4Y
 kJS3s295ugfAyrkvTLL+v6sqmZIV5Zrz5JaEoEIQXH4Jf4SyDvS+V9Y1NqXNH0wiVeTS
 wvUtvu/U756D+XE0hSKJ6cQbqtPvKQWmK8ApC3jOwQ6s5NeWvTkaJcy4lyMxtBMA2nln
 bjZSQfFEUiXGuesBPwdKtgvp5ihyrvVKrgvVtch1LJX0O3UpM0VH9f4gI6Sj3FAo23kC
 ZvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TQv+ti99nn6QcjzMpDYmQHnFsyEGeexnezIGZ/VzKZc=;
 b=GiNwpx59pAJU8yBb0enV03LixIUh1FGk218ty/8ydfI+Ss3ThrMYAm2kVFILiICuLB
 1Gd8GIyr5ZZtu3IvGLZ5iJHlFBpg19PHWMjqqHe+UItFjOI18ULKNfpPUvo+GKQFplkm
 U6Poxnk3s8ryI2BYLJMYdTv4T9KfGsmZsrSMn8mKxWKf4uoO65BVg6sqPUg3EZTogZrr
 eA09DJQOBBePQWy08jrRb8DEZ4B90I5RfSjbGZ3BdtkCScCxDjNWbPwWEzvrZrsANwPn
 B0b4puskapuBlnHOiLWGWEalPoG9kdE1AE2/Qh0/mskP6rwTSV44Ot4enbzUMdY45zsO
 ozVQ==
X-Gm-Message-State: APjAAAVmAQLMb7Vb08OmfTkqRxnA9RXRaYRBJIzL2Xe1uBdfCn3T785t
 DB0IUt+NJ3xg0/VHk5eDBuc=
X-Google-Smtp-Source: APXvYqwxmRE+t+R77vP39rFk8mSlugNXEutpqPoDMe0EipLgsHe+f/UJ78Kne7xxuyCqI7DWGcnO2g==
X-Received: by 2002:a65:430a:: with SMTP id j10mr20127944pgq.374.1566880998069; 
 Mon, 26 Aug 2019 21:43:18 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 a186sm14510174pge.0.2019.08.26.21.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:43:17 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:43:15 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827044315.GQ24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-13-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-13-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 12/13] target/openrisc: Implement l.adrp
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 05:07:44PM -0700, Richard Henderson wrote:
> This was added to the 1.3 spec.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
 

