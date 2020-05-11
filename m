Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97FC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B385B206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="W7wdij3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B385B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8pR-00078P-Hh
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jY8fu-0007Cn-5m
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:40:54 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:59044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jY8fs-0002MQ-RO
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1589204452;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9oTiTTjCyUNvNnSlPh1UEle4mQ5Pfvepo/yfLiBn9CM=;
 b=W7wdij3LsDPx17+Z99EGjobUSQbWr0cPGn5/6YZ4dfoPAPuVGydtsLm3
 5IHoTbi6SG6uTGIK134d1w3dZXd6K77lA9+8HCivgAMFTM5SIqwtV8aY1
 5q51wNV4uRnu65ZQCzUcgfLjODjg5l4wJ9SKHINZuIKKIiq1bvI+mxRtY Q=;
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com;
 dmarc=pass (p=none dis=none) d=citrix.com
IronPort-SDR: v4HspzHLgAwb5U+o8xK7e97+x5w+49kXorekB1vj78YFEH9Wd9qlRxlXJJL+0asnvYjx2qPUM5
 pibhlWrrGhEHVITsOSnh2VOm6PteQbcD606OPKE7rAViWuCoi87vxhQ1J6hDaBqz9QlTchTTu5
 pTsdOzlboZwc/3C4gj2zhYZJcb1lkF/HYMEpl+Qv+dgsA7kX0tkA8g9r/jVdwvqeO+lR105Vr+
 vE5jtb+NTwUSKQIvR1pRlcmo+oUwiYvbQEF4J0vQF4BCbkbNOijMsGsCj3ASwBurOY8Rzefa95
 +1E=
X-SBRS: 2.7
X-MesageID: 17496335
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,380,1583211600"; d="scan'208";a="17496335"
Date: Mon, 11 May 2020 14:40:43 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Roger Pau Monne <roger.pau@citrix.com>
Subject: Re: [PATCH] xen: fix build without pci passthrough
Message-ID: <20200511134043.GH2116@perard.uk.xensource.com>
References: <20200504101443.3165-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504101443.3165-1-roger.pau@citrix.com>
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=anthony.perard@citrix.com; helo=esa5.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 09:40:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 12:14:43PM +0200, Roger Pau Monne wrote:
> has_igd_gfx_passthru is only available when QEMU is built with
> CONFIG_XEN_PCI_PASSTHROUGH, and hence shouldn't be used in common
> code without checking if it's available.
> 
> Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an accelerator property')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org
> ---
>  hw/xen/xen-common.c | 4 ++++
>  hw/xen/xen_pt.h     | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index a15070f7f6..c800862419 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -127,6 +127,7 @@ static void xen_change_state_handler(void *opaque, int running,
>      }
>  }
>  
> +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
>  static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
>  {
>      return has_igd_gfx_passthru;
> @@ -136,6 +137,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
>  {
>      has_igd_gfx_passthru = value;
>  }
> +#endif
>  
>  static void xen_setup_post(MachineState *ms, AccelState *accel)
>  {
> @@ -197,11 +199,13 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
>  
>      compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
>  
> +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
>      object_class_property_add_bool(oc, "igd-passthru",
>          xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
>          &error_abort);
>      object_class_property_set_description(oc, "igd-passthru",
>          "Set on/off to enable/disable igd passthrou", &error_abort);
> +#endif

It might not be a good idea to have the presence of class property
depending on what is built-in. Instead, I think it would be better to
return an error when QEMU is built without xen_pt and a user is trying
to enable it. That can be done by calling by calling error_setg(errp,
"nop") in xen_set_igd_gfx_passthru().

>  }
>  
>  #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> index 179775db7b..660dd8a008 100644
> --- a/hw/xen/xen_pt.h
> +++ b/hw/xen/xen_pt.h
> @@ -1,6 +1,7 @@
>  #ifndef XEN_PT_H
>  #define XEN_PT_H
>  
> +#include "qemu/osdep.h"

Why do you need osdep?

>  #include "hw/xen/xen_common.h"
>  #include "hw/pci/pci.h"
>  #include "xen-host-pci-device.h"
> @@ -322,7 +323,13 @@ extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
>                                              unsigned int domain,
>                                              unsigned int bus, unsigned int slot,
>                                              unsigned int function);
> +
> +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
>  extern bool has_igd_gfx_passthru;
> +#else
> +# define has_igd_gfx_passthru false
> +#endif

I don't quite like the use of define here. Could you introduce a
function that return a bool instead? And defining that function in
hw/xen/xen.h like xen_enabled() would be fine I think.

Thanks,

-- 
Anthony PERARD

