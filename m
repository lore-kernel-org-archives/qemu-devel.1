Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56520C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 22:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A692072C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 22:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4vkZdXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A692072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPwOv-0007fy-9p
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 18:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jPwOG-0006q4-J0
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 18:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jPwOE-0002x0-QC
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 18:56:48 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jPwOE-0002wC-9l
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 18:56:46 -0400
Received: by mail-io1-xd42.google.com with SMTP id w1so6652623iot.7
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IvgW/0qH07zwxjdODqQ/wkgwGDwP10Y75Wq+uiCGqQc=;
 b=Z4vkZdXUCzEflRxHo4/BoQHXMctRosO8uawz4V6ao+y5Gn/pY6vhTXVdiNpDa1FjsM
 V/gC6oUtIMnqPY+UZQgXZQYM99SeqpSkdKNmKqfLod+6NRmJNr5B5Iu500T3KGJVgZ6k
 0HWcXwFmVIwDA26k8oqUR1wpIAQtWifWUtPoyILoHtVdzSatj3rJew5pWRkY+7bQ2HaA
 zuRuhCepQFZmLR+vF9XWgqVcUG2+9ldBTy3sO0rHupb8lYgGjr58OBxH2Mb3L7Qcdft9
 v2mST8ZQPPuWj+pQMNEL9+/YQdW4uKcd+Lf0/qcDXoy1GAXJZfesyzmLPBQi18VeSvjw
 EcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IvgW/0qH07zwxjdODqQ/wkgwGDwP10Y75Wq+uiCGqQc=;
 b=ffcmT9pJMow7GZdm1g69ALIwIm+plHlX3kmoLRAv63cc746aWPAYuDE2KJz0Os3myD
 XiXvKefo8q2mhG8Ctm/M6GtgoL3vLYONPO7sxxbba5/dNZ9Nc9h1sSam2TuXrG/CTVce
 kJQpIc5nY6fsgipmrLESkC/lJ40Emtw0ApLt/HJp+61R8kRlnPpmXGOcdIQXVCAnTtKY
 DRFgglEjm3ld8EcYPwfpPm1aUuy470iRSHdbOCaRQ+k99RxiHuf1H5N9/Z85y9usO1+4
 qk82Q287Bwx4Jw9Fi/viULuMepjaUG2YbDV3H60sHJSlzGzYQAS400EdW2IEod6hLrbR
 DZKg==
X-Gm-Message-State: AGi0PuapXXsU3/nkB+bCV3dA7ZkvhZpZjy+XNX/G0kQRoOQxY7Uv4aZ6
 5poYtBWpkpvIZ0UO4cCD0OAB+57GpXG5LrF9nOIvBg==
X-Google-Smtp-Source: APiQypIXmPHLcvbEMLaoylw67WcS+FV+BryMjmCs5C3z5k/15r+BfwsPOQMTmor8ATWksCqVvZ6vbDkZMefCgoGv4m4=
X-Received: by 2002:a02:ccf4:: with SMTP id l20mr9766213jaq.28.1587250604367; 
 Sat, 18 Apr 2020 15:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
 <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
 <20200417131032.lcyunbjwofsn2nzz@kamzik.brq.redhat.com>
In-Reply-To: <20200417131032.lcyunbjwofsn2nzz@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Sat, 18 Apr 2020 23:56:32 +0100
Message-ID: <CADSWDzvz6RzhQnPL9k91SGAXP0iGfXVd+h3RML8yqXrcCQ1xsQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=beata.michalska@linaro.org; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 14:10, Andrew Jones <drjones@redhat.com> wrote:
>
> On Fri, Apr 17, 2020 at 11:39:25AM +0100, Peter Maydell wrote:
> > On Mon, 23 Mar 2020 at 11:32, Beata Michalska
> > <beata.michalska@linaro.org> wrote:
> > >
> > > On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
> > > exception with no valid ISS info to be decoded. The lack of decode info
> > > makes it at least tricky to emulate those instruction which is one of the
> > > (many) reasons why KVM will not even try to do so.
> > >
> > > Add support for handling those by requesting KVM to inject external
> > > dabt into the quest.
> > >
> > > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > > ---
> > >  target/arm/cpu.h     |  2 ++
> > >  target/arm/kvm.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  target/arm/kvm_arm.h | 11 +++++++++++
> > >  3 files changed, 67 insertions(+)
> > >
> > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > > index 4ffd991..4f834c1 100644
> > > --- a/target/arm/cpu.h
> > > +++ b/target/arm/cpu.h
> > > @@ -560,6 +560,8 @@ typedef struct CPUARMState {
> > >          uint64_t esr;
> > >      } serror;
> > >
> > > +    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> >
> > I was trying to work out whether we need to migrate this state,
> > and I'm not sure. Andrew, do you know? I think this comes down
> > to "at what points in QEMU's kvm run loop can migration kick in",
> > and specifically if we get a KVM_EXIT_ARM_NISV do we definitely
> > go round the loop and KVM_RUN again without ever checking
> > to see if we should do a migration ?
> >
>
> I'd prefer a migration expert confirm this, so I've CC'ed David and Juan,
> but afaict there's no way to break out of the KVM_RUN loop after a
> successful (ret=0) call to kvm_arch_handle_exit() until after the next
> KVM_RUN ioctl. This is because even if migration kicks the vcpus between
> kvm_arch_handle_exit() and the next run, the signal won't do anything
> other than prepare the vcpu for an immediate exit.
>
I am definitely not an expert on that one, but if I got things right,
by the time the 'exit_request' gets verified , the external abort
should already be set up , the pending status cleared (through
KVM_SET_VCPU_EVENTS)
and the reg content verified (kvm_arch_pre_run), as all of it is being
 triggered
prior to checking the exit request. So this should not need a
dedicated migration state.

I will hold on with sending the new version though to get the confirmation
whether that is the case.

Thanks,

BR
Beata
>
> Thanks,
> drew
>

