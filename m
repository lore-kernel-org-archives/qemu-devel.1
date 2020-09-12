Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA5C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4576320731
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbOESNxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4576320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGz3j-00085q-5j
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 02:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGz1v-00076h-Ae
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGz1s-0004ki-LM
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599892134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVdtENz48/YR2yY0tFtha0Dp8M1kEziomsL89XYH/oY=;
 b=dbOESNxwKUYE6pBsavuI/zVH8bnrTM0cJoKD6bRXwlvuMl9lXQFhkyq5olI2muqmdv2Zqq
 KdUgKXKO6VgXgRrSP1CXp05C7lhK/Axuim8/jsl8dYfPpHZ5yNJvp19SpiToKaC8+3bJrc
 Hxnu3sOxaRr9rhhriSgOqY9mdjMiFec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-tmHYC558PbmpowmaOzGZ4w-1; Sat, 12 Sep 2020 02:28:50 -0400
X-MC-Unique: tmHYC558PbmpowmaOzGZ4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BF8081F006;
 Sat, 12 Sep 2020 06:28:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF79E60BEC;
 Sat, 12 Sep 2020 06:28:39 +0000 (UTC)
Subject: Re: [PATCH v5 3/8] s390/sclp: read sccb from mem based on provided
 length
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-4-walling@linux.ibm.com>
 <02dabe89-8df2-90d4-c7f1-5ef951942639@redhat.com>
 <811e906a-689e-a53c-706e-5d6217ef3cb2@linux.ibm.com>
 <2b7a8807-279f-1256-e89b-0f53ae6d5623@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d7989721-f9cb-6f77-6d52-08ce69c6dda5@redhat.com>
Date: Sat, 12 Sep 2020 08:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2b7a8807-279f-1256-e89b-0f53ae6d5623@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:04:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/2020 20.16, Collin Walling wrote:
> On 9/10/20 1:56 PM, Collin Walling wrote:
>> On 9/10/20 1:50 PM, Thomas Huth wrote:
>>> On 10/09/2020 11.36, Collin Walling wrote:
>>>> The header contained within the SCCB passed to the SCLP service call
>>>> contains the actual length of the SCCB. Instead of allocating a static
>>>> 4K size for the work sccb, let's allow for a variable size determined
>>>> by the value in the header. The proper checks are already in place to
>>>> ensure the SCCB length is sufficent to store a full response and that
>>>> the length does not cross any explicitly-set boundaries.
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>  hw/s390x/event-facility.c |  2 +-
>>>>  hw/s390x/sclp.c           | 58 ++++++++++++++++++++++-----------------
>>>>  include/hw/s390x/sclp.h   |  2 +-
>>>>  3 files changed, 35 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>>> index 645b4080c5..ed92ce510d 100644
>>>> --- a/hw/s390x/event-facility.c
>>>> +++ b/hw/s390x/event-facility.c
>>>> @@ -213,7 +213,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
>>>>  
>>>>      event_buf = &red->ebh;
>>>>      event_buf->length = 0;
>>>> -    slen = sizeof(sccb->data);
>>>> +    slen = sccb_data_len(sccb);
>>>>  
>>>>      rc = SCLP_RC_NO_EVENT_BUFFERS_STORED;
>>>>  
>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>> index 69a8724dc7..cb8e2e8ec3 100644
>>>> --- a/hw/s390x/sclp.c
>>>> +++ b/hw/s390x/sclp.c
>>>> @@ -231,25 +231,30 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>>>  {
>>>>      SCLPDevice *sclp = get_sclp_device();
>>>>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>>>> -    SCCB work_sccb;
>>>> -    hwaddr sccb_len = sizeof(SCCB);
>>>> +    SCCBHeader header;
>>>> +    SCCB *work_sccb;
>>>
>>> I'd maybe use "g_autofree SCCB *work_sccb = NULL" so you don't have to
>>> worry about doing the g_free() later.
>>
>> Can do.
>>
>>>
>>>> -    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
>>>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
>>>> +
>>>> +    work_sccb = g_malloc0(header.length);
>>>
>>> Please use be16_to_cpu(header.length) here as well.
>>
>> Good catch, thanks!
>>
> 
> Shouldn't the mallocs use cpu_to_be16 instead since the header length
> was read in from a cpu?

Now you confuse me ... s390x is big endian, so to get a usable value, we
have to convert big-endian to the host byte order, not the other way
round, don't we?

 Thomas


