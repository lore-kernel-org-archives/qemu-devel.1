Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED342146E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqA4SJel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED342146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mBD-0005u5-8f
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9mAU-0005AN-VV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9mAT-0006ZX-Od
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:47:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9mAT-0006Z9-Li
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583398065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvQP8eWqU2zXAlMm770mA4dRmrXOmXnlzicTMvtPq44=;
 b=hqA4SJelLCNKy2wXElIklzvfsvh+06E3e7YXCsD3AAfQLqDdRFgRXoQBjmZXHIMAmjgqZR
 cvGIw1r5syf+i75O60H5NqTxKEM3WO5hcWGzq6NqqwnsKHCcyyAZqwmtYe5b4ViPj370UH
 KWfgC6kvnUiqKcU8OB6uUSvKA4YeJuE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-IOKQg9bmMcmLcstoGdKA7A-1; Thu, 05 Mar 2020 03:47:43 -0500
X-MC-Unique: IOKQg9bmMcmLcstoGdKA7A-1
Received: by mail-ed1-f71.google.com with SMTP id f13so3792437edy.21
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A3NDn/4kNxLSUqsf/LYl6F/rDRZoAPPu89mJNuy3Frc=;
 b=KtU19wX2+GMXOvpcQ0MrudU8Apczp31rhOsQ7gS+wc/iUpzsffjmc4ERmXg57hhJa3
 ZaRtZ0fl8XBruM+P9B+8kvf7FLFUi6biTB3kW8a/LbOg2DbUtdEG5a9Eo5VXbJ4TFrjn
 4SLnTOpLnBqI2KT16YLa3u6revY7yNMwqmCHQNlHAK/qZR551EcGnUbl1y37lH3lar+V
 8BtD4Giisk5IwJ4dcO+/O85wlAWYyX/iMHuIqceDlhwa6eIHXB3IyQXkpi2tZYXgJs2s
 bYHjdY7oBzSfHq/bcWL4jNP0+Seau3agqiv2see1B5Ia2Q4p3ty8kzvXXnqprhkadUtF
 b3TQ==
X-Gm-Message-State: ANhLgQ2QOHkD+RtM2bC12z9lwvcHv57iKNDhY08c4xTspinlULekpWKp
 u1xFSXKn/Alzyny2yeYwofui4GG7JVY+LaICUuV8fVsuedXHrL/Hd19QHe1MYw1jA0+LkbB5qNV
 vV7bbDGVaqa4ZCVU=
X-Received: by 2002:aa7:c913:: with SMTP id b19mr3300941edt.94.1583398062292; 
 Thu, 05 Mar 2020 00:47:42 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuKLVceVu4kRXit8NV8QOgxcRYbG7kAYKd/K5VaMzOTnsX0MOSZu5IP1OEKQNgfmHpV7KaZZg==
X-Received: by 2002:aa7:c913:: with SMTP id b19mr3300913edt.94.1583398062064; 
 Thu, 05 Mar 2020 00:47:42 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id dk4sm216428ejb.74.2020.03.05.00.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:47:41 -0800 (PST)
Subject: Re: [PATCH v7 13/17] spapr,ppc: Simplify signature of
 kvmppc_rma_size()
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-14-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9c4810a-5e4a-b3e5-3d94-13b0acebdae5@redhat.com>
Date: Thu, 5 Mar 2020 09:47:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-14-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, Cedric Le Goater <clg@fr.ibm.com>,
 paulus@samba.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 4:43 AM, David Gibson wrote:
> This function calculates the maximum size of the RMA as implied by the
> host's page size of structure of the VRMA (there are a number of other
> constraints on the RMA size which will supersede this one in many
> circumstances).
>=20
> The current interface takes the current RMA size estimate, and clamps it
> to the VRMA derived size.  The only current caller passes in an arguably
> wrong value (it will match the current RMA estimate in some but not all
> cases).
>=20
> We want to fix that, but for now just keep concerns separated by having t=
he
> KVM helper function just return the VRMA derived limit, and let the calle=
r
> combine it with other constraints.  We call the new function
> kvmppc_vrma_limit() to more clearly indicate its limited responsibility.
>=20
> The helper should only ever be called in the KVM enabled case, so replace
> its !CONFIG_KVM stub with an assert() rather than a dummy value.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Cedric Le Goater <clg@fr.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   hw/ppc/spapr.c       | 5 +++--
>   target/ppc/kvm.c     | 5 ++---
>   target/ppc/kvm_ppc.h | 7 +++----
>   3 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 510494ad87..18bf4bc3de 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1586,8 +1586,9 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *sp=
apr)
>       spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
>  =20
>       if (spapr->vrma_adjust) {
> -        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(MACHINE(spa=
pr)),
> -                                          spapr->htab_shift);
> +        hwaddr vrma_limit =3D kvmppc_vrma_limit(spapr->htab_shift);
> +
> +        spapr->rma_size =3D MIN(spapr_node0_size(MACHINE(spapr)), vrma_l=
imit);
>       }
>   }
>  =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7f44b1aa1a..597f72be1b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2113,7 +2113,7 @@ void kvmppc_error_append_smt_possible_hint(Error *c=
onst *errp)
>  =20
>  =20
>   #ifdef TARGET_PPC64
> -uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
> +uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
>   {
>       struct kvm_ppc_smmu_info info;
>       long rampagesize, best_page_shift;
> @@ -2140,8 +2140,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
>           }
>       }
>  =20
> -    return MIN(current_size,
> -               1ULL << (best_page_shift + hash_shift - 7));
> +    return 1ULL << (best_page_shift + hash_shift - 7);
>   }
>   #endif
>  =20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 9e4f2357cc..332fa0aa1c 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -47,7 +47,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t =
page_shift,
>                                 int *pfd, bool need_vfio);
>   int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size)=
;
>   int kvmppc_reset_htab(int shift_hint);
> -uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)=
;
> +uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
>   bool kvmppc_has_cap_spapr_vfio(void);
>   #endif /* !CONFIG_USER_ONLY */
>   bool kvmppc_has_cap_epr(void);
> @@ -255,10 +255,9 @@ static inline int kvmppc_reset_htab(int shift_hint)
>       return 0;
>   }
>  =20
> -static inline uint64_t kvmppc_rma_size(uint64_t current_size,
> -                                       unsigned int hash_shift)
> +static inline uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
>   {
> -    return ram_size;
> +    g_assert_not_reached();
>   }
>  =20
>   static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


