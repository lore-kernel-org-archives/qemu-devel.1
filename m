Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98C720936
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XezVaV2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98C720936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJTQ-0001EA-RD
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 07:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrJSn-0000gp-MQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:02:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrJSm-0001XS-1T
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593774155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hKE7GQwYZOMKsVW7OQeccfcyZdU/pmiicXUb0/ew9cA=;
 b=XezVaV2E3hXUMtBEgQMrI9Vybt96s3p5SI10s9FgxRx/eRMoP7HroNY+SjVZgi+NuK5DdV
 w3yAHUjx4HWdJ3/zMcU5EY9lDzkhsbE+r/SutdDlfQmS3ywKpxdCnOY7Hzci/TLACsBdow
 ryL6K+uxZmX/BcJA22XxUq4CfQckTyk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-iA9dTKFkMTqaYW11yxpNqA-1; Fri, 03 Jul 2020 07:02:31 -0400
X-MC-Unique: iA9dTKFkMTqaYW11yxpNqA-1
Received: by mail-wm1-f70.google.com with SMTP id s134so34676798wme.6
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 04:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hKE7GQwYZOMKsVW7OQeccfcyZdU/pmiicXUb0/ew9cA=;
 b=XouasmxYVzBO7NBHWZnRX52jm/5An1cbwEtXzVP0sh5s958iAjd4/YFYwmzks7nPBC
 76zUmzYsdIRQKXW2Z8MVGITuBbjIOJhMrdo3I3jlvinALUxiZXhZuHo5AIi+cn5k9QD7
 XBlKI9j8x8ILkDChe/v/sVqvFnxDKIPDtLE5lulLF+C6gYusc58GkLJKyhgVNSCwYiBh
 DuqA1unm86QCQaXny9n08221xbZlXwSqInGaX6DWlvymXfmDNf1dDsU/KgYb7twLyGgx
 pVKs5vCO0ac/kSveHlZAC7Le2ngIjMZMeENeBnLNvqzSTnTfVNPrEwZfzQgziAtBj0k9
 wC7g==
X-Gm-Message-State: AOAM532apA2enZ/VBxvZH06G1e6gTBskrZsmC2MOr4B1uWMzfW0wThvB
 yo32cHgWPHaNVA9OpEfe//dCbUpztY5OLIhV8i72jycRCyIg4JRM2ImbqGjYm8RyBJ3wFgSJBzP
 esVy4T38RVx3bcQw=
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr36409489wrm.121.1593774150148; 
 Fri, 03 Jul 2020 04:02:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+hlQIn6vE+9c3cXCBdSUCFue4kgC83vxVeq3IEKLjEis93EygviiPXvHolzb3xe6HfW0Ymw==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr36409472wrm.121.1593774149949; 
 Fri, 03 Jul 2020 04:02:29 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w2sm14037670wrs.77.2020.07.03.04.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 04:02:29 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] hw/block/nvme: add remaining mandatory
 controller parameters
To: Klaus Jensen <its@irrelevant.dk>
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-12-its@irrelevant.dk>
 <e2cbec3f-896e-fa17-2aac-2c82e0d6df60@redhat.com>
 <20200703084626.xib465ie3vvladip@apples.localdomain>
 <05eda6c8-b6fc-b034-a76d-dc563427ed35@redhat.com>
 <20200703101003.iirx66jjnauvk7a3@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <5e623e78-29b0-50c7-28d2-78ae2dfb9ece@redhat.com>
