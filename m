Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5E2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMltdyBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE5E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlShZ-0000Gn-Vu
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSfE-0005Aa-Ml
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:39:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSfC-0004rh-Vb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XrGe2WzRvDQV5cyfB2MhoZTiCjLEkvQxdw5EGgIrZiI=;
 b=hMltdyBEil7tfg/vEi6ZKCbGzkKVU+OUSx9etl1nI/KFzA79csgXcU9cF5DH4veXa+BQ7o
 GziAkQ6xavf1/s2urHEJQKB2uvTR0P5Rv1PeyvtzalYi4IBn7zUt3JjlWEWQFE/qzHs4/I
 Pds8wVSdpqQ0Jk0VqN5omQi8CQ7QZho=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-FYgtd9MtPH6uUulrEzHueg-1; Wed, 17 Jun 2020 03:39:12 -0400
X-MC-Unique: FYgtd9MtPH6uUulrEzHueg-1
Received: by mail-il1-f200.google.com with SMTP id q24so916954ili.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XrGe2WzRvDQV5cyfB2MhoZTiCjLEkvQxdw5EGgIrZiI=;
 b=J4g6KflDRnDSyzyaJHWI3Xms2WZonI7jMAUlFGGugzLfw3gc/DpXRItPHL0Pa+Rizo
 8h+PbN0bqhBQF+nECxhJzoIhXHpYi4Fuluol3SLm0RPS7X+ZHQA/MGngczWBZAZ4woSd
 f2nv7nw3U0/TD1L8J4mQyePyNOUUjfD6WYzJbaCIh3tf6ycFQ2nAt7CjCkwQhXMkqJPB
 WiZn0GkHF7/JJMYPkdWZZaU+MF5eTgAM8pR+aJYeyBK7i7+a9bzAqrjEhfY4xEZY5iBN
 zdw8X5jfs3zteIsIbiKgZUhMXR2nJrqs3wGOB+WiFqg4NbYRZXD1NMBdMACDNojc3tTH
 +Ssw==
X-Gm-Message-State: AOAM531I8LhI99r26MyGzBnM8bH7wmXAZHbrNuP8uah1CnwIzuuukkWF
 1ArBFZzBQi0ZbDvKpQnqU5leeD5gkfuOBcyWDSyb2KcobDdtSMfl079d0HniwaxH7AD85pDVpsG
 35JYM6BlWBhL7bs7d9MjAcazOllbtcQY=
X-Received: by 2002:a05:6602:2e0e:: with SMTP id
 o14mr7119222iow.164.1592379552067; 
 Wed, 17 Jun 2020 00:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6w5A/527KlXcikjC9oowppp9LQ1lK/Cbo1dFXCzVdElfzjDgXil6pp1FQZ7iywetFe4reoXkSYKlt7gK5sSo=
X-Received: by 2002:a05:6602:2e0e:: with SMTP id
 o14mr7119212iow.164.1592379551766; 
 Wed, 17 Jun 2020 00:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-5-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200616205721.1191408-5-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2020 11:39:00 +0400
Message-ID: <CAMxuvaz9Wj6vr_wNcObr_Xktze7QMkPxNmR1LXTkvF5p+v2XGw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and
 TPM_TIS_SYSBUS_IRQ
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 12:58 AM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Before the enablement of interrupts on PCs, split the TPM_TIS_IRQ
> into TPM_TIS_ISA_IRQ for PCs and TPM_TIS_SYSBUS_IRQ for ARM.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
>  static Property tpm_tis_isa_properties[] =3D {
> -    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_ISA_IR=
Q),
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
>  static Property tpm_tis_sysbus_properties[] =3D {
> -    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ=
),
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
> --
> 2.24.1
>


