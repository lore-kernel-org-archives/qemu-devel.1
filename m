Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B640BC352A3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DFF20726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr2U1gnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DFF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izxYN-0006zF-NF
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 01:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izxXM-0006L4-Hk
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izxXL-0000UD-Ge
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:54:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izxXL-0000QG-DE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581058475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGR2bZ6i2S7xrJBq7XLMDAlyvfm/ueehCY6o9BKqukk=;
 b=Yr2U1gnHlpPbzNm9guRntHuoPUeuHKbcVnKUN6JpZIx3OG4qMYou9YdhQhv18//NdG0WCt
 HeXLldEPeqglIfksk7c/fjdPhD6zWv+thUmHFbtJs2190u0NyAnALQkJLBhBOzJqsI8F0h
 tvq848gXkkbFX66YcIZH6GjBRz330DQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-SiAeXkc3MPK6Z4Tswt_FGw-1; Fri, 07 Feb 2020 01:54:32 -0500
Received: by mail-qk1-f198.google.com with SMTP id k10so795121qki.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 22:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hNZHeIci6le4TqKLg+LjwYuqZ3I22qUa3x88wMJGoYs=;
 b=tnIZ1DSNjgMO+iAkVLrOInn8x/FXT/fJe7Fu9PKY/TeW5o1eX6S6pwxtcMatY23Hss
 QVConXfsBni4hkJve+JylhRG7sSrzEu+JaYW8yDrWLSr83NhFkthWo+P8EyFc1Lc14Xu
 OybaCUdTJUQu5Ok2s1X0UNsdOVOmsS0Ns7ygYdN1O/c1l/Wu9uj0bGqCMhC2kJ+527VQ
 w7junUKOMpUvtZA10my3Xx8QzAboZgN8kWWN1U86dXAi+PsdaTN2Z9/sFttdqHi7Y/6O
 uCrzhwLkvfPnYJqQZIUcichz7eRXN1chjxi+gCYSM2j5cviWIlBf/kFBT2DfT2ejc41O
 ht0w==
X-Gm-Message-State: APjAAAUzFeZjrgwK5tnX1Qas9Jz3u2DCKR6wRHrNZPfrET/eO3TGG+Ae
 oqUIkbmozm1B9pTndTM8mQ1L9biM9sXJHb4NVUuwdJO5PHG8pzzuwHL4Na4zgGtu09l2RmgNSsV
 ibicyrbGzAF0dqOM=
X-Received: by 2002:a0c:fac1:: with SMTP id p1mr5708164qvo.231.1581058471563; 
 Thu, 06 Feb 2020 22:54:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx78v0sDjFhNeUzMLbXLZboFn4UNWzExgeuptEAi3GZXSs1Wd8t+ySfA5RxIwJv8uNAGwDd4A==
X-Received: by 2002:a0c:fac1:: with SMTP id p1mr5708149qvo.231.1581058471218; 
 Thu, 06 Feb 2020 22:54:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id s20sm865861qkg.131.2020.02.06.22.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:54:30 -0800 (PST)
Date: Fri, 7 Feb 2020 01:54:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] spapr: Disable legacy virtio devices for pseries-5.0
 and later
Message-ID: <20200207013757-mutt-send-email-mst@kernel.org>
References: <20200207043055.218856-1-david@gibson.dropbear.id.au>
 <20200207043055.218856-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20200207043055.218856-2-david@gibson.dropbear.id.au>
X-MC-Unique: SiAeXkc3MPK6Z4Tswt_FGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pair@us.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, mdroth@us.ibm.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 03:30:54PM +1100, David Gibson wrote:
> PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> the guess mostly like classic PCI, even if some of the individual
> devices on the bus are PCI Express.  One consequence of that is that
> virtio-pci devices still default to being in transitional mode, though
> legacy mode is now disabled by default on current q35 x86 machine
> types.
>=20
> Legacy mode virtio devices aren't really necessary any more, and are
> causing some problems for future changes.  Therefore, for the
> pseries-5.0 machine type (and onwards), switch to modern-only
> virtio-pci devices by default.

It's worth noting in the commit log that this disables support
for guests older than Linux 4.0.

>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c9b2e0a5e0..216d3b34dc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -65,6 +65,7 @@
> =20
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
> +#include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/vhost-scsi-common.h"
> =20
> @@ -4512,7 +4513,14 @@ static const TypeInfo spapr_machine_info =3D {
>   */
>  static void spapr_machine_5_0_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class *=
/
> +    /* Most defaults for the latest behaviour are inherited from the
> +     * base class, but we need to override the (non ppc specific)
> +     * default behaviour for virtio */
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> +    };
> +
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> =20
>  DEFINE_SPAPR_MACHINE(5_0, "5.0", true);

So this sets the defaults, right?

Problem is we'll then need to remember to carry this in the latest
call. If we forget we get a mess.

How about adding a call to e.g. spapr_machine_latest_class_options
in DEFINE_SPAPR_MACHINE?
Then spapr_machine_latest_class_options can set the per-machine
defaults.

I send a patch for this:
=09[PATCH] ppc: function to setup latest class options
feel free to reuse.


> @@ -4523,11 +4531,15 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
>  static void spapr_machine_4_2_class_options(MachineClass *mc)
>  {
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> +    };
> =20
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> --=20
> 2.24.1


