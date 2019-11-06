Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52030C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160CB21848
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhfRVT7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160CB21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMNS-0002u2-8C
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSMMO-0001z7-2u
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSMMJ-0004kp-2d
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSMMI-0004kg-V6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573050750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOUTAhkRHTloq5XfO76LbFD23+eppc3LuKcyik9Qg1M=;
 b=BhfRVT7wVh0n4VRofAdIZt4c2wf0LPuUaqbS9hN7Q3GRpl5EQf6+5AcFd7GNQ1zs1hVfhY
 9U9NbQ7VhlTX6E8gaflHn1Z/EWQMsVVv5gHvAJZ2jB0KGK/ASOKTzSk7uY5Eso+fTjBNFA
 4bwZ7yxrYsDIpH/8Gs8k9DYje25Uh8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-xHYqKseyMRS98gS8DslVMw-1; Wed, 06 Nov 2019 09:32:28 -0500
Received: by mail-wm1-f70.google.com with SMTP id m68so1277158wme.7
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S168JjVzL5S9+bLnXK3PKMau66+ADjQ2bh3m2xgHkVU=;
 b=Vv7L8wDKd0FboGygu8fb13z1qOULm3IvJkqXRN06udwPCHl+wAKoc7E+LJIDAX5lXD
 6IyCrAhkQQzKKj7Rg88g5T8nfmxVycxfOgjk4W15+R0U4T1RZPS4RQGIE1XXcdIR5Fr0
 p4M2hIr+InDyJW0mOESms5OhPNI/SA8gyHiNh9xnpsSWiFo1QO+WoDAz0+WYq5iCCpLC
 h5YOTCEKm37++LiciBL9RiJRJr0tnNAmzOb1crNx0zzzeJ6Ree3b12WCHFcX5338Yvxs
 i69sZ+KlLDH/aHXSy6sKVPWGW9aqWXk1I2u+K3eOCgvr8FoFFbzifY15gogo853hvZpB
 WFIQ==
X-Gm-Message-State: APjAAAUEy8VVEttN7/xe3vRczCLFKfQ6JsQL5AFS6fAv0BWP6SAybumO
 Ws6IdpcSzUo/W+DZ4cWcfvlYOEIaQPAzrzzKOCuUJKIDZ/JjS7+twVI66wJj9liu4DbtBCMMY4W
 88nJrYCTiWJ81fro=
X-Received: by 2002:a7b:c444:: with SMTP id l4mr2787511wmi.49.1573050747611;
 Wed, 06 Nov 2019 06:32:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqplfMMnGG3RMEYWtbT34hJaJqI0hf/pT80SxtlWXRgRzRxjr6hBrnbQeV21SML/bJmpPR/g==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr2787490wmi.49.1573050747355;
 Wed, 06 Nov 2019 06:32:27 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id j63sm3358739wmj.46.2019.11.06.06.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 06:32:26 -0800 (PST)
Subject: Re: [PATCH v1 1/3] target/microblaze: Plug temp leaks for loads/stores
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-2-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e74da116-10be-3d7e-6014-33ed3cd446f8@redhat.com>
Date: Wed, 6 Nov 2019 15:32:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-2-edgar.iglesias@gmail.com>
Content-Language: en-US
X-MC-Unique: xHYqKseyMRS98gS8DslVMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 3:14 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>=20
> Plug TCG temp leaks for loads/stores.
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/translate.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 761f535357..ba143ede5f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -967,12 +967,14 @@ static void dec_load(DisasContext *dc)
>                      10 -> 10
>                      11 -> 00 */
>                   TCGv low =3D tcg_temp_new();
> +                TCGv t3 =3D tcg_const_tl(3);
>  =20
>                   tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_sub_tl(low, t3, low);
>                   tcg_gen_andi_tl(addr, addr, ~3);
>                   tcg_gen_or_tl(addr, addr, low);
>                   tcg_temp_free(low);
> +                tcg_temp_free(t3);
>                   break;
>               }
>  =20
> @@ -1006,9 +1008,16 @@ static void dec_load(DisasContext *dc)
>       tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
>  =20
>       if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > =
1) {
> +        TCGv_i32 t0 =3D tcg_const_i32(0);
> +        TCGv_i32 treg =3D tcg_const_i32(dc->rd);
> +        TCGv_i32 tsize =3D tcg_const_i32(size - 1);
> +
>           tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
> -        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> -                            tcg_const_i32(0), tcg_const_i32(size - 1));
> +        gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
> +
> +        tcg_temp_free_i32(t0);
> +        tcg_temp_free_i32(treg);
> +        tcg_temp_free_i32(tsize);
>       }
>  =20
>       if (ex) {
> @@ -1100,12 +1109,14 @@ static void dec_store(DisasContext *dc)
>                      10 -> 10
>                      11 -> 00 */
>                   TCGv low =3D tcg_temp_new();
> +                TCGv t3 =3D tcg_const_tl(3);
>  =20
>                   tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_sub_tl(low, t3, low);
>                   tcg_gen_andi_tl(addr, addr, ~3);
>                   tcg_gen_or_tl(addr, addr, low);
>                   tcg_temp_free(low);
> +                tcg_temp_free(t3);
>                   break;
>               }
>  =20
> @@ -1124,6 +1135,10 @@ static void dec_store(DisasContext *dc)
>  =20
>       /* Verify alignment if needed.  */
>       if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > =
1) {
> +        TCGv_i32 t1 =3D tcg_const_i32(1);
> +        TCGv_i32 treg =3D tcg_const_i32(dc->rd);
> +        TCGv_i32 tsize =3D tcg_const_i32(size - 1);
> +
>           tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
>           /* FIXME: if the alignment is wrong, we should restore the valu=
e
>            *        in memory. One possible way to achieve this is to pro=
be
> @@ -1131,8 +1146,11 @@ static void dec_store(DisasContext *dc)
>            *        the alignment checks in between the probe and the mem
>            *        access.
>            */
> -        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> -                            tcg_const_i32(1), tcg_const_i32(size - 1));
> +        gen_helper_memalign(cpu_env, addr, treg, t1, tsize);
> +
> +        tcg_temp_free_i32(t1);
> +        tcg_temp_free_i32(treg);
> +        tcg_temp_free_i32(tsize);
>       }
>  =20
>       if (ex) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


