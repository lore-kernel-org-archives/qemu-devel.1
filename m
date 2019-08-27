Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19592C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D154320828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsYkWX6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D154320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TSe-0005an-3S
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TRy-00059i-QK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TRx-0001DC-Ih
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:51:22 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TRx-0001CF-B8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:51:21 -0400
Received: by mail-pg1-x542.google.com with SMTP id w10so11917279pgj.7
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=88O812comtaSttiU+iGO2oLot9i/PkQhasDBHR20yz0=;
 b=hsYkWX6qA9anR6kOAMSOlx3jWGcZ2L2GMpDTdwn0hpa9Ebezo9ixxRBMM/tcXpYvcN
 +PvCb1tQCzPq411DQE73EIwbZsXZN7HTRt/Z5HHQfFTF2mNj+Nlerr1FeqHvKyLAzDbI
 6oXTIVnYiTINVLIIGaSkQEfJYgeKh7sDSQdkwDFRJasL2v+QLQC6uIqexhuNiVof+l4N
 sp6cF6Oxnz5HmwNOpok237DDPGlB/vrC1rEh7J2y2VuRa7JYImRG1xTgzCs7J1JBS7Xq
 8E6XnuiYVEMjHAEs9wCTBMpGUgRN5vqS8pWU6jrmtOAPdPGGHINcjlxQ0Vs1H3gLYWQk
 dXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=88O812comtaSttiU+iGO2oLot9i/PkQhasDBHR20yz0=;
 b=fnjtT8jZ6/jBdCU3CYh10FaZfdCXjwnBGj8PxB9TYSi5od2tTQrSUBaaQdxfcAtIzv
 8qTgNElRqKLtQFuWcs58z9coyKzmyhhOsr31Gg2g4QQ5e8Re9TjiF97xsDN78cugBdM0
 LMroPQeCr9dRhY4pUBtkNxeJeRYg1YL3lmsEAQa1ZwXizNXGcIqwTRijCnpUcaC5UbKw
 h1pKsR60D89XrYqUcXCgUxNd+rg/lQ7DGoi/yEtf3ye3x2oKmhE06oe0dsy3ZUINlEt2
 fITHnLNz+HF7aYA8yMgvhl1hIvNN9YLR1Gq3SqeNTlK+nnr8lCjHn+DPXXaCV+Sl7RKC
 EusQ==
X-Gm-Message-State: APjAAAUDf5vU85TfxDsfxMRTcBepWDNDyHYWWqAJ5fcIOGFLpOuRb1gL
 rlvy12mJmSjoT5VZ/QPIobU=
X-Google-Smtp-Source: APXvYqyqLtlQUCASSMCAf9w+8Ht9cuprEMsLwWTyH/8M868tfG3+Gs0K3DT4Knh2zurzzb90I5rSJQ==
X-Received: by 2002:a17:90a:a610:: with SMTP id
 c16mr22549677pjq.54.1566881478904; 
 Mon, 26 Aug 2019 21:51:18 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 e19sm13201328pfh.114.2019.08.26.21.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:51:18 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:51:16 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827045116.GS24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 00/13] target/openrisc updates
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

On Mon, Aug 26, 2019 at 05:07:32PM -0700, Richard Henderson wrote:
> The first three fix an MTTCG race on cpu_R[0], now that
> we do code generation in parallel.
> 
> Then some updates to the SPRs, cpuid checks for existing
> float insns, adding the new v1.3 instructions.
> 
> I've run this through the gcc testsuite as
> 
> make check-gcc \
> RUNTESTFLAGS='--target_board=or1k-qemu/-mhard-float/-mdouble-float execute.exp'
> 
>                 === gcc Summary ===
> 
> # of expected passes            103979
> # of unexpected failures        26
> # of expected failures          400
> # of unresolved testcases       1
> # of unsupported tests          2539
> 
> Of the 26, none are obviously floating-point related.
> 
Hi Richard,

Thanks for all of that.  I assume you will be taking care of upstreaming this?

FYI, I have been working on getting an old [glibc port][0] ready for upstreaming.
There still is a lot of testing and cleanup to be done.  But so far the work has
uncovered 2 bugs in OpenRISC binutils and gcc.  I cced you on both of those, did
you see them?

 - binutils (*) : https://sourceware.org/ml/binutils/2019-08/msg00214.html
 - gcc : https://gcc.gnu.org/ml/gcc-patches/2019-08/msg01549.html

* the binutils patch is already pushed upstream.

[0] https://github.com/stffrdhrn/or1k-glibc/tree/upstream-rebase

Sorry for hijacking this thread.

-Stafford

