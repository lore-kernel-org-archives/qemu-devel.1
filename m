Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD9C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B962073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9jh5fa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B962073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSzA-0002q4-Nr
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSwe-00016N-RW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSwa-0007aO-RP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:02:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSwa-0007a2-NW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9DTKhEQTxBk16OJwXce8w8Pd+xXlpe6HOqi+L+mwE4=;
 b=b9jh5fa4XCoUyoZRi18fwoLxS8txaoHKqa1EqMiSDX+H1+mfoA/ajfxQuz1SczTWKgm0o/
 DdjjXxkZJZVHpFcBEafIU7O5fkmi4kqBgGaZdEN784ed2iLwJeIN77jDBFRZw9BIe+FPds
 1JE3iOgfX1Yi93h3UK7aXEs/gKrPEqo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-92DZna81MOGD09NjDmuKTA-1; Mon, 20 Jan 2020 04:01:57 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so13795792wrn.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 01:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gis2CEdSpUIiOekFl8DZHNFjkRGg+LRuBlHXlBVt858=;
 b=IlbHtrwpqaiUX4s1InBHPo/YzxqlmYu+WbdXafLzs1Ax791c0CYAXN7O8qal6Tg3H6
 ZZw+cw5PT5D4r90cNo0jlG9UMfg6Xs6vlaU8m6gY3Ujl0kKSibt9tecyRVG/01LxOxVe
 AEOFeTqVvB2jGREG5YjlsDHSRCQLi25tkCOYYhMeu6q3Nagpin9cltzflM3dL3JcLroU
 AgGfQ1Cp/zh5vczEPavnKkdIQqPRJT6giBNXIZiTAydqd4wTIJuiolxH05CU5HO9G4rR
 v8tQvyXDotxy7JHkfgHVXwaDUXXgizK54MNKobaCyAhSnBpUATEKlRWqk6tTN8qhBQur
 uvIA==
X-Gm-Message-State: APjAAAWoxrKsXt8xTZovaUJuuhHgr03XXMC7XJ2BJmUnlFhVQ08sdfxt
 weopl7R9M1F01gpbh0yv7GdVzugaFinSfbV0Rxbqn5QQVCGsFjg+dU87ePNoq+YCxwNctoU06HZ
 bMk5jImkGx8QT53M=
X-Received: by 2002:a7b:c775:: with SMTP id x21mr17811301wmk.59.1579510915765; 
 Mon, 20 Jan 2020 01:01:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw35BwRyfTpYZZDf/8N1/VYApM3YgW2YTfYq+XXaCA5iqgLprwrDVP9pw9WGtN9J1L8c7RVUQ==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr17811280wmk.59.1579510915438; 
 Mon, 20 Jan 2020 01:01:55 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n187sm22669484wme.28.2020.01.20.01.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 01:01:54 -0800 (PST)
Subject: Re: [PATCH 7/9] cputlb: Partially merge tlb_dyn_init into tlb_init
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <724f3cfe-3808-ec2d-0a85-485d547c25b1@redhat.com>
Date: Mon, 20 Jan 2020 10:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109024907.2730-8-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 92DZna81MOGD09NjDmuKTA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 3:49 AM, Richard Henderson wrote:
> Merge into the only caller, but at the same time split
> out tlb_mmu_init to initialize a single tlb entry.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   accel/tcg/cputlb.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e60e501334..c7c34b185b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -97,22 +97,6 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t=
 ns,
>       desc->window_max_entries =3D max_entries;
>   }
>  =20
> -static void tlb_dyn_init(CPUArchState *env)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < NB_MMU_MODES; i++) {
> -        CPUTLBDesc *desc =3D &env_tlb(env)->d[i];
> -        size_t n_entries =3D 1 << CPU_TLB_DYN_DEFAULT_BITS;
> -
> -        tlb_window_reset(desc, get_clock_realtime(), 0);
> -        desc->n_used_entries =3D 0;
> -        env_tlb(env)->f[i].mask =3D (n_entries - 1) << CPU_TLB_ENTRY_BIT=
S;
> -        env_tlb(env)->f[i].table =3D g_new(CPUTLBEntry, n_entries);
> -        env_tlb(env)->d[i].iotlb =3D g_new(CPUIOTLBEntry, n_entries);
> -    }
> -}
> -
>   /**
>    * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if =
necessary
>    * @desc: The CPUTLBDesc portion of the TLB
> @@ -247,6 +231,17 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState=
 *env, int mmu_idx)
>       tlb_mmu_flush_locked(desc, fast);
>   }
>  =20
> +static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t=
 now)
> +{
> +    size_t n_entries =3D 1 << CPU_TLB_DYN_DEFAULT_BITS;
> +
> +    tlb_window_reset(desc, now, 0);
> +    desc->n_used_entries =3D 0;
> +    fast->mask =3D (n_entries - 1) << CPU_TLB_ENTRY_BITS;
> +    fast->table =3D g_new(CPUTLBEntry, n_entries);
> +    desc->iotlb =3D g_new(CPUIOTLBEntry, n_entries);
> +}
> +
>   static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t =
mmu_idx)
>   {
>       env_tlb(env)->d[mmu_idx].n_used_entries++;
> @@ -260,13 +255,17 @@ static inline void tlb_n_used_entries_dec(CPUArchSt=
ate *env, uintptr_t mmu_idx)
>   void tlb_init(CPUState *cpu)
>   {
>       CPUArchState *env =3D cpu->env_ptr;
> +    int64_t now =3D get_clock_realtime();
> +    int i;
>  =20
>       qemu_spin_init(&env_tlb(env)->c.lock);
>  =20
>       /* Ensure that cpu_reset performs a full flush.  */
>       env_tlb(env)->c.dirty =3D ALL_MMUIDX_BITS;
>  =20
> -    tlb_dyn_init(env);
> +    for (i =3D 0; i < NB_MMU_MODES; i++) {
> +        tlb_mmu_init(&env_tlb(env)->d[i], &env_tlb(env)->f[i], now);
> +    }
>   }
>  =20
>   /* flush_all_helper: run fn across all cpus
>=20


