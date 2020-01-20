Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC76C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16032077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fppwtP5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16032077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itStz-00068M-4W
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSsy-00058h-TE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSsv-0005cG-0q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSsu-0005c3-Tz
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTBNwqXOU0vSA3Kcc81vyC/bSzmFgyb/XcHNCP0W9BY=;
 b=fppwtP5Dzl+2XCWnl+HK3jASBlLoquPzoyf8VKdABKR9eIdfxWgxdwfOAw4Gj8YEUFGStY
 vZnrP62s6Ykd651ykgoQJ6xrDJPM2o5RxYBKXAn1hoPQlarLZD4Umd16oEHSJKw/KFW74i
 u4SOmcJi2LP2sgZCDu0TChVNwDjR7HE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-xgY1s08MMzyxBMNa4qPsJg-1; Mon, 20 Jan 2020 03:58:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id i9so13863251wru.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+sycqzM8BYcJkLA7rdtQW2P6p2rJIeWpN83xYyQsz3w=;
 b=TiLU9Vy5RHgfQ24ffK7IeCFvxk8pL+aaRN153Mw+RCitUuTIAEeBu2CZimWiiuIiY1
 kzEcc3Av2p8zZzdgBRvOa2zH28UeJrH5Xq6SQicVqoDU4+A2Ro29DWBZ/FPbBrFbAZHU
 d0J7GOfZFnxFhbp9EPSG9b786hVDAN+UptC6ivQay3ktL//QxRCXecUCeDG1zr8PUm95
 Xr5s0oymqTLpIgj+/IRYq/GLhRGwCjUZqtU/gArR/QOZfrXozI7DUVs7URKV2IE2kNDY
 5vBEJ7Gku+rWsRaKzLE0JR18TfgLEDddzs3+lE7w/+I6K2Rgffw8LRrVqunTlJ5E3Nci
 GMDQ==
X-Gm-Message-State: APjAAAWN6OKBpkNXIMjYFBD8qDc4LJCrp09pHC9yv1qGkiKztqiGe5Ui
 mpB5EzGNzLhM6GbmjU4FH1u+BtFdvj9ETxPDnyZQsUTVhsA9DEYA18Zueh4Je1hlBCGFHuOOt6X
 yCBNHRTzI5HtoDA8=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr17261084wrn.101.1579510689761; 
 Mon, 20 Jan 2020 00:58:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOSKenFPUIXfPECVAYHSM1xOMVM9jQ9BXbopyljexMtpxBcYjT0JJgh0Ok2fgoXaXY3dlBUg==
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr17261054wrn.101.1579510689352; 
 Mon, 20 Jan 2020 00:58:09 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id k8sm46373104wrl.3.2020.01.20.00.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 00:58:08 -0800 (PST)
