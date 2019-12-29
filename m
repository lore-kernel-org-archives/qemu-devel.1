Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174FC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 01:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776FC20838
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 01:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGPEiFos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776FC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilNNA-0004np-Mw
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 20:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilNLK-000309-3i
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 20:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilNLJ-0000Mi-4L
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 20:26:06 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilNLI-0000GY-TE
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 20:26:05 -0500
Received: by mail-pg1-x544.google.com with SMTP id 6so16374205pgk.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 17:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=fDd2fwTHMTFpAsIGBcEis+OLrts4nS3we1qYPEICUTY=;
 b=yGPEiFosoYN/N5intTyDMP0dsRU7i49bsJGU4KBf7zJu96feq2avBOXJnV+tRj2jLJ
 GQ/H9BAD+5tUNTf7KAnsKdyDLZKNDnxB4aCVqtHY6/5f7DO3NOwTFqhxvwP/G/lC+9tj
 +OUhMVmJcjzxvCFEZA01n77eiXTdhHYyCJYZ9GXFP85I7Qr1Zta/ceYZcmf7Fovnqwwq
 uwdv5rVkV4961Cqx/tdcPX/jPgC0xJvMzUd7zIHbuJ7gkj4oRVDrqZ+JVcX9BEfVZ/oc
 CQk4XDKVEm+0+EOHPSpXIfeyMZWiqns54mWp+1+dw+W9uaJKE2fNgvcY/v9nhXCIsJEp
 G2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fDd2fwTHMTFpAsIGBcEis+OLrts4nS3we1qYPEICUTY=;
 b=BXofowtN1+5iKeI4JPVqw/ZtXW4qDyuFlL0syI4Gg+ziE5JCv9GTTL9lmJhGHG67cW
 ZiCXotznuVTsKQ07S//FbGymRKEXRfRS5uadRf9v7ZRxtmI4QZUwjlZrUtpZz5cG+Qao
 yYpgkVmIyITrg2NHF/ZmLVBzl4jUAD4UnkM6QxANBqwhj5EgCihMKGKrbYoHgP33WnXQ
 i94CwKP7EuXw4CSG/jOUE0cCyccSgAsh6677sSbixTr9fO/7pCDQTuG9VjuagKq/kbWA
 0sbEtjknDtqj+Ie3MxzL21KFZg5HRlG/zpUqWcwwPtWy19OY8oUfjel3kTfhVnXDw0Vp
 jenw==
X-Gm-Message-State: APjAAAXlUsaiFSNpwSkubd98eUJanSjzD7bTLlomb0nlthh3UVQh9EX+
 H2JXBpMWscOdslL5zQZZ1lN0UJxOATY=
X-Google-Smtp-Source: APXvYqyOKs720Xb95I4L531mX9nzB4UR/1nVLyLnH9K3SxfMQKUNRTU6BbirV5sP1hwe4qI94bzJ0A==
X-Received: by 2002:a62:7fcd:: with SMTP id
 a196mr59693368pfd.208.1577582762476; 
 Sat, 28 Dec 2019 17:26:02 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id w20sm35777740pfi.86.2019.12.28.17.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 17:26:01 -0800 (PST)
Subject: Re: [PATCH 2/2] hppa: Switch to tulip NIC by default
To: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191221222205.GA27749@ls3530.fritz.box>
 <20191221222530.GB27803@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <011fdadf-244b-874a-3008-5195080d26e2@linaro.org>
Date: Sun, 29 Dec 2019 12:25:57 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191221222530.GB27803@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On 12/22/19 9:25 AM, Helge Deller wrote:
> Most HP PA-RISC machines have a Digital DS21142/43 Tulip network card,
> only some very latest generation machines have an e1000 NIC.
> Since qemu now provides an emulated tulip card, use that one instead.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Queued, thanks.


r~

