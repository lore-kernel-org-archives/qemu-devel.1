Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74404C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF0B206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsYLSBHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF0B206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLgKw-0003Q0-EZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLgKJ-0002zS-Ny
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLgKI-0004ov-H5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:59:07 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLgKI-0004oI-1s
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:59:06 -0400
Received: by mail-pl1-x641.google.com with SMTP id c12so790316plz.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QjS2Ux6QbNTgMi5Bl2pSoMFbfXu6ohQ90gJoWvN024w=;
 b=rsYLSBHB1MMmoTnKIH90yts+dOB5kwpWQ+EQhB4zYszpv318lGE1UOxarudGoNpr9k
 EECMqMB4AVPzMFTfJB+GJZpKQh5cag5wPhe+3/1CTC5/Mk+8PPhq5+QV0Vk4lHoXA4Jq
 X0FTMnUlRZodlIZn5ElwshirWai0HEZud/UTcKlcNB/Yv75dBo77rLTGUlJmdopFAZ3o
 kv0p41fOJujTHvS3Xq6dQ4KYznO//QuDabd+4ttibyrkSwfr87WHJk+w4jfb0qm9sF5S
 zbDrwe/mptX+ZmefiBLznkBs/G9i4O40K+9v3MVwNwpqWVdjhc5JAVfkj4jJYuriEawp
 0ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QjS2Ux6QbNTgMi5Bl2pSoMFbfXu6ohQ90gJoWvN024w=;
 b=Mis1TWIGaBkCWsyDkO7U5XOBdJ51C6dsW16levD5QfEz/xNpbEtS8YrUee+Pt7M9sg
 fuSrrrDvdA5TiZHVzuOrjEYKyjXIaAW+CZ8NAUxsjmIbjOXncj7uewg8TPjrPwpwqwGC
 3Kbdn11AOnKmci2uvC4NIwlgPf4K7q33n3QX8K8EaEIDjFZwowq5yA6IIvnhNf1BFpQ9
 3UW58Pd6eFllHXoCwO3hA95c26C/hfWNrOjPEiylDoB+U8nMjFKEEVLgRRbkFjOURynq
 +JwdNvnQP6r8oiM2Bko/gQVlq2ze/eUeHtSXbuH/qW1hf7ovxl6eL7oLUW9LZRiZ5Omx
 BaAA==
X-Gm-Message-State: AGi0Pua7TtmQYeV++X6D0YqKXT0wfyX4GYiwL8GPARWV8OkQShVyJg4R
 +nBx7AYmzRBsp2XzawSbzDNm3w==
X-Google-Smtp-Source: APiQypKp23woguSZSNNbfADIoUKS2nuRvuO30GnA8/RVSpWpd7/0GNoQhcNIUZtMzFtJ39W5yrlAYQ==
X-Received: by 2002:a17:902:bc89:: with SMTP id
 bb9mr773662plb.86.1586235544476; 
 Mon, 06 Apr 2020 21:59:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id x4sm453384pjf.23.2020.04.06.21.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 21:59:03 -0700 (PDT)
Subject: Re: [PATCH for-5.0?] target/xtensa: Statically allocate
 xtensa_insnbufs
To: Max Filippov <jcmvbkbc@gmail.com>
References: <20200407030938.26537-1-richard.henderson@linaro.org>
 <CAMo8BfJ9+fnA2xp8PMKm039oW-qVtTxpON6Ux=tkBySS=cQhxQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1770c1d1-a6ac-be6d-2bb6-8d3530d8878b@linaro.org>
Date: Mon, 6 Apr 2020 21:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJ9+fnA2xp8PMKm039oW-qVtTxpON6Ux=tkBySS=cQhxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 9:04 PM, Max Filippov wrote:
> On Mon, Apr 6, 2020 at 8:09 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Rather than dynamically allocate, and risk failing to free
>> when we longjmp out of the translator, allocate the maximum
>> buffer size from any of the supported cpus, which is 8:
> 
> There's macro MAX_INSN_LENGTH that defines maximal supported
> instruction length in bytes. Maybe the following instead, along the lines
> of what libisa does dynamically?:

Thanks for the pointer.  Looks better than mine.

>  #define MAX_INSN_LENGTH 64
> +#define MAX_INSNBUF_LENGTH \
> +    ((MAX_INSN_LENGTH + sizeof(xtensa_insnbuf_word) - 1) / \
> +     sizeof(xtensa_insnbuf_word))

There is a ROUND_UP macro, but it seems unnecessary.


r~

