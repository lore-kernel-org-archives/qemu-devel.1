Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE1DC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD50B2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZIMXHXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD50B2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj1Ps-0008Sp-41
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45003)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hj1NA-0007fa-3p
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hj1N4-0004C0-4p
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:01:57 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:35896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hj1N3-0003T6-4F
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:01:53 -0400
Received: by mail-ot1-x32c.google.com with SMTP id r6so5901973oti.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nc7FhtADW9xp5yBbGHukGL5daEwg0bkLWCNHmMQGab0=;
 b=tZIMXHXdZfIHRdZtekfjO06nBBVi7KgxJ4zJD5/LXc461AfcO5KTINlVqWbByXKhCg
 US3pe+3lQSjl9jO7qJEU/vExJxdDZ8FrUphzx0f06bOIIh94t1Uf3thKPXOQ7pxq7Ra7
 5JcTAkz6V1K5+KTMD2L38H/L9Q+e7qDwwTZXpPzhCQf5bFjnsJbjxzzK9sOly2OFISPm
 VNhY15mZYknOIEMseh88QxYGO+BumWGCvauK1TQG8RyGbxHi03qIaXud7fVT0oG7DiGI
 hG/jldimKb1eNKuZO3lCrNIQOv8MvKFEOynhVV9B7y45+q0gH5joVHLtnndUaXzifsrJ
 XXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nc7FhtADW9xp5yBbGHukGL5daEwg0bkLWCNHmMQGab0=;
 b=DfzC630VX9wc01ePa7LJyLw/zk+mRevxJawI2Uh5Wr/GrOmXrZ3WCzXSYwr8n6jBgd
 7cEEZnuYPYaWcOunLWyvp0BhNW/2+fbymstXVGHGzIt6OnBx/G1zXFoDFI2x6NuHoBwF
 1yVx8L7XtGdea/UmEQOy5XaArYwrTpTmUnubMtxNN0Ozax7blceG25Czq/wrwTfPp3aJ
 IirlgqjwUa0cyXoe0SJK6MC5n54YRlmGvNb+r2UrGbWG1/+oUU/FDz7hM2op/P4h0f58
 tihPtgeNUVi/DZzdKnf8AFDb7wPYxpGNQaSIkwcjzCKCtDrNbPslyNLfr99o1JZIwU4K
 oK7Q==
X-Gm-Message-State: APjAAAXa5iFONqtjr34/mNoW7kN3m+nBWnQIcusQhXsPFXbiZHWKA1r4
 jOmk2ohO2zkjFqvqnXUCzUpym2gHUvyvqfQKaqU=
X-Google-Smtp-Source: APXvYqzGVYANBDIFK9Fxw+NI9ZwGdjEQzZ/EuYFU+HAB8vQN66iJE4E8+VFfztFDpT+5KjcDneRnV+By6GLTWX0PN0Q=
X-Received: by 2002:a9d:6194:: with SMTP id g20mr473065otk.149.1562245275210; 
 Thu, 04 Jul 2019 06:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
 <1557953433-19663-20-git-send-email-pbonzini@redhat.com>
 <CAJ+F1CK+FYYOFefek55yrFWRfC=NYBH5g8uPw9iO1QWZLh6r5A@mail.gmail.com>
In-Reply-To: <CAJ+F1CK+FYYOFefek55yrFWRfC=NYBH5g8uPw9iO1QWZLh6r5A@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 4 Jul 2019 21:00:38 +0800
Message-ID: <CAKXe6SL43HsCZwq9LZTN-Pgy1u-Kwbi5Ako+gFhMTabXma2nHg@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PULL 19/21] ioapic: allow buggy guests
 mishandling level-triggered interrupts to make progress
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have posted a fix for this several weeks ago:

-->https://www.mail-archive.com/qemu-devel@nongnu.org/msg626186.html


