Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F21C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB702206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQbrl/yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB702206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSgm-0007DM-2M
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSeQ-00046V-Cl
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:38:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51218
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jlSeO-0004mv-Fb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTh7gVTBsoiOlaZTSSCPFqb66ZxmpJQkuWbOcSZwYbg=;
 b=gQbrl/ynDypnttBv2jMb/2JbN+wsjw3YjfYGRxR8Wxcgcd7aWLLOsUTUOvYd0/fIkrT95t
 ArgI0KMWBvLMdOdoSmZc+PJC9OZeroMJ0zO59ZBrYBLh7UI+uGpe4KHk+pIfTDltGhGWO0
 Gj9ojS0GDQb79H7aSb6oNnUHojveAoE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-ahwUGuQJMRqMh302VYUr0A-1; Wed, 17 Jun 2020 03:38:22 -0400
X-MC-Unique: ahwUGuQJMRqMh302VYUr0A-1
Received: by mail-io1-f72.google.com with SMTP id a16so1223133iow.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vTh7gVTBsoiOlaZTSSCPFqb66ZxmpJQkuWbOcSZwYbg=;
 b=DU+jU57C/kalhefBZI1yB+ZxIb1Ap7xg8xB7GzmjwIEUvG5w0tQpxGKwrvA2qFOeFB
 B83b+r1QuBTISucDCM2uptpUxaJJUDgZpgM+NMvrBLusdjNM2P6/JQQLl+hBNTmiZDdx
 VpiYCeRFlvKdgkcV6inNa+BthKxz/rZYE7K0EqDF2TL71O/Gi1F6vb4OdmM8mddppdg5
 9IPDRMfayzBJXTowKjAMRs3U5x1zWzOLzMM2xWiIs4TMOAp8oO5ZPyooqUQV6TrgUfvs
 4XLHQAUkd5BZOEYLMKXmPk8zskSmPb5Pn91sjKUgZaCy7TojNdcn2qz75AUXdlNXmocy
 1b2w==
X-Gm-Message-State: AOAM5330Y0b7YIudqCfW1OsxykVSe7URKcEVf0ZiQ3I4IX+ALkY10Uie
 dqvpgp1NPUb5hy/NwJMOLhlGewcqFYrSOdr6OTEdjw6ebqVRzpztHBKit+gI0f3FA0xjtJ9vMhd
 whyqsdVsDYJwSukXm+J9lMwxM5Df9Czw=
X-Received: by 2002:a5e:de03:: with SMTP id e3mr7220309iok.0.1592379501675;
 Wed, 17 Jun 2020 00:38:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw23rHmIcTnhGHpwcECh/2JOopvDieqt7ZE8HGdpc1+1Knm7SlrOhSHEKg6Sct4noJzP4myk97RExCnFiXVWxA=
X-Received: by 2002:a5e:de03:: with SMTP id e3mr7220296iok.0.1592379501460;
 Wed, 17 Jun 2020 00:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-3-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200616205721.1191408-3-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2020 11:38:10 +0400
Message-ID: <CAMxuvayz3cZh3x=RT8U1GwO_q7hZ5WdV68k=jWm2+Noys4FyyA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] tpm: Extend TPMIfClass with get_irqnum() function
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
Cc: Stefan Berger <stefanb@sbct-2.pok.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 12:57 AM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@sbct-2.pok.ibm.com>
>
> Implement get_irqnum() as part of the TPMIfClass to get the assigned IRQ
> number or TPM_IRQ_DISABLED (-1) in case IRQs cannot be used.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_tis_isa.c    |  9 +++++++++
>  hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
>  include/sysemu/tpm.h    | 12 ++++++++++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 30ba37079d..ed6d422f05 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_isa_get_tpm_version(TPM=
If *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>
> +static int8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateISA *isadev =3D TPM_TIS_ISA(ti);
> +    TPMState *s =3D &isadev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_isa_reset(DeviceState *dev)
>  {
>      TPMStateISA *isadev =3D TPM_TIS_ISA(dev);
> @@ -148,6 +156,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass=
, void *data)
>      dc->reset =3D tpm_tis_isa_reset;
>      tc->request_completed =3D tpm_tis_isa_request_completed;
>      tc->get_version =3D tpm_tis_isa_get_tpm_version;
> +    tc->get_irqnum =3D tpm_tis_isa_get_irqnum;
>  }
>
>  static const TypeInfo tpm_tis_isa_info =3D {
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index eced1fc843..86b3988be5 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_sysbus_get_tpm_version(=
TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>
> +static int8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(ti);
> +    TPMState *s =3D &sbdev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_sysbus_reset(DeviceState *dev)
>  {
>      TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(dev);
> @@ -137,6 +145,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *kl=
ass, void *data)
>      dc->reset =3D tpm_tis_sysbus_reset;
>      tc->request_completed =3D tpm_tis_sysbus_request_completed;
>      tc->get_version =3D tpm_tis_sysbus_get_tpm_version;
> +    tc->get_irqnum =3D tpm_tis_sysbus_get_irqnum;
>  }
>
>  static const TypeInfo tpm_tis_sysbus_info =3D {
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 03fb25941c..a81fb4e18e 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -25,6 +25,8 @@ typedef enum TPMVersion {
>      TPM_VERSION_2_0 =3D 2,
>  } TPMVersion;
>
> +#define TPM_IRQ_DISABLED  -1
> +
>  #define TYPE_TPM_IF "tpm-if"
>  #define TPM_IF_CLASS(klass)                                 \
>      OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
> @@ -41,6 +43,7 @@ typedef struct TPMIfClass {
>      enum TpmModel model;
>      void (*request_completed)(TPMIf *obj, int ret);
>      enum TPMVersion (*get_version)(TPMIf *obj);
> +    int8_t (*get_irqnum)(TPMIf *obj);
>  } TPMIfClass;
>
>  #define TYPE_TPM_TIS_ISA            "tpm-tis"
> @@ -74,4 +77,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>      return TPM_IF_GET_CLASS(ti)->get_version(ti);
>  }
>
> +static inline int8_t tpm_get_irqnum(TPMIf *ti)
> +{
> +    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
> +        return TPM_IRQ_DISABLED;
> +    }
> +
> +    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
> +}
> +
>  #endif /* QEMU_TPM_H */
> --
> 2.24.1
>


