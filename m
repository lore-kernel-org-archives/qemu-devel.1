Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9684C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8338F217D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="AORW9fsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8338F217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkDS-0005xe-CG
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 06:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibk7M-0002IW-1l
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibk7K-0008PV-Tv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:43:51 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:51292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ibk7I-0008NT-6Z; Mon, 02 Dec 2019 06:43:48 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id D5CAE96EF0;
 Mon,  2 Dec 2019 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575287022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU90s+NFHEXRn3VjyWITYrFg1NmjzzO7O71eODyuVMw=;
 b=AORW9fsFHNcLSiYHSAhDg3ykTt5o54RrTE6pWtKyaypd3oq4V5oT5DIEl4vYjc2RuyZbZY
 XIgQbyII3NsrhXsE0qf8WqoXzatgs+vLjGJKRlXkAi37RzLoeuqNdW9KcI0tJF25CckRVT
 t8vO/x57xHA7nnpS/oVmcc3lk9cooyo=
Subject: Re: [PATCH v5 05/13] hw/core/resettable: add support for changing
 parent
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-6-damien.hedde@greensocs.com>
 <CAFEAcA-UV7rSL1mPD=NLyLtan60WNsc+MDjR6p2aDoz34bq8dg@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <02003f2e-38f5-2ff3-8160-e0bf6063839a@greensocs.com>
Date: Mon, 2 Dec 2019 12:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UV7rSL1mPD=NLyLtan60WNsc+MDjR6p2aDoz34bq8dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575287022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU90s+NFHEXRn3VjyWITYrFg1NmjzzO7O71eODyuVMw=;
 b=Did3pQhHLza7i5pYC+rI0Gx3bb7g9TeE+DDv4mBgTLcnCNsmEn5+f4uBWFml/P9HGpNiCT
 12yMnL64LF0KDsVTOJX8loR3CrRjDwgERvarrnY97se+o+qsLf7OIJRjiI/xda8cjnlaUP
 VTWrQt1+zOJ7+WngsrqRI/f2Vs+5rMQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575287022; a=rsa-sha256; cv=none;
 b=P1O+eFriWFeGMbriDgzgaJYoTf0hrJebLLcJjOhGZZTXZOpMX7kE/qMCaMlilA5RXj4gXW
 Qq2hHaWUcIHFF4rskJ6U8Fywa5ISsYUgtxsrhLc/rFUK9RuIM/wJ3xWK61/rcseXlAXXLQ
 Cov7dmMkGJfdBcuw3pGWkja6jZgWEOA=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/29/19 7:38 PM, Peter Maydell wrote:
> On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Add a function resettable_change_parent() to do the required
>> plumbing when changing the parent a of Resettable object.
>>
>> We need to make sure that the reset state of the object remains
>> coherent with the reset state of the new parent.
>>
>> We make the 2 following hypothesis:
>> + when an object is put in a parent under reset, the object goes in
>> reset.
>> + when an object is removed from a parent under reset, the object
>> leaves reset.
>>
>> The added function avoid any glitch if both old and new parent are
>> already in reset.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  hw/core/resettable.c    | 54 +++++++++++++++++++++++++++++++++++++++++
>>  hw/core/trace-events    |  1 +
>>  include/hw/resettable.h | 16 ++++++++++++
>>  3 files changed, 71 insertions(+)
>>
>> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
>> index c5e11cff4f..60d4285fcc 100644
>> --- a/hw/core/resettable.c
>> +++ b/hw/core/resettable.c
>> @@ -32,6 +32,14 @@ static void resettable_phase_exit(Object *obj, void *opaque, ResetType type);
>>   */
>>  static bool enter_phase_in_progress;
>>
>> +/**
>> + * exit_phase_in_progress:
>> + * Flag telling whether we are currently in an enter phase where side
>> + * effects are forbidden. This flag allows us to catch if
>> + * resettable_change_parent() is called during exit phase.
>> + */
>> +static unsigned exit_phase_in_progress;
> 
> This is another global that I don't think we should have.
> Is it also just for asserts ?

Yes. It's only to ensure we don't miss-use the api.

--
Damien