Subject: Re: [PATCH 4/9] cputlb: Hoist tlb portions in tlb_mmu_resize_locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ca547aa-a710-84f2-262b-db29f4998d46@redhat.com>
Date: Mon, 20 Jan 2020 09:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109024907.2730-5-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: xgY1s08MMzyxBMNa4qPsJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 3:49 AM, Richard Henderson wrote:
> No functional change, but the smaller expressions make
> the code easier to read.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   accel/tcg/cputlb.c | 35 +++++++++++++++++------------------
>   1 file changed, 17 insertions(+), 18 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 49c605b6d8..c7dc1dc85a 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -115,8 +115,8 @@ static void tlb_dyn_init(CPUArchState *env)
>  =20
>   /**
>    * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if =
necessary
> - * @env: CPU that owns the TLB
> - * @mmu_idx: MMU index of the TLB
> + * @desc: The CPUTLBDesc portion of the TLB
> + * @fast: The CPUTLBDescFast portion of the same TLB
>    *
>    * Called with tlb_lock_held.
>    *
> @@ -153,10 +153,9 @@ static void tlb_dyn_init(CPUArchState *env)
>    * high), since otherwise we are likely to have a significant amount of
>    * conflict misses.
>    */
> -static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
> +static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast=
)
>   {
> -    CPUTLBDesc *desc =3D &env_tlb(env)->d[mmu_idx];
> -    size_t old_size =3D tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
> +    size_t old_size =3D tlb_n_entries(fast);
>       size_t rate;
>       size_t new_size =3D old_size;
>       int64_t now =3D get_clock_realtime();
> @@ -198,14 +197,15 @@ static void tlb_mmu_resize_locked(CPUArchState *env=
, int mmu_idx)
>           return;
>       }
>  =20
> -    g_free(env_tlb(env)->f[mmu_idx].table);
> -    g_free(env_tlb(env)->d[mmu_idx].iotlb);
> +    g_free(fast->table);
> +    g_free(desc->iotlb);
>  =20
>       tlb_window_reset(desc, now, 0);
>       /* desc->n_used_entries is cleared by the caller */
> -    env_tlb(env)->f[mmu_idx].mask =3D (new_size - 1) << CPU_TLB_ENTRY_BI=
TS;
> -    env_tlb(env)->f[mmu_idx].table =3D g_try_new(CPUTLBEntry, new_size);
> -    env_tlb(env)->d[mmu_idx].iotlb =3D g_try_new(CPUIOTLBEntry, new_size=
);
> +    fast->mask =3D (new_size - 1) << CPU_TLB_ENTRY_BITS;
> +    fast->table =3D g_try_new(CPUTLBEntry, new_size);
> +    desc->iotlb =3D g_try_new(CPUIOTLBEntry, new_size);
> +
>       /*
>        * If the allocations fail, try smaller sizes. We just freed some
>        * memory, so going back to half of new_size has a good chance of w=
orking.
> @@ -213,25 +213,24 @@ static void tlb_mmu_resize_locked(CPUArchState *env=
, int mmu_idx)
>        * allocations to fail though, so we progressively reduce the alloc=
ation
>        * size, aborting if we cannot even allocate the smallest TLB we su=
pport.
>        */
> -    while (env_tlb(env)->f[mmu_idx].table =3D=3D NULL ||
> -           env_tlb(env)->d[mmu_idx].iotlb =3D=3D NULL) {
> +    while (fast->table =3D=3D NULL || desc->iotlb =3D=3D NULL) {
>           if (new_size =3D=3D (1 << CPU_TLB_DYN_MIN_BITS)) {
>               error_report("%s: %s", __func__, strerror(errno));
>               abort();
>           }
>           new_size =3D MAX(new_size >> 1, 1 << CPU_TLB_DYN_MIN_BITS);
> -        env_tlb(env)->f[mmu_idx].mask =3D (new_size - 1) << CPU_TLB_ENTR=
Y_BITS;
> +        fast->mask =3D (new_size - 1) << CPU_TLB_ENTRY_BITS;
>  =20
> -        g_free(env_tlb(env)->f[mmu_idx].table);
> -        g_free(env_tlb(env)->d[mmu_idx].iotlb);
> -        env_tlb(env)->f[mmu_idx].table =3D g_try_new(CPUTLBEntry, new_si=
ze);
> -        env_tlb(env)->d[mmu_idx].iotlb =3D g_try_new(CPUIOTLBEntry, new_=
size);
> +        g_free(fast->table);
> +        g_free(desc->iotlb);
> +        fast->table =3D g_try_new(CPUTLBEntry, new_size);
> +        desc->iotlb =3D g_try_new(CPUIOTLBEntry, new_size);
>       }
>   }
>  =20
>   static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>   {
> -    tlb_mmu_resize_locked(env, mmu_idx);
> +    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mm=
u_idx]);
>       env_tlb(env)->d[mmu_idx].n_used_entries =3D 0;
>       env_tlb(env)->d[mmu_idx].large_page_addr =3D -1;
>       env_tlb(env)->d[mmu_idx].large_page_mask =3D -1;
>=20


