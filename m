Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBFCC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B262073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgphec37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B262073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvk0-0006bU-EN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55537)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkvQ4-0007jj-5B
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkvQ1-0001Mx-LC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:04:51 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:42076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkvPy-0001CX-2z
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:04:47 -0400
Received: by mail-io1-xd30.google.com with SMTP id u19so45480097ior.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lf3EnFwJ5D9ZPFimQQP7oOEz9HE97ug8lc33kyMVnFU=;
 b=cgphec37CI+8vVKtsqEnMoxxGKkeew9DzR4nK7h2XH+V5xoFMuXZadws0UHR2C59d/
 J9QeRDTMC1Uexxworq8KXfpiDxu6zisXZzWfXoGvPR4VL0kanMKW60jHqS2gS2HimuoN
 loEWqjg9TEyXq81oRhw2hrGr/+DGpjzlLJECLX0I1tjfPiqEkLv/W4KGbRNRzvFPfjtY
 p9q4B34gnVGrsJfmPgH4uWR9M+4/+VR6EdjUwnV5XkGmASsFRDFE4XOcb4pIHAqpkXpF
 4rx547BhawyFly3bpx8Su5MX/OUut1wRnfYD3EuYh4Rog+G8iaSVPOuPoUVqgXBuUal1
 0SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lf3EnFwJ5D9ZPFimQQP7oOEz9HE97ug8lc33kyMVnFU=;
 b=QmY5adYCF+iAOIG4cyvXX1L8rkD/YL2yzK6NwkGyyDNXpFjR3zIfmm7sTvcJ8WDYfN
 yssTcklIeaAGuAfw5jmwhIR3uzjCnMFhhPm1CcwbKi3t+VPDkPvfSJv12lfkcOyHZP/C
 T/fFxT9FXhvVtC9g4xNPJloUDnifl8ZmuzmMG7zBYY5hXleBbghwxpyU5eD5csSuEKZ8
 EQdMaXVAnNeWtsidBlnozocMyO1+4mT5ywDJDR844JNneFTBgRXgrCJDhcFrF2nbhGWD
 wH3MUx/vitZo64CoOHlNdgW6R1i4CRamqBU9VEChcM9oP9hJ66qo1Y9YKdg6MIR5VDrN
 j7AA==
X-Gm-Message-State: APjAAAVm67QRxFJznErm/gdpELNfevMgJdM+uXBaOaYNmPtDC3SygkFx
 zCe6Qz3loq94PUuzuKEkTswxwg==
X-Google-Smtp-Source: APXvYqznpi1PqBwV2vLkODThvTAkdyC/dmVHF1GKzKKGFq6zJoojY1DchoIL9jxy7mp4PWiCSkCxFQ==
X-Received: by 2002:a02:c916:: with SMTP id t22mr29447803jao.24.1562699078977; 
 Tue, 09 Jul 2019 12:04:38 -0700 (PDT)
Received: from [192.168.43.94] ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id q13sm16403348ioh.36.2019.07.09.12.04.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 12:04:38 -0700 (PDT)
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
Date: Tue, 9 Jul 2019 21:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d30
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 6:58 PM, Lucien Murray-Pitts wrote:
> Any suggestions on how to obtain pc_next from the "m68k_cpu_do_interrupt(
> CPUState *cs)" ?

I did have a suggestion.  It was fairly detailed.

https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06522.html


r~

