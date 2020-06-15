Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBBCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF3B2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgeH984b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF3B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqoQ-0004pn-2L
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqnh-0003yw-Q8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:13:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44639
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqng-00086I-6A
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592234007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6YYuSptYPx7PlLjC+yQ4Noo93WJ4shSJavaXO+6xGs=;
 b=QgeH984bozIG0W13NnNdpkE3R/w3sUaBn/hD+pbVBQQbjvaZoNkNdl6SVQEU7sKB06XV8X
 jy3g5on7JbaS0sGM/kmLRp7e6CCVZI+rUmrBWeiEMstGL6RPUQZoUzLJZfLL9Z+hqNP0tp
 SAuY0itPXVPofvYSxAjAoVbt1/1gz9w=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-3i3UgzR_NHqAzO_JptpUpQ-1; Mon, 15 Jun 2020 11:13:25 -0400
X-MC-Unique: 3i3UgzR_NHqAzO_JptpUpQ-1
Received: by mail-io1-f70.google.com with SMTP id l204so11597500ioa.4
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x6YYuSptYPx7PlLjC+yQ4Noo93WJ4shSJavaXO+6xGs=;
 b=uPuGPQncZKa6y6FfDsABoC7SU68Huc4NSgMwY1OzJTJsV0WiCAywPzwF3iYhk3ZVs+
 mQhkrprc06fu5+lp8FstehY93Dn5nvdsKCfB8fdSq8xb24o6aIugTBTraqVdjZgqbt3V
 9aGwMePN7l92SI1vBrk76bccpOfzCLrOtDEvXpW7Tz2FptQXU3NEW1l6ao/3bYqoDDjD
 x3F4yBTIhIJt0K8u0bmhm/deRRgaEnIFtSV79Zneym48LlOrMUoLXhPKBnYivrAy1goA
 rRR402+RqQVFnpfQGRVJjyO91+aHREbsFcv+fdKgKHHlISU4nFefJaarkJet6C2r4iz1
 XuSw==
X-Gm-Message-State: AOAM5315/U2v0WqWNLe6QmfX2BTzdhGJS1tT3MOE5p2ZjfBaulsQAEkR
 S68RZlzvzc3ZFeTCd/Mm4NFnvh3IPz4Exmlh+/PFt2MV/tMjbDak5KrOdDUQP/1+UhQxxcRkWTy
 jCnV5uzDunzHglqdBePR+dhYGjVYIQ/s=
X-Received: by 2002:a92:cb03:: with SMTP id s3mr11023455ilo.161.1592234001016; 
 Mon, 15 Jun 2020 08:13:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqB06x3ld5Nh1DJZcwleaexDXarPuhpA57wAY376BwJSKk5Ip7Di6exV5ZtCrdsc/auLljlrM2Op8+Ak5ymYc=
X-Received: by 2002:a92:cb03:: with SMTP id s3mr11023438ilo.161.1592234000828; 
 Mon, 15 Jun 2020 08:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-5-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200615142327.671546-5-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Jun 2020 19:13:09 +0400
Message-ID: <CAMxuvaxm+5Nuv2_1UTXY+-kK1CYMkxqU2pfLOxMgeDEqOjhgZA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] acpi: Enable TPM IRQ
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 11:02:21
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

On Mon, Jun 15, 2020 at 6:24 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Move the TPM TIS IRQ to unused IRQ 13, which is also accepted by Windows.
> Query for the TPM's irq number and enable the TPM IRQ if not zero.
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
> index 900f786d08..747defe1ce 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2021,6 +2021,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
>
>              if (TPM_IS_TIS_ISA(tpm)) {
> +                uint8_t irq =3D tpm_get_irqnum(tpm);
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
> +                if (irq) {
> +                    aml_append(crs, aml_irq_no_flags(irq));
> +                }
>                  aml_append(dev, aml_name_decl("_CRS", crs));
>
>                  tpm_build_ppi_acpi(tpm, dev);
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 1a2a57a21f..063a9eb42a 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -24,7 +24,7 @@
>  #define TPM_TIS_ADDR_BASE           0xFED40000
>  #define TPM_TIS_ADDR_SIZE           0x5000
>
> -#define TPM_TIS_IRQ                 5
> +#define TPM_TIS_IRQ                 13
>
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>  #define TPM_TIS_LOCALITY_SHIFT      12
> --
> 2.24.1
>


