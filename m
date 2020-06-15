Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D44C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA85A2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULB5BRhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA85A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqmF-0002uo-3D
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqla-0002S7-Rl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:11:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqlZ-0007mi-86
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592233876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vm0ZGVTLQ+JIj/s3ZH4q21uEwiG+Dz0/klh63ZK0jMA=;
 b=ULB5BRhjzKdiMKRo1Fc9ZdBME8h0Qdoejeh/Hx0wH8/VwE9oEPTkUo7bm/tBRRZZ9DhyEW
 eHd/WDGRRdn1EY7ogpj/1ecdC26M1RFuHxElvZOrZB65rKY0A6q1Rd3PBqTUcc75kerd+I
 M9aYKMrSxK9N5HALeNkBjxJZ5gLRTBw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-i3ZZQ1lcO32XnuGGY6N27A-1; Mon, 15 Jun 2020 11:11:14 -0400
X-MC-Unique: i3ZZQ1lcO32XnuGGY6N27A-1
Received: by mail-io1-f71.google.com with SMTP id p8so11534895ios.19
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vm0ZGVTLQ+JIj/s3ZH4q21uEwiG+Dz0/klh63ZK0jMA=;
 b=aQXW+44VUB3ihaDd/IeSmRx/R8wehBC/SYOZIsAEcuIMhRZ3fjH7hnOjo5vRqEli/S
 qTsEEQWs7yAxDEDLL5QwK1IzfUACFw/QBS6nuG/gRvesAi7khLnAYonSwSyLt0CPMfAf
 Ea32rvVxKDFKy4xSbB36SWDaI9kvT4tAs8VRDrIsatfF6poKVBD4sEnrG93Snp+Ol0CQ
 R2F3ZuH95tt23cjRQ1Fq8+xHwAVNJCtBWvdNe/NtNsQAI+F4kG4kDQlJujmZ+SQL9/vo
 Wgq7NlARmQ6WzcU2k6Fjbu5XstsUOKnGA8MZvGb6/dxkFC0iW1Yr4vAq1zaEijFuQ2Rw
 3p8A==
X-Gm-Message-State: AOAM531DTq40GurIg8pH4KQ6m/Ju9aPRGWrF37qNQ0Oc8hMcVqoBW+vI
 FWrvGW9OM79/uImykX85jUB1XieyS/NLysMakpZ9mTm+xWEBpJXzAMw8fQlK15NcHl4HWoD6myL
 wKJpjE92wTLDnGRWdY4ajlJOqlThCg1c=
X-Received: by 2002:a5d:93d0:: with SMTP id j16mr27610483ioo.82.1592233873363; 
 Mon, 15 Jun 2020 08:11:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnJjrmwNiUcXWNnxM4G+cSoGPiwmgYiobebnXGo+fd4GxXuM+svDgNuHzOENYw/dHFklaC/NTfoPDRaKQRb64=
X-Received: by 2002:a5d:93d0:: with SMTP id j16mr27610468ioo.82.1592233873152; 
 Mon, 15 Jun 2020 08:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-3-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200615142327.671546-3-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Jun 2020 19:11:02 +0400
Message-ID: <CAMxuvayUv9zpnzW93pcQXCFpFX5BZ7ZSRNvJ_XRgLPiyjfa_pQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tpm: Extend TPMIfClass with get_irqnum() function
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
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
Cc: Stefan Berger <stefanb@sbct-2.pok.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jun 15, 2020 at 6:23 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@sbct-2.pok.ibm.com>
>
> Implement get_irqnum() as part of the TPMIfClass to be get the assigned

^^ to get

> IRQ number.
>

Since it is TIS ISA specific (at least for now), perhaps a dedicated
tpm_tis_get_irq_num() is more appropriate?

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_tis_isa.c    |  9 +++++++++
>  hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
>  include/sysemu/tpm.h    | 10 ++++++++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 30ba37079d..63b62f4c21 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>
> +static uint8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(ti);
> +    TPMState *s = &isadev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_isa_reset(DeviceState *dev)
>  {
>      TPMStateISA *isadev = TPM_TIS_ISA(dev);
> @@ -148,6 +156,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
>      dc->reset = tpm_tis_isa_reset;
>      tc->request_completed = tpm_tis_isa_request_completed;
>      tc->get_version = tpm_tis_isa_get_tpm_version;
> +    tc->get_irqnum = tpm_tis_isa_get_irqnum;
>  }
>
>  static const TypeInfo tpm_tis_isa_info = {
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index eced1fc843..6cf45e5057 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>
> +static uint8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
> +    TPMState *s = &sbdev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_sysbus_reset(DeviceState *dev)
>  {
>      TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> @@ -137,6 +145,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->reset = tpm_tis_sysbus_reset;
>      tc->request_completed = tpm_tis_sysbus_request_completed;
>      tc->get_version = tpm_tis_sysbus_get_tpm_version;
> +    tc->get_irqnum = tpm_tis_sysbus_get_irqnum;
>  }
>
>  static const TypeInfo tpm_tis_sysbus_info = {
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 03fb25941c..b94a8a2b16 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -41,6 +41,7 @@ typedef struct TPMIfClass {
>      enum TpmModel model;
>      void (*request_completed)(TPMIf *obj, int ret);
>      enum TPMVersion (*get_version)(TPMIf *obj);
> +    uint8_t (*get_irqnum)(TPMIf *obj);
>  } TPMIfClass;
>
>  #define TYPE_TPM_TIS_ISA            "tpm-tis"
> @@ -74,4 +75,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>      return TPM_IF_GET_CLASS(ti)->get_version(ti);
>  }
>
> +static inline uint8_t tpm_get_irqnum(TPMIf *ti)
> +{
> +    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
> +        return 0;
> +    }
> +
> +    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
> +}
> +
>  #endif /* QEMU_TPM_H */
> --
> 2.24.1
>


