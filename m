Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C153C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90402072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ0kzFcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90402072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOS4-0002mK-Mx
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irOQn-0001cv-3x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irOQm-0004r9-5M
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:48:37 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:38081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irOQl-0004ph-VG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:48:36 -0500
Received: by mail-pf1-x430.google.com with SMTP id x185so6774217pfc.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AOnGMNKFHNkSKQ3aU1D5WOp68/Etcml3eqjqkGkHH/0=;
 b=IQ0kzFcL5HjLsbhccanDtswrS879Tss11AMlegr6EqpycAdwO2bHv/mGaYdaNBnfO7
 500fFQbmyfr8OeZCo1RXO7O5vcM7Kh8Hd8iB4szTImvaTMKzkEHestNU+rHM8DEnh9Zy
 iWetEKYCKN0mvx73TepHc0waIb4mk09CKMQZsn16VndNoOW2Keg5GktOvzWqjyB7fycc
 m44eo2ybaZEcrYStgqrGDVtETZpec29aIXvh64+vxCxQnM4s2HbQorJLr0HQvrSYAoLD
 3RCMeMEj6dH60Wkbff4pjJWkDZToY0xVhO4DTzfsQ984NMpfz/1ZIKQBPcr9mirnIZK5
 7yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AOnGMNKFHNkSKQ3aU1D5WOp68/Etcml3eqjqkGkHH/0=;
 b=d1qcXuYq86/dm/W1qq8VA5OwvG4fP69FmqdJvi07H5NdXfzYbKi3xAHsYdsNKNzr46
 1qgbRQlLmqOvL/88UM1EQ79ajIP23470V7amEscp3Yi3AMyVfq9TdB90+9uwD9LhytM8
 PigZ1fBUhlsicWFumJiIIo/+A5HIkqcHC8CJtvZOfWu8OEZvmXKeRUV/MszsjK9dZjj9
 UR+PD9I1rW38U8/KkPrODI2n/XVw9e7ax+2MoKIRgQul169ViAtw3gxxWp9eYRuwyE1C
 nYRsmImfb9YpnsnlDLgSe6zIvojhD52YzMLrFNRf36x34GMg3Duf9/zP4yBFVNbvaY74
 nqjQ==
X-Gm-Message-State: APjAAAW28zqd5Y5jpCOqNevDDCBt3PCyG8cMes59HvATvTDzZ+x767gA
 +0ve4mdJjAoGFSUokrRz2kkD4A==
X-Google-Smtp-Source: APXvYqwLeoabO+vpym5fsrslCI8xQioJghsBd9J3riqFoPqNDRV9fViHR2LFRRe0N/t43KitY8CfvA==
X-Received: by 2002:a63:7985:: with SMTP id
 u127mr27155097pgc.169.1579016914890; 
 Tue, 14 Jan 2020 07:48:34 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id q22sm19131473pfg.170.2020.01.14.07.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 07:48:34 -0800 (PST)
Subject: Re: [PATCH v2 2/3] target/riscv: fsd/fsw doesn't dirty FP state
To: shihpo.hung@sifive.com, qemu-riscv@nongnu.org
References: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
 <1578996840-14863-2-git-send-email-shihpo.hung@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a94696f-832b-2870-644e-e1859313bf42@linaro.org>
Date: Tue, 14 Jan 2020 05:48:30 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578996840-14863-2-git-send-email-shihpo.hung@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 12:13 AM, shihpo.hung@sifive.com wrote:
> Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvd.inc.c | 1 -
>  target/riscv/insn_trans/trans_rvf.inc.c | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

