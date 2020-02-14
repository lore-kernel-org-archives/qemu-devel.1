Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F5C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 02:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE4C217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 02:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws8B7oOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE4C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2QgD-0005E1-Sf
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 21:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j2Qfc-0004gk-FQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 21:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j2Qfa-0000qW-Og
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 21:25:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j2Qfa-0000oC-Fr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 21:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581647129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lrAOZ9XjD+N2YIRPqwm0lN9LlzDnvRAI1rMkp2cWqc=;
 b=Ws8B7oOeF2HSUzSoIw5CW3lZcz3Ge+sbBZccwPQbJYGONKKItMSJjoCGzp0Y7BA1wBrxx7
 QFNn6P56NOVfWvZTYwn+QjgEyK3PwCR2y0tjxqFmZZPA1py6iB2SXXXQs+2bgYoHLsSuJ9
 bMig0nj+GiC7nM6tVrxb6pOr02Agd4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-guSVQx0fN4SJRXBvGUTGJw-1; Thu, 13 Feb 2020 21:25:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3726800D41;
 Fri, 14 Feb 2020 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-88.bne.redhat.com [10.64.54.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D98719C70;
 Fri, 14 Feb 2020 02:25:16 +0000 (UTC)
Subject: Re: [RESEND RFC PATCH v2 1/2] target/arm: Allow to inject SError
 interrupt
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200205110541.37811-2-gshan@redhat.com>
 <8dce7dbe-c6c1-122a-f960-0fc29257dd1c@redhat.com>
 <CAFEAcA-RiVfrFFkxppB=z8x76rjorF-5onyGwVAdsHY7W1U88g@mail.gmail.com>
 <21e4051a-4d06-03cb-6d8e-5331b5b570c4@redhat.com>
 <CAFEAcA_zyMgG5SQpVCwUTx3CyU=S=enSZCLCU=2NurukHNM=AA@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <6d4934de-4aa6-24b4-6768-2439336a51af@redhat.com>
Date: Fri, 14 Feb 2020 13:25:13 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_zyMgG5SQpVCwUTx3CyU=S=enSZCLCU=2NurukHNM=AA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: guSVQx0fN4SJRXBvGUTGJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 2/13/20 9:31 PM, Peter Maydell wrote:
> On Thu, 13 Feb 2020 at 03:49, Gavin Shan <gshan@redhat.com> wrote:
>> On 2/12/20 10:34 PM, Peter Maydell wrote:
>>> Yeah, this is on my list to look at; Richard Henderson also could
>>> have a look at it. From a quick scan I suspect you may be missing
>>> handling for AArch32.
> 
>> Yes, the functionality is only supported on aarch64 currently by intention
>> because the next patch enables it on "max" and "host" CPU models and both
>> of them are running in aarch64 mode.
>>
>> https://patchwork.kernel.org/patch/11366119/
>>
>> If you really want to get this supported for aarch32 either, I can do
>> it. However, it seems there is a long list of aarch32 CPU models, defined
>> in target/arm/cpu.c::arm_cpus. so which CPU models you prefer to see with
>> this supported? I think we might choose one or two popular CPU models if
>> you agree.
> 
> I don't think you should need to care about the CPU models.
> We should implement SError (aka "asynchronous external
> abort" in ARMv7 and earlier) generically for all CPUs. The
> SError/async abort should be triggered by a qemu_irq line
> inbound to the CPU (similar to FIQ and IRQ); the board can
> choose to wire that up to something, or not, as it likes.
> 

Yes, what I need to care about is board with this. It means
I will get this supported on "virt" only. Thanks for the comments
and the changes will be included in v3.

Thanks,
Gavin