Thanks,
Li Qiang

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2019=E5=B9=B47=
=E6=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:57=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi
>
> On Thu, May 16, 2019 at 1:04 AM Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >
> > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > It was found that Hyper-V 2016 on KVM in some configurations (q35
> machine +
> > piix4-usb-uhci) hangs on boot. Root-cause was that one of Hyper-V
> > level-triggered interrupt handler performs EOI before fixing the cause =
of
> > the interrupt. This results in IOAPIC keep re-raising the level-trigger=
ed
> > interrupt after EOI because irq-line remains asserted.
> >
> > Gory details: https://www.spinics.net/lists/kvm/msg184484.html
> > (the whole thread).
> >
> > Turns out we were dealing with similar issues before; in-kernel IOAPIC
> > implementation has commit 184564efae4d ("kvm: ioapic: conditionally del=
ay
> > irq delivery duringeoi broadcast") which describes a very similar issue=
.
> >
> > Steal the idea from the above mentioned commit for IOAPIC implementatio=
n
> in
> > QEMU. SUCCESSIVE_IRQ_MAX_COUNT, delay and the comment are borrowed as
> well.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Message-Id: <20190402080215.10747-1-vkuznets@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> After this commit, I get the following ASAN error when booting a VM:
>
> /home/elmarco/src/qq/hw/intc/ioapic.c:266:27: runtime error: index 41
> out of bounds for type 'int [24]'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D9761=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address
> 0x61b00000312c at pc 0x55e40b8f9e74 bp 0x7f269c1d32a0 sp
> 0x7f269c1d3290
> WRITE of size 4 at 0x61b00000312c thread T4 (CPU 0/KVM)
>     #0 0x55e40b8f9e73 in ioapic_eoi_broadcast
> /home/elmarco/src/qq/hw/intc/ioapic.c:266
>     #1 0x55e40bd3fa4e in kvm_arch_handle_exit
> /home/elmarco/src/qq/target/i386/kvm.c:3644
>     #2 0x55e40b7d1fd7 in kvm_cpu_exec
> /home/elmarco/src/qq/accel/kvm/kvm-all.c:2083
>     #3 0x55e40b6e435f in qemu_kvm_cpu_thread_fn
> /home/elmarco/src/qq/cpus.c:1282
>     #4 0x55e40ce9ba42 in qemu_thread_start
> /home/elmarco/src/qq/util/qemu-thread-posix.c:502
>     #5 0x7f26ac3435a1 in start_thread (/lib64/libpthread.so.0+0x85a1)
>     #6 0x7f26ac270302 in __clone (/lib64/libc.so.6+0xfb302)
>
> Address 0x61b00000312c is a wild pointer.
> SUMMARY: AddressSanitizer: heap-buffer-overflow
> /home/elmarco/src/qq/hw/intc/ioapic.c:266 in ioapic_eoi_broadcast
> Shadow bytes around the buggy address:
>   0x0c367fff85d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c367fff85e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c367fff85f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c367fff8600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c367fff8610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fa fa
> =3D>0x0c367fff8620: fa fa fa fa fa[fa]fa fa fa fa fa fa fa fa fa fa
>   0x0c367fff8630: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c367fff8640: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c367fff8650: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c367fff8660: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c367fff8670: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
>   Shadow gap:              cc
> Thread T4 (CPU 0/KVM) created by T0 here:
>     #0 0x7f26af884965 in pthread_create (/lib64/libasan.so.5+0x3a965)
>     #1 0x55e40ce9be8b in qemu_thread_create
> /home/elmarco/src/qq/util/qemu-thread-posix.c:539
>     #2 0x55e40b6ea347 in qemu_kvm_start_vcpu
> /home/elmarco/src/qq/cpus.c:2018
>     #3 0x55e40b6eb03b in qemu_init_vcpu /home/elmarco/src/qq/cpus.c:2084
>     #4 0x55e40bb52352 in x86_cpu_realizefn
> /home/elmarco/src/qq/target/i386/cpu.c:5382
>     #5 0x55e40c017aed in device_set_realized
> /home/elmarco/src/qq/hw/core/qdev.c:834
>     #6 0x55e40c95e703 in property_set_bool
> /home/elmarco/src/qq/qom/object.c:2074
>     #7 0x55e40c959332 in object_property_set
> /home/elmarco/src/qq/qom/object.c:1266
>     #8 0x55e40c961edb in object_property_set_qobject
> /home/elmarco/src/qq/qom/qom-qobject.c:27
>     #9 0x55e40c959700 in object_property_set_bool
> /home/elmarco/src/qq/qom/object.c:1332
>     #10 0x55e40ba831a3 in pc_new_cpu /home/elmarco/src/qq/hw/i386/pc.c:15=
31
>     #11 0x55e40ba838a0 in pc_cpus_init
> /home/elmarco/src/qq/hw/i386/pc.c:1579
>     #12 0x55e40ba9f394 in pc_q35_init
> /home/elmarco/src/qq/hw/i386/pc_q35.c:183
>     #13 0x55e40baa19ab in pc_init_v4_0
> /home/elmarco/src/qq/hw/i386/pc_q35.c:385
>     #14 0x55e40c035aa7 in machine_run_board_init
> /home/elmarco/src/qq/hw/core/machine.c:1033
>     #15 0x55e40bda59d8 in main /home/elmarco/src/qq/vl.c:4494
>     #16 0x7f26ac198f32 in __libc_start_main (/lib64/libc.so.6+0x23f32)
>
> I start investigating.
>
> > ---
> >  hw/intc/ioapic.c                  | 57
> +++++++++++++++++++++++++++++++++++----
> >  hw/intc/trace-events              |  1 +
> >  include/hw/i386/ioapic_internal.h |  3 +++
> >  3 files changed, 56 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> > index 9d75f84..7074489 100644
> > --- a/hw/intc/ioapic.c
> > +++ b/hw/intc/ioapic.c
> > @@ -139,6 +139,15 @@ static void ioapic_service(IOAPICCommonState *s)
> >      }
> >  }
> >
> > +#define SUCCESSIVE_IRQ_MAX_COUNT 10000
> > +
> > +static void delayed_ioapic_service_cb(void *opaque)
> > +{
> > +    IOAPICCommonState *s =3D opaque;
> > +
> > +    ioapic_service(s);
> > +}
> > +
> >  static void ioapic_set_irq(void *opaque, int vector, int level)
> >  {
> >      IOAPICCommonState *s =3D opaque;
> > @@ -222,13 +231,39 @@ void ioapic_eoi_broadcast(int vector)
> >          }
> >          for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
> >              entry =3D s->ioredtbl[n];
> > -            if ((entry & IOAPIC_LVT_REMOTE_IRR)
> > -                && (entry & IOAPIC_VECTOR_MASK) =3D=3D vector) {
> > -                trace_ioapic_clear_remote_irr(n, vector);
> > -                s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
> > -                if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 <<
> n))) {
> > +
> > +            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
> > +                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
> IOAPIC_TRIGGER_LEVEL) {
> > +                continue;
> > +            }
> > +
> > +            if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
> > +                continue;
> > +            }
> > +
> > +            trace_ioapic_clear_remote_irr(n, vector);
> > +            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
> > +
> > +            if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
> > +                ++s->irq_eoi[vector];
> > +                if (s->irq_eoi[vector] >=3D SUCCESSIVE_IRQ_MAX_COUNT) =
{
> > +                    /*
> > +                     * Real hardware does not deliver the interrupt
> immediately
> > +                     * during eoi broadcast, and this lets a buggy
> guest make
> > +                     * slow progress even if it does not correctly
> handle a
> > +                     * level-triggered interrupt. Emulate this behavio=
r
> if we
> > +                     * detect an interrupt storm.
> > +                     */
> > +                    s->irq_eoi[vector] =3D 0;
> > +
> timer_mod_anticipate(s->delayed_ioapic_service_timer,
> > +
>  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                                         NANOSECONDS_PER_SECOND / 100)=
;
> > +                    trace_ioapic_eoi_delayed_reassert(vector);
> > +                } else {
> >                      ioapic_service(s);
> >                  }
> > +            } else {
> > +                s->irq_eoi[vector] =3D 0;
> >              }
> >          }
> >      }
> > @@ -401,6 +436,9 @@ static void ioapic_realize(DeviceState *dev, Error
> **errp)
> >      memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
> >                            "ioapic", 0x1000);
> >
> > +    s->delayed_ioapic_service_timer =3D
> > +        timer_new_ns(QEMU_CLOCK_VIRTUAL, delayed_ioapic_service_cb, s)=
;
> > +
> >      qdev_init_gpio_in(dev, ioapic_set_irq, IOAPIC_NUM_PINS);
> >
> >      ioapics[ioapic_no] =3D s;
> > @@ -408,6 +446,14 @@ static void ioapic_realize(DeviceState *dev, Error
> **errp)
> >      qemu_add_machine_init_done_notifier(&s->machine_done);
> >  }
> >
> > +static void ioapic_unrealize(DeviceState *dev, Error **errp)
> > +{
> > +    IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
> > +
> > +    timer_del(s->delayed_ioapic_service_timer);
> > +    timer_free(s->delayed_ioapic_service_timer);
> > +}
> > +
> >  static Property ioapic_properties[] =3D {
> >      DEFINE_PROP_UINT8("version", IOAPICCommonState, version,
> IOAPIC_VER_DEF),
> >      DEFINE_PROP_END_OF_LIST(),
> > @@ -419,6 +465,7 @@ static void ioapic_class_init(ObjectClass *klass,
> void *data)
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >
> >      k->realize =3D ioapic_realize;
> > +    k->unrealize =3D ioapic_unrealize;
> >      /*
> >       * If APIC is in kernel, we need to update the kernel cache after
> >       * migration, otherwise first 24 gsi routes will be invalid.
> > diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> > index a28bdce..90c9d07 100644
> > --- a/hw/intc/trace-events
> > +++ b/hw/intc/trace-events
> > @@ -25,6 +25,7 @@ apic_mem_writel(uint64_t addr, uint32_t val)
> "0x%"PRIx64" =3D 0x%08x"
> >  ioapic_set_remote_irr(int n) "set remote irr for pin %d"
> >  ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %=
d
> vector %d"
> >  ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
> > +ioapic_eoi_delayed_reassert(int vector) "delayed reassert on EOI
> broadcast for vector %d"
> >  ioapic_mem_read(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t
> val) "ioapic mem read addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8"
> retval 0x%"PRIx32
> >  ioapic_mem_write(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t
> val) "ioapic mem write addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8"
> val 0x%"PRIx32
> >  ioapic_set_irq(int vector, int level) "vector: %d level: %d"
> > diff --git a/include/hw/i386/ioapic_internal.h
> b/include/hw/i386/ioapic_internal.h
> > index 9848f39..07002f9 100644
> > --- a/include/hw/i386/ioapic_internal.h
> > +++ b/include/hw/i386/ioapic_internal.h
> > @@ -96,6 +96,7 @@ typedef struct IOAPICCommonClass {
> >      SysBusDeviceClass parent_class;
> >
> >      DeviceRealize realize;
> > +    DeviceUnrealize unrealize;
> >      void (*pre_save)(IOAPICCommonState *s);
> >      void (*post_load)(IOAPICCommonState *s);
> >  } IOAPICCommonClass;
> > @@ -111,6 +112,8 @@ struct IOAPICCommonState {
> >      uint8_t version;
> >      uint64_t irq_count[IOAPIC_NUM_PINS];
> >      int irq_level[IOAPIC_NUM_PINS];
> > +    int irq_eoi[IOAPIC_NUM_PINS];
> > +    QEMUTimer *delayed_ioapic_service_timer;
> >  };
> >
> >  void ioapic_reset_common(DeviceState *dev);
> > --
> > 1.8.3.1
> >
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
>
