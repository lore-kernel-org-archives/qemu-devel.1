Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D47DC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B3F21D6C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgJmZTvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B3F21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMPF-0004p0-95
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSMMl-0002Tg-7x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSMMk-0004x0-7C
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47626
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSMMk-0004wf-3L
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573050777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLtk6EYcIXivEEvgUEOTHPAJ2CtP6ur8JSnfSb9XRc4=;
 b=HgJmZTvYrY3KifM02TDUEMwqxT9bQfH/JAzqVqVgn7VhLSNYQxUDOMQu4XucOz21HPvDe6
 jNlIgKchg5oYDiEh1U1lyKHna80MwbaGlO11WugJW9k1JT3Vi7o2kwap443B1uIpWd9SqD
 wRUFEq/sLVJ6K8+vowZIQ2F7c9pBvac=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-48fv0wEQN3WwjlT9xCVYPg-1; Wed, 06 Nov 2019 09:32:54 -0500
Received: by mail-wm1-f70.google.com with SMTP id y14so1286185wmi.4
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ummrZPU0IbvmB3MU5bIC6s+jm9dzELLRWiLZkATAQUM=;
 b=YfBXdBiTn182tzd1jAiVK94KyZS6ilnmteD+82XqQrruLNefrwyKn3u7sIg76Ptexr
 V2fCL+77aTSzQaIIh28Bmrm+EgKq8SS4DGPffM+XILDWrmWk0xkceaUT9Q3m5/aXqeQS
 jJ2J2dhinen4hLD7ak4Ke6QP36FKAUVeJLLE+CZQBMScFP9bqNs7ZFnZyUca5VZAlHeI
 nkMPjRW1eU0Zge3DRFkxlw8lBiW8JsHSjhxZsm4hW7YCg9ZfKPxRateBKBEPJpCSum1z
 ykheLY/50G3q4siu54jm3mLM5QGD3o8bi1CEIZDgI0LGiLS8oAnm3gQRQ3pqZeSYC+cu
 Xxrw==
X-Gm-Message-State: APjAAAURZTekvYFzkrIEVeiO+TgFWv5sJmtj1/g/sLZZQ7pnYT9yrrZL
 wc8k2JmLOOQPBIXaGQeC1B4d3R6Fpa0o99D2I6blWgwtAHQwt/Zk3MirJqLHNa7AixEYIbqSDOD
 bTMgbdh98VnuxfEI=
X-Received: by 2002:adf:f447:: with SMTP id f7mr2897042wrp.210.1573050772062; 
 Wed, 06 Nov 2019 06:32:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqydoe0dibM5cJEE1kHZuZz9IhtUXx5K6/9F5OYOgkkOilxopm1SADLbmi0ktG6LKrzC22lW0Q==
X-Received: by 2002:adf:f447:: with SMTP id f7mr2897019wrp.210.1573050771888; 
 Wed, 06 Nov 2019 06:32:51 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id b66sm3002597wmh.39.2019.11.06.06.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 06:32:51 -0800 (PST)
Subject: Re: [PATCH v1 3/3] target/microblaze: Plug temp leak around
 eval_cond_jmp()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-4-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <52609719-08d9-9271-8bb3-13c02e409929@redhat.com>
Date: Wed, 6 Nov 2019 15:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-4-edgar.iglesias@gmail.com>
Content-Language: en-US
X-MC-Unique: 48fv0wEQN3WwjlT9xCVYPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> Plug temp leak around eval_cond_jmp().
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/translate.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index e9ff9e650d..93e22a89ac 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1705,7 +1705,10 @@ void gen_intermediate_code(CPUState *cs, Translati=
onBlock *tb, int max_insns)
>                   dc->tb_flags &=3D ~D_FLAG;
>                   /* If it is a direct jump, try direct chaining.  */
>                   if (dc->jmp =3D=3D JMP_INDIRECT) {
> -                    eval_cond_jmp(dc, env_btarget, tcg_const_i64(dc->pc)=
);
> +                    TCGv_i64 tmp_pc =3D tcg_const_i64(dc->pc);
> +                    eval_cond_jmp(dc, env_btarget, tmp_pc);
> +                    tcg_temp_free_i64(tmp_pc);
> +
>                       dc->is_jmp =3D DISAS_JUMP;
>                   } else if (dc->jmp =3D=3D JMP_DIRECT) {
>                       t_sync_flags(dc);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


