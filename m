Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E8FC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F413B206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pML6Md8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F413B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtaD-0003WC-Jp
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhtZN-0002nF-Vg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhtZN-0001BA-1u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:29:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhtZM-00019o-P4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:29:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id e3so3664838wrs.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y9bd0dehI6x3r+dPEwq4O1tHHSmceDossebDFjKafAI=;
 b=pML6Md8RM6a9MWhj4ZOiayUdoyBt5uT37VstJLJf6Fm8WMjkZJmgUOlZwD63ab5RGM
 plCI7iPbKZqT6q4g1yKX6gSYxfNEy6JbVPUils12cDYerWLcXCvYnMmMFZcTXG8X9LiT
 +fMfW8GxkEqLfaXJet2ZSYzkJxQtgT7kWwzetQSd5zwMyvSR8NiTrZ0D2NcAcFYr2swv
 Vnw3824Gx/9I+qPmG/V8Ny0Gy9HMsBpY+6quNgj5n68zgeL8Azi/jGtBhOxUvSv48sfE
 6o5vmC6+5mCVakWywXf6oKp5n1bhndyUll+WKHE74QHMtSqNTBONvE1f7woXi4JCAKwq
 r8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y9bd0dehI6x3r+dPEwq4O1tHHSmceDossebDFjKafAI=;
 b=Dz9KwC3VgqHnEOAT/8MXYl57KziC6VudVy1c1Eiw4GvWM2DADMjsSXuA0UhfpJXlhi
 pLhu3U56X6FmXD+LqPcRdaq2nEjDCYr0ECGViZv9IQWrDzCBdZp85nmxs+/vJcmFsmt0
 Wbx0/5eG3V3ojLknOcnuLZ1otlThuOIbuzP4qOheCW/aPGngFLpo3MfivxAMbdKjwY4V
 sSe/ELhepTyrlwJ0znP/JhWSYZozFYknGM3SXuIYFBfnNWYyMC2kxKvQITIfty+oeBPj
 b4wttzgo1q6SjMyPD6fwpgCVbHoUs8Z9XS92xS+593JyiJ8S0gSVc6qRFuR5DnnnBB9A
 AwMQ==
X-Gm-Message-State: APjAAAXg6o1M9jdvbO63+NcZIwRDnbIK7H86wj3sRzrGRw0qBm5NwMzp
 IphpreuyneJuomDJ3+rSwrldIw==
X-Google-Smtp-Source: APXvYqxn32OaNQpAd3PHRXko3Rp7giKJR4/nNiNRm2YLQRz0t9+fnEHBjUMuotEt1sbQAhjUifs3pA==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr20076281wrw.266.1561976995222; 
 Mon, 01 Jul 2019 03:29:55 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id o126sm9696105wmo.1.2019.07.01.03.29.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 03:29:54 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-16-richard.henderson@linaro.org>
 <CAL1e-=ghMjUtEyqKX+s15RcyQp6uQO_hJ_u4RTSJ5ZyPvFnymw@mail.gmail.com>
 <b376dc86-6879-2a72-3261-7fdf06172456@linaro.org>
 <CAL1e-=hS_nQQYY39j-mx1QBFw+Xe3V5NgFW7ifrkMZRxFbB=OA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <38326483-d804-02c6-42bc-9633fc4d5028@linaro.org>
Date: Mon, 1 Jul 2019 12:29:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hS_nQQYY39j-mx1QBFw+Xe3V5NgFW7ifrkMZRxFbB=OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v6 15/16] tcg/ppc: Update vector support to
 v2.07
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 5:57 AM, Aleksandar Markovic wrote:
> 
> On Jun 30, 2019 5:12 PM, "Richard Henderson" <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
>>
>> On 6/30/19 3:37 PM, Aleksandar Markovic wrote:
>> >>  bool have_isa_2_06;
>> >>  bool have_isa_2_06_vsx;
>> >> +bool have_isa_2_07_vsx;
>> >
>> > Does this flag indicate support for PowerISA 2.07 or VSX?
>>
>> VSX & 2.07,
>>
>> >> +    if (hwcap2 & PPC_FEATURE2_ARCH_2_07) {
>> >> +        if (hwcap & PPC_FEATURE_HAS_VSX) {
>> >> +            have_isa_2_07_vsx = true;
>> >> +        }
>> >> +    }
>>
>> Like so.
>>
>> While it would have been possible to have one single have_isa_vsx, we would
>> then also have to check a second flag to see which revision.  Therefore I
>> created these composite flags so that we only have to check one.
>>
> 
> Yes, but, in this patch, for example, among other things, the support for
> doubleword integer max/min vector operation is implemented. Why is the
> existence of that support dependant on VSX (PPC_FEATURE_HAS_VSX)?

Because otherwise the instruction doesn't exist?


r~

