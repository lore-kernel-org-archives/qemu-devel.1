Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647AFC3F2D0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBC424687
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDA9YJTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBC424687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbEl-0004Js-BC
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBbD9-0002la-49
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBbD7-0002B3-QI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBbD7-00028Z-Kc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583832601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2KWVU7CbUk6WuUdKXDBEVm2zPZZpnlW3OPQKjlLv9E=;
 b=SDA9YJTLA4DN7xTObQjykHvUw2l/YxAZQ3Lktw03Xi1jiRrBLoAXkeB3UmGkEpEljt8KXC
 Q4IOrdApfYUeReZE2gxmDWhqIXtufZlMH1RbJvdIUiPt1sCQ7pSv+JQXBl+WvH+2yN1FbJ
 OUIDM7L+wde+qRwXuXmrnPOAVnJz5Mg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-9NDY5HrVNFiKD4ZVx5ncBw-1; Tue, 10 Mar 2020 05:29:59 -0400
X-MC-Unique: 9NDY5HrVNFiKD4ZVx5ncBw-1
Received: by mail-qk1-f198.google.com with SMTP id h6so9283727qkj.14
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3mgVEC0nKISW3jluk2UEAnsHz4UdLXwkGdViTb3JOOM=;
 b=svS/ed9dLaUzatE7rvaVJeiTG6PSZh2XmSQONS5ZQrDz4V4RxVJT2YwWr/7dsnTnxv
 8V0vp8sjdStuq2GJ0in5zwzKn2TXzIiIBY04xhNDu03fQaw2RLhXNA9sCUUXnGBUBIn+
 EYRLlDJOBxK5bflfOT+A1kR5D7mVSlUiYdNuXO6swXIaKOZF0BJAz2geHEkYe8Z2B5un
 APbiE+23NQBiEKLsB7Q7hWkAR5w+iwfBaWGThTDalNcK/rWnrHnj3gN/OKFncGMWS0aS
 7FV1vIMeI/vbrFNKnWoLXLdcCRaTu6h9t03qqjpEnUAz0P29wdAdxAVHRAdxh1Q55ZHm
 lJnw==
X-Gm-Message-State: ANhLgQ3dc8Bmaz7SAbHu+45MmcLw5tOJET6MJ7NBhIIcmxwhLVLD45B3
 ZSbPiqg2vPfceyYZWJEZGxvZ27Ub6xikCX4i0MKVP9JG+vzEj95uTm4cq57WFHtC4ss1WP4OONN
 JakcQghCGGrOocGM=
X-Received: by 2002:a37:8384:: with SMTP id f126mr16810810qkd.99.1583832598872; 
 Tue, 10 Mar 2020 02:29:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsdg6Sju4eJe4hjPhJtX2Ha9Jn+5m1H/2rRcuZDbaCpPttgWtgMFe33gUBW2kIvH3XOC1vMPg==
X-Received: by 2002:a37:8384:: with SMTP id f126mr16810802qkd.99.1583832598627; 
 Tue, 10 Mar 2020 02:29:58 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 17sm6875039qkm.105.2020.03.10.02.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:29:57 -0700 (PDT)
Date: Tue, 10 Mar 2020 05:29:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 12/14] i386/cpu: Store LAPIC bus frequency in CPU structure
Message-ID: <20200310052900-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-13-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200309235411.76587-13-liran.alon@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:54:09AM +0200, Liran Alon wrote:
> No functional change.
> This information will be used by following patches.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  linux-headers/asm-x86/kvm.h | 4 ++++
>  target/i386/cpu.h           | 1 +
>  target/i386/kvm.c           | 6 +++---
>  3 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 503d3f42da16..99eeaaf2f0b4 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -446,4 +446,8 @@ struct kvm_pmu_event_filter {
>  #define KVM_PMU_EVENT_ALLOW 0
>  #define KVM_PMU_EVENT_DENY 1
> =20
> +/* From arch/x86/kvm/lapic.h */
> +#define KVM_APIC_BUS_CYCLE_NS       1
> +#define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_=
NS)
> +
>  #endif /* _ASM_X86_KVM_H */


This header is auto-generated from UAPI - you can't add
your own stuff here.


> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 576f309bbfc8..9c7cd7cde107 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1580,6 +1580,7 @@ typedef struct CPUX86State {
>      bool tsc_valid;
>      int64_t tsc_khz;
>      int64_t user_tsc_khz; /* for sanity check only */
> +    uint64_t apic_bus_freq;
>  #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>      void *xsave_buf;
>  #endif
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 69eb43d796e6..00917196dffb 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1496,6 +1496,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
> =20
> +    env->apic_bus_freq =3D KVM_APIC_BUS_FREQUENCY;
> +
>      /* Paravirtualization CPUIDs */
>      r =3D hyperv_handle_properties(cs, cpuid_data.entries);
>      if (r < 0) {
> @@ -1800,9 +1802,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          c =3D &cpuid_data.entries[cpuid_i++];
>          c->function =3D KVM_CPUID_SIGNATURE | 0x10;
>          c->eax =3D env->tsc_khz;
> -        /* LAPIC resolution of 1ns (freq: 1GHz) is hardcoded in KVM's
> -         * APIC_BUS_CYCLE_NS */
> -        c->ebx =3D 1000000;
> +        c->ebx =3D env->apic_bus_freq / 1000; /* Hz to KHz */
>          c->ecx =3D c->edx =3D 0;
> =20
>          c =3D cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
> --=20
> 2.20.1


