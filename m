Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3777CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6E020650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNuHubwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6E020650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFBV-0006p6-L3
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEeh-0005VI-Rt
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEeg-0001MQ-FC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:18:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEee-0001L4-FW
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571829493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ftW1HDTjgHchxI1sBiXxqXZ8nyuXShsgsD7QjOpNC8=;
 b=MNuHubwPiSnbc9mGKnLnYgsHIq+a6cg2Q72/5+daJK2m5LNCq4hS1ILs9VsimH2JabB6Rs
 T+6WsIhS6Xuq0ar8R5+xB01hgb0OHUU7O3PlB8bngOnv1+oeHud68sax/atqxDTSri4svr
 9peUCsLEGVf3e7aARdnXL7RytdhIKDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-aJ0nrJWMP3yIUenkvceeaA-1; Wed, 23 Oct 2019 07:18:09 -0400
Received: by mail-wm1-f72.google.com with SMTP id v26so5372253wmh.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fYU8LVB63QJbgTUtlnIadcPQToPg+TsuOTP1E19G/ws=;
 b=Mc+B6MT3cuD28KXRdcY1IpeMsyDvCILRXbdmh7DVqS0sCW37ABVHPQZ/MS/3+uP1iQ
 gmxVLblBLiAK0f6IyaKNZ8JvtbFwbK6sol2fs8Lr+vhHy9Lm4RKe3TmXcWn9YWsONT5y
 Tkj4WsZ9sk+oj5L65eVZBvy3lfH7axFg19KYZSbvqK1JKgBnGJzd2IjZ5p/bcCrrrHW1
 2+pOTnVs7L1L/JRbuKw2uuZBJPGmPuXJHXxKQ96y79xpjxZfpMrvRJ89w9/ncS6j4TT7
 jPGnIFNUhI+rLC+57Jp1q8R5+WYBRDs9IYGkOB7c3OutgDlDNfCnbK5b602eYJBXDP5F
 sGfw==
X-Gm-Message-State: APjAAAWwMEVSavU2CXu+tb++nxSCwL9YiWyYsRobPyalVt/lpseeK7zR
 R2PzhCm9s6IQ18i5rWWPtnVOaw01Xl3XKPCPdW98j7DP2hQ/4aS6xFHpXSDn6lCU9QsUH8e8dQO
 KZMG+PjcBbihKJ3s=
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr6904474wma.37.1571829488708; 
 Wed, 23 Oct 2019 04:18:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9jCaWrV9vzDWK8DtN97xeIpT2CjTNvJhPxS2eBwZGbHkaVR2TqKiGcIUq/Mn82BIBzLR0Qg==
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr6904457wma.37.1571829488462; 
 Wed, 23 Oct 2019 04:18:08 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u7sm15390368wre.59.2019.10.23.04.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:18:07 -0700 (PDT)
Subject: Re: [PATCH v5 3/7] ppc/pnv: Introduce a PnvCore reset handler
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21ea9a84-0a26-0ff7-c2a3-458c2c9016a1@redhat.com>
Date: Wed, 23 Oct 2019 13:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022163812.330-4-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: aJ0nrJWMP3yIUenkvceeaA-1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi C=C3=A9dric,

On 10/22/19 6:38 PM, C=C3=A9dric Le Goater wrote:
> in which individual CPUs are reset. It will ease the introduction of
> future change reseting the interrupt presenter from the CPU reset
> handler.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/pnv_core.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index b1a7489e7abf..9f981a4940e6 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -40,9 +40,8 @@ static const char *pnv_core_cpu_typename(PnvCore *pc)
>       return cpu_type;
>   }
>  =20
> -static void pnv_cpu_reset(void *opaque)
> +static void pnv_core_cpu_reset(PowerPCCPU *cpu)
>   {
> -    PowerPCCPU *cpu =3D opaque;
>       CPUState *cs =3D CPU(cpu);
>       CPUPPCState *env =3D &cpu->env;
>  =20
> @@ -192,8 +191,17 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChi=
p *chip, Error **errp)
>  =20
>       /* Set time-base frequency to 512 MHz */
>       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> +}
> +
> +static void pnv_core_reset(void *dev)

Here the opaque pointer is a 'PnvCore *pc'.
If you don't want to call it 'opaque', maybe 'pc' is better.

> +{
> +    CPUCore *cc =3D CPU_CORE(dev);
> +    PnvCore *pc =3D PNV_CORE(dev);

This type conversion is not necessary.

What about:

    static void pnv_core_reset(void *opaque)
    {
        PnvCore *pc =3D opaque;
        CPUCore *cc =3D CPU_CORE(pc);

> +    int i;
>  =20
> -    qemu_register_reset(pnv_cpu_reset, cpu);
> +    for (i =3D 0; i < cc->nr_threads; i++) {
> +        pnv_core_cpu_reset(pc->threads[i]);
> +    }
>   }
>  =20
>   static void pnv_core_realize(DeviceState *dev, Error **errp)
> @@ -244,6 +252,8 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>       snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
>       pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
>                             pc, name, PNV_XSCOM_EX_SIZE);
> +
> +    qemu_register_reset(pnv_core_reset, pc);
>       return;
>  =20
>   err:
> @@ -259,7 +269,6 @@ static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
>   {
>       PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
>  =20
> -    qemu_unregister_reset(pnv_cpu_reset, cpu);
>       object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
>       cpu_remove_sync(CPU(cpu));
>       cpu->machine_data =3D NULL;
> @@ -273,6 +282,8 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
>       CPUCore *cc =3D CPU_CORE(dev);
>       int i;
>  =20
> +    qemu_unregister_reset(pnv_core_reset, pc);
> +
>       for (i =3D 0; i < cc->nr_threads; i++) {
>           pnv_unrealize_vcpu(pc->threads[i]);
>       }
>=20


