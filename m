Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E6DC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A932074A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Brn4nV5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A932074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC86i-00058i-8p
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jC85w-0004eY-RW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jC85u-0004mg-Ky
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:36:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53484
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jC85u-0004ka-Dk
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583959005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I15MR1572HWJ+ayxWO2mXWntlJCVFtEcYrhKY6BTKiQ=;
 b=Brn4nV5Hn2gJZeu/KbdxKXIJoX/nAyg9LlMPpQyGACiY4lK6CMKWYk4dvaQqGT/adBsksC
 muKd9ivyBamf2bgv9zwi4Trq4gyOlKJpUrekZZOie2U+f3IOkeb7jv+Mv3omp5Qvjn0Q7U
 dXTsOoR91lcYD+72fCVcXV/xmVURE5Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-1q_FPEigM2-aamwh_twxXg-1; Wed, 11 Mar 2020 16:36:11 -0400
X-MC-Unique: 1q_FPEigM2-aamwh_twxXg-1
Received: by mail-qv1-f71.google.com with SMTP id l16so2126937qvo.15
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 13:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pcX5s55guStmWEhxEF0sb37NU56OLLm/1kWear36HQA=;
 b=Ms0cGrc1riYVvD4GcEJEsRj6iD387rh0sn4w+g823lULK/kZ5I+JoDc6dhNyto0CcQ
 mDzUoHmHxV4sk74lnmmYRp/Vn091EJuSaB6K/2KZ41K3pyYQaS9IfnHeJ+pJT5FhlZqW
 uefWj7CXwB5qtL5Q66c8bXncCtKr6GmpqDhAK5zRG7flEt3iPUrcFRryA1WkprfikNTg
 lf1YUh6s00yNjXEdTdjF0u2DvkLLjjNImTih1q3r0+avbk5pUiZwNdL/0I7ePvAJdWza
 hUbvJjy27U+uRTjsfinup02SYcLgZlETfHo7tZ4gFiAx1NzfBfAs+IzGmW88UuHg3hEp
 114Q==
X-Gm-Message-State: ANhLgQ0wTC9O5DeFmULr8xdDi6J+XbF7c3+CSgQQoB351WPwjBdh/hut
 SbqYDaY+dS6nK2nXo9woPnW7YUS5RQNFzfno143+paPPo3ZAPMPrKl+/p02AtF/cTXjLH48HaH4
 571W7qvsZvlTA9ck=
X-Received: by 2002:a37:4b4c:: with SMTP id y73mr4429032qka.467.1583958970228; 
 Wed, 11 Mar 2020 13:36:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQIkhsvUmEc8YEc4FgN10zpcbYGCdUPAQxD5uxRu1xwWTI8jUU9G8iSUbYOhrdqVYjRJQvjQ==
X-Received: by 2002:a37:4b4c:: with SMTP id y73mr4429015qka.467.1583958969926; 
 Wed, 11 Mar 2020 13:36:09 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id g49sm6960386qtk.1.2020.03.11.13.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 13:36:09 -0700 (PDT)
Date: Wed, 11 Mar 2020 16:36:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200311162509-mutt-send-email-mst@kernel.org>
References: <20200311170826.79419-1-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200311170826.79419-1-liran.alon@oracle.com>
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the patch! Some questions/comments:

On Wed, Mar 11, 2020 at 07:08:26PM +0200, Liran Alon wrote:
> From: Elad Gabay <elad.gabay@oracle.com>
>=20
> Microsoft introduced this ACPI table to avoid Windows guests performing
> various workarounds for device erratas. As the virtual device emulated
> by VMM may not have the errata.
>=20
> Currently, WAET allows hypervisor to inform guest about two
> specific behaviors: One for RTC and the other for ACPI PM Timer.
>=20
> Support for WAET have been introduced since Windows Vista. This ACPI
> table is also exposed by other hypervisors, such as VMware, by default.
>=20
> This patch adds WAET ACPI Table to QEMU.

