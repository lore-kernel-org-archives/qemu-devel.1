Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB04C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB407217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3EjK2Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB407217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1zm9-00074p-4u
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 16:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1zlK-0006eG-NV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1zlJ-0005TB-Fl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:41:38 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:35129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1zlJ-0005Qq-7M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:41:37 -0500
Received: by mail-pg1-x529.google.com with SMTP id l24so1903002pgk.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7eJ4VeuOK8ezxHtXH5V/NpaSeQ96jy2G2iT03PiZ6k8=;
 b=j3EjK2NaxO/6EtwQ36YRkzlz9VKRoWxLzLcZPknAVCyQg3XY8g9x1XpDY/TLXs0y8n
 KuMy13NDNt9UQQ+YZheEGdCmU1WQEwLBWqGta/YlajSeajwwYt+lPuX+gaRoUIdKXtPG
 cpcm+tEfJ6TvTKO4ph0zOt5FmIgoatlwfMWbiX6jAc4sJn5Ii5lk8CZIXyQTrKKvrBEE
 O4rXM07wfFDACXT6yvqmeYyStC10XDO7mQn3o/8i1bHnMy8MwrN8EDCs9/+RHrv2NIvY
 VaTxAkJkEiWDHTLvJQwK4eEETq/Dl2shiMv0PGJBjxVAupaVxnQAbgNVfQcf9WvblOl9
 4Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7eJ4VeuOK8ezxHtXH5V/NpaSeQ96jy2G2iT03PiZ6k8=;
 b=rBc/c+rvbp2dlPf9Ts4aiHtrXIG3LON9TGB2SGtKbLLGvm+m8TohUJL+Zd52zpXST7
 DG9DRpuaj96/5akSzBd5pm/48sYfJgkhvr2efk2a8VijOg4T/8oPcSM1CYg9twsdVdDh
 QIWBMr6WpimIOPESjcb+2GM3A8G8YEWM7K7ep6jVeEMilA9WZOIs95IfxUuP8mKzW021
 BwgbNR+amdeP+B2ApSTS3v69Z4wlxUR8MG3vZGruQ0WqyP0KyaWe/7/sln8HTQQxbGaN
 5T8eVFjvSv3TF9sa0zflC0BGsK1KnSISQ0IuduxQy1GB4Ith8avNoRJjWjRJOhk5GZgj
 APPQ==
X-Gm-Message-State: APjAAAUPrUyAQkeFNYgExMeBbkDffCaGtSvnjQYBIvbffkRrdgmkSld1
 lyKyS3SfhYVlrriWckcZMqElMV4b8ng=
X-Google-Smtp-Source: APXvYqzZ5fo7wPEbIuLYMpV2leF//MJCyo4u8qjMnxW1iTBxnqqhkQ//Iybr7VSU4oTRKdFsC+Dh3Q==
X-Received: by 2002:aa7:8545:: with SMTP id y5mr10545387pfn.185.1581543695610; 
 Wed, 12 Feb 2020 13:41:35 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id h7sm78603pgc.69.2020.02.12.13.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 13:41:34 -0800 (PST)
Subject: Re: [PULL 5/5] qemu_set_log_filename: filename argument may be NULL
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200130213814.334195-1-stefanha@redhat.com>
 <20200130213814.334195-6-stefanha@redhat.com>
 <906a4b84-8f4f-fe12-3357-02d02d5dac7d@linaro.org>
 <87mu9oxew1.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9bf6b7e2-d4f3-d883-a5df-25a31903c28d@linaro.org>
Date: Wed, 12 Feb 2020 13:41:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87mu9oxew1.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Salvador Fandino <salvador@qindel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 2:45 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 1/30/20 1:38 PM, Stefan Hajnoczi wrote:
>>> From: Salvador Fandino <salvador@qindel.com>
>>>
>>> NULL is a valid log filename used to indicate we want to use stderr
>>> but qemu_set_log_filename (which is called by bsd-user/main.c) was not
>>> handling it correctly.
>>>
>>> That also made redundant a couple of NULL checks in calling code which
>>> have been removed.
>>>
>>> Signed-off-by: Salvador Fandino <salvador@qindel.com>
>>> Message-Id: <20200123193626.19956-1-salvador@qindel.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  trace/control.c |  4 +---
>>>  util/log.c      | 28 ++++++++++++++++------------
>>>  vl.c            |  5 +----
>>>  3 files changed, 18 insertions(+), 19 deletions(-)
>>
>> This patch has broken -D <filename> for *-linux-user.
>> After e144a605a, all logging goes to stderr.
> 
> I posted:
> 
>   Subject: [PATCH] tracing: only allow -trace to override -D if set
>   Date: Tue, 11 Feb 2020 11:10:54 +0000
>   Message-Id: <20200211111054.27538-1-alex.bennee@linaro.org>
> 
> as a fix which partially reverted this.

Thanks, that fixes it for me.


r~

