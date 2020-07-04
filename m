Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDEF2184D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhgX0yFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDEF2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpvn-00045S-ET
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpnQ-0007fa-4p
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:34:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpnM-0004SD-Nn
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vRgqPnxmiOGvvAu7uYqs3vwf19JrTVnHtpmg1acFEdI=;
 b=KhgX0yFnIRXZ4rZLkaNJ59/N0kif48OvR+jIHuJnzj+7gDxaMJNI8STN+VzmEjvJzVrzMi
 HQdjAHVahB53H4a7oaf2T1NNwoTjnIOCVRBk+HFNcRTSPiuTUrgKjyps3UpTRmTOJ9cyUR
 p7oszp4dfi94K+fscBCTlWhJBMADS4g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-RbR96ScIOeiwBOnz7m3GMw-1; Sat, 04 Jul 2020 17:33:56 -0400
X-MC-Unique: RbR96ScIOeiwBOnz7m3GMw-1
Received: by mail-wr1-f69.google.com with SMTP id y16so36837489wrr.20
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vRgqPnxmiOGvvAu7uYqs3vwf19JrTVnHtpmg1acFEdI=;
 b=IkywkvNhudWU4tC1L+n1Tyx7ON5qdbuFAJnJOeyyrKPPzKI81BU2Qyd6Pe8xL+f7cU
 vbegrnkCVZKcL57l6vZuoqRAlFh5Wqpi1udK6zyzFmkN9FTshAQLKFKJxLVpcs9DAx0u
 4uWBseZ5R8iatx5hfD2dswhgXJFiPVqKdR3+AT3cGVP+L1tUnkayY8Ftb0p5UVMvGuMd
 aR8NWm8cLaI/orRtDUZ16UwkqAevGYZ+RgCmJnnoye7RM8niAvDZg/frfBjN/xRaGA6o
 NLjoXIYTUxKt3z7NEegzcdN7uTibgoIRKIFYU3GuHoPX6T58T5788tV/zABYE4Hp5fsb
 IsVw==
X-Gm-Message-State: AOAM5325T9juXognuueOKfM6DjRW9xLUee+ZgKGYZ51oviltpUHe/rf+
 wbF6fpmOpzu9dbqFBQwvocQgOjhazOal4S3L1mo7n846M+gja26BuECBBFHttrS3lqMRnSbsrvc
 UZOIQ4tYG4Xge46Y=
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr41679276wrq.250.1593898435349; 
 Sat, 04 Jul 2020 14:33:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiF7nDECa8+M8gmc8y2IoaVqgEd4fQu2xaHaR9uLa3+dIXYdTkZQxVbPNPOFfbMMVjAeRSvA==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr41679261wrq.250.1593898435164; 
 Sat, 04 Jul 2020 14:33:55 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v12sm5612089wrt.31.2020.07.04.14.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 14:33:54 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] hw/block/nvme: add remaining mandatory
 controller parameters
To: Klaus Jensen <its@irrelevant.dk>
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-12-its@irrelevant.dk>
 <e2cbec3f-896e-fa17-2aac-2c82e0d6df60@redhat.com>
 <20200703084626.xib465ie3vvladip@apples.localdomain>
 <05eda6c8-b6fc-b034-a76d-dc563427ed35@redhat.com>
 <20200703101003.iirx66jjnauvk7a3@apples.localdomain>
 <5e623e78-29b0-50c7-28d2-78ae2dfb9ece@redhat.com>
 <20200703143749.dgk45bmvl6ir7oyg@apples.localdomain>
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
Message-ID: <227e7666-123c-7bb1-329e-aab0d70400de@redhat.com>
Date: Sat, 4 Jul 2020 23:33:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703143749.dgk45bmvl6ir7oyg@apples.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:04
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

