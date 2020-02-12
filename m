Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B6C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59135206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfhFiHTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59135206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lEY-0001bj-7B
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1lDn-00015M-V2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1lDl-0005A1-Mr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:10:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54406
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1lDl-00059o-JQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581487801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zhgsr9Xfhk29GspuJT2aRP0ElWuBMsc5HyOM+cklgcw=;
 b=IfhFiHTqUgBJRRxSHgdHkOGRaRyhgN6AdBKQwPriK74wgxjaJvQ6sBAwD/9l3fw2l+y27R
 XGlKOMhPrMVu+C7Pbzmid0C8ud+IQDnbmV7QP0Pc8xb9X4oBxD6HKJGjPayn/nuRnvEavb
 WTjvD8RqunmHFjKyYobmInc3eiKQqkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-dTyuxw7yMbGAEC3Nvns9hg-1; Wed, 12 Feb 2020 01:09:56 -0500
Received: by mail-wm1-f70.google.com with SMTP id b133so520487wmb.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PbyBmTfCQIx72FudDnZejO8RYXQnYvDC7feOY5x6hy8=;
 b=Xn8rgVSiY8Q5ZvOPQpBjgcP0yO717YH8tAXi2QSiCRjSQheaeVSfKbp00+lLh1RwTn
 EeQKkjeC9IU4IlJYjSbN6cdXlaXUZj2tDzdB5Ztoc3gRKkZ6lljDwQijWMa6vz/a+LPa
 WCKrc6FVxvlVBchIfIOZb0Trljnq1FXmGvxgMA+6JuCKkm7szkDTSVU5uOJq0RkOkIsB
 G6L6pHk8FTjb1eSOCBsSV2k5EgjlZhGmPeoSNrqbeBvgtAnfKwKk+Eff9Tyycq1knT5t
 5y1fba4/OvmyZ3v+R4tpWXfM/MSgZYTEOm1xnAzX3CLWNiHS/axKw4U80aAcQNeVe/Q3
 dLLw==
X-Gm-Message-State: APjAAAVXrnbpBWIS8g6kM8vTn/Y5ZeAutsDPuw19d37CxxrgY13GwvpB
 5KEyFOagmiNIeUT5G6ZyqZCWe88UojbulyVFO8+Aa/AxWggcOZ3JPSmMQb2uLZCR4s7p3u2Ac0n
 gB1/ijfS1WChj9cA=
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr12854420wrw.193.1581487794816; 
 Tue, 11 Feb 2020 22:09:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXnlk9GAP8/O9KP7PTBDkmhrpM5FvC9LHUe3awDXLnp76GGndARYRFKbM8PgDD07Y567LCrQ==
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr12854381wrw.193.1581487794451; 
 Tue, 11 Feb 2020 22:09:54 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id f11sm6767448wml.3.2020.02.11.22.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:09:53 -0800 (PST)
Subject: Re: [PATCH 1/2] tcg: Add tcg_gen_gvec_5_ptr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200212025145.24300-1-richard.henderson@linaro.org>
 <20200212025145.24300-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81c51843-8732-32af-1039-b4718173a647@redhat.com>
Date: Wed, 12 Feb 2020 07:09:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212025145.24300-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: dTyuxw7yMbGAEC3Nvns9hg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: peter.maydell@linaro.org, tsimpson@quicinc.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 3:51 AM, Richard Henderson wrote:
> Extend the vector generator infrastructure to handle
> 5 vector arguments.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-gvec.h |  7 +++++++
>   tcg/tcg-op-gvec.c         | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
>=20
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index 830d68f697..74534e2480 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -83,6 +83,13 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, =
uint32_t bofs,
>                           uint32_t maxsz, int32_t data,
>                           gen_helper_gvec_4_ptr *fn);
>  =20
> +typedef void gen_helper_gvec_5_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_pt=
r,
> +                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_5_ptr *fn);
> +
>   /* Expand a gvec operation.  Either inline or out-of-line depending on
>      the actual vector size and the operations supported by the host.  */
>   typedef struct {
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 41b4a3c661..327d9588e0 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -290,6 +290,38 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs=
, uint32_t bofs,
>       tcg_temp_free_i32(desc);
>   }
>  =20
> +/* Generate a call to a gvec-style helper with five vector operands
> +   and an extra pointer operand.  */
> +void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_5_ptr *fn)
> +{
> +    TCGv_ptr a0, a1, a2, a3, a4;
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +    a3 =3D tcg_temp_new_ptr();
> +    a4 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +    tcg_gen_addi_ptr(a3, cpu_env, cofs);
> +    tcg_gen_addi_ptr(a4, cpu_env, eofs);
> +
> +    fn(a0, a1, a2, a3, a4, ptr, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_ptr(a3);
> +    tcg_temp_free_ptr(a4);
> +    tcg_temp_free_i32(desc);
> +}
> +
>   /* Return true if we want to implement something of OPRSZ bytes
>      in units of LNSZ.  This limits the expansion of inline code.  */
>   static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


