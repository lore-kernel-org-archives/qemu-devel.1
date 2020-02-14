Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA09C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1E42067D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwCyYyjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1E42067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2g8G-0001DK-CP
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2g7X-0008Qa-98
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2g7V-0002z8-Ks
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:55:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2g7V-0002yq-Gx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581706520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EN8zjuPHGL5alcVnWz2YMgcaV5lO4slthD+6U+XV9Cc=;
 b=SwCyYyjkNejnZUFuMmBbZQ80hHsa6M7k1JZ4rWBbavy6xA0GfPKQQXi1OnltSUS4xxdaI+
 ppf/FzAUDND5x139vySRCyu9venIWUnM/bUYbtxztpKIHFLJLmzz+lXuA1O7kS9rFpRbIx
 FdPP9mqNMcgHmRpzmjrgo9dWbb5xno4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-OP6zDUUVN4qo2Re50GkhuQ-1; Fri, 14 Feb 2020 13:55:19 -0500
Received: by mail-wr1-f72.google.com with SMTP id o9so4545755wrw.14
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S3GH1oAA4Bad2Xr/3CgXymLB45XQFQaZUty8DiYaUTU=;
 b=iKgRwmLAVZUtk69vBJ5b398yEABCqn6iMSmDT3x0Rs1whw3V3odpon+sB+sRTyriMQ
 sc2Wuq85JoIDNxngavo8BJh2PFNQtAMs5YCSxZT6WAvg8PKhFL3PpOYaxO7cLNT1lzl2
 3APrXPRcjIG5NCJHXb1lyDVWRXfZe8FpxpArkpSbuNEQAUDpEfg4jobXpfu1q9u2JG/n
 Fej8Z3/mN9Hp0zAJOEJLjscbHs3xiyIN2G07fHQCCkeqlhuv7mquxkml80lmy9KH2zf6
 yqO47ts4+ENG/ITbjt8S9TaOR71qHjpuH17j/5PXVCzx+ohYxMyP/Kt+qPG4YlW9KPUm
 6ufw==
X-Gm-Message-State: APjAAAVjo1tPIqX+Odu00arf2AfFiRHXmdhnsQh0oiPwPT1Ei+E26LDU
 rRQFtUMiLEI51UwgBIeUAXGS5zf4NerqQ89wgzeG9z2GVpCpCSYRVKZOEn2jdJM7I6vTse4l7uK
 Zsz6VLpBdISMH9JY=
X-Received: by 2002:adf:cd04:: with SMTP id w4mr5650745wrm.219.1581706517993; 
 Fri, 14 Feb 2020 10:55:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRbLyZtkjN81l0vnXT+c41ZcaH6P2kYyDV1uWOkUwGoI6vouj7ZMw8xsWFq38F3qNuX3KhTA==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr5650736wrm.219.1581706517773; 
 Fri, 14 Feb 2020 10:55:17 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm5260381wrw.20.2020.02.14.10.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 10:55:17 -0800 (PST)
Subject: Re: [RFC v2 1/6] tpm: rename TPM_TIS into TPM_TIS_ISA
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29cc9864-a016-b251-506a-8c04b37efe28@redhat.com>
Date: Fri, 14 Feb 2020 19:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214183704.14389-2-eric.auger@redhat.com>
Content-Language: en-US
X-MC-Unique: OP6zDUUVN4qo2Re50GkhuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 7:36 PM, Eric Auger wrote:
> As we plan to introduce a sysbus TPM_TIS, let's rename
> TPM_TIS into TPM_TIS_ISA.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/acpi-build.c | 6 +++---
>   hw/tpm/tpm_tis.c     | 4 ++--
>   include/sysemu/tpm.h | 6 +++---
>   3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c4e46fa74..26777f8828 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2026,7 +2026,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           }
>       }
>  =20
> -    if (TPM_IS_TIS(tpm_find())) {
> +    if (TPM_IS_TIS_ISA(tpm_find())) {
>           aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>                      TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
>       }
> @@ -2197,7 +2197,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>               /* Scan all PCI buses. Generate tables to support hotplug. =
*/
>               build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_e=
n);
>  =20
> -            if (TPM_IS_TIS(tpm)) {
> +            if (TPM_IS_TIS_ISA(tpm)) {
>                   if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>                       dev =3D aml_device("TPM");
>                       aml_append(dev, aml_name_decl("_HID",
> @@ -2304,7 +2304,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, =
GArray *tcpalog)
>           (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>  =20
>       tpm2_ptr->platform_class =3D cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> -    if (TPM_IS_TIS(tpm_find())) {
> +    if (TPM_IS_TIS_ISA(tpm_find())) {
>           tpm2_ptr->control_area_address =3D cpu_to_le64(0);
>           tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
>       } else if (TPM_IS_CRB(tpm_find())) {
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 31facb896d..c609737272 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -91,7 +91,7 @@ typedef struct TPMState {
>       TPMPPI ppi;
>   } TPMState;
>  =20
> -#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> +#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS_ISA)
>  =20
>   #define DEBUG_TIS 0
>  =20
> @@ -1008,7 +1008,7 @@ static void tpm_tis_class_init(ObjectClass *klass, =
void *data)
>   }
>  =20
>   static const TypeInfo tpm_tis_info =3D {
> -    .name =3D TYPE_TPM_TIS,
> +    .name =3D TYPE_TPM_TIS_ISA,
>       .parent =3D TYPE_ISA_DEVICE,
>       .instance_size =3D sizeof(TPMState),
>       .instance_init =3D tpm_tis_initfn,
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 15979a3647..1691b92c28 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -43,12 +43,12 @@ typedef struct TPMIfClass {
>       enum TPMVersion (*get_version)(TPMIf *obj);
>   } TPMIfClass;
>  =20
> -#define TYPE_TPM_TIS                "tpm-tis"
> +#define TYPE_TPM_TIS_ISA            "tpm-tis"

It should be safe to rename this "tpm-tis-isa" in this patch.

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   #define TYPE_TPM_CRB                "tpm-crb"
>   #define TYPE_TPM_SPAPR              "tpm-spapr"
>  =20
> -#define TPM_IS_TIS(chr)                             \
> -    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
> +#define TPM_IS_TIS_ISA(chr)                         \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
>   #define TPM_IS_CRB(chr)                             \
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
>   #define TPM_IS_SPAPR(chr)                           \
>=20


