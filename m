Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0221C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AC52187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrfXNirm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AC52187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2XfK-0006ah-Su
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 04:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1j2Xef-0005pE-5p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1j2Xed-0002S7-UQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:53:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1j2Xed-0002Qd-Pl
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581673979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtYh2eubS/WqhSyA6bT0OfoBAOKouSgEVvVK7WxmNwY=;
 b=CrfXNirmt41g2w9u9VU2FCPj2/G/dUnxfoVy+PEswqMedtBnbHsvLb+ANfQp4IePtHhjeL
 M4ittc8W8N+uCQ3zDIXAuDiUKW0WhFF1LnHO7SrxrpLkU/QftRQmKAW6F6Lhy6vz2aFW6D
 ioCM1vF+8YeZ66CgWig6GkpxRjd4x+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-SEhiHXEtM6SlLs6KLGajBg-1; Fri, 14 Feb 2020 04:52:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A460D8010E3;
 Fri, 14 Feb 2020 09:52:56 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27AFA5C1C3;
 Fri, 14 Feb 2020 09:52:52 +0000 (UTC)
Subject: Re: [PATCH] Report stringified errno in VFIO related errors
To: Cornelia Huck <cohuck@redhat.com>
References: <2dc5a0962a38b912e4fa4900f9813b7ea1a9273c.1581670009.git.mprivozn@redhat.com>
 <20200214104740.07f59c72.cohuck@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <a1f18897-264b-1ccd-f64a-bab40c9e1653@redhat.com>
Date: Fri, 14 Feb 2020 10:52:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214104740.07f59c72.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: SEhiHXEtM6SlLs6KLGajBg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 10:47 AM, Cornelia Huck wrote:
> On Fri, 14 Feb 2020 09:47:39 +0100
> Michal Privoznik <mprivozn@redhat.com> wrote:
> 
>> In a few places we report errno formatted as a negative integer.
>> This is not as user friendly as it can be. Use strerror() and/or
>> error_setg_errno() instead.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>   hw/vfio/common.c    | 2 +-
>>   util/vfio-helpers.c | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 5ca11488d6..a3a2a82d99 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -352,7 +352,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>>           return 0;
>>       }
>>   
>> -    error_report("VFIO_MAP_DMA: %d", -errno);
>> +    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
>>       return -errno;
>>   }
> 
> I think you missed the one in vfio_dma_unmap().
> 

Indeed, will send v2.

Michal


