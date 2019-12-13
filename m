Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82532C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B5B24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtS7frjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B5B24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48211 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjnY-00044Q-3Y
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifjeh-0001Vt-B3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifjef-0008PI-FS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:02:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifjef-0008Ng-8u
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576238562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDpMWcY8MAvgf11QbhUG+VybIy/cco4vYWuQfZdZoDo=;
 b=RtS7frjsYObr9s79UN4DXHM5kTl15vqX4WkteSuzq/fnWgHl9W+XXSYZZSG7mEFYQyS+NY
 IDrYxgimTbpYX4dnNERuyXwxiAdY2Iml9b2LmJn3MK+xkeQLK+2ZqRkQxtKreqdlYK07Ap
 j7zUrox619enkawbUFbo5SzeHEmX1d8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-AUOugu-eNiimCP-cBN0QTA-1; Fri, 13 Dec 2019 07:02:41 -0500
Received: by mail-wm1-f70.google.com with SMTP id g1so2265977wmg.4
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 04:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KFc9zrc0lnaWTXScDbTfhkxNxQpAVklGF7JvKKV46Yw=;
 b=X1v2KUfSphZOzaoPKKnJRrLNu0S9Qh3a4g/8HPfjkUemlllnJaam158rP2LHfvJLhg
 qhSq/Fg64bQOXtN1YxLnNMI3w1ZAIgPiub0MXSAEYOR87LjB6hcRcHPHlsFv5GmjUIGm
 sqPoHQbiSBVDHUq6KWc6OOuNJXN48I7LMOcnC67V/VDJLEkyhc+LvmpEUdpa9Vuj5pbU
 3dVXnqX/G1SUMSidtms5BXV8KC5IMrCCOZ5jN/pZYCz4w1JXsxhasKvt5AKxUPHt0PJw
 GgmDYxPhtUNUmSkJxLd5STkB9oMOFJLf9MYfq6QY2d0mFloqLCCHozRrRhl3fhf1ZsPw
 LLjQ==
X-Gm-Message-State: APjAAAXLUYIbdaN9NGVrZ69FzaLS+MBE0wHSo19E13dxE+ifsMkSFYOu
 IA28JdTy/wdHyNSBgk5YMoUKsUSFv2yL+ZLwCTslQKjmL3qJ+kG6MfUqXyTNxyKgoNWtR+cTZPb
 MnNwdk40fJevu8Ss=
X-Received: by 2002:a05:600c:21da:: with SMTP id
 x26mr12626475wmj.4.1576238559917; 
 Fri, 13 Dec 2019 04:02:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoCftRM04qYwi72pC5q921M1Ds05cpN5tdRSlsIAa2FJQ3rJ756T/keW2JOQHWPggqcz0ujA==
X-Received: by 2002:a05:600c:21da:: with SMTP id
 x26mr12626438wmj.4.1576238559671; 
 Fri, 13 Dec 2019 04:02:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id u8sm9915651wmm.15.2019.12.13.04.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 04:02:39 -0800 (PST)
Subject: Re: [PATCH] hw/i386: De-duplicate gsi_handler() to remove
 kvm_pc_gsi_handler()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213110736.10767-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02225320-0c42-33d2-6e30-16935eaaa5d2@redhat.com>
Date: Fri, 13 Dec 2019 13:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213110736.10767-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: AUOugu-eNiimCP-cBN0QTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 12:07, Philippe Mathieu-Daud=C3=A9 wrote:
> Both gsi_handler() and kvm_pc_gsi_handler() have the same content,
> except one comment. Move the comment, and de-duplicate the code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/sysemu/kvm.h |  1 -
>  hw/i386/kvm/ioapic.c | 12 ------------
>  hw/i386/pc.c         |  5 ++---
>  3 files changed, 2 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 9fe233b9bf..f5d0d0d710 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -515,7 +515,6 @@ int kvm_irqchip_add_irqfd_notifier(KVMState *s, Event=
Notifier *n,
>  int kvm_irqchip_remove_irqfd_notifier(KVMState *s, EventNotifier *n,
>                                        qemu_irq irq);
>  void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi);
> -void kvm_pc_gsi_handler(void *opaque, int n, int level);
>  void kvm_pc_setup_irq_routing(bool pci_enabled);
>  void kvm_init_irq_routing(KVMState *s);
> =20
> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
> index f94729c565..bae7413a39 100644
> --- a/hw/i386/kvm/ioapic.c
> +++ b/hw/i386/kvm/ioapic.c
> @@ -48,18 +48,6 @@ void kvm_pc_setup_irq_routing(bool pci_enabled)
>      }
>  }
> =20
> -void kvm_pc_gsi_handler(void *opaque, int n, int level)
> -{
> -    GSIState *s =3D opaque;
> -
> -    if (n < ISA_NUM_IRQS) {
> -        /* Kernel will forward to both PIC and IOAPIC */
> -        qemu_set_irq(s->i8259_irq[n], level);
> -    } else {
> -        qemu_set_irq(s->ioapic_irq[n], level);
> -    }
> -}
> -
>  typedef struct KVMIOAPICState KVMIOAPICState;
> =20
>  struct KVMIOAPICState {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ac08e63604..97e9049b71 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -350,6 +350,7 @@ void gsi_handler(void *opaque, int n, int level)
> =20
>      DPRINTF("pc: %s GSI %d\n", level ? "raising" : "lowering", n);
>      if (n < ISA_NUM_IRQS) {
> +        /* Under KVM, Kernel will forward to both PIC and IOAPIC */
>          qemu_set_irq(s->i8259_irq[n], level);
>      }
>      qemu_set_irq(s->ioapic_irq[n], level);
> @@ -362,10 +363,8 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_en=
abled)
>      s =3D g_new0(GSIState, 1);
>      if (kvm_ioapic_in_kernel()) {
>          kvm_pc_setup_irq_routing(pci_enabled);
> -        *irqs =3D qemu_allocate_irqs(kvm_pc_gsi_handler, s, GSI_NUM_PINS=
);
> -    } else {
> -        *irqs =3D qemu_allocate_irqs(gsi_handler, s, GSI_NUM_PINS);
>      }
> +    *irqs =3D qemu_allocate_irqs(gsi_handler, s, GSI_NUM_PINS);
> =20
>      return s;
>  }
>=20

Queued, thanks.

Paolo


