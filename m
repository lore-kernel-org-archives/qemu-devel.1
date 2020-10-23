Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12073C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F6F20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lwvk2gwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F6F20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2a8-0005f5-Tw
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 15:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2ZU-00057M-E4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2ZS-0006aj-FU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603480669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0UI5B+lNVPLNsg8mJYzIPlP7Rb9OmyK0EgoNbSZVA0=;
 b=Lwvk2gwPCwGFlGjDboYs+jcQ71eU3mNsMNUGb2wPRxlJyRE0dwjdSHTNGBhPH2NcC4P7bK
 iaqHqOHDJ1AP4xAjQnkqa7XMPEo0b4mFkFd0i0gfCXcbbrSrUHKu5E7S4jB4AhzngY/wYT
 AFItfl9h0jAy+uXfCZ33K5ywhyKPTsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-PZ9Kv0UpNQ67fX6-a4zeVA-1; Fri, 23 Oct 2020 15:17:47 -0400
X-MC-Unique: PZ9Kv0UpNQ67fX6-a4zeVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08B9564156;
 Fri, 23 Oct 2020 19:17:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67B919CBA4;
 Fri, 23 Oct 2020 19:17:39 +0000 (UTC)
Date: Fri, 23 Oct 2020 21:17:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 5/5] spapr: Simplify error handling in spapr_memory_plug()
Message-ID: <20201023211738.7ee925fd@redhat.com>
In-Reply-To: <160309734178.2739814.3488437759887793902.stgit@bahia.lan>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309734178.2739814.3488437759887793902.stgit@bahia.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 10:49:01 +0200
Greg Kurz <groug@kaod.org> wrote:

> As recommended in "qapi/error.h", add a bool return value to
> spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
> of local_err in spapr_memory_plug().
> 
> This allows to get rid of the error propagation overhead.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
you won't need this patch if check from spapr_drc_attach() were
moved to _pre_plug() time.

> ---
>  hw/ppc/spapr.c                |   23 ++++++++++-------------
>  hw/ppc/spapr_nvdimm.c         |    5 +++--
>  include/hw/ppc/spapr_nvdimm.h |    2 +-
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 62f217a6b914..0cc19b5863a4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3382,7 +3382,7 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>      return 0;
>  }
>  
> -static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
> +static bool spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                             bool dedicated_hp_event_source, Error **errp)
>  {
>      SpaprDrc *drc;
> @@ -3403,7 +3403,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                                        addr / SPAPR_MEMORY_BLOCK_SIZE);
>                  spapr_drc_detach(drc);
>              }
> -            return;
> +            return false;
>          }
>          if (!hotplugged) {
>              spapr_drc_reset(drc);
> @@ -3425,12 +3425,12 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                                             nr_lmbs);
>          }
>      }
> +    return true;
>  }
>  
>  static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                Error **errp)
>  {
> -    Error *local_err = NULL;
>      SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      uint64_t size, addr;
> @@ -3444,27 +3444,24 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      if (!is_nvdimm) {
>          addr = object_property_get_uint(OBJECT(dimm),
>                                          PC_DIMM_ADDR_PROP, &error_abort);
> -        spapr_add_lmbs(dev, addr, size,
> -                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> -                       &local_err);
> +        if (!spapr_add_lmbs(dev, addr, size,
> +                            spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT), errp)) {
> +            goto out_unplug;
> +        }
>      } else {
>          slot = object_property_get_int(OBJECT(dimm),
>                                         PC_DIMM_SLOT_PROP, &error_abort);
>          /* We should have valid slot number at this point */
>          g_assert(slot >= 0);
> -        spapr_add_nvdimm(dev, slot, &local_err);
> -    }
> -
> -    if (local_err) {
> -        goto out_unplug;
> +        if (!spapr_add_nvdimm(dev, slot, errp)) {
> +            goto out_unplug;
> +        }
>      }
>  
>      return;
>  
>  out_unplug:
>      pc_dimm_unplug(dimm, MACHINE(ms));
> -out:
> -    error_propagate(errp, local_err);
>  }
>  
>  static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 9e3d94071fe1..a833a63b5ed3 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -89,7 +89,7 @@ bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
>  }
>  
>  
> -void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
> +bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
>  {
>      SpaprDrc *drc;
>      bool hotplugged = spapr_drc_hotplugged(dev);
> @@ -98,12 +98,13 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
>      g_assert(drc);
>  
>      if (!spapr_drc_attach(drc, dev, errp)) {
> -        return;
> +        return false;
>      }
>  
>      if (hotplugged) {
>          spapr_hotplug_req_add_by_index(drc);
>      }
> +    return true;
>  }
>  
>  static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
> diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
> index 490b19a009f4..344582d2f5f7 100644
> --- a/include/hw/ppc/spapr_nvdimm.h
> +++ b/include/hw/ppc/spapr_nvdimm.h
> @@ -30,6 +30,6 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>  void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
>  bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
>                             uint64_t size, Error **errp);
> -void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
> +bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
>  
>  #endif
> 
> 


