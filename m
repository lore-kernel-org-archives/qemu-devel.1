Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8587ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC5A20854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC5A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4fn-0003DC-RG
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iL4f4-0002Xq-Eh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iL4f1-00042F-T4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:13:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iL4f1-00041G-NP; Thu, 17 Oct 2019 08:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A06A618CB903;
 Thu, 17 Oct 2019 12:13:42 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A85D60BE1;
 Thu, 17 Oct 2019 12:13:41 +0000 (UTC)
Subject: Re: [PULL 19/31] target/s390x: Return exception from
 mmu_translate_real
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191010113356.5017-1-david@redhat.com>
 <20191010113356.5017-20-david@redhat.com>
 <CAFEAcA-Z94EAN_dt06nH97SbyMc3Jg6uj_xn-zTTMjUrvNrUDw@mail.gmail.com>
 <CAFEAcA-KkMgfEPiZeoaGZaNozRzQeOtVhBidOqSm+cu6zD6d0A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0bf06f79-3555-dfe8-10f6-0ecaaf532f1f@redhat.com>
Date: Thu, 17 Oct 2019 14:13:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KkMgfEPiZeoaGZaNozRzQeOtVhBidOqSm+cu6zD6d0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 17 Oct 2019 12:13:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.10.19 14:05, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 12:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 10 Oct 2019 at 12:35, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> Do not raise the exception directly within mmu_translate_real,
>>> but pass it back so that caller may do so.
>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-Id: <20191001171614.8405-8-richard.henderson@linaro.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> Hi; Coverity complains about dead code in this patch
> 
> Forgot to mention the issue number, which is CID 1406404.
> 
> thanks
> -- PMM
> 

Will have a look thanks!

-- 

Thanks,

David / dhildenb

