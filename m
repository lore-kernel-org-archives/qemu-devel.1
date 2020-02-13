Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FDC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538C820848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ksh70mi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538C820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2COH-0007Hi-HU
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j2CNb-0006ir-Qk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j2CNZ-00055m-An
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:09:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j2CNZ-00055F-5t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581592195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBDpDGp8hRaSxc8Ce6qbjpIukw3OOaVaDvkazzNkgeo=;
 b=Ksh70mi4HATtoguDz1QfyC4J3OEWj8XUe88MosS+PNpHzChl5ou9t6goLxnbmJoK06wetH
 51QxtUrDKv+TzQaakpL5iXXOwBJ2102wGP7WHAxgOtkrAQxhE+qRbuX2w/7ABgi48pquvY
 5cCth0dCUETVkWpwZlrdxVNDfFWLb+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-ZXUFChKiMOq3jFMFDIbVoQ-1; Thu, 13 Feb 2020 06:09:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22168800D4C;
 Thu, 13 Feb 2020 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-95.bne.redhat.com [10.64.54.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECB5E1001B2B;
 Thu, 13 Feb 2020 11:09:46 +0000 (UTC)
Subject: Re: [RESEND RFC PATCH v2 1/2] target/arm: Allow to inject SError
 interrupt
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200205110541.37811-2-gshan@redhat.com>
 <8dce7dbe-c6c1-122a-f960-0fc29257dd1c@redhat.com>
 <CAFEAcA-RiVfrFFkxppB=z8x76rjorF-5onyGwVAdsHY7W1U88g@mail.gmail.com>
 <21e4051a-4d06-03cb-6d8e-5331b5b570c4@redhat.com>
 <a0ff5b47-876d-533f-ea18-e53ee371ceba@linaro.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <e7f614cc-ebd2-877d-2720-02d7d6edf152@redhat.com>
Date: Thu, 13 Feb 2020 22:09:44 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a0ff5b47-876d-533f-ea18-e53ee371ceba@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZXUFChKiMOq3jFMFDIbVoQ-1
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
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 4:39 PM, Richard Henderson wrote:
> On 2/12/20 7:49 PM, Gavin Shan wrote:
>> On 2/12/20 10:34 PM, Peter Maydell wrote:
>>> Yeah, this is on my list to look at; Richard Henderson also could
>>> have a look at it. From a quick scan I suspect you may be missing
>>> handling for AArch32.
>>>
>>
>> [Thanks for copying Richard Henderson]
>>
>> Yes, the functionality is only supported on aarch64 currently by intention
>> because the next patch enables it on "max" and "host" CPU models and both
>> of them are running in aarch64 mode.
> 
> We shouldn't leave the aarch32 exception entry paths unimplemented though.  C.f.
> 
> AArch32.TakePhysicalSErrorException()
> AArch32.TakeVirtualSErrorException()
> 
> It really shouldn't be more than a couple of lines, just like
> arm_cpu_do_interrupt_aarch64.  Remember both arm_cpu_do_interrupt_aarch32 and
> arm_cpu_do_interrupt_aarch32_hyp.
> 

Thanks for the details. The SError injection for aarch32 will be included in v3.

>> However, it seems there is a long list of aarch32 CPU models, defined
>> in target/arm/cpu.c::arm_cpus. so which CPU models you prefer to see with
>> this supported? I think we might choose one or two popular CPU models if
>> you agree.
> 
> Even qemu-system-aarch64 -cpu max can exercise this path when EL1 is running in
> aarch32 mode.  Admittedly it would be easier if we had the rest of the plumbing
> so that -cpu max,aarch64=off worked.
> 
> FWIW, the rest of the patch looks good.
> 

I think "-cpu max,aarch64=off" is only valid when KVM is enabled? If that's true,
the ioctl(cpu, KVM_SET_VCPU_EVENTS, &events) already worked for aarch32 or aarch64
guest if I'm correct enough. But yes, I need to test it because I never tested this
series on aarch32 guest :)

Thanks,
Gavin



