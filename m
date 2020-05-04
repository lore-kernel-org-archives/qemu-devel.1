Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79718C47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4585720721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2U/Wxw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4585720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYXZ-0006MI-GE
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVYS5-0003at-8J
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:35:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVYRv-0001jD-Ci
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588588546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7qjpECM+aCBLbyZzL1R9qYhC5J3RWAlBF99gihbx48=;
 b=g2U/Wxw4UzsrUOmsJnyRlSQsXAP3E6eg4kJ2HDZbdrITbNpbQKmJbzGDr7WpXXRkgiyUAb
 1fY6I4/PB4pvVA7Xp5uLiI8eVET+r48hxBE2vdzaEXVeYWXCBxKhWe7IUUjMo2OZi0KYsB
 oz3c7ot6x1GhskypYk1bER8F/a57keg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-re19EY4ANNynswR3cLLuig-1; Mon, 04 May 2020 06:35:42 -0400
X-MC-Unique: re19EY4ANNynswR3cLLuig-1
Received: by mail-wm1-f70.google.com with SMTP id v185so3285736wmg.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=65qtTvM5Bdj416dEt86Eaggl2O6nVd/jv4X1UlNrfBg=;
 b=WR92ovZnTAAaA7TT7OkPeIW/e1ISLP1NtXtvGa3z3t7vI7tJdqi3EfcYm3dk/aLa4V
 lRKPLRYhe4jXRieUjWP6xaLFnY7cD6KkCFFa8MIXdHyfwV6XNj015fQEJI7FY47pB9PA
 zlYMQb5bypM0/g2jbFPQdp6NWrrvxG868VLPwbNOQpM74MEmFQMyWSYtpaM17MBvf22O
 Vnch6y5kvpnHpX/jIDmRaKqkVHhY11Qw45ut+fsTaVJZ+jREIrOff0xwlcCPA77obVTx
 OEdYYbeLKt/rQV1IkD3nA+PLav/M7SI9vxG+7knCvE4aN0CZY32jmeqfuptvOUowj3cJ
 zg/Q==
X-Gm-Message-State: AGi0PuZ748oJIbxHsbbzstaQuYKMsWOwwDJocJ68hHkNFbwGVBK3hum+
 ntw+LVHBQ+JtLwsnhvJG6vR9JKyhrsyVPPbfFMai8uc+r+hWG0n8Y45HSj5xDB1TJwxaAhaXLJu
 KO+4TZM0p5g7A5fY=
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr9244264wrw.17.1588588541485;
 Mon, 04 May 2020 03:35:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypKyJu1SMZNPQhE0tcEAXzN/rWndTUAqQVqX8t6qJaWFe5I/Z+N5VZ1io0MxIvHn6HTRdzqEog==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr9244239wrw.17.1588588541200;
 Mon, 04 May 2020 03:35:41 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id l19sm13335878wmj.14.2020.05.04.03.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 03:35:40 -0700 (PDT)
Subject: Re: [PATCH] xen: fix build without pci passthrough
To: Roger Pau Monne <roger.pau@citrix.com>, qemu-devel@nongnu.org
References: <20200504101443.3165-1-roger.pau@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ccf11b67-4aaa-5fb2-e23f-674380b47a13@redhat.com>
Date: Mon, 4 May 2020 12:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504101443.3165-1-roger.pau@citrix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Roger,

On 5/4/20 12:14 PM, Roger Pau Monne wrote:
> has_igd_gfx_passthru is only available when QEMU is built with
> CONFIG_XEN_PCI_PASSTHROUGH, and hence shouldn't be used in common
> code without checking if it's available.
>=20
> Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an acceler=
ator property')
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>

See Kconfig fix suggested here:
https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg61844.html

> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org
> ---
>   hw/xen/xen-common.c | 4 ++++
>   hw/xen/xen_pt.h     | 7 +++++++
>   2 files changed, 11 insertions(+)
>=20
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index a15070f7f6..c800862419 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -127,6 +127,7 @@ static void xen_change_state_handler(void *opaque, in=
t running,
>       }
>   }
>  =20
> +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
>   static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
>   {
>       return has_igd_gfx_passthru;
> @@ -136,6 +137,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, boo=
l value, Error **errp)
>   {
>       has_igd_gfx_passthru =3D value;
>   }
> +#endif
>  =20
>   static void xen_setup_post(MachineState *ms, AccelState *accel)
>   {
> @@ -197,11 +199,13 @@ static void xen_accel_class_init(ObjectClass *oc, v=
oid *data)
>  =20
>       compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
>  =20
> +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
>       object_class_property_add_bool(oc, "igd-passthru",
>           xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
>           &error_abort);
>       object_class_property_set_description(oc, "igd-passthru",
>           "Set on/off to enable/disable igd passthrou", &error_abort);
> +#endif
>   }
>  =20
>   #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> index 179775db7b..660dd8a008 100644
> --- a/hw/xen/xen_pt.h
> +++ b/hw/xen/xen_pt.h
> @@ -1,6 +1,7 @@
>   #ifndef XEN_PT_H
>   #define XEN_PT_H
>  =20
> +#include "qemu/osdep.h"
>   #include "hw/xen/xen_common.h"
>   #include "hw/pci/pci.h"
>   #include "xen-host-pci-device.h"
> @@ -322,7 +323,13 @@ extern void *pci_assign_dev_load_option_rom(PCIDevic=
e *dev,
>                                               unsigned int domain,
>                                               unsigned int bus, unsigned =
int slot,
>                                               unsigned int function);
> +
> +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
>   extern bool has_igd_gfx_passthru;
> +#else
> +# define has_igd_gfx_passthru false
> +#endif
> +
>   static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
>   {
>       return (has_igd_gfx_passthru
>=20


