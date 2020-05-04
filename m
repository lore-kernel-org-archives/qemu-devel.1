Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13ADC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC59A20705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/mWTA8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC59A20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbhy-0001Kd-Su
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVbgH-0007Ny-Hy
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:02:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVbgG-0006IN-Ke
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588600967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2zvL/m0upHD3M3uIFvfVJE3iUisfia4c6lGbRcMKBI=;
 b=N/mWTA8CbLbrbHUB+n57DmFfXDoTgrNjRS7kfjJEAvFeqqC6viLXz6W+wFUv0ArhNzW8Vy
 GEeE7OejTu+0ieOG30L/2/RBlwmg+502ngCUc6hb8hjXqiX3iphYjgqiWRPx60fXob2AwE
 AP2/6tBSbDOXc0GRZigohpZU40ztS5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-M37_rEWEPXG3CvAAfKF0NA-1; Mon, 04 May 2020 10:02:36 -0400
X-MC-Unique: M37_rEWEPXG3CvAAfKF0NA-1
Received: by mail-wm1-f70.google.com with SMTP id b203so3535180wmd.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1ud3LEA0R6Fmmcf+jn9FDHF/7TgcxqnsbsXbon6TAKw=;
 b=HWVQd3CXnoIHWKLMSikw0tyoGo2TZe9MWHWE1cYUXQ+OUWBI8Rlcu0tcQWoDsDxhkE
 +HIduaRkZBPLSTY8odmSQzyKchJAd4xv/GJifwD2xjjTAe5mKbLEF7U0PkwmBVUE6Ouw
 YpGFOSybFl06er7VMU3f0FbftcOObXmgupMJTmuV3v4ct+wlqiTZeX3vSCFkHOfEOwV6
 DzPQpgAmhC5tUNyAcJUnQKtAA/xTVldLQEPAdOv+7pagK85qZ8jSVT+I8bJMWJ/1LxJc
 BTFrZFngFR95I7smdQhxyrMlXbix6BCObJP5nGjsnNgztPQmWWZXBRKFlFFjmXXaB0hV
 ja0Q==
X-Gm-Message-State: AGi0PuZS7EJcwuU73czQT7J/VMrfxTJLusiKdi1mPu6jWsu5cW8xDJjw
 PbKaanV+7c8uUKXuT9s4vZKzGzsbPRRXfC/pd2j8HLbJmsqnXQXMFrv2ueV6LUf3DE6ndoJGjxr
 vhHhbg8HTL2Ge51Q=
X-Received: by 2002:a5d:494a:: with SMTP id r10mr18268367wrs.136.1588600955506; 
 Mon, 04 May 2020 07:02:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypI++jIMyizyHqSkUFbrUwRzRkm5ha0thIMIpbBwx0s173sqjPFyN/heqsT7vnpTUthQlnPbmg==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr18268351wrs.136.1588600955333; 
 Mon, 04 May 2020 07:02:35 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 d7sm18795097wrn.78.2020.05.04.07.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:02:34 -0700 (PDT)
Date: Mon, 4 May 2020 10:02:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [PATCH v6 2/8] fw_cfg: Write the extra roots into the fw_cfg
Message-ID: <20200504100057-mutt-send-email-mst@kernel.org>
References: <20200408125816.955-1-miaoyubo@huawei.com>
 <20200408125816.955-3-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200408125816.955-3-miaoyubo@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 08, 2020 at 08:58:10PM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> Write the extra roots into the fw_cfg therefore the uefi could
> get the extra roots. Only if the uefi know there are extra roots,
> the config space of devices behind the root could be obtained.
>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> ---
>  hw/arm/virt.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7dc96abf72..0fdfe4129c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -77,6 +77,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/char/pl011.h"
> +#include "hw/pci/pci_bus.h"
> =20
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1435,6 +1436,12 @@ void virt_machine_done(Notifier *notifier, void *d=
ata)
>      ARMCPU *cpu =3D ARM_CPU(first_cpu);
>      struct arm_boot_info *info =3D &vms->bootinfo;
>      AddressSpace *as =3D arm_boot_address_space(cpu, info);
> +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> +                                   object_resolve_path_type("",
> +                                   "pcie-host-bridge", NULL),
> +                                   TYPE_PCI_HOST_BRIDGE);
> +
> +    PCIBus *bus =3D s->bus;
> =20
>      /*
>       * If the user provided a dtb, we assume the dynamic sysbus nodes


Seems duplicated all over the place. Add an API for that?

> @@ -1453,6 +1460,22 @@ void virt_machine_done(Notifier *notifier, void *d=
ata)
>          exit(1);
>      }
> =20
> +    if (bus) {
> +        int extra_hosts =3D 0;
> +        QLIST_FOREACH(bus, &bus->child, sibling) {
> +            /* look for expander root buses */
> +            if (pci_bus_is_root(bus)) {
> +                extra_hosts++;
> +            }
> +        }
> +        if (extra_hosts && vms->fw_cfg) {
> +            uint64_t *val =3D g_malloc(sizeof(*val));
> +            *val =3D cpu_to_le64(extra_hosts);
> +            fw_cfg_add_file(vms->fw_cfg,
> +                   "etc/extra-pci-roots", val, sizeof(*val));
> +        }
> +    }
> +
>      virt_acpi_setup(vms);
>      virt_build_smbios(vms);


Duplicated from pc. Pls refactor.

>  }
> --=20
> 2.19.1
>=20


