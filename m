Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02315C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE99E2178F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpfSjYM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE99E2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJij-0001Hu-Ul
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaJaK-0006ey-UQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaJaI-0005bM-VN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:11:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaJaI-0005W3-Ni
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574946709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFHTNKWgTCo2jx97fwvF/7FG6b+SSf+FA0BOhmn0F4k=;
 b=NpfSjYM7w0xqtDISe7e/if3TpkLvKCz4FNCNEM1yVoHpFHMyjsp5U302JbKbqJFOdahKgt
 Gu19KC1LyPWmqAYcPMJbtlBreHPnk/ofGZGrgbXtgvemySTvBDeECdLC3mQ3d7PrDFx/BK
 Y6JpvIiQ9RrtAJAjmvmD2QqZWTXbLpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-1shXcq67PqeVYIKs_72I_w-1; Thu, 28 Nov 2019 08:11:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1740D1800D52;
 Thu, 28 Nov 2019 13:11:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58C325C1B0;
 Thu, 28 Nov 2019 13:11:40 +0000 (UTC)
Subject: Re: [PATCH v1 1/1] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org
References: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
 <52e295af-3b34-6cb7-ba52-a26ae70aebcd@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5f3f505a-7bcd-d8ee-a4df-c9bf658955af@redhat.com>
Date: Thu, 28 Nov 2019 14:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <52e295af-3b34-6cb7-ba52-a26ae70aebcd@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1shXcq67PqeVYIKs_72I_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, frankja@linux.ibm.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/2019 13.35, Christian Borntraeger wrote:
> Ack.
> 
> Conny, I think this would be really nice to have for 4.2 (together with a bios rebuild)
> as this fixes a regression. Opinions?

If we do another rc of 4.2, I think we definitely want this to be 
included, otherwise quite a bunch of things don't work anymore as 
expected, e.g. "-boot menu=on"...

>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index c0223fa..7251f9a 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -112,7 +112,7 @@ void sclp_get_loadparm_ascii(char *loadparm)
>>       ReadInfo *sccb = (void *)_sccb;
>>   
>>       memset((char *)_sccb, 0, sizeof(ReadInfo));
>> -    sccb->h.length = sizeof(ReadInfo);
>> +    sccb->h.length = SCCB_SIZE;
>>       if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
>>           ebcdic_to_ascii((char *) sccb->loadparm, loadparm, LOADPARM_LEN);
>>       }

I gave it a quick try, and this fixes "-boot menu=on" for me, so:

Tested-by: Thomas Huth <thuth@redhat.com>


