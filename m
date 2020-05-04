Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E08C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 05:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3764D206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 05:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVSnEu7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3764D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVTYd-0002li-D5
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 01:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVTXr-0002DV-II
 for qemu-devel@nongnu.org; Mon, 04 May 2020 01:21:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVTXq-0006f5-6c
 for qemu-devel@nongnu.org; Mon, 04 May 2020 01:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588569692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9lVqxyBk75HwNGZENcHVduBzI17YMLdle2c3mnZrB+8=;
 b=AVSnEu7WRdFAxM1Ej7A5E2woloyEU8irM4DguGKYc0m00JI5idu9GrBITr+rPi+GmNYEgH
 I0cUznbRQCZdQnkwImGC1JwIWNpFIerlbHel/815hrP/m1Z7bcoMaUHthkGYPUMNLiyZAD
 B6JyxLTk+DnM8nPvE5UUZqefhR9u4Tc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-PfIw97DbM5G05-jpSWTlCw-1; Mon, 04 May 2020 01:21:31 -0400
X-MC-Unique: PfIw97DbM5G05-jpSWTlCw-1
Received: by mail-wr1-f71.google.com with SMTP id o6so2776367wrn.0
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 22:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Za/E9RQPajz82vsaW1sAfD7tIhOVgcZ9GFqKv3Oy1Eo=;
 b=eX+ty8N1SZuk1eD9tnXRxedMfM15W1jZGJPMQDL6DA/+0SC/C6HdD5kVNdCi8iBHB5
 zZRxNPAWQjZpIcxwxgQ+TrrwmzBjL84tTGHuJEAHblPolGoqGXkNBx3JyYDHocD5LdnQ
 BQuA7toMp3JxUqDH1irh/PDaUX8GjstjyjXeumzlCRIZFv+SunJ/K2w+iHa46vb5hVDX
 J5BLODz3WRTeYMcq2sZAGBkmZQnQ6LpGtU52fuk1uPLg1bcKzKsVELNHWeemXaZDyVq9
 lERT3XVUE8C/BPqYgpzbN1H1LuUOqDXXokIlluRryAujCfV0wBs+YenWVax+MbPfLseC
 EvZQ==
X-Gm-Message-State: AGi0Puaeac0q7S3JbCTAR0wh0JR43c3FdcaGKpCmDd+I4XpO5XBJqZxj
 hOzSVgTTUmgHaU6gfZfDD2y5w0Eh5rR6H0+N5ihmAYOwpofjy0/2ZuOyREE8euNKo/hfXrrDXfL
 t5YpwIMPeFnlx/s4=
X-Received: by 2002:a5d:5224:: with SMTP id i4mr16995985wra.1.1588569689871;
 Sun, 03 May 2020 22:21:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDcbOifrv32mqB/yQtcooTLF9STd6I3Mkf273ilMUMxBcLv8DvkyZf3fVgdUSNog/fe+JhUQ==
X-Received: by 2002:a5d:5224:: with SMTP id i4mr16995953wra.1.1588569689529;
 Sun, 03 May 2020 22:21:29 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 v16sm11492450wml.30.2020.05.03.22.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2020 22:21:28 -0700 (PDT)
Date: Mon, 4 May 2020 01:21:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 2/2] arm/acpi: Add the TPM2.0 device under the DSDT
Message-ID: <20200504012048-mutt-send-email-mst@kernel.org>
References: <20200502203536.15011-1-eric.auger@redhat.com>
 <20200502203536.15011-3-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200502203536.15011-3-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, gshan@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, imammedo@redhat.com, eric.auger.pro@gmail.com,
 lersek@redhat.com, ardb@kernel.org, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 02, 2020 at 10:35:36PM +0200, Eric Auger wrote:
> In case it is dynamically instantiated, add the TPM 2.0 device object
> under the DSDT table in the ACPI namespace. Its HID is MSFT0101
> while its current resource settings (CRS) property is initialized
> with the guest physical address and MMIO size of the device.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index cc5863eaf2..0cb9cdb2ce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -45,6 +45,7 @@
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
> +#include "hw/platform-bus.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/tpm.h"
> @@ -362,6 +363,38 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>      aml_append(scope, dev);
>  }
> =20
> +static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
> +{
> +    hwaddr pbus_base =3D vms->memmap[VIRT_PLATFORM_BUS].base;
> +    PlatformBusDevice *pbus =3D PLATFORM_BUS_DEVICE(vms->platform_bus_de=
v);
> +    MemoryRegion *sbdev_mr;
> +    SysBusDevice *sbdev;
> +    hwaddr tpm_base;
> +
> +    sbdev =3D (SysBusDevice *)object_dynamic_cast(OBJECT(tpm_find()),
> +                                                TYPE_SYS_BUS_DEVICE);
> +    if (!sbdev) {
> +        return;
> +    }
> +
> +    tpm_base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    assert(tpm_base !=3D -1);
> +
> +    tpm_base +=3D pbus_base;
> +
> +    sbdev_mr =3D sysbus_mmio_get_region(sbdev, 0);
> +
> +    Aml *dev =3D aml_device("TPM0");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs =3D aml_resource_template();
> +    aml_append(crs,
> +               aml_memory32_fixed(tpm_base, sbdev_mr->size, AML_READ_WRI=
TE));

I don't think you are supposed to poke at memory region struct internals li=
ke
this.


> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>  static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
>  {
> @@ -785,6 +818,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>      }
> =20
>      acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_tpm(scope, vms);
> =20
>      aml_append(dsdt, scope);
> =20
> --=20
> 2.20.1


