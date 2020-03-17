Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5EC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8E820714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNAVswsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8E820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJyL-0007Wt-Vx
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEJxi-000774-Dp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEJxg-0002rj-IJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:41:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEJxg-0002eN-B7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584481279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLS9SRGMsn2yZU9F/8535m1eR8R3P8AhotvRndyORcw=;
 b=SNAVswsvfOSKhRroaMCr4KSlBXbkWxghGQfa5XdbZoqsyesoqS7K5oBBIonAi+sX8Xk0te
 ppoTImejHwyuBRvDXt4mSE7E0Du3bmno0n8nC9H7lUCVqjIKhc0p0nsy0WN9idnywSJ+RV
 ehveP+1qfTY8EQ62+NzGBSm0ZwAIv24=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-tnQ5S3fKNhq9KFld9SAf9g-1; Tue, 17 Mar 2020 17:41:14 -0400
X-MC-Unique: tnQ5S3fKNhq9KFld9SAf9g-1
Received: by mail-wm1-f69.google.com with SMTP id s20so274409wmj.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 14:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZRhykLnusXpF7rIwQJBFw65hGcQgWtiyDctIL+DgZlw=;
 b=Wqw7MLo2eXbjnoO1F+ePflLy0/9zppMwXvTOWtXeUw9V7G9/RYivBnGGBxIUD33l9T
 bHZUpqJeO5NkoC2e/hM5uyHKQdlWSJwjOMWizY22hhzaz0ZjiQa7r2ThPKD6kVV/188Q
 Pq6AGBHWJ/uIwts39tYDMGQvh1cRTwAxh41iKXqrZNZyLdWs3EgASmX0XBH1FalNherD
 SBBWG8sdREjkEHtm1I6GlCa+axL/JRyZCZ+K/hPCZR1NFOmjGPQpRY8fTCGnbkS4kjsK
 vFOdafdFaqsebU32uv0/Q/CioQnPtaOhRMK0eHWLcefwlsdUQ+sI0l71tphf/5rJDvK4
 wg/Q==
X-Gm-Message-State: ANhLgQ08DBQEsrXQ5UK1dzprMtjhNdsU9bz/8fn4TbCSjQThGIdMsQU4
 QO0xkWD+h5pgkea4hI8wojsWKEihFPCLP7mVGIfTakO7NX1AlPNAupNLSQjfShkE5QlZOuZQoR/
 /Znv8IG1bee3ODBg=
X-Received: by 2002:a1c:f615:: with SMTP id w21mr1015461wmc.152.1584481273185; 
 Tue, 17 Mar 2020 14:41:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvWd/h4jocmdIVaGIOUcJSVLLd3M8JoA3TA8XLhOHZVLa7zfJpR5dTOJ/cTeE08MkGMT9+AXQ==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr1015443wmc.152.1584481272876; 
 Tue, 17 Mar 2020 14:41:12 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k9sm6440949wrd.74.2020.03.17.14.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 14:41:12 -0700 (PDT)
Date: Tue, 17 Mar 2020 17:41:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200317214108.GD233068@xz-x1>
References: <20200317195042.282977-1-peterx@redhat.com>
 <20200317195042.282977-5-peterx@redhat.com>
 <20200317150646.2718d3a6@w520.home>
MIME-Version: 1.0
In-Reply-To: <20200317150646.2718d3a6@w520.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 03:06:46PM -0600, Alex Williamson wrote:

[...]

> > diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> > index 15747fe2c2..81a17cc2b8 100644
> > --- a/hw/intc/ioapic.c
> > +++ b/hw/intc/ioapic.c
> > @@ -236,8 +236,29 @@ void ioapic_eoi_broadcast(int vector)
> >          for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
> >              entry =3D s->ioredtbl[n];
> > =20
> > -            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
> > -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D IO=
APIC_TRIGGER_LEVEL) {
> > +            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector) {
> > +                continue;
> > +            }
> > +
> > +            /*
> > +             * When IOAPIC is in the userspace while APIC is still in
> > +             * the kernel (i.e., split irqchip), we have a trick to
> > +             * kick the resamplefd logic for registered irqfds from
> > +             * userspace to deactivate the IRQ.  When that happens, it
> > +             * means the irq bypassed userspace IOAPIC (so the irr and
> > +             * remote-irr of the table entry should be bypassed too
> > +             * even if interrupt come).  Still kick the resamplefds if
> > +             * they're bound to the IRQ, to make sure to EOI the
> > +             * interrupt for the hardware correctly.
> > +             *
> > +             * Note: We still need to go through the irr & remote-irr
> > +             * operations below because we don't know whether there're
> > +             * emulated devices that are using/sharing the same IRQ.
> > +             */
> > +            kvm_resample_fd_notify(n);
> > +
> > +            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
> > +                IOAPIC_TRIGGER_LEVEL) {
> >                  continue;
> >              }
> > =20
>=20
> What's the logic for sending resampler notifies before testing if the
> ioapic entry is in level triggered mode?  vfio won't use this for
> anything other than level triggered.  Inserting it between these checks
> confused me and in my testing wasn't necessary.  Thanks,

I put it there to match the kernel implementation, and IIUC Paolo
agreed with that too:

https://patchwork.kernel.org/patch/11407441/#23190969

Since we've discussed a few times here, I think I can talk a bit more
on how I understand this in case I was wrong...

Even if we have the fact that all the existing devices that use this
code should be using level-triggered IRQs, however... *If* there comes
an edge-triggered INTx device and we assign it using vfio-pci, vfio
should also mask the IRQ after it generates (according to
vfio_intx_handler), is that right?  Then we still need to kick the
resamplefd for that does-not-exist device too to make sure it'll work?

Thanks,

>=20
> Alex
>=20
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 141342de98..583a976f8a 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -555,4 +555,8 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void=
 *source);
> >  int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
> >  struct ppc_radix_page_info *kvm_get_radix_page_info(void);
> >  int kvm_get_max_memslots(void);
> > +
> > +/* Notify resamplefd for EOI of specific interrupts. */
> > +void kvm_resample_fd_notify(int gsi);
> > +
> >  #endif
>=20

--=20
Peter Xu


