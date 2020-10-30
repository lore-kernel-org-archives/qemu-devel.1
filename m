Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E17C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C1D2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTT9UvZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C1D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWiU-0005fJ-0q
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYWho-00056x-Mg; Fri, 30 Oct 2020 11:52:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYWhl-0003mt-1t; Fri, 30 Oct 2020 11:52:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so6962362wrp.10;
 Fri, 30 Oct 2020 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dvb7IQunz2aNgckCmay4cq8YoBKmrHgG6tBMb/zjLVs=;
 b=tTT9UvZtaH8WujdIcIuvVH47IsRuWHtlan0AAKQj6GtR44KsH3rSc/FjsKk/f5/l/g
 a0nHXj5fbBNnPd6dRZ/cnNNxfgky29Qw6E2Eq7VKH9g8YbzS3m0kIkDbRym5esB3pGvL
 iV+p575jSBuL9b7KhzGEcgdNx4JRcrnlk6TddJ1lQjKqNHWDdFgH6VgRDTZ7LzW5herf
 DSONTrZRWqNrCiR28yBiTXh2E+Krwf6w/UlcluqVuSz4GB8TD9QA1TYjWQPPkYsQLzV0
 sQ6udxRK9dJVZJg1+B3hWa6Rs5HRMkYsQC0jEtw7VJWaLDjFIT2ToIZdB0xP8trylxxR
 gd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dvb7IQunz2aNgckCmay4cq8YoBKmrHgG6tBMb/zjLVs=;
 b=MN1HrbiEL5VHgw+/L5Hd3NMHTmXpp1lGTJ2r5GKs9apAF03xm+0L5IYdv1k83p84dq
 uW0eIl6+UTKYlKK5AjyAPoft4l+3DG8n0pvuJdAwvq/lw0vSuGpFVDFnrfHdHaDHR8pp
 ZMheiL/373FRBy9ClQ4kZjLrDUchFq+EtAZG7lzEjUkELIdi10rxUZnWIGMuTiM35R3e
 UUWYyyYLE/R1QA8koJTjiS2mM7VNLMqjxqeSaLkoQGdoQzYITG56QTDaVMD+gT3nvtez
 RZCXQdUD6zRlb3ZETiY42MOSUCFtgNxrHJQCvJ50x9iVnBbNiE9NdHTSEcfa/ztg/6zk
 Kk+g==
X-Gm-Message-State: AOAM532hVdSh22cXgRkal/JCIFUbQo7pO1Q1FqtG5bq7OI/sOEELHlMp
 B1JFkTEmeQBhjz+b6nd7De4=
X-Google-Smtp-Source: ABdhPJz+ISrds19NDdN0voBn3NoVElv9amBi43zNkcPzcri1hF9O7N3GQik7Qp+oznpX0S1q3o429A==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr3956610wro.420.1604073158170; 
 Fri, 30 Oct 2020 08:52:38 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u6sm4996680wmj.40.2020.10.30.08.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 08:52:37 -0700 (PDT)
Subject: Re: [PATCH] docs/system: Deprecate raspi2/raspi3 machine aliases
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201019082121.1544550-1-f4bug@amsat.org>
 <CAFEAcA9tBN9mDsotycNHnh4cUVMaYtGJO8NBqgvATKw8fJ7i7g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <877f333d-596c-4cdf-1df9-d832a34833eb@amsat.org>
Date: Fri, 30 Oct 2020 16:52:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9tBN9mDsotycNHnh4cUVMaYtGJO8NBqgvATKw8fJ7i7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Libvirt <libvir-list@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 3:33 PM, Peter Maydell wrote:
> On Mon, 19 Oct 2020 at 09:23, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Since commit aa35ec2213b ("hw/arm/raspi: Use more
>> specific machine names") the raspi2/raspi3 machines
>> have been renamed as raspi2b/raspi3b.
>>
>> As more Raspberry Pi 2/3 models are emulated, in order
>> to avoid confusion deprecate the raspi2/raspi3 machine
>> aliases.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  docs/system/deprecated.rst | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
>> index 905628f3a0c..f0c7aaeb2ff 100644
>> --- a/docs/system/deprecated.rst
>> +++ b/docs/system/deprecated.rst
>> @@ -355,6 +355,11 @@ This machine has been renamed ``fuloong2e``.
>>  These machine types are very old and likely can not be used for live migration
>>  from old QEMU versions anymore. A newer machine type should be used instead.
>>
>> +Raspberry Pi ``raspi2`` and ``raspi3`` machines (since 5.2)
>> +'''''''''''''''''''''''''''''''''''''
>> +
>> +These machines have been respectively renamed ``raspi2b`` and ``raspi3b``.
>> +
> 
> This isn't valid rST syntax, which requires the underlining to
> be exactly the same length as the title string it underlines:
> 
> Warning, treated as error:
> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/system/deprecated.rst:348:Title
> underline too short.
> 
> Raspberry Pi ``raspi2`` and ``raspi3`` machines (since 5.2)
> '''''''''''''''''''''''''''''''''''''
> 
> I also think it would be helpful to have at least a sentence
> saying why we've renamed the machines.

I indeed forgot to run 'make man/html'.