Could you add a bit more info? Why is this so useful we are adding this
by default? How does it change windows behaviour when present?

> It also makes sure to introduce
> the new ACPI table only for new machine-types.

OK and why is that?

>=20
> Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
> Co-developed-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/acpi-build.c        | 18 ++++++++++++++++++
>  hw/i386/pc_piix.c           |  2 ++
>  hw/i386/pc_q35.c            |  2 ++
>  include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
>  include/hw/i386/pc.h        |  1 +
>  5 files changed, 48 insertions(+)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c4e46fa7466..29f70741cd96 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker *lin=
ker)
>      build_header(linker, table_data, (void *)(table_data->data + dmar_st=
art),
>                   "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
>  }
> +
> +static void
> +build_waet(GArray *table_data, BIOSLinker *linker)
> +{
> +    AcpiTableWaet *waet;
> +
> +    waet =3D acpi_data_push(table_data, sizeof(*waet));

Can combine with the previous line.

> +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIMER_GOOD)=
;
> +
> +    build_header(linker, table_data,
> +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL);
> +}
> +
>  /*
>   *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5=
.2
>   *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
> @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, MachineSt=
ate *machine)
>                            machine->nvdimms_state, machine->ram_slots);
>      }
> =20
> +    if (!pcmc->do_not_add_waet_acpi) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_waet(tables_blob, tables->linker);
> +    }
> +
>      /* Add tables supplied by user (if any) */
>      for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)) {
>          unsigned len =3D acpi_table_len(u);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9088db8fb601..2d11a8b50a9c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
> =20
>  static void pc_i440fx_4_2_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_i440fx_5_0_machine_options(m);
>      m->alias =3D NULL;
>      m->is_default =3D false;
> +    pcmc->do_not_add_waet_acpi =3D true;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 84cf925cf43a..1e0a726b27a7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
> =20
>  static void pc_q35_4_2_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>      pc_q35_5_0_machine_options(m);
>      m->alias =3D NULL;
> +    pcmc->do_not_add_waet_acpi =3D true;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 57a3f58b0c9a..803c904471d5 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -634,4 +634,29 @@ struct AcpiIortRC {
>  } QEMU_PACKED;
>  typedef struct AcpiIortRC AcpiIortRC;
> =20
> +/*
> + * Windows ACPI Emulated Devices Table.
> + * Specification:
> + * http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-=
CE7CE0D98DC2/WAET.docx
> + */
> +
> +/*
> + * Indicates whether the RTC has been enhanced not to require acknowledg=
ment
> + * after it asserts an interrupt. With this bit set, an interrupt handle=
r can
> + * bypass reading the RTC register C to unlatch the pending interrupt.
> + */
> +#define ACPI_WAET_RTC_GOOD      (1 << 0)
> +/*
> + * Indicates whether the ACPI PM timer has been enhanced not to require
> + * multiple reads. With this bit set, only one read of the ACPI PM timer=
 is
> + * necessary to obtain a reliable value.
> + */
> +#define ACPI_WAET_PM_TIMER_GOOD (1 << 1)
> +

ACPI spec is so huge we really can't add enums for all values,
it just does not scale.


So we switched to a different way to do this: you add e.g. 1 << 1
in the code directly, and put the comments there.


Igor this is becoming a FAQ. Could you write up the way ACPI
generation code should look?


> +struct AcpiTableWaet {
> +    ACPI_TABLE_HEADER_DEF
> +    uint32_t emulated_device_flags;
> +} QEMU_PACKED;
> +typedef struct AcpiTableWaet AcpiTableWaet;
> +


>  #endif
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 60c988c4a5aa..f1f64e8f45c8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -100,6 +100,7 @@ typedef struct PCMachineClass {
>      int legacy_acpi_table_size;
>      unsigned acpi_data_size;
>      bool do_not_add_smb_acpi;
> +    bool do_not_add_waet_acpi;
> =20
>      /* SMBIOS compat: */
>      bool smbios_defaults;
> --=20
> 2.20.1


