Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF79C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CDF208D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMOoK0+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CDF208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSmV-000804-SO
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSgA-0006cS-RS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:40:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSg9-0004xS-2O
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnG4JgPnXhyxWxU0iv1BcGR+nNW+W10frRGXgtKku6c=;
 b=GMOoK0+JUuzZTHceGUy/ul+RoYH73m8nIUeJLvylL+10w8brKZh2WjYZ3uHnld+Gv5IieI
 xSM4Zg6rDND52vyCJYV6HRMPXj3VR8W1syI5KsrjhfxnJZe5L9phpEcq6sWUU9rEHvkqzY
 LRlv2oA8RafTn4tojGAVU9m6ZCnU37c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-IE6NE_q3MOuipkD4FTyj0w-1; Wed, 17 Jun 2020 03:40:10 -0400
X-MC-Unique: IE6NE_q3MOuipkD4FTyj0w-1
Received: by mail-il1-f199.google.com with SMTP id v14so909555ilo.19
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FnG4JgPnXhyxWxU0iv1BcGR+nNW+W10frRGXgtKku6c=;
 b=eDmSDU+sPSAlGt9wcqP1yCuFelBxg0OQgQVQRswzM9TFas3Zx+HWkaJkFbwH8cxIEd
 xAVtGsqaeHHbtCEU9bpnOarXzu2GvdQi61PrHP0CS8i6nt+FPS96OnnpCdUry0qzf+CA
 10Lb7pSsN+ACLfXlGmbVlC9YKXDZo3r263TLQqGB6FLWGmPc5rnJOVFkn63x67//MOm1
 PQQscfVaLFoDBIiWNgMvAKl1YnsIixoN5Wu4JoCw0OQWQ5h370tvLXgI81lNkDmLLMZt
 av8rhStZI/FdNhVsRMzoA66rHc7Cb6EPXFCz1kulROfdIfWc4mDw18cTrnpdYqtcyTkb
 nxyw==
X-Gm-Message-State: AOAM530hHuPAzG5AwKi9RqBFR9yzx2lboL4+eK3t4GnWAHWOgJ6McEMh
 iaUAqAGp3fdV9Hssp88btwFdOX3oeNVMzmAsvouoHveI8xZ+GLGuetBJ8GZlY0sg1xaOdEgj9Ud
 WxK9mHBGyoJAOiqptnbmsngEr4+PbcJE=
X-Received: by 2002:a05:6602:1616:: with SMTP id
 x22mr7287511iow.70.1592379610172; 
 Wed, 17 Jun 2020 00:40:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykg2wfmF/mAJL7RveD9MVIWVxxBVvCAzMvVGCCb9gzctZK+EDl5QRnCXdujj0VsQMensrIyW3G/+MNizAS1fI=
X-Received: by 2002:a05:6602:1616:: with SMTP id
 x22mr7287500iow.70.1592379610005; 
 Wed, 17 Jun 2020 00:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-6-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200616205721.1191408-6-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2020 11:39:59 +0400
Message-ID: <CAMxuvawcP3fijc9LN8-P-cMC9jCCxoBBCVaaxbZp7X+YLLfe9A@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] acpi: Enable TPM IRQ
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 12:57 AM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Move the TPM TIS IRQ to unused IRQ 13, which is the only one accepted by
> Windows. Query for the TPM's irq number and enable the TPM IRQ unless
> TPM_IRQ_DISABLED is returned.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/i386/acpi-build.c  | 11 +++++------
>  include/hw/acpi/tpm.h |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 900f786d08..bb9a7f8497 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2021,6 +2021,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
>
>              if (TPM_IS_TIS_ISA(tpm)) {
> +                int8_t irq =3D tpm_get_irqnum(tpm);
>                  if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>                      dev =3D aml_device("TPM");
>                      aml_append(dev, aml_name_decl("_HID",
> @@ -2035,12 +2036,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>                  crs =3D aml_resource_template();
>                  aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>                             TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> -                /*
> -                    FIXME: TPM_TIS_IRQ=3D5 conflicts with PNP0C0F irqs,
> -                    Rewrite to take IRQ from TPM device model and
> -                    fix default IRQ value there to use some unused IRQ
> -                 */
> -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> +
> +                if (irq !=3D TPM_IRQ_DISABLED) {
> +                    aml_append(crs, aml_irq_no_flags(irq));
> +                }
>                  aml_append(dev, aml_name_decl("_CRS", crs));
>
>                  tpm_build_ppi_acpi(tpm, dev);
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d5caee9771..d356f2e06e 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -24,7 +24,7 @@
>  #define TPM_TIS_ADDR_BASE           0xFED40000
>  #define TPM_TIS_ADDR_SIZE           0x5000
>
> -#define TPM_TIS_ISA_IRQ             5
> +#define TPM_TIS_ISA_IRQ             13    /* only one possible */
>  #define TPM_TIS_SYSBUS_IRQ          5
>
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
> --
> 2.24.1
>


