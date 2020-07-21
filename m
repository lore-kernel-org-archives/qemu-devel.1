Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB78C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A3C20720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glXhSuxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A3C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxvHa-0001tD-Av
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxvGq-0001HK-NM
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:37:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxvGo-0000KJ-BZ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595349453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIR4CbSK82CzCUBKxZ5hEDMIxILQxXQSqvgRCuvn1u8=;
 b=glXhSuxJJETf4Mf+o8O90F3dxWPiX6WmLB1oMnZ6Xj6qV0OKW0bZD2xr5EQCZIIrj2cXB1
 zFpMnWa1Q9rt81RN/iInVsfcL3+3gltuw2TuPCbRXYqqzJh/JpSAEFTuxJgM/5lnTlgbUa
 clmYNA7eWs7fNVsmyqxR0aIKcupXWq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-D5Ke43ZEPcOAwXgMtn8DLQ-1; Tue, 21 Jul 2020 12:37:29 -0400
X-MC-Unique: D5Ke43ZEPcOAwXgMtn8DLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 938FC91299;
 Tue, 21 Jul 2020 16:37:28 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9E5E7268E;
 Tue, 21 Jul 2020 16:37:24 +0000 (UTC)
Subject: Re: [RFC PATCH-for-5.1] hw/ide: Do not block for AIO while resetting
 a drive
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200717171938.1249-1-f4bug@amsat.org>
 <20200720100246.GA24159@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <e853fb33-8b6a-1e36-e028-1efc51b01616@redhat.com>
Date: Tue, 21 Jul 2020 12:37:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720100246.GA24159@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:58:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 6:02 AM, Stefan Hajnoczi wrote:
> On Fri, Jul 17, 2020 at 07:19:38PM +0200, Philippe Mathieu-Daudé wrote:
>> Last minute chat:
>> 19:01 <stefanha> f4bug: use bdrv_aio_cancel_async() if possible because it won't block the current thread.
>> 19:02 <stefanha> f4bug: For example, in device emulation code where the guest has requested to cancel an I/O request it's often possible to use the async version.
>> 19:02 <stefanha> f4bug: But in synchronous code like device reset it may be necessary to use the synchronous (blocking) bdrv_aio_cancel() API instead. :(
>> 19:14 <stefanha> f4bug: The way to decide is: will the current function return to the event loop and is there someone who will handle the request completion callback when cancel finishes?
>> 19:14 <stefanha> f4bug: If the next line of code requires the request to finished then async cancel cannot be used.
>> 19:15 <stefanha> f4bug: On the other hand, if the function can return and it's okay for the request to cancel at some future time then you can use async.
>>
>> So I'll revisit this patch :)
>> ---
>>   hw/ide/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index d997a78e47..e3a9ce7d25 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -1315,7 +1315,8 @@ static void ide_reset(IDEState *s)
>>       trace_ide_reset(s);
>>   
>>       if (s->pio_aiocb) {
>> -        blk_aio_cancel(s->pio_aiocb);
>> +        /* If there is a pending AIO callback, invoke it now. */
>> +        blk_aio_cancel_async(s->pio_aiocb);
> 
> This is a place where an async call is not allowed. The completion
> function must be called right away (synchronously) before we can
> continue resetting the device.
> 
> I sent a patch that allows bdrv_aio_cancel() to find the AioContext so
> it can call aio_poll().
> 
> Stefan
> 

OK, dropping Phil's patch here.

--js


