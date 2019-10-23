Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D771CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6122084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7LTboUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6122084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNF13-0006oq-DG
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEmK-00032B-8N
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEmI-00066p-30
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:26:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEmG-000625-6I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571829966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wp/92vFeJJwHk8zHiYRk0f0kQL5XroUuv/jkwu+Fk+E=;
 b=Q7LTboUE8IsqeHoSzH6cRRrU3ks+V12sbLEUawPEbRjJhkISvtJEujmjzHjWJePADWbT3B
 wY7W7aERKuK6XUI8HYPe4jvg7N1I+jn3oNIwDnxryj9JLFqqn+xdNqceP7zX9hXYPePhdl
 t/SbpWZBA7n4URv6OL2tPwz9Uo3NYBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-XeVTI48qMh-QGEpwhMElIA-1; Wed, 23 Oct 2019 07:26:03 -0400
Received: by mail-wr1-f71.google.com with SMTP id 92so5433077wro.14
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m9q/U1JTiiMa06l0oVGiV/ZCGM5x1enfqDjDlRWfRKo=;
 b=roUk4Q2LbYT6lD+TwUJI+8JB5nLlYf4WWL1tytaPuyzmvFtB2uhkw3z+FyYuo1yrXi
 D3bspjOjsYl1PJ8tsncqDqvGPS9ZtmYxcNuSqB1kW/fTanXg239B0xlFxxXuuGi3Sej8
 7WYoHBvQeYfN6voxt2hblEkXFqpU1nR//sf0W0ceVlOS2yNomt0qEakbbETh1rwFfQ2Z
 xiDl9jNQcHOU3gISZrgt2DS5KwNa+CrrbscUowxBPQxwO5LmnVO+7/L3eLRLxR4Lyb+3
 XxchUWhHB/WydJZIyebCu4Z6RQcareXv8B3O9Lacm9spcdqgOIWeiFzY5Aa5qsb4dBpQ
 CuhQ==
X-Gm-Message-State: APjAAAUSeXnz6fzl1t/c72DL7ypst1rDUtUEAiQjhxj8HtP4EwKXq1Is
 MbSc2DevbObUvkg0syYCHxFnHrkhfZCEFq67WTdsM7FHnL6eKN6f+dq6TiI4mO9wKMbLSNhREMp
 o8u6xsCyHLlxWZBA=
X-Received: by 2002:a5d:5221:: with SMTP id i1mr7392485wra.297.1571829961866; 
 Wed, 23 Oct 2019 04:26:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxivxE+HICPDznw+3ROOUIuGj+yZhjEMG4cYbi3E5JbSL24HtUu3KvsH1lW5f6quA9GZx3Rfw==
X-Received: by 2002:a5d:5221:: with SMTP id i1mr7392472wra.297.1571829961653; 
 Wed, 23 Oct 2019 04:26:01 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id w15sm13756333wro.65.2019.10.23.04.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:26:01 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] ppc/pnv: Fix naming of routines realizing the CPUs
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-7-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8389f4b-6dc5-95ed-f89e-737598ef1059@redhat.com>
Date: Wed, 23 Oct 2019 13:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022163812.330-7-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: XeVTI48qMh-QGEpwhMElIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 6:38 PM, C=C3=A9dric Le Goater wrote:
> The 'vcpu' suffix is inherited from the sPAPR machine. Use better
> names for PowerNV.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/pnv_core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index be0310ac0340..e81cd3a3e047 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -162,7 +162,7 @@ static const MemoryRegionOps pnv_core_power9_xscom_op=
s =3D {
>       .endianness =3D DEVICE_BIG_ENDIAN,
>   };
>  =20
> -static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip *chip, Error **err=
p)
> +static void pnv_core_cpu_realize(PowerPCCPU *cpu, PnvChip *chip, Error *=
*errp)
>   {
>       CPUPPCState *env =3D &cpu->env;
>       int core_pir;
> @@ -247,7 +247,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>       }
>  =20
>       for (j =3D 0; j < cc->nr_threads; j++) {
> -        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
> +        pnv_core_cpu_realize(pc->threads[j], pc->chip, &local_err);
>           if (local_err) {
>               goto err;
>           }
> @@ -269,7 +269,7 @@ err:
>       error_propagate(errp, local_err);
>   }
>  =20
> -static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
> +static void pnv_core_cpu_unrealize(PowerPCCPU *cpu)
>   {
>       PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
>  =20
> @@ -289,7 +289,7 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
>       qemu_unregister_reset(pnv_core_reset, pc);
>  =20
>       for (i =3D 0; i < cc->nr_threads; i++) {
> -        pnv_unrealize_vcpu(pc->threads[i]);
> +        pnv_core_cpu_unrealize(pc->threads[i]);
>       }
>       g_free(pc->threads);
>   }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


