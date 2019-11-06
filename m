Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C0C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4852921A49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvbAtODn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4852921A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMOy-0004Q0-Ec
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSMNp-0003Jl-Am
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSMNm-0005Sv-LF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:34:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSMNl-0005Rv-Jv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573050841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARC41zqo07M+3gXAgJ2g3zDDdcSwa2/TDh3QlbqoQgA=;
 b=KvbAtODnEE593GAnsJri6BWI5mJNvl1ZH5B+D/L2VBItTYibFQEidjTBQkyO2FiVYeMwG+
 NeYOPI/9RVj1/QgmoOVctG12UsfBTzWUrGntYUloM2+pl8SpHP2AWm6WwEFV2AORmZzMxR
 ww8N++ssNM5l34a/L72f1SLsXwxDVek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-CqRhIFNZODm3RvaXdfhFCA-1; Wed, 06 Nov 2019 09:33:57 -0500
Received: by mail-wm1-f72.google.com with SMTP id t203so1011653wmt.7
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YCRI2ahNDQVxFWI4T11jUAe6ArG4C+SC27a8FnUc25I=;
 b=MgBswY9d/l0zVEVaONcBNX7nWtosWQZ9yiTxbVPHj0xsl+q6eFxqD30EYfThC9LYOJ
 VN4rc3kiRyK/JE7lnXPU6KgS1WvSNzl7ze423zEyAzHDW1irQJDBbLRxxWB1Bg5/BIXl
 KXpOKd3irypMAar04AzBCJYtu/AEVpUsqABaoQb1IBKh8hBOlKrbCaCt7X/nUDQSq3NX
 PrI6sts2jTVYXfqsSB23R5rpCeyRzrM09XJP9HpZL58k370KOgmRRwQE5kQjvty8cJ94
 eJt3JdhwYvvnRG/F5bBwUKN9zaZXMspPM3LjO2zTVnyZSPSeRtd6gs0Nz99CJ1kYCxGx
 v6Ow==
X-Gm-Message-State: APjAAAXyx+ddlE3D8K3MxC140EbUweO413MDE7TGEsNlW/CnUA9HVJca
 gMSgLWAlv13xLlFk9zSMcnEylGtZptBwxxw6eUKcDN3MBbarHewOyi5yMev8XzGGIuJU3LQ7NuQ
 05Vf2pN3mme7Tiy0=
X-Received: by 2002:a1c:808d:: with SMTP id b135mr2688743wmd.175.1573050836316; 
 Wed, 06 Nov 2019 06:33:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGdqs+oh06joDSrpc6n3/FVWN6Gey2QxA6U/x1TlZjPhk1apj02rzgPwndyFLt3W3a0ngiEQ==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr2688723wmd.175.1573050836132; 
 Wed, 06 Nov 2019 06:33:56 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id 6sm3745929wmd.36.2019.11.06.06.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 06:33:55 -0800 (PST)
Subject: Re: [PATCH v1 2/3] target/microblaze: Plug temp leaks with delay slot
 setup
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-3-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81ea045e-2cb3-aae9-d127-c27dd8e85800@redhat.com>
Date: Wed, 6 Nov 2019 15:33:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-3-edgar.iglesias@gmail.com>
Content-Language: en-US
X-MC-Unique: CqRhIFNZODm3RvaXdfhFCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> Plug temp leaks with delay slot setup.
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/translate.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index ba143ede5f..e9ff9e650d 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1201,6 +1201,17 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i=
64 pc_true, TCGv_i64 pc_false)
>       tcg_temp_free_i64(tmp_zero);
>   }
>  =20
> +static void dec_setup_dslot(DisasContext *dc)
> +{
> +        TCGv_i32 tmp =3D tcg_const_i32(dc->type_b && (dc->tb_flags & IMM=
_FLAG));
> +
> +        dc->delayed_branch =3D 2;
> +        dc->tb_flags |=3D D_FLAG;
> +
> +        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, bimm));
> +        tcg_temp_free_i32(tmp);
> +}
> +
>   static void dec_bcc(DisasContext *dc)
>   {
>       unsigned int cc;
> @@ -1212,10 +1223,7 @@ static void dec_bcc(DisasContext *dc)
>  =20
>       dc->delayed_branch =3D 1;
>       if (dslot) {
> -        dc->delayed_branch =3D 2;
> -        dc->tb_flags |=3D D_FLAG;
> -        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_F=
LAG)),
> -                      cpu_env, offsetof(CPUMBState, bimm));
> +        dec_setup_dslot(dc);
>       }
>  =20
>       if (dec_alu_op_b_is_small_imm(dc)) {
> @@ -1274,10 +1282,7 @@ static void dec_br(DisasContext *dc)
>  =20
>       dc->delayed_branch =3D 1;
>       if (dslot) {
> -        dc->delayed_branch =3D 2;
> -        dc->tb_flags |=3D D_FLAG;
> -        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_F=
LAG)),
> -                      cpu_env, offsetof(CPUMBState, bimm));
> +        dec_setup_dslot(dc);
>       }
>       if (link && dc->rd)
>           tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
> @@ -1379,10 +1384,7 @@ static void dec_rts(DisasContext *dc)
>           return;
>       }
>  =20
> -    dc->delayed_branch =3D 2;
> -    dc->tb_flags |=3D D_FLAG;
> -    tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)=
),
> -                  cpu_env, offsetof(CPUMBState, bimm));
> +    dec_setup_dslot(dc);
>  =20
>       if (i_bit) {
>           LOG_DIS("rtid ir=3D%x\n", dc->ir);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