Date: Fri, 3 Jul 2020 13:02:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703101003.iirx66jjnauvk7a3@apples.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 12:10 PM, Klaus Jensen wrote:
> On Jul  3 11:21, Philippe Mathieu-Daudé wrote:
>> On 7/3/20 10:46 AM, Klaus Jensen wrote:
>>> On Jul  3 10:31, Philippe Mathieu-Daudé wrote:
>>>> On 7/3/20 8:34 AM, Klaus Jensen wrote:
>>>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>>>
>>>>> Add support for any remaining mandatory controller operating parameters
>>>>> (features).
>>>>>
>>>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>>>> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
>>>>> ---
>>>>>  hw/block/nvme.c       | 39 +++++++++++++++++++++++++++++++++------
>>>>>  hw/block/nvme.h       | 18 ++++++++++++++++++
>>>>>  hw/block/trace-events |  2 ++
>>>>>  include/block/nvme.h  |  7 +++++++
>>>>>  4 files changed, 60 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>>>>> index ba523f6768bf..affb9a967534 100644
>>>>> --- a/hw/block/nvme.c
>>>>> +++ b/hw/block/nvme.c
>>>>> @@ -1056,8 +1056,16 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>>>>>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>>>>>      uint32_t result;
>>>>> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
>>>>> +    uint16_t iv;
>>>>>  
>>>>> -    switch (dw10) {
>>>>> +    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
>>>>> +
>>>>> +    if (!nvme_feature_support[fid]) {
>>>>> +        return NVME_INVALID_FIELD | NVME_DNR;
>>>>> +    }
>>>>> +
>>>>> +    switch (fid) {
>>>>>      case NVME_TEMPERATURE_THRESHOLD:
>>>>>          result = 0;
>>>>>  
>>>>> @@ -1088,14 +1096,27 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>                               ((n->params.max_ioqpairs - 1) << 16));
>>>>>          trace_pci_nvme_getfeat_numq(result);
>>>>>          break;
>>>>> +    case NVME_INTERRUPT_VECTOR_CONF:
>>>>> +        iv = dw11 & 0xffff;
>>>>> +        if (iv >= n->params.max_ioqpairs + 1) {
>>>>> +            return NVME_INVALID_FIELD | NVME_DNR;
>>>>> +        }
>>>>> +
>>>>> +        result = iv;
>>>>> +        if (iv == n->admin_cq.vector) {
>>>>> +            result |= NVME_INTVC_NOCOALESCING;
>>>>> +        }
>>>>> +
>>>>> +        result = cpu_to_le32(result);
>>>>> +        break;
>>>>>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>>>>>          result = cpu_to_le32(n->features.async_config);
>>>>>          break;
>>>>>      case NVME_TIMESTAMP:
>>>>>          return nvme_get_feature_timestamp(n, cmd);
>>>>>      default:
>>>>> -        trace_pci_nvme_err_invalid_getfeat(dw10);
>>>>> -        return NVME_INVALID_FIELD | NVME_DNR;
>>>>> +        result = cpu_to_le32(nvme_feature_default[fid]);
>>>>
>>>> So here we expect uninitialized fid entries to return 0, right?
>>>>
>>>
>>> Yes, if defaults are not 0 (like NVME_ARBITRATION), it is explicitly set.
>>>
>>>>> +        break;
>>>>>      }
>>>>>  
>>>>>      req->cqe.result = result;
>>>>> @@ -1124,8 +1145,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>  {
>>>>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>>>>>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>>>>> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
>>>>>  
>>>>> -    switch (dw10) {
>>>>> +    trace_pci_nvme_setfeat(nvme_cid(req), fid, dw11);
>>>>> +
>>>>> +    if (!nvme_feature_support[fid]) {
>>>>> +        return NVME_INVALID_FIELD | NVME_DNR;
>>>>> +    }
>>>>> +
>>>>> +    switch (fid) {
>>>>>      case NVME_TEMPERATURE_THRESHOLD:
>>>>>          if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
>>>>>              break;
>>>>> @@ -1172,8 +1200,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>      case NVME_TIMESTAMP:
>>>>>          return nvme_set_feature_timestamp(n, cmd);
>>>>>      default:
>>>>> -        trace_pci_nvme_err_invalid_setfeat(dw10);
>>>>> -        return NVME_INVALID_FIELD | NVME_DNR;
>>>>> +        return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
>>>>>      }
>>>>>      return NVME_SUCCESS;
>>>>>  }
>>>>> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
>>>>> index f8940435f9ef..8ad1e3c89cee 100644
>>>>> --- a/hw/block/nvme.h
>>>>> +++ b/hw/block/nvme.h
>>>>> @@ -87,6 +87,24 @@ typedef struct NvmeFeatureVal {
>>>>>      uint32_t    async_config;
>>>>>  } NvmeFeatureVal;
>>
>> What do you think about adding:
>>
>> --- a/include/block/nvme.h
>> +++ b/include/block/nvme.h
>> @@ -804,7 +804,8 @@ enum NvmeFeatureIds {
>>      NVME_WRITE_ATOMICITY            = 0xa,
>>      NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
>>      NVME_TIMESTAMP                  = 0xe,
>> -    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
>> +    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
>> +    NVME_FEATURE_ID_COUNT           = 0x100
>>  };
>>
> 
> I can definitely go with that. I added it as NVME_FID_MAX.

Good name.

> 
>>>>>  
>>>>> +static const uint32_t nvme_feature_default[0x100] = {
>>
>> Why uint32_t and not uint16_t?
>>
> 
> The feature values are by definition 32 bits wide, so even though the
> defaults here do not require it, I think uin32_t should be used.

Can you prepend a new patch making nvme_get_feature() return uin32_t
instead of uint16_t? That would be clearer.

> 
>> With the previously suggested enum you can now replace 0x100
>> by NVME_FEATURE_ID_COUNT.
>>
>>>>> +    [NVME_ARBITRATION]           = NVME_ARB_AB_NOLIMIT,
>>>>> +};
>>>>> +
>>>>> +static const bool nvme_feature_support[0x100] = {
>>
>> Ditto NVME_FEATURE_ID_COUNT.
>>
> 
> Fixed!
> 


