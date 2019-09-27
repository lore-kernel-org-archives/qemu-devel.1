Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D882075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LA+6HdLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D882075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmOC-0006rf-Ew
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDmGK-0007WE-Hd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDmGJ-0002aG-Er
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:10:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDmGJ-0002Yo-CC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569575402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=P9psUB6/KiwaS9H3i7HotZch7N5x0EpQX8KuIQgs6HY=;
 b=LA+6HdLly5YtyMaa72Z3wrTlhCWNtYYuIFq1kPiOOW3mRodkPelzAKmcSn9ppk3YVHcFbb
 yE7L29woiK3Px4REyBQEvBdwrCjJMpWVSgTryJOiMO/7IQTNqPs+uviac79mrbrM3vn+Yg
 J0T+hD1tocl2jQCoD21iB4b9b3dsy4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-r-Gpg8dXP_CHi9HMStma2A-1; Fri, 27 Sep 2019 05:09:59 -0400
Received: by mail-wm1-f70.google.com with SMTP id l3so2465787wmf.8
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 02:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nlNeTP7NbLjKSuFudQImRwe8GPXTrHcfQIxAIjyT0I0=;
 b=I3p2o4G8bBtK3h/hzNeYxhlNS7PDH9Lq83120Kh/TUdtobD2ERXHSCox3B2C5Vx/6o
 qAAvGyDOiL1Gkpd+EpLr6c1DJuw5Z1v7gYsyjaR9ENCpnbI0FrU+Ph0IEkwiEkamkPQP
 HCgehk3+8CmwrbEdce36LvPUQtdMYrY9QE3nWZv3pPE30GVaAJdnFwfZIGTtPHGGLqSQ
 4i7X+cxyd4RlqjDzxG0fIUQ3z7322krjIYCQPqsKLDvJia4Bf9+ZSjdpJpH2A9JGbEqW
 hL6rja4g2RxwE9LH5RT+NNjueuo9r0voD+wkE1AkvKEWu5dV/V8bS8YQqwhzh2Pec61U
 SKkw==
X-Gm-Message-State: APjAAAXH6+rpKI6SUyY3moGsb2Q6Yce1FwSTMy+86Y0MZRrw0sYRjG93
 sRnID/+x+zD1lRpNcV/0IpO7qJoW+gbhrepaTEU12f93FFca5Lr4aOx4bHYy0spyjZShxk2BmZi
 yvtAZ1sOIoog9CzY=
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr5816494wmh.134.1569575398623; 
 Fri, 27 Sep 2019 02:09:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxf0TOaXmlFkKoUgI2m5CkYyzKOgy48FTz49Sv3XC4NTR/F+DQOrN/vZQWUpX4ZXjXjRTmtAQ==
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr5816486wmh.134.1569575398455; 
 Fri, 27 Sep 2019 02:09:58 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id n8sm9425071wma.7.2019.09.27.02.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 02:09:57 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] target/riscv: Print CPU and privledge in disas
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7ffed750-767a-40be-4ef1-d52aad93f2e5@redhat.com>
Date: Fri, 27 Sep 2019 11:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
Content-Language: en-US
X-MC-Unique: r-Gpg8dXP_CHi9HMStma2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: alistair23@gmail.com, palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 2:45 AM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index adeddb85f6..537af0003e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -810,7 +810,14 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbas=
e, CPUState *cpu)
> =20
>  static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState =
*cpu)
>  {
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
> +    CPURISCVState *env =3D &rvcpu->env;
> +#endif
>      qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
> +#ifndef CONFIG_USER_ONLY
> +    qemu_log("CPU: %d; priv: "TARGET_FMT_ld"\n", cpu->cpu_index, env->pr=
iv);
> +#endif

Nit: can be extracted as another function to reduce the ifdef'ry and
simply use:

       log_cpu_priv(cpu);

>      log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
>  }
> =20

With function previously defined:

static void log_cpu_priv(const CPUState *cpu)
{
#ifndef CONFIG_USER_ONLY
    RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
    CPURISCVState *env =3D &rvcpu->env;

    qemu_log("CPU: %d; priv: "TARGET_FMT_ld"\n", cpu->cpu_index, env->priv)=
;
#endif
}

Anyway, fixing the typo in the patch subject:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


