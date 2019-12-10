Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D69C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7753F20828
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2FuMeKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7753F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiac-0000jT-Gk
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ieiZb-0008Tf-Ge
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ieiZa-0003Tr-Bn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:41:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ieiZa-0003TC-7l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575996077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQ2rGxKgg83OZ9oqSgECS/5VH/LEYzs7CGZjuEUgRUI=;
 b=U2FuMeKaqgxy+iGDpBgo5bCgXw9zQJw2HHyuJ/4Q9+797q+iMJ08+JmFb18wQka96E4XHQ
 SWMxHo/Y/WbAmMZWDHH0kQBvnd5rZa5Plbp5bBT51gnmYx/X/P5V/8eufVyr6Vm0n1gedV
 6acw9wrylReaa1fWfYTu7ZakekpSQwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-fCV5_Z9mP2qvGb4xpFHIBQ-1; Tue, 10 Dec 2019 11:41:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E711010C5D;
 Tue, 10 Dec 2019 16:41:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227271001902;
 Tue, 10 Dec 2019 16:41:10 +0000 (UTC)
Date: Tue, 10 Dec 2019 17:41:08 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 2/5] timer: arm: Introduce functions to get the host
 cntfrq
Message-ID: <20191210164108.waqpn3wbo75nwqpx@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <20191016143410.5023-3-drjones@redhat.com>
 <CAFEAcA-a9O88EbKqSNxb_7GLVZzC+dx0daEWyAAe9SS4SRa1oQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-a9O88EbKqSNxb_7GLVZzC+dx0daEWyAAe9SS4SRa1oQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fCV5_Z9mP2qvGb4xpFHIBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 03:47:39PM +0000, Peter Maydell wrote:
> On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
> >
> > When acceleration like KVM is in use it's necessary to use the host's
> > counter frequency when converting ticks to or from time units.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  include/qemu/timer.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> > index 85bc6eb00b21..8941ddea8242 100644
> > --- a/include/qemu/timer.h
> > +++ b/include/qemu/timer.h
> > @@ -1006,6 +1006,22 @@ static inline int64_t cpu_get_host_ticks(void)
> >  }
> >  #endif
> >
> > +#if defined(__aarch64__)
> > +static inline uint32_t cpu_get_host_tick_frequency(void)
> > +{
> > +    uint64_t frq;
> > +    asm volatile("mrs %0, cntfrq_el0" : "=3Dr" (frq));
> > +    return frq;
> > +}
> > +#elif defined(__arm__)
> > +static inline uint32_t cpu_get_host_tick_frequency(void)
> > +{
> > +    uint32_t frq;
> > +    asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=3Dr" (frq));
> > +    return frq;
> > +}
> > +#endif
>=20
> Don't we want to know what the guest counter frequency
> is, not the host counter frequency? That is, I would have
> expected that we get this value via doing a KVM ONE_REG ioctl
> to ask the kernel what the guest cntfrq is. Are we using
> the host value on the assumption that the guest might have
> misprogrammed their copy of the register?
>

Indeed it would be best to get whatever KVM is using for the given VCPU's
CNTFRQ through GET_ONE_REG, but KVM doesn't seem to allow it. I hadn't
tested before, but to be sure, I did now with the following kselftests
test

 #include "kvm_util.h"
 #include "processor.h"
=20
 static void guest_code(void) { }
=20
 int main(void)
 {
   struct kvm_vm *vm =3D vm_create_default(0, 0, guest_code);
   uint64_t reg;
=20
   get_reg(vm, 0, ARM64_SYS_REG(3, 3, 14, 0, 0), &reg);
   printf("%lx\n", reg);
   return 0;
 }

The vcpu ioctl fails with ENOENT. Currently KVM requires all guests to
have the same frequency as the host, but I guess that will change
eventually. It's definitely best to do the save/restore thing, as you
suggest.

Thanks,
drew