On 7/3/20 4:37 PM, Klaus Jensen wrote:
> On Jul  3 13:02, Philippe Mathieu-Daudé wrote:
>> On 7/3/20 12:10 PM, Klaus Jensen wrote:
>>> On Jul  3 11:21, Philippe Mathieu-Daudé wrote:
>>>> On 7/3/20 10:46 AM, Klaus Jensen wrote:
>>>>> On Jul  3 10:31, Philippe Mathieu-Daudé wrote:
>>>>>> On 7/3/20 8:34 AM, Klaus Jensen wrote:
>>>>>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>>>>>
>>>>>>> Add support for any remaining mandatory controller operating parameters
>>>>>>> (features).
>>>>>>>
>>>>>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>>>>>> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
>>>>>>> ---
>>>>>>>  hw/block/nvme.c       | 39 +++++++++++++++++++++++++++++++++------
>>>>>>>  hw/block/nvme.h       | 18 ++++++++++++++++++
>>>>>>>  hw/block/trace-events |  2 ++
>>>>>>>  include/block/nvme.h  |  7 +++++++
>>>>>>>  4 files changed, 60 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>>>>>>> index ba523f6768bf..affb9a967534 100644
>>>>>>> --- a/hw/block/nvme.c
>>>>>>> +++ b/hw/block/nvme.c
>>>>>>> @@ -1056,8 +1056,16 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>>>>>>>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>>>>>>>      uint32_t result;
>>>>>>> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
>>>>>>> +    uint16_t iv;
>>>>>>>  
>>>>>>> -    switch (dw10) {
>>>>>>> +    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
>>>>>>> +
>>>>>>> +    if (!nvme_feature_support[fid]) {
>>>>>>> +        return NVME_INVALID_FIELD | NVME_DNR;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    switch (fid) {
>>>>>>>      case NVME_TEMPERATURE_THRESHOLD:
>>>>>>>          result = 0;
>>>>>>>  
>>>>>>> @@ -1088,14 +1096,27 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>>>                               ((n->params.max_ioqpairs - 1) << 16));
>>>>>>>          trace_pci_nvme_getfeat_numq(result);
>>>>>>>          break;
>>>>>>> +    case NVME_INTERRUPT_VECTOR_CONF:
>>>>>>> +        iv = dw11 & 0xffff;
>>>>>>> +        if (iv >= n->params.max_ioqpairs + 1) {
>>>>>>> +            return NVME_INVALID_FIELD | NVME_DNR;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        result = iv;
>>>>>>> +        if (iv == n->admin_cq.vector) {
>>>>>>> +            result |= NVME_INTVC_NOCOALESCING;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        result = cpu_to_le32(result);
>>>>>>> +        break;
>>>>>>>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>>>>>>>          result = cpu_to_le32(n->features.async_config);
>>>>>>>          break;
>>>>>>>      case NVME_TIMESTAMP:
>>>>>>>          return nvme_get_feature_timestamp(n, cmd);
>>>>>>>      default:
>>>>>>> -        trace_pci_nvme_err_invalid_getfeat(dw10);
>>>>>>> -        return NVME_INVALID_FIELD | NVME_DNR;
>>>>>>> +        result = cpu_to_le32(nvme_feature_default[fid]);
>>>>>>
>>>>>> So here we expect uninitialized fid entries to return 0, right?
>>>>>>
>>>>>
>>>>> Yes, if defaults are not 0 (like NVME_ARBITRATION), it is explicitly set.
>>>>>
>>>>>>> +        break;
>>>>>>>      }
>>>>>>>  
>>>>>>>      req->cqe.result = result;
>>>>>>> @@ -1124,8 +1145,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>>>  {
>>>>>>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>>>>>>>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>>>>>>> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
>>>>>>>  
>>>>>>> -    switch (dw10) {
>>>>>>> +    trace_pci_nvme_setfeat(nvme_cid(req), fid, dw11);
>>>>>>> +
>>>>>>> +    if (!nvme_feature_support[fid]) {
>>>>>>> +        return NVME_INVALID_FIELD | NVME_DNR;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    switch (fid) {
>>>>>>>      case NVME_TEMPERATURE_THRESHOLD:
>>>>>>>          if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
>>>>>>>              break;
>>>>>>> @@ -1172,8 +1200,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>>>>>>>      case NVME_TIMESTAMP:
>>>>>>>          return nvme_set_feature_timestamp(n, cmd);
>>>>>>>      default:
>>>>>>> -        trace_pci_nvme_err_invalid_setfeat(dw10);
>>>>>>> -        return NVME_INVALID_FIELD | NVME_DNR;
>>>>>>> +        return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
>>>>>>>      }
>>>>>>>      return NVME_SUCCESS;
>>>>>>>  }
>>>>>>> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
>>>>>>> index f8940435f9ef..8ad1e3c89cee 100644
>>>>>>> --- a/hw/block/nvme.h
>>>>>>> +++ b/hw/block/nvme.h
>>>>>>> @@ -87,6 +87,24 @@ typedef struct NvmeFeatureVal {
>>>>>>>      uint32_t    async_config;
>>>>>>>  } NvmeFeatureVal;
>>>>
>>>> What do you think about adding:
>>>>
>>>> --- a/include/block/nvme.h
>>>> +++ b/include/block/nvme.h
>>>> @@ -804,7 +804,8 @@ enum NvmeFeatureIds {
>>>>      NVME_WRITE_ATOMICITY            = 0xa,
>>>>      NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
>>>>      NVME_TIMESTAMP                  = 0xe,
>>>> -    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
>>>> +    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
>>>> +    NVME_FEATURE_ID_COUNT           = 0x100
>>>>  };
>>>>
>>>
>>> I can definitely go with that. I added it as NVME_FID_MAX.
>>
>> Good name.
>>
>>>
>>>>>>>  
>>>>>>> +static const uint32_t nvme_feature_default[0x100] = {
>>>>
>>>> Why uint32_t and not uint16_t?
>>>>
>>>
>>> The feature values are by definition 32 bits wide, so even though the
>>> defaults here do not require it, I think uin32_t should be used.
>>
>> Can you prepend a new patch making nvme_get_feature() return uin32_t
>> instead of uint16_t? That would be clearer.
>>
> 
> Ah. Now I see where the confusion comes from ;)
> 
> nvme_get_feature() does not return the value of the feature. It returns
> a uint16_t with a value from the NvmeStatusCodes enum (which really
> should be a typedef used all over the place.

Ah! You are right, I misread it indeed :)


