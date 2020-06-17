Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E2DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D56C20679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1/Uj8Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D56C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTBw-0004se-CE
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlTBM-0004TL-As
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:12:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlTBK-0002By-0s
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592381544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vAapxgtMWnm8sDzN7uk68BM6d7ymtkjR6TFfmSGo/Mk=;
 b=e1/Uj8Xwx27LfLlJyHKiPDRwScyd0tUgBl8Iqgds2vZ4uES1/i90dZ/C7aQcgK90jqeX76
 q0g7YKEXSDJhc3eY4J2HhZ4YjTE+SGxyZVA/VShmIEEGWZOzyydH2FoPov7f+vBfCezSOh
 e70D10SUBtwqaohucwaAYEi8mOk6SU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-NrcIidI9NEKvyPFc4WBUvw-1; Wed, 17 Jun 2020 04:12:22 -0400
X-MC-Unique: NrcIidI9NEKvyPFc4WBUvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0ED2803317;
 Wed, 17 Jun 2020 08:12:21 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABB6A5C1BD;
 Wed, 17 Jun 2020 08:12:17 +0000 (UTC)
Subject: Re: [PATCH v3 4/8] tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and
 TPM_TIS_SYSBUS_IRQ
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-5-stefanb@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <62a70526-7c3d-8342-3c23-a2751b6d508c@redhat.com>
Date: Wed, 17 Jun 2020 10:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200616205721.1191408-5-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 philmd@redhat.com, mkedzier@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/16/20 10:57 PM, Stefan Berger wrote:
> Before the enablement of interrupts on PCs, split the TPM_TIS_IRQ
> into TPM_TIS_ISA_IRQ for PCs and TPM_TIS_SYSBUS_IRQ for ARM.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_tis_isa.c    | 2 +-
>  hw/tpm/tpm_tis_sysbus.c | 3 ++-
>  include/hw/acpi/tpm.h   | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index ed6d422f05..27222a9a49 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -97,7 +97,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
>  }
>  
>  static Property tpm_tis_isa_properties[] = {
> -    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_ISA_IRQ),
irq_num is a uint32 prop while the default value we are going to assign
is -1. I guess we will end up with irq_num = 255?

Thanks

Eric
>      DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
>      DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 86b3988be5..bf4583c3f6 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -97,7 +97,8 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>  }
>  
>  static Property tpm_tis_sysbus_properties[] = {
> -    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num,
> +                       TPM_TIS_SYSBUS_IRQ),
>      DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
>      DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 1a2a57a21f..d5caee9771 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -24,7 +24,8 @@
>  #define TPM_TIS_ADDR_BASE           0xFED40000
>  #define TPM_TIS_ADDR_SIZE           0x5000
>  
> -#define TPM_TIS_IRQ                 5
> +#define TPM_TIS_ISA_IRQ             5
> +#define TPM_TIS_SYSBUS_IRQ          5
>  
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>  #define TPM_TIS_LOCALITY_SHIFT      12
> 


