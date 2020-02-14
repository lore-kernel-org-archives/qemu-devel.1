Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9402C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95ECB2187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXVEF8Gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95ECB2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2UOk-0003iU-Sz
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j2UNu-0002z4-5F
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j2UNs-0001pH-8w
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:23:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51125
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j2UNs-0001oc-4p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581661407;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/cEIzy2lLCmEJumUIZaTRQAhf9WUeC8c9gRGqdTpm0=;
 b=BXVEF8GmIrCnsy9wU4P6tB9z5NXhGYSY7h3NspUsrhQdL2gpWkfhLfJLjv0uSVmMUKFnw1
 McvklBu0UTtBgjFvh+QfsVQwNzxXIXfW0G8wKcHs6tCtr2JfpEivzBF0E1sKEtiBB4y8D2
 xwOlybed0pV76zustvXqz89Hi9oZ4GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-X1loO7BlPD2DXX2iKh1ogQ-1; Fri, 14 Feb 2020 01:23:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1716189F760;
 Fri, 14 Feb 2020 06:23:24 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-93.bne.redhat.com [10.64.54.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBCE0384;
 Fri, 14 Feb 2020 06:23:18 +0000 (UTC)
Subject: Re: [RESEND RFC PATCH v2 2/2] target/arm: Support NMI injection
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200205110541.37811-3-gshan@redhat.com>
 <CAFEAcA8LJf3rQhi1VyBqSrC9Rj_ZKiYeVMJ8Gb-U7HA4LVagLA@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <9342b389-331d-353b-f6f2-c6a676e0ea32@redhat.com>
Date: Fri, 14 Feb 2020 17:23:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8LJf3rQhi1VyBqSrC9Rj_ZKiYeVMJ8Gb-U7HA4LVagLA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: X1loO7BlPD2DXX2iKh1ogQ-1
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 10:11 PM, Peter Maydell wrote:
> On Wed, 5 Feb 2020 at 11:06, Gavin Shan <gshan@redhat.com> wrote:
>>
>> This supports QMP/HMP "nmi" command by injecting SError interrupt to
>> guest, which is expected to crash with that. Currently, It's supported
>> on two CPU models: "host" and "max".
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/arm/virt.c          | 18 ++++++++++++++++
>>   target/arm/cpu-qom.h   |  1 +
>>   target/arm/cpu.c       | 48 ++++++++++++++++++++++++++++++++++++++++++
>>   target/arm/cpu64.c     | 25 ++++++++++++++++++----
>>   target/arm/internals.h |  8 +++++++
>>   5 files changed, 96 insertions(+), 4 deletions(-)
> 
> A few quick general notes:
> 
> (1) as I mentioned on the cover letter, the mechanism
> for injecting an SError/async external abort into the
> CPU should be a qemu_irq line, like FIQ/IRQ, not a
> special-purpose method on the CPU object.
> 
> (2) for function naming, there's a dividing line between:
>   * code that implements the (unfortunately x86-centric)
>     monitor command named "nmi"; these functions can have
>     names with 'nmi' in them
>   * code which implements the actual mechanism of 'deliver
>     an SError to the CPU'; these functions should not
>     have 'nmi' in the name or mention nmi, because nmi is
>     not a concept in the Arm architecture
> 
> (3) Before we expose 'nmi' to users as something that
> delivers an SError, we need to think about the interactions
> with RAS, because currently we also use SError to say
> "there was an error in the host memory you're using",
> and we might in future want to use SError for proper
> emulated RAS. We don't want to paint ourselves into a
> corner by grabbing SError exclusively for 'nmi'.
> 

Hi Peter, Thanks for the nice details. I just posted v3 to address
(1) and (2).

For (3), I'm not sure. It seems we need some registers to record the
details on why the SError is raised. For ARMv8 with RAS extension is
supported, VSESR_EL2 can be used. Otherwise, we probably need some
space in ESR_EL1. For aarch32, DFSR might be the alternative. With
more details about the cause, the "NMI" and other errors can be
classified.

May I ask if the SError is going to be triggered by simulated device
or real one, or both in future? If it's corresponding to host memory
error, it seems it should be triggered by a real hardware. In this case,
the error should be intercepted and then delivered to guest. I need
more details how the SError will be used for RAS.

Thanks,
Gavin


