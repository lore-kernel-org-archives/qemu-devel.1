Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF0C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2900720746
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0s3pkP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900720746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC9Ag-0002ic-MX
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 17:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC99r-0001Lg-9J
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC99p-0003Fc-In
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:44:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC99p-0003EQ-8z
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583963092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3wXPGRq5MaYiY47aIi5wRu0Vl4wQxtILsLFnlGEDHA=;
 b=D0s3pkP1xF/Hk81EcTGbYDEMh8Ehbt+eZW96F3Y4FkezGgtJk+3YCzn+TMJgCDJN19OXqj
 EGDUXsC6HN7T2swHfQGxRyyMAlczK2BHlbhzXWR0+6GdrC/84iRONuCeF4w92AEBR6FKNe
 X4uYf7apjWxDHNIchWbu2iZ0TGezd+4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-Pt9xOxdRMgmo_bSZJbXekQ-1; Wed, 11 Mar 2020 17:44:50 -0400
X-MC-Unique: Pt9xOxdRMgmo_bSZJbXekQ-1
Received: by mail-wr1-f71.google.com with SMTP id 31so1583103wrq.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 14:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B3wXPGRq5MaYiY47aIi5wRu0Vl4wQxtILsLFnlGEDHA=;
 b=ZsCec3y02GlEiKBg9TC3fx4Ya5Mi+6vm+G+tOdzOfi572WNcJUF+YZOI1eV1ZjeNMb
 NpHUvBhD1yZewBPRIQaxwiXr3AV8o6L0S6uaz5k3iwhYaMEabYB4CRyZRmtt0ve4uxNw
 2BNBi9P7WEj1kCYINOTcmbRzWaKEmXK8ka0u1MJTIAWIVtpoSgxyHvAASdnEcsWgsA25
 jOs6lSXSMp9CW1dpnSEEf06BbgawS9wCkouD4Gcjvw3tz8/0VasJP+9Cg+XLDcR1OvnE
 KnKn36S8HR8YvQIkm8fmqUtMXs2a0eqa1g2TwFZuSC4rKHv/oJetjFbsHaD0bfKzMEwt
 aC8g==
X-Gm-Message-State: ANhLgQ15GXee1bnxPPWD7/ZENPME3IWxwsxsEkzenvJZ+4bHBEwOOqNu
 c0nIQEUALRZ32EAG5XJo/rdPNPDhMUPg1Hi+IbKNMeMrb1eRwBcyr0PBd83py8Sus/RdIS5GgfQ
 RAbQtGLmYC/imoMw=
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr3804575wrr.422.1583963088961; 
 Wed, 11 Mar 2020 14:44:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6Ya9emR3TILKoDNXEMpCMas+U67f6yhtwJ1k5uHGGkEi+CmdoNisEa//YVw0iyBJlUsa2EA==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr3804554wrr.422.1583963088734; 
 Wed, 11 Mar 2020 14:44:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id b203sm10298660wmc.45.2020.03.11.14.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 14:44:47 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Maxime Villard <max@m00nbsd.net>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
 <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
 <CABgObfZjnFFV3hosrP+sf5d3KmPPGuFJZo-oY5=u340wtxLYGg@mail.gmail.com>
 <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
 <24fe7b93-8a34-e5d7-18b5-0f7607221ad3@redhat.com>
 <85e4202d-91dd-0d31-373a-febe566353ab@m00nbsd.net>
 <93e2e198-26ed-c8c7-b47e-977915156a17@redhat.com>
 <f48f9c36-5104-1346-cb91-d52c2887097b@m00nbsd.net>
 <050cacce-41fc-db89-ded9-5cdf6c20a2de@redhat.com>
 <cad16d05-13db-cb80-a049-84bb048def23@m00nbsd.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <933ede25-3ccf-3937-3649-3c7caea83f86@redhat.com>
Date: Wed, 11 Mar 2020 22:44:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cad16d05-13db-cb80-a049-84bb048def23@m00nbsd.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, jmcneill@invisible.ca, Kamil Rytarowski <n54@gmx.com>,
 philmd@redhat.com, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/03/20 22:21, Maxime Villard wrote:
>> Yes, you don't know how long that run would take.  I don't know about
>> NVMM but for KVM it may even never leave if the guest is in HLT state.
> Ok, I see, thanks.
> 
> In NVMM the runs are short

How do you ensure that a guest with interrupts off exits promptly?

> , the syscalls are fast, and pending signals
> cause returns to userland. Therefore, in practice, it's not a big problem,
> because (1) the window is small and (2) if we have a miss it's not going
> to take long to come back to Qemu.
> 
> I see a quick kernel change I can make to reduce 95% of the window
> already in the current state. The remaining 5% will need a new
> nvmm_vcpu_kick() function.

You can also do what KVM did until a few years ago: swap the signal mask
atomically when you enter the hypervisor (e.g. unmasking SIGUSR1---this
has to be done in the kernel) and when you leave it.  Then in QEMU you
keep SIGUSR1 masked and "eat" it with sigwaitinfo.

> For now this issue is unimportant and no Qemu change is required.

If you say so.

Paolo


