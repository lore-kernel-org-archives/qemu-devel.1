Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAFECA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A4E20650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/171ktT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A4E20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNF5f-0001ut-2s
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEfm-0005xf-0i
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEfi-0001bp-53
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:19:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52032
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEfg-0001b3-5q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571829559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Jts3e9l2ylTadIAJh1BkTXV8OTL4o3m8xGmEG2sLsg=;
 b=i/171ktTLGrD69tBBhQvL9vJVFDiWTqisDAwByC2wxl/cEIU6Ma6mTG95+Amkp3tqbrfFA
 yXHc4PCGYH/fAJI3GT8FcW0LBFEjtIUOknM+Xwmi9djfmS97bvsVCo6kujcLsH1//Tmdd3
 h7zsm+huSe0iX+GeoFZnyYkZORLCP94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-QAc8rRGXM_2sSTxbWXizWQ-1; Wed, 23 Oct 2019 07:19:17 -0400
Received: by mail-wm1-f71.google.com with SMTP id k9so8659060wmb.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GbMPl5h6OvyoA03HzLo1GmohD/3Urvdfg+1Kb3wnqP8=;
 b=lQkmwL4Qjlef/j7J4ABna99GoRq5+tH6++rF7d35mj7Ne/mwAOM0+yPFP0qg2R15di
 x3cJ32myElLWU+KyfQeWZEPUslKe8cUUvPGBWZn4uFdkVCpcvbh7dbqy2Yq6x103Ac3m
 zxZqkKtiwXH+bU7T8z9cvoMsGyCSiuVIzDY/VJDpq/CXhipuLEHA/tpSwIYMDRJMESiS
 nIzU1sEMZlGP5KokpGmxPuJR/0KUe0K/4gxUc11v4A30MJTfzkyBnUehxzR/JNXD/aSe
 204L/jrt6O5PRv+EZn2AnAdhxOdJXiOhiAO64a9YJAGpGfk2PDlqBozJVcaxgnaKmF26
 VclQ==
X-Gm-Message-State: APjAAAVBnPo5gUE9eEBKlFfwC4WZN2pmDGnNYZsARyEYGE5VDW8WweYE
 AGzZwsSmtyd5P6NfQK1gbmwb1klUpTB7K9AsHi2d9SJBe4jXQXcvjBL9+Cuit4q4BoVUnINo9hN
 66Z6iFBOfy7/+lqc=
X-Received: by 2002:a5d:628e:: with SMTP id k14mr7861702wru.60.1571829556431; 
 Wed, 23 Oct 2019 04:19:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzc37GrnPGjCWfKzzzrAthzS3ZBnsCrgZSMwjjsWesF8GkRpW836WW0VdMbTQNO9BxCiRqWxg==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr7861688wru.60.1571829556228; 
 Wed, 23 Oct 2019 04:19:16 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id r1sm15711961wrw.60.2019.10.23.04.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:19:15 -0700 (PDT)
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b4c6e217-05e4-a87d-7e5e-116b0259808b@redhat.com>
Date: Wed, 23 Oct 2019 13:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022163812.330-5-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: QAc8rRGXM_2sSTxbWXizWQ-1
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

On 10/22/19 6:38 PM, C=C3=A9dric Le Goater wrote:
> We will use it to reset the interrupt presenter from the CPU reset
> handler.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   include/hw/ppc/pnv_core.h | 3 +++
>   hw/ppc/pnv_core.c         | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index bfbd2ec42aa6..55eee95104da 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -31,6 +31,8 @@
>   #define PNV_CORE_GET_CLASS(obj) \
>        OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
>  =20
> +typedef struct PnvChip PnvChip;
> +
>   typedef struct PnvCore {
>       /*< private >*/
>       CPUCore parent_obj;
> @@ -38,6 +40,7 @@ typedef struct PnvCore {
>       /*< public >*/
>       PowerPCCPU **threads;
>       uint32_t pir;
> +    PnvChip *chip;
>  =20
>       MemoryRegion xscom_regs;
>   } PnvCore;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 9f981a4940e6..cc17bbfed829 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>                                   "required link 'chip' not found: ");
>           return;
>       }
> +    pc->chip =3D PNV_CHIP(chip);
>  =20
>       pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>       for (i =3D 0; i < cc->nr_threads; i++) {
> @@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>       }
>  =20
>       for (j =3D 0; j < cc->nr_threads; j++) {
> -        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
> +        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
>           if (local_err) {
>               goto err;
>           }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


