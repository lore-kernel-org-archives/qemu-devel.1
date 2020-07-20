Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3124120684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7Ea2DAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3124120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxS6K-0002jO-FJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxS5d-0002B8-HM
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:28:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27122
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxS5b-0002fu-1H
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595237281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyw1x2awEfAoxLL/ZtYXL9am0uEB+u+N63WU1r6fGZI=;
 b=S7Ea2DAx9GeSkbnzFWtK9irINvmV4IvyrnUe2uxrEQiqD5vV7qfoO1xXdRsf1Wfk6kwVEk
 Uw75AQm4hjPOQWuVQjFZdEC8+cyirDqJdOZ5iLkvgd8Ok3GgffwmoV0bza9S6AFS1P0Lvj
 oRGU3ok0bizG1ZuZp2O/N++eHhna/QM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-mIIMRVWqPCOTtXRTcqvpfg-1; Mon, 20 Jul 2020 05:27:59 -0400
X-MC-Unique: mIIMRVWqPCOTtXRTcqvpfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022BF18A1DF3;
 Mon, 20 Jul 2020 09:27:58 +0000 (UTC)
Received: from [10.72.12.53] (ovpn-12-53.pek2.redhat.com [10.72.12.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC1DD78530;
 Mon, 20 Jul 2020 09:27:49 +0000 (UTC)
Subject: Re: [PATCH] hw/net/xgmac: Fix buffer overflow in xgmac_enet_send()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200710091940.641296-1-mcascell@redhat.com>
 <CAFEAcA9XQUcdiy2x18Zr+EYDaJ4hY-1Bd-DgL6-j6sJi5Ow+Gg@mail.gmail.com>
 <df0eae88-2bc8-04fa-feb9-7633ba13d635@redhat.com>
 <CAFEAcA_2zG1E1COPTi78DY2V2-e8sJwc-s0c7cCfm12U2DE00Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <727aefd4-8881-4ea5-811a-6d7cd20f4b2c@redhat.com>
Date: Mon, 20 Jul 2020 17:27:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2zG1E1COPTi78DY2V2-e8sJwc-s0c7cCfm12U2DE00Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 21:45:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Rob Herring <robh@kernel.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/20 下午5:14, Peter Maydell wrote:
> On Tue, 14 Jul 2020 at 10:09, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2020/7/10 下午7:07, Peter Maydell wrote:
>>> On Fri, 10 Jul 2020 at 10:20, Mauro Matteo Cascella <mcascell@redhat.com> wrote:
>>>> A buffer overflow issue was reported by Mr. Ziming Zhang, CC'd here. It
>>>> occurs while sending an Ethernet frame due to missing break statements
>>>> and improper checking of the buffer size.
>>>>
>>>> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
>>>> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
>>>> ---
>>>>    hw/net/xgmac.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
>>>> index 574dd47b41..b872afbb1a 100644
>>>> --- a/hw/net/xgmac.c
>>>> +++ b/hw/net/xgmac.c
>>>> @@ -224,17 +224,20 @@ static void xgmac_enet_send(XgmacState *s)
>>>>                DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
>>>>                            "xgmac buffer 1 len on send > 2048 (0x%x)\n",
>>>>                             __func__, bd.buffer1_size & 0xfff);
>>>> +            break;
>>>>            }
>>>>            if ((bd.buffer2_size & 0xfff) != 0) {
>>>>                DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
>>>>                            "xgmac buffer 2 len on send != 0 (0x%x)\n",
>>>>                            __func__, bd.buffer2_size & 0xfff);
>>>> +            break;
>>>>            }
>>>> -        if (len >= sizeof(frame)) {
>>>> +        if (frame_size + len >= sizeof(frame)) {
>>>>                DEBUGF_BRK("qemu:%s: buffer overflow %d read into %zu "
>>>> -                        "buffer\n" , __func__, len, sizeof(frame));
>>>> +                        "buffer\n" , __func__, frame_size + len, sizeof(frame));
>>>>                DEBUGF_BRK("qemu:%s: buffer1.size=%d; buffer2.size=%d\n",
>>>>                            __func__, bd.buffer1_size, bd.buffer2_size);
>>>> +            break;
>>>>            }
>>>>
>>>>            cpu_physical_memory_read(bd.buffer1_addr, ptr, len);
>>> This is correct in the sense that it avoids the buffer overflow.
>>>
>>> I suspect that we should probably also be reporting the error
>>> back to the guest via some kind of error flag in the descriptor
>>> and/or in a status register. Unfortunately I don't have a copy
>>> of the datasheet and it doesn't seem to be available online :-(
>>> Does anybody have a copy to check ?
>> I tried to download the datasheet from [1] but it's not a programmer
>> manual.
>>
>> I think we can apply this patch first and do follow-up fixes on top?
> Yes, agreed, since nobody seems to have docs for this device.
> This is an only-happens-with-malicious-or-buggy-guest case anyway,
> and the highbank/midway (only users of the device) aren't important
> or widely used machine types any more.
>
> I suppose we could add a comment
> /*
>   * FIXME: these cases of malformed tx descriptors (bad sizes)
>   * should probably be reported back to the guest somehow
>   * rather than simply silently stopping processing, but we
>   * don't know what the hardware does in this situation.
>   * This will only happen for buggy guests anyway.
>   */
>
> but anyway
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Were you planning to take this patch, Jason, or should I?


I've queued for rc1 this with the above suggested comment.

Thanks


>
> thanks
> -- PMM
>


