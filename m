Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41991C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E95C22200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hY2DCkVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E95C22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUREx-0007p2-F6
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kURBG-0004nr-FY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kURB9-0006Dy-Lz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrpPQd5p0rc5eZWEDvEMiOOOTeVEpn9h+d8SwjCUmY0=;
 b=hY2DCkVFJU94seDgI3dsfgsR9j1uapmuDAoTqjhuCdNo3JNLljU6vysXiQD+ssu8jMcOaF
 nX6iLqH5x//hAr4Cqh2bXNwxH93Dqnzq+daU7ZOI2CncJlfC+b82aenh8XwHubMmR0psju
 r6HOIz3f+r49F9gw8kChRgFG/HzzvR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-bUD0mWfhOZeXKrPjxqg5Nw-1; Mon, 19 Oct 2020 05:10:05 -0400
X-MC-Unique: bUD0mWfhOZeXKrPjxqg5Nw-1
Received: by mail-wm1-f69.google.com with SMTP id u207so4334130wmu.4
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KrpPQd5p0rc5eZWEDvEMiOOOTeVEpn9h+d8SwjCUmY0=;
 b=ee+ycFF4STTH7hYk4hOMYLFhuuAwfpGKV3k9X3dEdBXm0EKNQdBpL6+qBMvs3wBgu2
 R3kLoViruRMrECfWGFkQ2ICP4k1gnHmxd6zCsSbs43aM5arlRvNHH269ctWd94T9jSKf
 OHQTi5pMnIzS7hFEfFBRuCy3/0hkJTJA/fwNlpeC8NkBnMLJsqsICJUEeKwvPpVLGgfA
 BUfGLydnyDfaaljAVFew/RAa+txtqkhm/WSXkMYmACP+LGaIfwUroUwHe3/C5fKBYWFR
 ZUhugq7/vAm6ZwXPFIioQ7jZ9wRMI/pETmw7C6eiw32vTYzO77xxfpNAjiC037QmqpJx
 f8yg==
X-Gm-Message-State: AOAM533I3pI0r8DPYG5t8/tXuZAz/S6vFt/Iof9L/4cTOAQGrJKA8zPN
 7j0E5ftMdcdVvLv9YfpBdOy6adMkVJI8AG38RTm1aUslORjvlFcUUIxNO4uy0VVy/xXvo8CqTUA
 t3mPJCGrq16BNayk=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr16999915wms.77.1603098603881; 
 Mon, 19 Oct 2020 02:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEILTCYgkJJ2kjlcd8nzP4Ef1xe9ptOJ0H/GKMbczuovCmJTaP6vVDjAsYQxFUxaYahOZ4HQ==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr16999880wms.77.1603098603625; 
 Mon, 19 Oct 2020 02:10:03 -0700 (PDT)
Received: from [192.168.1.36] (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id a8sm2126219wmj.31.2020.10.19.02.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 02:10:03 -0700 (PDT)
Subject: Re: [PATCH 5/5] spapr: Simplify error handling in spapr_memory_plug()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309734178.2739814.3488437759887793902.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26919105-d4eb-352f-d4e4-31649efd1f85@redhat.com>
Date: Mon, 19 Oct 2020 11:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160309734178.2739814.3488437759887793902.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 10:49 AM, Greg Kurz wrote:
> As recommended in "qapi/error.h", add a bool return value to
> spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
> of local_err in spapr_memory_plug().
> 
> This allows to get rid of the error propagation overhead.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr.c                |   23 ++++++++++-------------
>   hw/ppc/spapr_nvdimm.c         |    5 +++--
>   include/hw/ppc/spapr_nvdimm.h |    2 +-
>   3 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 62f217a6b914..0cc19b5863a4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3382,7 +3382,7 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>       return 0;
>   }
>   
> -static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
> +static bool spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                              bool dedicated_hp_event_source, Error **errp)
>   {
>       SpaprDrc *drc;
> @@ -3403,7 +3403,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                                         addr / SPAPR_MEMORY_BLOCK_SIZE);
>                   spapr_drc_detach(drc);
>               }
> -            return;
> +            return false;
>           }
>           if (!hotplugged) {
>               spapr_drc_reset(drc);
> @@ -3425,12 +3425,12 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                                              nr_lmbs);
>           }
>       }
> +    return true;
>   }
>   
>   static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp)
>   {
> -    Error *local_err = NULL;
>       SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
>       PCDIMMDevice *dimm = PC_DIMM(dev);
>       uint64_t size, addr;
> @@ -3444,27 +3444,24 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       if (!is_nvdimm) {
>           addr = object_property_get_uint(OBJECT(dimm),
>                                           PC_DIMM_ADDR_PROP, &error_abort);
> -        spapr_add_lmbs(dev, addr, size,
> -                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> -                       &local_err);
> +        if (!spapr_add_lmbs(dev, addr, size,
> +                            spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT), errp)) {
> +            goto out_unplug;
> +        }
>       } else {
>           slot = object_property_get_int(OBJECT(dimm),
>                                          PC_DIMM_SLOT_PROP, &error_abort);
>           /* We should have valid slot number at this point */
>           g_assert(slot >= 0);
> -        spapr_add_nvdimm(dev, slot, &local_err);
> -    }
> -
> -    if (local_err) {
> -        goto out_unplug;
> +        if (!spapr_add_nvdimm(dev, slot, errp)) {
> +            goto out_unplug;
> +        }
>       }
>   
>       return;
>   
>   out_unplug:
>       pc_dimm_unplug(dimm, MACHINE(ms));
> -out:
> -    error_propagate(errp, local_err);
>   }
>   
>   static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 9e3d94071fe1..a833a63b5ed3 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -89,7 +89,7 @@ bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
>   }
>   
>   
> -void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
> +bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
>   {
>       SpaprDrc *drc;
>       bool hotplugged = spapr_drc_hotplugged(dev);
> @@ -98,12 +98,13 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
>       g_assert(drc);
>   
>       if (!spapr_drc_attach(drc, dev, errp)) {
> -        return;
> +        return false;
>       }
>   
>       if (hotplugged) {
>           spapr_hotplug_req_add_by_index(drc);
>       }
> +    return true;
>   }
>   
>   static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
> diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
> index 490b19a009f4..344582d2f5f7 100644
> --- a/include/hw/ppc/spapr_nvdimm.h
> +++ b/include/hw/ppc/spapr_nvdimm.h
> @@ -30,6 +30,6 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>   void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
>   bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
>                              uint64_t size, Error **errp);
> -void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
> +bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);

Maybe document the returned value?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   
>   #endif
> 
> 
> 


