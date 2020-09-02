Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED6C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD1F20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1pin3P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD1F20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVK0-0004c8-F7
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVF4-0006c7-LC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:04:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVF1-0008A8-KB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:04:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5so5826249wrp.8
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h+8fotHbRzRWmDg4HkxaqTxaG0DImkn/RQwfGmOrZ04=;
 b=e1pin3P7U3Fc+SEO8vir9089sIKtnbf9k6Bf4ns5BO1N6H6VVAYdpoIk86gTCH92Ms
 jiEliuiCKh+SP75eMowuEh9jUoCyOtH+WzbRxBz82XtH9/eepmS/f/Onv31c5Guc5jp/
 AGM8nHlhbzddydqm3eIlLR1HL1RCrTh7AiKdtnv57m+PzozrXuryWyAngulsUnMeLcfR
 n0hb1wdA+4X0vO66gyFB3iqeieJqmpL2BfQGKikuLQSlCI3ZiMZpRuDwXe6VOXdRiJ7l
 T0m7OQ2OXBXRX0Eo3pKpyMwp92kc0GleJ5DCBtwiNx41wFC6lu623zrJ3AmKZXMDguja
 f7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h+8fotHbRzRWmDg4HkxaqTxaG0DImkn/RQwfGmOrZ04=;
 b=dPBenucG0nWNSyZZuihyl985MiCWLi3WfuahuMa2P37zJmo6nOvU+9QzlvAqdOx3c/
 baK4jPMKRPlnHRI+qIFAbpk+UBCzAdAYSrQ3BzQXsL84ZLMNghdPyZmUZXVREkD0AmT2
 zbYu2csVy1stHfatl3coLayRe4sN8DdlT/v8xa6CyxM/DrCzw4/3ZmDWcZ9FhGgqRolV
 MCA75lLkdU4XXwoFD7GoN8DGLLmFoImQAXgKE8BKDYAfvUIRiju5ZBEXlzbOnvDABYYY
 kNGQ4YuLXtYSYEUwqXHjhrjBAF7uE4ql/EELdTG8BxZXZJKRQS1/cPI2YNDYGB4ckMOf
 5/vg==
X-Gm-Message-State: AOAM531A6sjAn9l3m31IAD3S6V6bVV3UDE6afhgqY/zmFQXjw8M7oVBi
 YHyjTOHWDXpJue/V/xaCws8CjiaZ+TM=
X-Google-Smtp-Source: ABdhPJxpufm0xwgWWlUjpgvrLpGzsY1kH8FlxXcHIfelWMcr2AQpGPiqb4Q2yNGoshJ/zYmcLaJhnQ==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr7697242wrq.408.1599062646271; 
 Wed, 02 Sep 2020 09:04:06 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l19sm212183wmi.8.2020.09.02.09.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 09:04:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpus: Do not dump CPU state when calling hw_error()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
 <20200901112323.94969-2-f4bug@amsat.org>
 <cae3f7a9-eef7-3efa-5968-7bf2de0d2b22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <44d5ac42-16ff-db20-2e64-259f5cc39ccc@amsat.org>
Date: Wed, 2 Sep 2020 18:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cae3f7a9-eef7-3efa-5968-7bf2de0d2b22@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 8:33 AM, Thomas Huth wrote:
> On 01/09/2020 13.23, Philippe Mathieu-Daudé wrote:
>> We already have cpu_abort() to dump CPU states and abort.
>>
>> Restrict hw_error() to peripheral errors, hoping we can completely
>> remove it by proper functions from "error-report.h" in the future.
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
> 
> IIRC I rather suggested to rename the function to "cpu_hw_error" and
> only use it for real CPU problems...
> But I think your approach here is fine as well. Please replace the
> "Suggested-by" with "Reviewed-by" now :-)
> 
>  Thomas
> 
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  softmmu/cpus.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>> index a802e899abb..c96a04d7f18 100644
>> --- a/softmmu/cpus.c
>> +++ b/softmmu/cpus.c
>> @@ -913,16 +913,11 @@ static void stop_tcg_kick_timer(void)
>>  void hw_error(const char *fmt, ...)
>>  {
>>      va_list ap;
>> -    CPUState *cpu;
>>  
>>      va_start(ap, fmt);
>>      fprintf(stderr, "qemu: hardware error: ");
>>      vfprintf(stderr, fmt, ap);
>>      fprintf(stderr, "\n");
>> -    CPU_FOREACH(cpu) {
>> -        fprintf(stderr, "CPU #%d:\n", cpu->cpu_index);
>> -        cpu_dump_state(cpu, stderr, CPU_DUMP_FPU);
>> -    }
> 
> You could argue that cpu_abort() only prints the state of one CPU and
> not of all. But I doubt that dumping the state of *all* CPUs is really
> helpful in any of the contexts where hw_error() is used. So I think it's
> fine to remove this CPU_FOREACH loop here.

I find this not very practical when using more than 8 vCPUs.
Personally I stopped looking at this output because it is too noisy.

Are there developers interested in having cpu_abort() dumping all
vCPU registers? I can move that there. Or the interested ones can
also do it later if they find it useful :)

> 
>>      va_end(ap);
>>      abort();
>>  }
>>
> 
> 

