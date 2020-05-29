Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC0B2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7ad+0Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC0B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZYa-0002k6-VI
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZXr-00028K-9J
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:35:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZXq-000804-BY
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590737709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKVlpny19OjSJHh6zUBMxLIPSFNQM4m2iwVdpolAVuA=;
 b=X7ad+0MlC5z2YZBDQDz7WjZv+IGmlu4x4rkQ6GFjymmrw7mbj9+/EV0W87POZkrruQIwQF
 Lsyw/LR2eARZnTQ3gn3pt+hM2S3axQPfwvilKU30KBB4L2oGrjf1xvgp35sNPQHEZD9pxB
 U2xLaVC+uVqMd2aobgFLw5QFzGuAFhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29--iD-rhBZMD2_lCruCWnpQA-1; Fri, 29 May 2020 03:35:07 -0400
X-MC-Unique: -iD-rhBZMD2_lCruCWnpQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AD34460;
 Fri, 29 May 2020 07:35:06 +0000 (UTC)
Received: from [10.72.13.231] (ovpn-13-231.pek2.redhat.com [10.72.13.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EECB02B6F5;
 Fri, 29 May 2020 07:35:04 +0000 (UTC)
Subject: Re: [PATCH 1/1] e1000e: Added ICR clearing by corresponding IMS bit.
From: Jason Wang <jasowang@redhat.com>
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200513113125.1465650-1-andrew@daynix.com>
 <20200513113125.1465650-2-andrew@daynix.com>
 <57ab1532-c3a6-e631-5b0e-e89fc4d82873@redhat.com>
Message-ID: <7d8202a5-58ad-d7e9-db29-3316834547b8@redhat.com>
Date: Fri, 29 May 2020 15:35:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <57ab1532-c3a6-e631-5b0e-e89fc4d82873@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/29 下午3:18, Jason Wang wrote:
>
> On 2020/5/13 下午7:31, andrew@daynix.com wrote:
>> From: Andrew Melnychenko <andrew@daynix.com>
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
>> Added ICR clearing if there is IMS bit - according to the note by
>> section 13.3.27 of the 8257X developers manual.
>>
>> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>> ---
>>   hw/net/e1000e_core.c | 10 ++++++++++
>>   hw/net/trace-events  |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index d5676871fa..10212d7932 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -2624,6 +2624,16 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
>>           e1000e_clear_ims_bits(core, core->mac[IAM]);
>>       }
>>   +    /*
>> +     * PCIe* GbE Controllers Open Source Software Developer's Manual
>> +     * 13.3.27 Interrupt Cause Read Register
>> +     */
>> +    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
>> +        (core->mac[ICR] & core->mac[IMS])) {
>> + trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR], 
>> core->mac[IMS]);
>> +        core->mac[ICR] = 0;
>> +    }
>> +
>
>
> Hi Andrew:
>
> So my comments still. I think we need to implement 82574l behavior (if 
> you go through e1000e.c all chapters it mentioned is for 82574l 
> datasheet not the one you pointed to me).
>
> And actually the 82574l behavior is much more simpler.


To be more specific.

See chapter 7.4.5 which describes the ICR clearing.

It has three methods for clearing: auto-clear, clear-on-write and 
clear-on-read.

And in the part of "Read to clear" it said:

"""
All bits in the ICR register are cleared on a read to ICR.

"""

So there's no need to IMS and other stuffs here.

Thanks


>
> Thanks


