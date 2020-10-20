Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FDFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CD52222F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRC66Jx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CD52222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUn7I-0004Wk-Om
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUn4K-0001G3-Fx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:32:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUn4I-0008W3-Rd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:32:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so1032557wrp.10
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ibEjVVPi+FirD8gYLhJISOpQaB7YuMMV0RIjTpvwP8A=;
 b=pRC66Jx+fK5dnYL7pcPros/4tKyTUpwbN6CquNwzxvUeIDwxRnsn+Id7nBgZln9PIn
 kaSW0aLGFRE6zbFAQuHLFNfTnQ4DePJYk2kBnA6W1FsTDX4YilmqzLf3LR6vw18k95Uc
 Orq0Pu3CifS/398JdBehI4nCaxJ0tUYuQ6ZffFHXmyjDFiP5WPGANJl6ZfJs3Hc6CE+l
 QASmJftQQfoH3OD/s1C2oCu1oLY5S1vkSKObr/KbIvUldZ9PTXcXFKaQr2EkRArc1pgq
 vsGKbrvGb4QlwMv8j3T4pme2I7lVsxdkoQA/R9/MypK9LSjAGQARN6J5IXX8RZZM6NjE
 lBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ibEjVVPi+FirD8gYLhJISOpQaB7YuMMV0RIjTpvwP8A=;
 b=E4tWap6dbnPKZs+d7nnN08/JjDS8UrJT2UKSIc5SmrOxU9qFkIuaC9rvwU9y1B4x4E
 zQQGU5g/3ZmY4LsRPJ9lwL4C2W5N16MjMsS+S+DOSLyxI7wjZWTPF2777UNh99ZohKyJ
 W0XBVoDr+AVKUQlD+RE8NI8szPHvyvLZuoC3vlDeKhFTzgQijw75Dwbo8KT0vkeGRje9
 RIbN2rdDdsfMtIOp3n47l3IaUPjmvhkPDeJJeTcPgCH7sF8+UCDlQsbN3B+BedYAJc1C
 fEVcVEDIXb1Q1w8aq47Pk9AS1LDEo71OY6hrvwqzWwxli7jfzIYEOJhjgXk+Rw3pyRF2
 amBg==
X-Gm-Message-State: AOAM533COl+YDh9SXfGXogDpse7UmLWkrIw2tNf1y8SywSO0DP2zDeNi
 KXKSkcaUmsPtuK8lsw1Oidg=
X-Google-Smtp-Source: ABdhPJwa6Khib653apYddM03Q8z+5r4CmBkky9ZVqdwzvnw7U1/YVxrYpWUxVo1oiXftXSnd088ydA==
X-Received: by 2002:adf:b641:: with SMTP id i1mr2062882wre.376.1603182748433; 
 Tue, 20 Oct 2020 01:32:28 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id g125sm1588293wme.33.2020.10.20.01.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:32:27 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev-clock: add a reference on aliased clocks
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20201020074426.105878-1-luc@lmichel.fr>
 <32eb21b8-e63d-87bb-6d94-95d888ec9a3b@amsat.org>
Message-ID: <9841f5ed-2731-0ae9-7871-cb32efc12a68@amsat.org>
Date: Tue, 20 Oct 2020 10:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <32eb21b8-e63d-87bb-6d94-95d888ec9a3b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 9:58 AM, Philippe Mathieu-Daudé wrote:
> Cc'ing Markus/Marc-André too.
> 
> On 10/20/20 9:44 AM, Luc Michel wrote:
>> When aliasing a clock with the qdev_alias_clock() function, a new link
>> property is created on the device aliasing the clock. The link points
>> to the aliased clock and use the OBJ_PROP_LINK_STRONG flag. This
>> property is read only since it does not provide a check callback for
>> modifications.
>>
>> The object_property_add_link() documentation stats that with
>> OBJ_PROP_LINK_STRONG properties, the linked object reference count get
>> decremented when the property is deleted. But it is _not_ incremented on
>> creation (object_property_add_link() does not actually know the link).
>>
>> This commit increments the reference count on the aliased clock to
>> ensure the aliased clock stays alive during the property lifetime, and
>> to avoid a double-free memory error when the property get deleted.
>>
>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>> ---
>>   hw/core/qdev-clock.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
>> index 6a9a340d0f..5f5e143702 100644
>> --- a/hw/core/qdev-clock.c
>> +++ b/hw/core/qdev-clock.c
>> @@ -59,10 +59,11 @@ static NamedClockList 
>> *qdev_init_clocklist(DeviceState *dev, const char *name,
>>       } else {
>>           object_property_add_link(OBJECT(dev), name,
>>                                    object_get_typename(OBJECT(clk)),
>>                                    (Object **) &ncl->clock,
>>                                    NULL, OBJ_PROP_LINK_STRONG);
>> +        object_ref(OBJECT(clk));

OK, this is particular to this model because device_finalize()
garbage-collector and calls qdev_finalize_clocklist().

With a comment explaining why we need this call:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>       }
>>       ncl->clock = clk;
>>       QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
>>
> 

