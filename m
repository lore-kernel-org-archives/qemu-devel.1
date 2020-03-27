Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06047C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA6120658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRHELxWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA6120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHppJ-0003YI-09
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 10:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHpoW-0002ko-BR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHpoV-0006tA-54
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:18:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHpoV-0006pq-0t
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585318702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ert/iE6EJCBLd+MTrOqo5Mwf9BEd385RrALrRmJztvA=;
 b=LRHELxWZw95TFrTsFD/2lgFqPG02JgH6XfwKWV8Op/bOP9wC6V3e3yZagzCxJgA+hMg/8t
 JiOKsyP5yTSpHV35/Hg5qYuSDU+ubXsXsrEnZNi44gIyPyXEE97unjMnFYmOlvlmGUdALF
 8+eWwHhpqG685epoTve+XFG6HuAIZBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-5wn-hAirOzewZlnJMuC7Hw-1; Fri, 27 Mar 2020 10:18:20 -0400
X-MC-Unique: 5wn-hAirOzewZlnJMuC7Hw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64ED801E66;
 Fri, 27 Mar 2020 14:18:19 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD218FBED;
 Fri, 27 Mar 2020 14:18:12 +0000 (UTC)
Date: Fri, 27 Mar 2020 15:18:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/6] acpi: factor out acpi_dsdt_add_fw_cfg()
Message-ID: <20200327151811.0feb4680@redhat.com>
In-Reply-To: <20200327121111.1530-4-kraxel@redhat.com>
References: <20200327121111.1530-1-kraxel@redhat.com>
 <20200327121111.1530-4-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 13:11:08 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add helper function to add fw_cfg device.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build-pc.c | 51 ++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build-pc.c b/hw/i386/acpi-build-pc.c
> index a9dbf080566b..3fdae2984b91 100644
> --- a/hw/i386/acpi-build-pc.c
> +++ b/hw/i386/acpi-build-pc.c
> @@ -1809,6 +1809,33 @@ static void build_smb0(Aml *table, I2CBus *smbus, =
int devnr, int func)
>      aml_append(table, scope);
>  }
> =20
> +static void acpi_dsdt_add_fw_cfg(Aml *scope, FWCfgState *fw_cfg)
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
> +
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -2088,30 +2115,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
> +        acpi_dsdt_add_fw_cfg(scope, x86ms->fw_cfg);
>          aml_append(dsdt, scope);
>      }
> =20


