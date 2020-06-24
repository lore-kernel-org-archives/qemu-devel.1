Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3467BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D0C20723
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djyfAGD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D0C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7En-0005jq-60
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo7CE-0002kU-HZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:20:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo7CC-0004Ub-VN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593012016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGZsSWXffSiJb1p0nir2LQXN9NW5yQD066+LJdbMnbw=;
 b=djyfAGD9qp2SOCvF8UW/eaZaMBlzkznvc7+rebvOcPDJ9VC85ICCfEr71RsjQA7r66edty
 zSaClc2jgb6/2M7u+tMeWBIsOVKdGmfgqrnVEWufyiURipqPXGiAvNDhLcipwjashXKRHN
 U9N1uCik/unWlQWz1bTEzQXjsA5f8MM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-1mYLA-kbMn20laGQKPd3Dw-1; Wed, 24 Jun 2020 11:20:12 -0400
X-MC-Unique: 1mYLA-kbMn20laGQKPd3Dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C89D3107AFD1;
 Wed, 24 Jun 2020 15:20:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-35.ams2.redhat.com [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8300060F8A;
 Wed, 24 Jun 2020 15:20:00 +0000 (UTC)
Subject: Re: [PATCH v3 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-7-walling@linux.ibm.com>
 <20200624143635.2d87c1ca.cohuck@redhat.com>
 <d627e738-7414-4c7f-52ce-4972dfc30544@redhat.com>
 <20200624145500.69f9ab24.cohuck@redhat.com>
 <7ad94e6b-7e5e-04f6-109a-990075a1d8c2@linux.ibm.com>
 <20200624165730.358a883f.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d662d49-2a31-b010-db3a-6d06aa843dfd@redhat.com>
Date: Wed, 24 Jun 2020 17:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624165730.358a883f.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: frankja@linux.ibm.com, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 16.57, Cornelia Huck wrote:
> On Wed, 24 Jun 2020 10:49:57 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 6/24/20 8:55 AM, Cornelia Huck wrote:
>>> On Wed, 24 Jun 2020 14:40:58 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>    
>>>> On 24/06/2020 14.36, Cornelia Huck wrote:
>>>>> On Thu, 18 Jun 2020 18:22:56 -0400
>>>>> Collin Walling <walling@linux.ibm.com> wrote:
[...]
>>>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>>>> index 0dfbe6e5ec..f7c49e339e 100644
>>>>>> --- a/hw/s390x/sclp.c
>>>>>> +++ b/hw/s390x/sclp.c
>>>>>> @@ -56,6 +56,18 @@ static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
>>>>>>        uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
>>>>>>    
>>>>>>        switch (code & SCLP_CMD_CODE_MASK) {
>>>>>> +    case SCLP_CMDW_READ_SCP_INFO:
>>>>>> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
>>>>>> +    case SCLP_CMDW_READ_CPU_INFO:
>>>>>> +        /*
>>>>>> +         * An extended-length SCCB is only allowed for Read SCP/CPU Info and
>>>>>> +         * is allowed to exceed the 4k boundary. The respective commands will
>>>>>> +         * set the length field to the required length if an insufficient
>>>>>> +         * SCCB length is provided.
>>>>>> +         */
>>>>>> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>>>>>> +            return true;
>>>>>> +        }
>>>>>
>>>>> Add a fallthrough annotation?
>>>>
>>>> ... otherwise Coverity and friends will complain later.
>>>
>>> Nod.
>>>    
>>
>> Something simple like...
>>
>> /* without this feature, these commands must respect the 4k boundary */
>>
>> ?
> 
> No, I meant something that is parsed by static checkers (/* fallthrough */
> seems to be the common marker for that in QEMU). I think what the
> fallthrough does is already clear enough to humans.

See also the "-Wimplicit-fallthrough" compiler option ... which we do 
not have enabled for QEMU yet, but maybe will be enabled one day. It can 
e.g. check for "/* fallthrough */" comments.

  Thomas


