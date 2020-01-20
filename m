Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F0C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD742073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6j0PNYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD742073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSzC-0002th-9D
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSxe-0001sd-KT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSxY-00081m-Kz
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:03:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSxY-00081C-HF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=en2ln8BMqXjJyVrxJCShW2v5MM90UUcPG5wrNz2a2Q8=;
 b=h6j0PNYZUrU0K52IyB0lDyMuQthPLNm7qUQ9Gfh/AxssOSya3Ypxu6Cca+jByDTQGVONDN
 VceRlq871nmVRuKfhlRny0wPGFdIOuX/78Vh88zI2dNLFcLGE9AlNFmkzeWtXPz/0V2f6U
 kgTxRvT2fVX5N8tH4csoceC/yF3/3TM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-89OEhEKjOieFBWYVywhbAw-1; Mon, 20 Jan 2020 04:02:58 -0500
Received: by mail-wm1-f69.google.com with SMTP id y125so4132963wmg.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 01:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2A0kflpHyc3czuB01ItLmOjfBm78wUi7bLIc6qhOkX0=;
 b=LPaR3g9dRcJxDzZokn8Yr/v+dLKSJ8g+rLzDX9PI2urGtZ3boB8AOYT1iL6RpN/zvz
 HaWkKPSGWjF4hffBARirXeBch1yEP1T73BUOhm44TAt0b+I8O0veaiz0hX0d5zqNH1Aj
 WOZeQqSH8BhU+R0XMHhUnZGE9lVXczRnjxT0Jt6kmHcbg+UFs50zL8BT1RGqNge/Jsj7
 ZtjjCKToxFSn7kELDCHqkojAl18X/bBe+k5BA0aTVqrSiAMIOIoX4PyI6wWtWKBWKNyg
 7LVTqF72PBvQBQHIGdtMyqwIfa0uGN8o4QIr8IyHhH+5zAKnffWm61fQrQidRsZ/naei
 eqvQ==
X-Gm-Message-State: APjAAAU8tSnYDqJ8q+/lY00lmQS6a+XESKJD/7iIq8jxx/8eVcWivpdZ
 6F5mSsCsl+rwigRICgTqF7HfX3+G6yyriSQZQY3ILvWaUShawuPMpvu1PAZpBTt1yvzrbwVvvHv
 hqEzDyYmyI3p0Km4=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr16884042wrq.196.1579510977783; 
 Mon, 20 Jan 2020 01:02:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlRgYmlVK1xmBNx47RQhMyPmYq7y/LWs3qWBndShxN8Y3TQW0Oul7NJ3reiu6yzjQNNnXHhQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr16884023wrq.196.1579510977519; 
 Mon, 20 Jan 2020 01:02:57 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s19sm21925478wmj.33.2020.01.20.01.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 01:02:56 -0800 (PST)
Subject: Re: [PATCH 9/9] cputlb: Hoist timestamp outside of loops over tlbs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1391f6f5-4d6a-da8d-1707-c3f5a17a9144@redhat.com>
Date: Mon, 20 Jan 2020 10:02:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109024907.2730-10-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 89OEhEKjOieFBWYVywhbAw-1
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
> Do not call get_clock_realtime() in tlb_mmu_resize_locked,
> but hoist outside of any loop over a set of tlbs.  This is
> only two (indirect) callers, tlb_flush_by_mmuidx_async_work
> and tlb_flush_page_locked, so not onerous.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   accel/tcg/cputlb.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 761e9d44d7..9f6cb36921 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -137,12 +137,12 @@ static void tlb_window_reset(CPUTLBDesc *desc, int6=
4_t ns,
>    * high), since otherwise we are likely to have a significant amount of
>    * conflict misses.
>    */
> -static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast=
)
> +static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast=
,
> +                                  int64_t now)
>   {
>       size_t old_size =3D tlb_n_entries(fast);
>       size_t rate;
>       size_t new_size =3D old_size;
> -    int64_t now =3D get_clock_realtime();
>       int64_t window_len_ms =3D 100;
>       int64_t window_len_ns =3D window_len_ms * 1000 * 1000;
>       bool window_expired =3D now > desc->window_begin_ns + window_len_ns=
;
> @@ -222,12 +222,13 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, =
CPUTLBDescFast *fast)
>       memset(desc->vtable, -1, sizeof(desc->vtable));
>   }
>  =20
> -static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
> +static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx,
> +                                        int64_t now)
>   {
>       CPUTLBDesc *desc =3D &env_tlb(env)->d[mmu_idx];
>       CPUTLBDescFast *fast =3D &env_tlb(env)->f[mmu_idx];
>  =20
> -    tlb_mmu_resize_locked(desc, fast);
> +    tlb_mmu_resize_locked(desc, fast, now);
>       tlb_mmu_flush_locked(desc, fast);
>   }
>  =20
> @@ -310,6 +311,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>       CPUArchState *env =3D cpu->env_ptr;
>       uint16_t asked =3D data.host_int;
>       uint16_t all_dirty, work, to_clean;
> +    int64_t now =3D get_clock_realtime();
>  =20
>       assert_cpu_is_self(cpu);
>  =20
> @@ -324,7 +326,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>  =20
>       for (work =3D to_clean; work !=3D 0; work &=3D work - 1) {
>           int mmu_idx =3D ctz32(work);
> -        tlb_flush_one_mmuidx_locked(env, mmu_idx);
> +        tlb_flush_one_mmuidx_locked(env, mmu_idx, now);
>       }
>  =20
>       qemu_spin_unlock(&env_tlb(env)->c.lock);
> @@ -446,7 +448,7 @@ static void tlb_flush_page_locked(CPUArchState *env, =
int midx,
>           tlb_debug("forcing full flush midx %d ("
>                     TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
>                     midx, lp_addr, lp_mask);
> -        tlb_flush_one_mmuidx_locked(env, midx);
> +        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
>       } else {
>           if (tlb_flush_entry_locked(tlb_entry(env, midx, page), page)) {
>               tlb_n_used_entries_dec(env, midx);
>=20


