Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE95C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FCF2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx41BLG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FCF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtnNU-0000YX-9F
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 03:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtnMv-00005U-Vd
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:22:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27068
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtnMu-0005LR-HF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594365767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LP15d34TouyszSVQjRJOSuUkVhVo3nqKacLbUvCJx0=;
 b=Qx41BLG0Nm9gemivRX69161axI4mzWyjapcGeJ7Xl0JkOG34nlYOE5+tJ5feAzyvncyo2F
 7BgclXkuWEOsZ3zAuRsKQe4EjPk27BGaCdCmSdda6253DmnzhDhPCxJi/8YlZji0e8aJRu
 WX/zd0JqdnIIGMsyDJmGrclkK5syiOk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Ce0YOLg0MVq8mLD1m1x4vg-1; Fri, 10 Jul 2020 03:22:46 -0400
X-MC-Unique: Ce0YOLg0MVq8mLD1m1x4vg-1
Received: by mail-wr1-f71.google.com with SMTP id g14so4952186wrp.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 00:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1LP15d34TouyszSVQjRJOSuUkVhVo3nqKacLbUvCJx0=;
 b=lNi91HpKpsFh7lkyHCE6QAxN/m0nDEx0Ao78EmCan8Kan/tKbe71gDI3DITi88hRiT
 H7LqbONgznCVqXYAIGGiANtWn8CIpRTCehsBZjv1uhWYrXoWwlBUNp/z97WWCg0YG1bP
 imEbVX0ErF/fHHn1NiQX2E+c/DjqyXNrY48WyoFjh0Uo3+uF4IDdblhfKbsF8vgStrHt
 gbP7rQYCxSTW0A8Z8FBFDZsBaI60nVi5eoNzI/iwTTXUyeHNG+qXrvhFYAdM7AjFm1tF
 CnMFBzjeF/yyW9qQiFv1aEheJtsbR3tfUOmnILw71GuS9nwG+n7KyvNJLaEnJ07mPTUB
 K6Og==
X-Gm-Message-State: AOAM530xcU2axfufHUlf/fHLuMZ7GbUZXXH6zc+wkTFVtyVq3mmHOpDb
 QgADAx0Uni03bCBBH6/XJjokTq9pcp/OmhnBRNBv54IrMEz2D4YjWuVJ1fXd6WXsKaIvWlvXZ44
 7cBfMMJbpuYkejC8=
X-Received: by 2002:a1c:5418:: with SMTP id i24mr3615693wmb.47.1594365765013; 
 Fri, 10 Jul 2020 00:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJDfpsWJATF3x2k0/kUpiedr1e5eRuZK3mH9pswy5ELHGWFABftH17kpJ0ccpVvxQfTUOiuQ==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr3615668wmb.47.1594365764803; 
 Fri, 10 Jul 2020 00:22:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id g14sm9517815wrw.83.2020.07.10.00.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 00:22:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
To: Eduardo Habkost <ehabkost@redhat.com>, Jim Mattson <jmattson@google.com>
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
 <20200708171621.GA780932@habkost.net> <20200708172653.GL3229307@redhat.com>
 <20200709094415.yvdh6hsfukqqeadp@sirius.home.kraxel.org>
 <CALMp9eQnrdu-9sZhW3aXpK4pizOW=8G=bj1wkumSgHVNfG=CbQ@mail.gmail.com>
 <20200709191307.GH780932@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79aa7955-6bc1-d8b2-fed0-48a0990d9dea@redhat.com>
Date: Fri, 10 Jul 2020 09:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709191307.GH780932@habkost.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Guilherme Piccoli <gpiccoli@canonical.com>,
 Pedro Principeza <pedro.principeza@canonical.com>,
 kvm list <kvm@vger.kernel.org>, libvir-list@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>, mtosatti@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Mohammed Gamal <mgamal@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 fw@gpiccoli.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 21:13, Eduardo Habkost wrote:
>> Doesn't this require intercepting MOV-to-CR3 when the guest is in PAE
>> mode, so that the hypervisor can validate the high bits in the PDPTEs?
> If the fix has additional overhead, is the additional overhead
> bad enough to warrant making it optional?  Most existing
> GUEST_MAXPHYADDR < HOST_MAXPHYADDR guests already work today
> without the fix.

The problematic case is when host maxphyaddr is 52.  That case wouldn't
work at all without the fix.

Paolo


