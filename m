Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3402072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz3ZZtcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3402072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAE9R-0007m7-1d
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jAE8g-0007Kb-MV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jAE8f-00035l-5h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:39:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jAE8e-00033i-W1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583505584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyVmr7aNt8RWb7ivdXkwQxg3/2gkQb2bOSMC9koKSyU=;
 b=Wz3ZZtcrWsgKgsJCOZK6ladIV4fjPm2LzWY84i2LAbFUfiIUkpCcZnds9/jekutjRZUTZn
 VSg2he1qNTYRoC9dLCvIFneTEcqukL2hjheKk9wUyS/VxgeOASvNgRrqQRg+s7wWTUrn3F
 H574rZIUlnGAH4qJVj2Rc/Ymdtn1s/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-oYiygv_VMp-3Qlwp34SBVA-1; Fri, 06 Mar 2020 09:39:42 -0500
X-MC-Unique: oYiygv_VMp-3Qlwp34SBVA-1
Received: by mail-wm1-f70.google.com with SMTP id m4so969432wmi.5
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 06:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dyVmr7aNt8RWb7ivdXkwQxg3/2gkQb2bOSMC9koKSyU=;
 b=k23Q5/A1GRLsC0YJnkixRkNrXOL+bzmhaY+NiyIdvdP2kSW8/pw96FwzJY3szE4NwR
 n8ZNQ6RhO/UZx2Fc0gkffNvdWJTnSh25nx90WtVpfvTEiOqg3H9sS2PLhi2eSHr6yhyG
 kFJ/XVMDvgTVHPI8PCPeVfAPiAvwfDvCiZt/mUycIciQ61EWppGmyfqaOhuSfTc5HIjX
 Q1u3zD83UtCV6ijxo+LhGkT75W6oCk9dVrI9y13ggaLuk2sHsR3rrzr74QLE3Xm1V3g2
 bvbAMNeIxlrGoffTcE3biW4p9YnyQ4HMBRVusFcH4BsrCWTNRXVuDKVSca7+PhBztAOk
 vC3Q==
X-Gm-Message-State: ANhLgQ23yPzV5wPTQoam3yVt6kz00m7w9XH71JMzhoh7z3da90tgqCpi
 CVPwkLPzNIAHAKxOJKxggXSxNn+xdNqteIV4du6c+bXwND0gPJwagYKJo0+eikIChu2V9tsd/d7
 ZXtGD17YbJW/VEKQ=
X-Received: by 2002:a5d:4384:: with SMTP id i4mr4323114wrq.396.1583505581124; 
 Fri, 06 Mar 2020 06:39:41 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvaDWb7pBEzAZ78eCr8V+iO9t8Fp1wpAzMpXGVG1XSGWO2upieUdHbVIp58sVbwLcZ3gXAxFA==
X-Received: by 2002:a5d:4384:: with SMTP id i4mr4323100wrq.396.1583505580881; 
 Fri, 06 Mar 2020 06:39:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8cd7:8509:4683:f03a?
 ([2001:b07:6468:f312:8cd7:8509:4683:f03a])
 by smtp.gmail.com with ESMTPSA id m21sm13636090wmi.27.2020.03.06.06.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 06:39:40 -0800 (PST)
Subject: Re: [PATCH RFC 4/4] kvm: Implement atomic memory region resizes via
 region_resize()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200303141939.352319-1-david@redhat.com>
 <20200303141939.352319-5-david@redhat.com>
 <102af47e-7ec0-7cf9-8ddd-0b67791b5126@redhat.com>
 <3b67a5ba-dc21-ad42-4363-95bb685240b9@redhat.com>
 <2a8d8b63-d54f-c1e7-9668-5d065e36aa1d@redhat.com>
 <d5704319-e9b8-be6b-6c95-d2e2edc6614c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b1d9549-5564-94e6-a55f-ca80996c6ef9@redhat.com>
Date: Fri, 6 Mar 2020 15:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d5704319-e9b8-be6b-6c95-d2e2edc6614c@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/20 15:30, David Hildenbrand wrote:
>> Assuming we're only talking about CPU ioctls (seems like a good
>> approximation) maybe you could use start_exclusive/end_exclusive?  The
>> current_cpu->in_exclusive_context assignments can be made conditional on
>> "if (current_cpu)".
>>
>> However that means you have to drop the BQL, see
>> process_queued_cpu_work.  It may be a problem.
>>
> Yeah, start_exclusive() is expected to be called without the BQL,
> otherwise the other CPUs would not be able to make progress and can
> eventually be "caught".
> 
> It's essentially the same reason why I can't use high-level
> pause_all_vcpus()/resume_all_vcpus(). Will drop the BQL which is very
> bad for resizing code.

But any other synchronization primitive that you do which blocks all
vCPUs will have the same issue, otherwise you get a deadlock.

Paolo


