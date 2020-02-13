Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A1AC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B72821734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO9TiYDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B72821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j25W9-0003n0-Dg
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j25VT-0003HC-Sl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j25VS-0006fD-MZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:49:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j25VS-0006dI-JT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581565778;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47Mm1myGpPPW+ruwkT/I7EdLKcI7mHHjG7F+OyG5zcY=;
 b=bO9TiYDtoHhRFTF9wGzBjtFaqL/j1niz+K5yrO6hAZMlG+sefQPf+EBI400TLdVWdD/gdE
 P4cp3N+5TtS/Or3YoHe5vRrBR25YdgsD6MRHn0wgR5MLo4qChviHBkPurJChQ5XGRVsipo
 x81WiSRQ2ObXMcDDLrHWjWLTRGlIPxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-lpd9mqrfPjGyNrAGruFQdA-1; Wed, 12 Feb 2020 22:49:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BD8613E4;
 Thu, 13 Feb 2020 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-95.bne.redhat.com [10.64.54.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E7B060499;
 Thu, 13 Feb 2020 03:49:24 +0000 (UTC)
Subject: Re: [RESEND RFC PATCH v2 1/2] target/arm: Allow to inject SError
 interrupt
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200205110541.37811-2-gshan@redhat.com>
 <8dce7dbe-c6c1-122a-f960-0fc29257dd1c@redhat.com>
 <CAFEAcA-RiVfrFFkxppB=z8x76rjorF-5onyGwVAdsHY7W1U88g@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <21e4051a-4d06-03cb-6d8e-5331b5b570c4@redhat.com>
Date: Thu, 13 Feb 2020 14:49:21 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RiVfrFFkxppB=z8x76rjorF-5onyGwVAdsHY7W1U88g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: lpd9mqrfPjGyNrAGruFQdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 10:34 PM, Peter Maydell wrote:
> On Wed, 12 Feb 2020 at 06:39, Gavin Shan <gshan@redhat.com> wrote:
>> On 2/5/20 10:05 PM, Gavin Shan wrote:
>>> This allows to inject SError interrupt, which will be used on receiving
>>> QMP/HMP "nmi" command in next patch.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>    target/arm/cpu.c    | 11 +++++++++++
>>>    target/arm/cpu.h    | 12 +++++++++---
>>>    target/arm/helper.c |  4 ++++
>>>    3 files changed, 24 insertions(+), 3 deletions(-)
>>>
>>
>> Hi Peter, could you please take a look when you get a chance? I'm not sure
>> the implementation is good enough to inject SError. If there are somebody
>> else who can help to review, please let me know so that I can copy her/him
>> either.
> 
> Yeah, this is on my list to look at; Richard Henderson also could
> have a look at it. From a quick scan I suspect you may be missing
> handling for AArch32.
> 

[Thanks for copying Richard Henderson]

Yes, the functionality is only supported on aarch64 currently by intention
because the next patch enables it on "max" and "host" CPU models and both
of them are running in aarch64 mode.

https://patchwork.kernel.org/patch/11366119/

If you really want to get this supported for aarch32 either, I can do
it. However, it seems there is a long list of aarch32 CPU models, defined
in target/arm/cpu.c::arm_cpus. so which CPU models you prefer to see with
this supported? I think we might choose one or two popular CPU models if
you agree.

Thanks,
Gavin


