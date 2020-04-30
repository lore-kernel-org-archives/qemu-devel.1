Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBD0C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0B52073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo61YCHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0B52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCO8-0005FC-O9
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUC7V-0007dR-2J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUC6W-0001KG-5U
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:33:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jUC6V-0001Hl-Mu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588264322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lm01oWShkBDXnGbfwV19JsB1g2JkYLJo9A3Gm8eb74c=;
 b=bo61YCHpQDBMkbnpt8y/s+YxntvBEIvUiTvxSiq3y+zXaBTsuHN+k6RrfLiLxuGq1TjYGg
 IGPFzBaLbqSG/jXEXfU8HskjkaEGBTy7bXmOaamobC4sAqTkcxVxYHIFFTup615lt6jBZb
 b/Qh+PyG215SRo7jvkdGZQTMVvennxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-qR8B3hT-OJ-jSDdr5EaSIg-1; Thu, 30 Apr 2020 12:31:58 -0400
X-MC-Unique: qR8B3hT-OJ-jSDdr5EaSIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D64C61030983;
 Thu, 30 Apr 2020 16:31:56 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2E3F512E4;
 Thu, 30 Apr 2020 16:31:45 +0000 (UTC)
Date: Thu, 30 Apr 2020 18:31:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 14/15] acpi: factor out fw_cfg_add_acpi_dsdt()
Message-ID: <20200430183144.1eca20ea@redhat.com>
In-Reply-To: <20200429140003.7336-15-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-15-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 16:00:02 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add helper function to add fw_cfg device,
> also move code to hw/i386/fw_cfg.c.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/fw_cfg.h     |  1 +
>  hw/i386/acpi-build.c | 24 +-----------------------
>  hw/i386/fw_cfg.c     | 28 ++++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> index 9e742787792b..275f15c1c5e8 100644
> --- a/hw/i386/fw_cfg.h
> +++ b/hw/i386/fw_cfg.h
> @@ -25,5 +25,6 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
>                                 uint16_t apic_id_limit);
>  void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
>  void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
> +void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
> =20
>  #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 643e875c05a5..a8b790021974 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1874,30 +1874,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> =20
>      /* create fw_cfg node, unconditionally */
>      {
> -        /* when using port i/o, the 8-bit data register *always* overlap=
s
> -         * with half of the 16-bit control register. Hence, the total si=
ze
> -         * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, th=
e
> -         * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
> -        uint8_t io_size =3D object_property_get_bool(OBJECT(x86ms->fw_cf=
g),
> -                                                   "dma_enabled", NULL) =
?
> -                          ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr=
_t) :
> -                          FW_CFG_CTL_SIZE;
> -
>          scope =3D aml_scope("\\_SB.PCI0");
> -        dev =3D aml_device("FWCF");
> -
> -        aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
> -
> -        /* device present, functioning, decoding, not shown in UI */
> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> -
> -        crs =3D aml_resource_template();
> -        aml_append(crs,
> -            aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, i=
o_size)
> -        );
> -        aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -        aml_append(scope, dev);
> +        fw_cfg_add_acpi_dsdt(scope, x86ms->fw_cfg);
>          aml_append(dsdt, scope);
>      }
> =20
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index da60ada59462..c55abfb01abb 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -15,6 +15,7 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/numa.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/firmware/smbios.h"
>  #include "hw/i386/fw_cfg.h"
>  #include "hw/timer/hpet.h"
> @@ -179,3 +180,30 @@ void fw_cfg_build_feature_control(MachineState *ms, =
FWCfgState *fw_cfg)
>      *val =3D cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
>      fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val)=
);
>  }
> +
> +void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
> +{
> +    /*
> +     * when using port i/o, the 8-bit data register *always* overlaps
> +     * with half of the 16-bit control register. Hence, the total size
> +     * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
> +     * DMA control register is located at FW_CFG_DMA_IO_BASE + 4
> +     */
> +    Object *obj =3D OBJECT(fw_cfg);
> +    uint8_t io_size =3D object_property_get_bool(obj, "dma_enabled", NUL=
L) ?
> +        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
> +        FW_CFG_CTL_SIZE;
> +    Aml *dev =3D aml_device("FWCF");
> +    Aml *crs =3D aml_resource_template();
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
> +
> +    /* device present, functioning, decoding, not shown in UI */
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> +
> +    aml_append(crs,
> +        aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_si=
ze));
> +
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}


