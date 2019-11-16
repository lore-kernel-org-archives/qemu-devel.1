Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BE3C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 12:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834F5206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h32MyB8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834F5206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVxBH-0005ir-S0
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 07:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iVxA0-00057t-Ch
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 07:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iVx9z-00058S-A0
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 07:26:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iVx9z-000566-2f
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 07:26:39 -0500
Received: by mail-wm1-x344.google.com with SMTP id t26so13300158wmi.4
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2019 04:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eLJVzqfwLZESavNcQrNukQr53AX70MNe4FibHkYnXI4=;
 b=h32MyB8xKDnUQTtMZ3ttyBvBC/Alnf2Jffr7bWlP9B9hHhsFbrW06m1acemX5VeZw1
 FTui/mehPZUzAV0fDPCXuBKBn+yBibDrOGTQO1wx1MJLOXPIA11b1ZyNpvZd8u2pPoy2
 hYeyHD8pHIwdItqoJYyR7kFr9T6Tncr9v66Ni7Sp1W5eag2fsLLwEUFVNKpub3PlcUAS
 epO3BZqWBrlybNJXxcLfrmmAsyVVltBiYy58pgqSKFSs37PLtFQ2AReVItmbJHeHIk3S
 A9AdnJ7FXa8fxStyBsy1NGb0kdU7HRQA3zdRo3hsW2n64Ghyb4/A9ywOACB0o+Tr9ptN
 2Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eLJVzqfwLZESavNcQrNukQr53AX70MNe4FibHkYnXI4=;
 b=VixmfhkoZ9HRtWDFSZpMjNAHqSA5ho+PEA1hoKmVoKm8ON+hdU1iGJs55dbWznCCyo
 vD0RztRTsazv4ZMABVCKi+dwdoe7FDfv8qdc2pEQKCNas5WOfhSSIz0n1x4F2WhSq8y6
 xnq4lXafg05F1LHtiKdnKWyIy+Xf4PSWNxoAGha20kwha9jIzpem7p8aDiwfnSpsX2Ie
 9T/fom17ET3uPLvWmdyJFw3WahMxnYeN4cSeqclC6fgBgFTsE4TxK2pnaMSp4zLzl/nS
 o9v26ieQf0ea9a3ZSlrdMoZ7G3u5AhYXSpLbbNsNVmSH3m+qrNLfj9GKpw23P+60pAKv
 yvEg==
X-Gm-Message-State: APjAAAU/03mTrLT1szeJbbElqz8xgz8V6pXlU1DD8DoNtkqOmogbFFla
 jtoN1b2DtE/pP7iysXrOI26B8w==
X-Google-Smtp-Source: APXvYqxzzGo2C6v0wwOdwB2xCfkl+XbJuOLe5IiAYGJmspqJVR1vTiqWP9XLC3zRaCvKElKgs6s5YA==
X-Received: by 2002:a1c:9d4a:: with SMTP id g71mr21059916wme.66.1573907197675; 
 Sat, 16 Nov 2019 04:26:37 -0800 (PST)
Received: from [192.168.8.102] (87.red-176-87-99.dynamicip.rima-tde.net.
 [176.87.99.87])
 by smtp.gmail.com with ESMTPSA id b66sm13973708wmh.39.2019.11.16.04.26.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Nov 2019 04:26:36 -0800 (PST)
Subject: Re: [PATCH v1 2/5] qemu_log_lock/unlock now preserves the
 qemu_logfile handle.
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-3-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <af1b568f-89ca-c471-c27e-89907d4385a4@linaro.org>
Date: Sat, 16 Nov 2019 13:26:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112150105.2498-3-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 4:01 PM, Robert Foley wrote:
> qemu_log_lock() now returns a handle and qemu_log_unlock() receives a
> handle to unlock.  This allows for changing the handle during logging
> and ensures the lock() and unlock() are for the same file.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
> v1
>     - Moved this up in the patch sequence to be
>       before adding RCU for qemu_logfile.
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

