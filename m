Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0875CC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CAD2223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN/hZtkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CAD2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpnw-0004DD-EM
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpnM-0003fz-0z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpnJ-0001ZK-OJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603193228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LP5PNTd9mm9d+qqKCCt6fyeiLsJDCPQtN+P5klOE2As=;
 b=AN/hZtkGCzfYDjjY+gWRs8iCpc1M7Rvh/pJKaycjddXj5pTZJqvEENN+Ra/gI8ESDPx+Rd
 gmO2cT8966atRWRqGeM+aytJVTCk90S7QHJ31+RVAd/5ZYUEJApQCWD6wo+BxI7wkWFEJd
 +Obs50JFaLN0RJSWcaMwIvTjNi54beo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-0fWsSxRXN3uD6WbqHxtpuA-1; Tue, 20 Oct 2020 07:27:06 -0400
X-MC-Unique: 0fWsSxRXN3uD6WbqHxtpuA-1
Received: by mail-wr1-f72.google.com with SMTP id x16so687983wrg.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LP5PNTd9mm9d+qqKCCt6fyeiLsJDCPQtN+P5klOE2As=;
 b=lpjJGbanT9rzPuJzTFtI/8IzQxDAiUnsmjGH5htksoVQVBRX4fCHc1hSXBXpxa2TtC
 5QxSo46mex/rR08Q5s8otIVM5r40U4goLknXDK3vXlnZ18Ap9xAJ7CZo1G05vHFAUh34
 GDeOvpFXrBWSGzM3ubQsJMeGfXhSef0dsUV4Mvhrs/p8edl5fZLuan0Ylunh44M2Z/qp
 kJbRgnYPvir+ff3UTr6v1xCSLrtoeyiY2chTGBZ4AKwZe0nrOxyk5zVf8bRHKsjNuGgx
 KvQJfKkP8kzzCRrZWgDQXHDhMfFcE+YIYFfF0wMqNN8eC39xJc+7P8SKr84WaLRMZfkC
 Qygw==
X-Gm-Message-State: AOAM530oKPhZrvvTUoEzJ792uw4q4o8DI+bFhE+T+S1hfuI0ddpLdGiS
 SuPnfXEeApS0GzqUs7D3mC/xcQ+oGZ90TsCmprc4fVTL4uQ1GIMjCOXSz/JvbOFlMt6eFKlepyK
 PO8HCcBRslYV0IWM=
X-Received: by 2002:adf:94e3:: with SMTP id 90mr2769049wrr.380.1603193225487; 
 Tue, 20 Oct 2020 04:27:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx68UJxv10RdP0ZOwuylAshiNsDasTG9394Y7eM/v7+lCS+ZIVFeFUaQ9eKZx3SJd1oLknlaw==
X-Received: by 2002:adf:94e3:: with SMTP id 90mr2769014wrr.380.1603193225144; 
 Tue, 20 Oct 2020 04:27:05 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id w1sm2558382wrp.95.2020.10.20.04.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 04:27:04 -0700 (PDT)
Subject: Re: [PATCH] microbit_i2c: Fix coredump when dump-vmstate
To: Peng Liang <liangpeng10@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201019093401.2993833-1-liangpeng10@huawei.com>
 <786deb83-b6f4-d778-d5ed-19f3901ad211@redhat.com>
 <0c174303-50bc-128a-26ab-c062f98cd6cd@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d45ce658-f628-ae9d-1db2-68a14d815333@redhat.com>
Date: Tue, 20 Oct 2020 13:27:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <0c174303-50bc-128a-26ab-c062f98cd6cd@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, xiexiangyou@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 1:17 PM, Peng Liang wrote:
> On 10/19/2020 6:35 PM, Philippe Mathieu-Daudé wrote:
>> On 10/19/20 11:34 AM, Peng Liang wrote:
>>> VMStateDescription.fields should be end with VMSTATE_END_OF_LIST().
>>> However, microbit_i2c_vmstate doesn't follow it.  Let's change it.
>>
>> It might be easy to add a Coccinelle script to avoid future errors.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
> 
> I tried to add a Coccinelle script to add VMSTATE_END_OF_LIST() to the
> end of VMStateDescription.fields.  For those who are not defined as
> compound literals, it works well.  However, I cannot make it work for
> those defined as compound literals.  And Julia doesn't think compound
> literals are supported currently[1].  So maybe currently it's hard to
> check the error using Coccinelle :(

Interesting.

> 
> Thanks for my colleague Biaoxiang Ye, who wrote a shell script to find
> the errors, I didn't find other similar errors.

Thanks for giving it a try. We could commit and run the script
in a gitlab-ci job to avoid such regressions.

> 
> [1]
> https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2010201143330.2736@hadrien/T/#t
> 
> Thanks,
> Peng
> 
>>>
>>> Fixes: 9d68bf564e ("arm: Stub out NRF51 TWI magnetometer/accelerometer
>>> detection")
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
>>> ---
>>>    hw/i2c/microbit_i2c.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
>>> index 802473982082..e92f9f84ea81 100644
>>> --- a/hw/i2c/microbit_i2c.c
>>> +++ b/hw/i2c/microbit_i2c.c
>>> @@ -83,6 +83,7 @@ static const VMStateDescription microbit_i2c_vmstate
>>> = {
>>>        .fields = (VMStateField[]) {
>>>            VMSTATE_UINT32_ARRAY(regs, MicrobitI2CState,
>>> MICROBIT_I2C_NREGS),
>>>            VMSTATE_UINT32(read_idx, MicrobitI2CState),
>>> +        VMSTATE_END_OF_LIST()
>>>        },
>>>    };
>>>   
>>
>>
>> .
> 


