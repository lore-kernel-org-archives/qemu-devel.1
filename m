Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45AEC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD4A20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="No6Bd196"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD4A20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGSb-0003EA-J6
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieGRw-0002et-2a
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieGRu-0000dc-SQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:39:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieGRu-0000dK-P9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575887970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WlPLQEtspZUkNR0y4t+3P/dWfqO1encB2iQTeCfS9I=;
 b=No6Bd196SVYrv3OC+SD7YkDB47Lhj11Bztov530H/RX6djpdjFvEatewhrkCVChGRnZA0M
 9W9+T2A2t2KYjgcey7UcksmYuzfKVi5Grv5yV88d5dZhSBRC3ePRg0m9kqJoJI0E+yP5F4
 K6oMvdu63zgxb8CsCyleAOXngxPkLSc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-wUAURK0zM5WM8M5NcFxEwA-1; Mon, 09 Dec 2019 05:39:25 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so6562017wrm.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 02:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=37PzRRb96EmE565UKk5K5Sle2KLqEF/Osq1v4/uQF1U=;
 b=res+gw7PjD4wYs0ro6U4Lly7R4JPzX38oV/7GtdXsz9p1XCdB3jtQh7acSiFD+14jt
 Pe16mgJj9pFp4CHwSq+zywFnr12frd4WPyV+MTPsj06t7ALl1k12ERUtfyj3WQGpbGaK
 SB7UjDwZUs7fiNGxInyYinUYNGpSepq2INNEnjliAhGX3IYGYN52lxIqaQQXhECsrXbU
 IBsY+qvNUD3zcVd8qFdLEvwVVxAFtQapNszYKgYFKPlG8VtNN2xHdInZ9E5FrKkAen1Q
 JGgd7URMjbdwdVEKFwxInkIISADTxbedfOLvfHlk6+U2q/mTc17Dc2wmH2krf1RqAxHy
 hxTw==
X-Gm-Message-State: APjAAAUa6VungBxTsry8eWdex7Skzi78LtEHthyoO+EyICm8734rzVV+
 ahsP+xYC3Rc9iuh/0r2BKgg0bNEsva8mAu4Op2gcxCUF5w8UbaqWpem1WUCC9EZhxC1dtFYXrQN
 Q1UJecnHJtieAqXo=
X-Received: by 2002:a1c:2e91:: with SMTP id
 u139mr22884113wmu.154.1575887964364; 
 Mon, 09 Dec 2019 02:39:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfP6BHvCad51bpoAe7dzTInHZw6capU81LLD9rqlQDM7kuvwLPfzyGGVsC9nfgYCgVqKFnWw==
X-Received: by 2002:a1c:2e91:: with SMTP id
 u139mr22884071wmu.154.1575887964061; 
 Mon, 09 Dec 2019 02:39:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id v188sm13618269wma.10.2019.12.09.02.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 02:39:23 -0800 (PST)
Subject: Re: [PATCH-for-5.0 v3 6/6] hw/pci-host: Add Kconfig entry to select
 the IGD Passthrough Host Bridge
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-7-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b4c7637-ffc1-102e-7f29-2568831eb20c@redhat.com>
Date: Mon, 9 Dec 2019 11:39:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191209095002.32194-7-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: wUAURK0zM5WM8M5NcFxEwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 10:50, Philippe Mathieu-Daud=C3=A9 wrote:
> Add the XEN_IGD_PASSTHROUGH Kconfig option.
>=20
> Xen build has that option selected by default. Non-Xen builds now
> have to select this feature manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: Only default with Xen (Alex Williamson)
>=20
> I did not used 'depends on XEN' as suggested by Alex but
> 'default y if XEN', so one can build XEN without this feature
> (for example, on other ARCH than X86).
> ---
>  hw/pci-host/Kconfig       | 5 +++++
>  hw/pci-host/Makefile.objs | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index b0aa8351c4..24ba8ea046 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -1,6 +1,11 @@
>  config PAM
>      bool
> =20
> +config XEN_IGD_PASSTHROUGH
> +    bool
> +    default y if XEN
> +    select PCI_I440FX

Maybe "depends on PCI_I440FX" (so if somebody builds a Xen+KVM, q35-only
machine they don't get IGD passthrough).  I can do this when applying.

Paolo

> +
>  config PREP_PCI
>      bool
>      select PCI
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index fa6d1556c0..9c466fab01 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -14,7 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
>  common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
>  common-obj-$(CONFIG_FULONG) +=3D bonito.o
>  common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
> -common-obj-$(CONFIG_PCI_I440FX) +=3D xen_igd_pt.o
> +common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) +=3D xen_igd_pt.o
>  common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
>  common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
>  common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
>=20


