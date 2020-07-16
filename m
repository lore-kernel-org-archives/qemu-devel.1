Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0EAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F66C206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJX8ZhJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F66C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxmD-0003PD-GG
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxle-0002rx-Ge
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:53:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxlc-0001QO-0C
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594882394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOSW9FU+hR+QTQwnBMpD1V1aqjHzvWgQvl6NB6VHdZA=;
 b=VJX8ZhJxqwRRal9t4lVxYn4YSIeDVxpLYMySUmEtv/8LQwnpEfvA0SLbiYkqNPVH2h6tnJ
 kp/JlPEELo06j1NzMjsyvEfUuF+7576A0p4WpAL1YM7NHjJyeA5FcMvreyWhKmfBk2bamV
 hYulhbbq68SOyac7zFiFSdKuo4FKL78=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-hiHly5iOO9C5G8lG3Quc9g-1; Thu, 16 Jul 2020 02:53:12 -0400
X-MC-Unique: hiHly5iOO9C5G8lG3Quc9g-1
Received: by mail-wr1-f72.google.com with SMTP id o25so4761702wro.16
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 23:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iOSW9FU+hR+QTQwnBMpD1V1aqjHzvWgQvl6NB6VHdZA=;
 b=t02emPZnshsPQT/p9pis3tkRxoVq8RPWqRNxqjUJLRnuII1k+tbs63rbQ/H0On+T40
 4WpevCH2gUjvjEbAcAYvU0s7x4rzkFxerZzNFzUQqIP7zgrOQ+CEahq5zouT+kmKNjqQ
 pS+iRn+/OYY6tyJesVPIKaEbjdB4ourVskNSu5GW2kYNLm5Q8mie5c/WNT3/5GuQltFv
 sx1ooiZwaaDUxYuCmKKTTNoHs3a1gqrM/GhSUA38pVf3C47Dzg0tFZPh1pxVOi9UxqM5
 0MVabeiE23BHOh+QDIn+FVCV4wUNvMtSbUD910neMgqabGvhDW40uQisVGkni5kixs/F
 IS6Q==
X-Gm-Message-State: AOAM532a8sUEIDNbGtTnZh5M1Df8JYD2OxXumAT3YU79baGKybnCjxTH
 9X5LTBDZaVcVA7WzthyugQKzbDNmSwoG0hlrZk7vKS1RbpH494ZsdGm7V4DC2PNObRnt4x1T0zD
 5dWnNRFiYXvbEhU0=
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr3631266wrn.9.1594882390970;
 Wed, 15 Jul 2020 23:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaQJvbZaAsIb9DSohIgN+bH0sBoT1t0F9SDV4aDt5dPDA4FJRQ3+VMlulU9wPd3EiZdocshw==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr3631244wrn.9.1594882390665;
 Wed, 15 Jul 2020 23:53:10 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 h5sm7569101wrc.97.2020.07.15.23.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 23:53:09 -0700 (PDT)
Date: Thu, 16 Jul 2020 02:53:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716025009-mutt-send-email-mst@kernel.org>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> Some recent error handling cleanups unveiled issues with our support of
> PCI bridges:
> 
> 1) QEMU aborts when using non-standard PCI bridge types,
>    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"
> 
> $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> Unexpected error in object_property_find() at qom/object.c:1240:
> qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
> Aborted (core dumped)
> 
> This happens because we assume all PCI bridge types to have a "chassis_nr"
> property. This property only exists with the standard PCI bridge type
> "pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
> much simpler to check the presence of "chassis_nr" earlier.
> 
> 2) QEMU abort if same "chassis_nr" value is used several times,
>    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
>    object_property_add() & friends"
> 
> $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=1 \
>                         -device pci-bridge,chassis_nr=1
> Unexpected error in object_property_try_add() at qom/object.c:1167:
> qemu-system-ppc64: -device pci-bridge,chassis_nr=1: attempt to add duplicate property '40000100' to object (type 'container')
> Aborted (core dumped)
> 
> This happens because we assume that "chassis_nr" values are unique, but
> nobody enforces that and we end up generating duplicate DRC ids. The PCI
> code doesn't really care for duplicate "chassis_nr" properties since it
> is only used to initialize the "Chassis Number Register" of the bridge,
> with no functional impact on QEMU. So, even if passing the same value
> several times might look weird, it never broke anything before, so
> I guess we don't necessarily want to enforce strict checking in the PCI
> code now.
> 
> Workaround both issues in the PAPR code: check that the bridge has a
> unique and non null "chassis_nr" when plugging it into its parent bus.
> 
> Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>



> ---
>  hw/ppc/spapr_pci.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 329002ac040e..09d52ef7954d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1480,6 +1480,57 @@ static void spapr_pci_bridge_plug(SpaprPhbState *phb,
>      add_drcs(phb, bus);
>  }
>  
> +/* Returns non-zero if the value of "chassis_nr" is already in use */
> +static int check_chassis_nr(Object *obj, void *opaque)
> +{
> +    int new_chassis_nr =
> +        object_property_get_uint(opaque, "chassis_nr", &error_abort);
> +    int chassis_nr =
> +        object_property_get_uint(obj, "chassis_nr", NULL);
> +
> +    if (!object_dynamic_cast(obj, TYPE_PCI_BRIDGE)) {
> +        return 0;
> +    }
> +
> +    /* Skip unsupported bridge types */
> +    if (!chassis_nr) {
> +        return 0;
> +    }
> +
> +    /* Skip self */
> +    if (obj == opaque) {
> +        return 0;
> +    }
> +
> +    return chassis_nr == new_chassis_nr;
> +}
> +
> +static bool bridge_has_valid_chassis_nr(Object *bridge, Error **errp)

I would rename this "bridge_has_unique_chassis_nr".

> +{
> +    int chassis_nr =
> +        object_property_get_uint(bridge, "chassis_nr", NULL);
> +
> +    /*
> +     * slotid_cap_init() already ensures that "chassis_nr" isn't null for
> +     * standard PCI bridges, so this really tells if "chassis_nr" is present
> +     * or not.
> +     */
> +    if (!chassis_nr) {
> +        error_setg(errp, "PCI Bridge lacks a \"chassis_nr\" property");
> +        error_append_hint(errp, "Try -device pci-bridge instead.\n");
> +        return false;
> +    }
> +
> +    /* We want unique values for "chassis_nr" */
> +    if (object_child_foreach_recursive(object_get_root(), check_chassis_nr,
> +                                       bridge)) {
> +        error_setg(errp, "Bridge chassis %d already in use", chassis_nr);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void spapr_pci_plug(HotplugHandler *plug_handler,
>                             DeviceState *plugged_dev, Error **errp)
>  {
> @@ -1491,6 +1542,12 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
>      PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
>      uint32_t slotnr = PCI_SLOT(pdev->devfn);
>  
> +    if (pc->is_bridge) {
> +        if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
> +            return;
> +        }
> +    }
> +


Add a comment here explaning DRC ids are generated from chassis_nr and
these need to be unique?


>      /* if DR is disabled we don't need to do anything in the case of
>       * hotplug or coldplug callbacks
>       */
>

With above fixed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>
 
Feel free to merge.


