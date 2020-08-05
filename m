Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3BDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD176206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQSw6sNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD176206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3KJV-0005Ji-7A
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 10:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3KI7-0004Pk-Eh
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:21:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3KI5-0000Cy-Pq
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:21:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so6517126wmi.5
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UmjUG2U6bJo4d8tcUQzqD20uir6V+QHyCKcOYjQhhho=;
 b=cQSw6sNwq9xzU5A4EXktaGcXg49lXdADd0dHqN8b/dTqTy1b8N0wHMbbS9771mAasL
 ayGd4Wthr98Dk7YMZICjC+z+2cN+EFwPfRfyi1s04zzEDCR9NFJnsWJpmw/ow4k9ve0j
 kpCDNAQtCRonwlGBIjiwXXrJMT8V/FiV/IKxOK8FzlM+i2dBuZtx4WbTYrtKBeYo54DY
 e7wCw72OUIwgaAeLlMAmF5L3pJmqpWyVSqE2CSz6yPHFr7HrcxDxAUt9MPcJ4LmB3Mbj
 SZcxrMphVJ5789Xno8SzimPaaZwAhTSbw+dCMvFW4CnTA5JdP58j8N/xDl0NEVz2vVJb
 58Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UmjUG2U6bJo4d8tcUQzqD20uir6V+QHyCKcOYjQhhho=;
 b=GbS08KzFk1aTzI3ePMQ1fybTbZpUMbKYkrhNA5KI16ewRHiRXE6PDQ/u2ohoOTR4wU
 Cw/LsHOUf7c32E+RCUfO19Q/8ydHJRb0U9H0xkyJOhpwh7eFQOQh7q698e0XTejnenv5
 bUlwKP1RIFoucpwghBRZgkmCvZiA9oV5Zm7sMg1rBY4yyuGBWmE0r7yBuP30YnZnhZHs
 YuemrRb8L5ivmPPkutPlM1tzL0PHzM4aHHf0X3nTmNP61itatauGAdJ6vTJnDfCyNhOa
 KMxtVb4EqtajkHZPg74oaFy8TnXvW+ANoGmccbrt7kWRlaNGyccHAItMpy1IxbLN6e4c
 QwAA==
X-Gm-Message-State: AOAM531golX1w7oCsPsHe3n6woMOFk/icCAwhX8c/nR2+w9NA4zh99or
 Xvqo0cckiNDSpjyBuTGEZbg=
X-Google-Smtp-Source: ABdhPJwMwdwZKEkT3z0uidkTgkD+GEpbU16zzf72fFyxocfz9HGcYsYiiy49dPztzWL15E60CQ2CRQ==
X-Received: by 2002:a05:600c:290a:: with SMTP id
 i10mr3731739wmd.175.1596637272158; 
 Wed, 05 Aug 2020 07:21:12 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id a11sm3373572wrq.0.2020.08.05.07.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 07:21:11 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] memory: Display bigger regions first in 'info
 mtree' output
To: Peter Xu <peterx@redhat.com>
References: <20200727174543.4219-1-f4bug@amsat.org>
 <20200727180931.GA89946@xz-x1.hitronhub.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48c43451-9c89-2706-8d56-91c60e6eaa77@amsat.org>
Date: Wed, 5 Aug 2020 16:21:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200727180931.GA89946@xz-x1.hitronhub.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/27/20 8:09 PM, Peter Xu wrote:
> On Mon, Jul 27, 2020 at 07:45:43PM +0200, Philippe Mathieu-Daudé wrote:
>> When different regions have the same address, we currently
>> sort them by the priority. Also sort them by the region
>> size.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  softmmu/memory.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index af25987518..c28dcaf4d6 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -2960,7 +2960,8 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>>          QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>>              if (new_ml->mr->addr < ml->mr->addr ||
>>                  (new_ml->mr->addr == ml->mr->addr &&
>> -                 new_ml->mr->priority > ml->mr->priority)) {
>> +                 (MR_SIZE(new_ml->mr->size) > MR_SIZE(ml->mr->size) ||
>> +                  new_ml->mr->priority > ml->mr->priority))) {
>>                  QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>>                  new_ml = NULL;
>>                  break;
> 
> Note that this change could make the outcome unpredictable... Assuming two
> memory regions:
> 
>   mr1: addr=0, size=0x1000, pri=2
>   mr2: addr=0, size=0x2000, pri=1
> 
> Then assuming submr_print_queue only contains these two mrs.  Then when
> submr_print_queue has mr1 at head, then when we insert mr2 we'll think it
> should be inserted before mr1 (because mr2's size bigger), so the result will be:
> 
>   mr2:...
>   mr1:...
> 
> If submr_print_queue has mr2 at head, then when we insert mr1 we'll think it
> should be inserted before mr2 (because mr1's priority higher).  We'll instead
> get:
> 
>   mr1:...
>   mr2:...
> 
> Phil, could I ask what's the case to be fixed?

What I want is sort regions of same priority by bigger size first,
the smaller size last (as a leaf of the tree, the leaf is the MR
that handles the memory access).

Maybe this patch is not complete. I'll follow Peter Maydell suggestion
to split the compare() function out to make it more readable.
This qtailq is only used for the monitor 'mtree' command, right?
I understand the flatview uses something else.

Regards,

Phil.

