Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FFC33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05D4207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmJ7Nn8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05D4207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSos-0001aS-V3
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSoC-00012a-ED
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSo8-0003BB-U9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:53:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSo8-0003Aq-Qt
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lqb1U9RqvFWJSpDs2Vt84UGnFot8/3lqRQ79Yd/S6Y=;
 b=PmJ7Nn8eupk6+YKDTwUuSlxhNDEwbxEvEXDLyOPNyeD6/wZgRfA567LeTNI/zu2gcsj9AB
 ROMpqfPkI+WoaASCpTL1NIc/tLD3uACWIBDwX3Z+n04xwbwBSU/lyZWvROtYRjRnjpANJY
 3ohy+t8B7H+woaJ9fFsUCb/uiViduWE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-V02hvxBbOey-T4FKMAX30w-1; Mon, 20 Jan 2020 03:53:12 -0500
Received: by mail-wr1-f69.google.com with SMTP id f17so13896038wrt.19
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ysc8RiMi5UPW/kkJmjQo/3i8swZMS+aGCdULZipYKng=;
 b=CwfEsC341hkCEzD3kSSl2eZbIRmHy0RleKXIO/XkAjUMKBVzClDsssMSxLo2nC/8vB
 dLTrFMk/gWkioU2agKMIoQajZSwWm45txxazeniGfuxWAbqH5G2TaO/RE8ilVm9Rb7+u
 qlV9dtHfYf/PThN8dAVpHs+VpMnHgQ2HjXfArJdP+zqqoAbB5jnuqtzufD17UWqOs+fO
 qR8+cx+jmtfO0CjK3P96M8yaBw2HrygNqqDXlwZohIwPZ2prcppPwHn5oMk2WmIVV0kz
 00MbrKjaICe9kNWiHI9Gic2cf0jN8fZzROhPC45FxBdLRvY8IApiYxW55ZEALcvYWcIM
 gymA==
X-Gm-Message-State: APjAAAV7YSIfikc4LeDKaio4yXPZC3dtlgnbWSLVloQ+FninJx9R3vED
 Na5r6xDbmC+jX/v/wQr4gXxmKTuJOE5ZOV4uNlp2tnh5RpVNDO84R00T2kTDiid29nS5zSHLSRT
 05fcVqeK/WScxSs4=
X-Received: by 2002:a7b:c416:: with SMTP id k22mr18407033wmi.10.1579510390890; 
 Mon, 20 Jan 2020 00:53:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqywpK3f/jNO4mXoKKsFv5Vd0mQiwRbuE3JIb1IAofmPso1SSnTtzbeF6rIUhw13+D37/VvvYA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr18407001wmi.10.1579510390565; 
 Mon, 20 Jan 2020 00:53:10 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id j12sm50466683wrw.54.2020.01.20.00.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 00:53:10 -0800 (PST)
Subject: Re: [PATCH 2/9] cputlb: Make tlb_n_entries private to cputlb.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <da7f1d44-1543-7351-4dc3-9b24501fcb99@redhat.com>
Date: Mon, 20 Jan 2020 09:53:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109024907.2730-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: V02hvxBbOey-T4FKMAX30w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 3:49 AM, Richard Henderson wrote:
> There are no users of this function outside cputlb.c,
> and its interface will change in the next patch.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/exec/cpu_ldst.h | 5 -----
>   accel/tcg/cputlb.c      | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index a46116167c..53de19753a 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -234,11 +234,6 @@ static inline uintptr_t tlb_index(CPUArchState *env,=
 uintptr_t mmu_idx,
>       return (addr >> TARGET_PAGE_BITS) & size_mask;
>   }
>  =20
> -static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> -{
> -    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> -}
> -
>   /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
>   static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_i=
dx,
>                                        target_ulong addr)
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 1a81886e58..e4a8ed9534 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -80,6 +80,11 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on=
_cpu_data));
>   QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>   #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>  =20
> +static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> +{
> +    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> +}
> +
>   static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
>   {
>       return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
>=20


