Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5792146E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ithcicD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5792146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mC8-0006sr-Ex
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9mBI-00068p-Mt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9mBH-00075b-LF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:48:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45257
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9mBH-000759-Hk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583398114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6iD3jkxdEUU6AhYstY4Hbm7yleMcPSD0UH/1os5sVw=;
 b=ithcicD6B7YHM8Sf/rjp6LpDx6vl6JuyAxspFfYS2DhMUSP9bdBBVFopWuvaVtlLiiiFGo
 UtuEt4Ur4fRUv5qpMqugegYrtUWmgdO2FS6qcZFj2SPuzC2Jdvtq8MZmciLZv77UEyhFwk
 JfVd+f8MOGiYta1R77s+WUVaSHhjSIo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-syFrhbkvM8a-WOTsgfrsrw-1; Thu, 05 Mar 2020 03:48:33 -0500
X-MC-Unique: syFrhbkvM8a-WOTsgfrsrw-1
Received: by mail-ed1-f71.google.com with SMTP id g11so3807885edu.10
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l2lpAZ5lFx4H6TAvT4R4+M+SHAhl0nK0/QdqFhDNOcs=;
 b=pGqIKJSc/+G0v4ukLpnWLrqi1TCwy77GPOQl8vGEsONrnLdub4APH4/Yw9vkq3tYMS
 vrEivDJIDtquIjAZOPuhDKA03O7phbRuGTKjWCP/qM38x+y9Ty6OQIm4btteygKTn7tS
 cqkZiFROn9+eM/s7niLE4mh0m6bNL53R5GOGX/4EqGOrbCn64rSGo3thJt53HLjL8jjE
 l38ww/i5MDmrYlxaZezvmTyxHqSgOdwYN9JFczbaSrJoHPxx6PokBskNRE/v+rnry5E3
 /NzVM1axfoZPgpPBMtfLf9p9JqDMNFGF3nYES7IVx3F1Wj4i0abxkfDlM7+eIOrZVRL6
 wFCg==
X-Gm-Message-State: ANhLgQ0mNua3938xC1hNIJB5IKMNZXf4ODEsdzfAlWiry/DUaT2k4Do6
 iAfsNwmh3cseQCDyV04lrPg+qNfb3yr1bSSi1mytGBr2VF/+dFmSuS9kGOWA4AtCFXF+7o/g2ue
 uCJEWm8IRcknOYAE=
X-Received: by 2002:a17:907:20ae:: with SMTP id
 pw14mr4225646ejb.347.1583398112071; 
 Thu, 05 Mar 2020 00:48:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsMmz2FB1bd9BTvf6iLuCagm1dxzJvC1+stE+vJjJQMA1iS8ka12cQUOwdUnrGOStkw5wlQQA==
X-Received: by 2002:a17:907:20ae:: with SMTP id
 pw14mr4225609ejb.347.1583398111753; 
 Thu, 05 Mar 2020 00:48:31 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g5sm607894edn.9.2020.03.05.00.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:48:31 -0800 (PST)
Subject: Re: [PATCH v7 10/17] target/ppc: Only calculate RMLS derived RMA
 limit on demand
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-11-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a6de71d-eb48-d638-2f33-04d7143b1284@redhat.com>
Date: Thu, 5 Mar 2020 09:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-11-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 4:43 AM, David Gibson wrote:
> When the LPCR is written, we update the env->rmls field with the RMA limi=
t
> it implies.  Simplify things by just calculating the value directly from
> the LPCR value when we need it.
>=20
> It's possible this is a little slower, but it's unlikely to be significan=
t,
> since this is only for real mode accesses in a translation configuration
> that's not used very often, and the whole thing is behind the qemu TLB
> anyway.  Therefore, keeping the number of state variables down and not
> having to worry about making sure it's always in sync seems the better
> option.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   target/ppc/cpu.h        | 1 -
>   target/ppc/mmu-hash64.c | 9 ++++++---
>   2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 8077fdb068..f9871b1233 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1046,7 +1046,6 @@ struct CPUPPCState {
>       uint64_t insns_flags2;
>   #if defined(TARGET_PPC64)
>       ppc_slb_t vrma_slb;
> -    target_ulong rmls;
>   #endif
>  =20
>       int error_code;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index fcccaabb88..4fd7b7ee74 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -837,8 +837,10 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr,
>  =20
>               goto skip_slb_search;
>           } else {
> +            target_ulong limit =3D rmls_limit(cpu);
> +
>               /* Emulated old-style RMO mode, bounds check against RMLS *=
/
> -            if (raddr >=3D env->rmls) {
> +            if (raddr >=3D limit) {
>                   if (rwx =3D=3D 2) {
>                       ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
>                   } else {
> @@ -1000,8 +1002,10 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *=
cpu, target_ulong addr)
>                   return -1;
>               }
>           } else {
> +            target_ulong limit =3D rmls_limit(cpu);
> +
>               /* Emulated old-style RMO mode, bounds check against RMLS *=
/
> -            if (raddr >=3D env->rmls) {
> +            if (raddr >=3D limit) {
>                   return -1;
>               }
>               return raddr | env->spr[SPR_RMOR];
> @@ -1091,7 +1095,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
al)
>       CPUPPCState *env =3D &cpu->env;
>  =20
>       env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> -    env->rmls =3D rmls_limit(cpu);
>       ppc_hash64_update_vrma(cpu);
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


