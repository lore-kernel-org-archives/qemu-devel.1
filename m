Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1613CC2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D772B206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrR3lMwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D772B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iebYL-0003RL-UU
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 04:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iebXg-0002ud-Tl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iebXf-00047z-Qn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:10:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37549
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iebXf-00047X-NG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575969051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXhaKz5t0SnmdGGWEp19gAGZ5Jhfzdl8xxTalkAiyCM=;
 b=FrR3lMwdT27jnGWmkBAqofznitoDSqTZsXL0E1lyVR7NDDsLYb601arlz71SgKbuJfvpI3
 a4QaP12mbkPYVG60bxZol+CL1nBCX6gLgocCb/U4F5CkdvjqUiHaeuTVENki7gHcbFvFOE
 M2bynN/gzdkbi53aMzzB2qDsF9jyn0w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-cRy1oV7FNJqrlE1ptafbFw-1; Tue, 10 Dec 2019 04:10:50 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so8661437wrm.17
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 01:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F8EemnXVmh3q0qbc4kn14DfmQcPahbm4unXi1nZ9NCc=;
 b=Ii0ug5LHy92iUomapGo+18ttEpJLr2ykQ4nr5JLjvgIh5sekuf8n4Ltc5Vy1Sergmq
 lfRbbREVIUWgcaRh14PqKR5OISb9vjfoQ/ULpqFNdXqVxKAy5JypmBWdy6rNw7ATy61a
 SnD/q7tNGPSbN2JyLvk4+QeijwpTaG90mbXRu6jx3CM2oN18Q+soQ3EDtAgcUhpuao3w
 FOVB95kgFrvfJdgk1OiQ4uuGF/T5bwqkoEpmGqwiuF8F4YP/JTTTUWrMHNslyOotX+cq
 gMgG3G02Tq9S/yrCtheQWla6J3Bd+VxufssnHWU2DzRWg/9nJcTWcwjojB5HD5Wi9gVm
 OqAw==
X-Gm-Message-State: APjAAAWhr/xWPyCRFYb+gWx+gxGrbsQgGJq3CTDx9zMv3BaRhubxFt1w
 zFT0OlYtZvyWjIi8BoDz3jAriRS1jK/qXdSvOGKfmd03pwljud2dyrXimxRGDS3d1qut05oZWFC
 F2lNGZ3qvsuNAHCY=
X-Received: by 2002:adf:ee45:: with SMTP id w5mr1867370wro.352.1575969048584; 
 Tue, 10 Dec 2019 01:10:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzR9lo1IU2hc4RwXyb2OWIY3dWQOIEHWCmgxi3Wn0LP+FuJOdDyNSPuyRA9X8RdvHG17r6jYQ==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr1867348wro.352.1575969048362; 
 Tue, 10 Dec 2019 01:10:48 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z6sm2660313wrw.36.2019.12.10.01.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 01:10:47 -0800 (PST)
Subject: Re: [PATCH] ppc: Drop useless extern annotation for functions
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157596536058.115682.18155243603867418789.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49c6ac09-d047-0b51-147f-1e07a27adf22@redhat.com>
Date: Tue, 10 Dec 2019 10:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157596536058.115682.18155243603867418789.stgit@bahia.lan>
Content-Language: en-US
X-MC-Unique: cRy1oV7FNJqrlE1ptafbFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/19 9:09 AM, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   include/hw/ppc/pnv_xscom.h |   22 +++++++++++-----------
>   include/hw/ppc/spapr_vio.h |    6 +++---
>   2 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index a40d2a2a2a98..1c1d76bf9be5 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -109,16 +109,16 @@ typedef struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>   #define PNV10_XSCOM_PSIHB_SIZE     0x100
>  =20
> -extern void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp=
);
> -extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
> -
> -extern void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
> -                                    MemoryRegion *mr);
> -extern void pnv_xscom_region_init(MemoryRegion *mr,
> -                                  struct Object *owner,
> -                                  const MemoryRegionOps *ops,
> -                                  void *opaque,
> -                                  const char *name,
> -                                  uint64_t size);
> +void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
> +int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
> +
> +void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
> +                             MemoryRegion *mr);
> +void pnv_xscom_region_init(MemoryRegion *mr,
> +                           struct Object *owner,
> +                           const MemoryRegionOps *ops,
> +                           void *opaque,
> +                           const char *name,
> +                           uint64_t size);
>  =20
>   #endif /* PPC_PNV_XSCOM_H */
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index 72762ed16b70..ce6d9b0c6605 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -80,10 +80,10 @@ struct SpaprVioBus {
>       uint32_t next_reg;
>   };
>  =20
> -extern SpaprVioBus *spapr_vio_bus_init(void);
> -extern SpaprVioDevice *spapr_vio_find_by_reg(SpaprVioBus *bus, uint32_t =
reg);
> +SpaprVioBus *spapr_vio_bus_init(void);
> +SpaprVioDevice *spapr_vio_find_by_reg(SpaprVioBus *bus, uint32_t reg);
>   void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt);
> -extern gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
> +gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
>  =20
>   static inline void spapr_vio_irq_pulse(SpaprVioDevice *dev)
>   {
>=20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


