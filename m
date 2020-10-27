Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F3720829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4W1ff1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F3720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLEi-0006zH-H8
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXLDj-00064g-32
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXLDg-0004pb-SV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603790682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okdOaljvxcml9JLqRisZVg7xhV5MVr/LP0+LFRRmECo=;
 b=T4W1ff1i+W+XnZxTzbLNy6AQuUZ8myg2IELVzKwxBLv+miEUT3/Mr5qsiRA+TbiV3yOSX8
 vT1rouIgpvjpR48oBLnI0uTtsk8x3QyVsrmyvTjPSHoVuefJOx4ZvikO110BQuhOysmlOD
 +mfqNWn+lzzCWpIq0SxqJVj9sJunv5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-VBbznfeGOJix91Qeiuw_Sw-1; Tue, 27 Oct 2020 05:24:39 -0400
X-MC-Unique: VBbznfeGOJix91Qeiuw_Sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B17D1804B6D;
 Tue, 27 Oct 2020 09:24:37 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E70E555773;
 Tue, 27 Oct 2020 09:24:36 +0000 (UTC)
Subject: Re: [PATCH] arm/trace: Fix hex printing
To: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
References: <20201014193355.53074-1-dgilbert@redhat.com>
 <CAFEAcA8CYt-rkovgj_5kMtygsPNm3C4F6yi4s3cb0bduz7+NaA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <04136efa-9229-6c7e-d43e-0033a354c2d4@redhat.com>
Date: Tue, 27 Oct 2020 10:24:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8CYt-rkovgj_5kMtygsPNm3C4F6yi4s3cb0bduz7+NaA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/19/20 9:26 PM, Peter Maydell wrote:
> On Wed, 14 Oct 2020 at 20:36, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
>>
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Use of 0x%d - make up our mind as 0x%x
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  hw/arm/trace-events | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index c8a4d80f6b..a335ee891d 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -41,7 +41,7 @@ smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
>>  smmuv3_decode_cd(uint32_t oas) "oas=%d"
>>  smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
>>  smmuv3_cmdq_cfgi_ste(int streamid) "streamid =%d"
>> -smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
>> +smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
> 
> Ah, I missed that you'd sent this patch before.
> 
> Eric, do we want to use hex here, or should we go for
> decimal the way we do with (almost) all the other
> tracing of stream IDs (eg mmuv3_cmdq_cfgi_ste in the line before)?
> 
> The other odd-one-out is smmuv3_find_ste which prints a hex
> SID; I think the other tracing of SIDs is always decimal.
I think my preference would be to use hexa here and in the other places.

Thanks

Eric
> 
> thanks
> -- PMM
> 


