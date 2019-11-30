Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F34FC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 07:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CC820732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 07:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5i44htS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CC820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaxYE-0001lN-9O
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 02:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaxXE-0000gi-BC
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaxXD-00014V-6V
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:51:20 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iaxXD-00014E-0d
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:51:19 -0500
Received: by mail-wm1-x342.google.com with SMTP id u8so1787899wmu.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 23:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jTVGgo+dJuyqSobNUSePHKWmo8yex4/soowUkUSeHl8=;
 b=S5i44htS1PIi1uyQGwajIx7gC4oRoyCJWqHuTNBJBt28b6uky5ee5xB+RMJNG6fqBm
 UGKRezWzOivMXz2lUYq2/0nClcx9pWOoi7JKOrTfcMhSI8wB6Kwia9aizSMLipvVj19a
 I70y9AYKfMGz6M9Cc/2a1M+XbPv3y1YCT0758KjtMjt2IdaIJyuxZoJE/EwkJ/zu+bTN
 rXxO3MicgSy74eAPYSFOv21YaC8yASJAmmdULB+/Clv/nkAPdWlMeNzvB/HBb1z5t22P
 lDY1gR4oz0/nLNQzvbONzyUjpViAISz8OYRkGAUfD/jOPkyIT/iq26f9M7GT33Jt2TUC
 MnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jTVGgo+dJuyqSobNUSePHKWmo8yex4/soowUkUSeHl8=;
 b=Qb41gejr4VxaVAAdwsuSCGjkfCac+RuP01k4ZMzTBcQ5K/51vvNG8Bb1XwMF8Tnk1I
 wrTrHi+yw6zoF/SjcVvK554t/O+HaPYq0eRl1XBtjS3tqKuroIP35dYONw+xXQIBKPYe
 rjo8vJniu2CLQw2LFrMtwY7+RHeFw4eFpXZpKdIAK5Q/qVqJd2i1axmQyorvA38+vjOq
 BEbKLMfY6Utwt1evqCnnzEGj3c4U/Qx/GERGiTc9/9BtJY4lep6la1AEwvlpxR9uUlMA
 3qWwhpAJ/zQewRCrCHA5Ra5OKV91buX3UiuaVVeFc6WFXuczLaaIj3e9d/9JQm40aIAJ
 wV9Q==
X-Gm-Message-State: APjAAAVmkPDrSFFEGCdmgPPGjBFesWKGQ2L5y8U2mEg4b7BgomUfYUPP
 3aGZ/7lruWNKErg7ATMcfplWuTemcZ5tYA7FwWskjbEVeHQ=
X-Google-Smtp-Source: APXvYqz/Qg2DqxoiVPxERaCNiNncjs0u/6OhdPuMWP+6ZaJgKtu+wavD5nsTpu5sXM5ehqe6o2nVnyKRxwGoGtlDqiE=
X-Received: by 2002:a1c:4b03:: with SMTP id y3mr7570019wma.91.1575100277888;
 Fri, 29 Nov 2019 23:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20191129174630.6922-1-felipe@nutanix.com>
 <20191129174630.6922-3-felipe@nutanix.com>
In-Reply-To: <20191129174630.6922-3-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 30 Nov 2019 11:51:05 +0400
Message-ID: <CAJ+F1CJ8AhGBL_+8BXQFbkc-2=ycru1z=aWw-Gcv2u=2WSw13Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ich9: fix getter type for sci_int property
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 9:46 PM Felipe Franciosi <felipe@nutanix.com> wrote=
:
>
> When QOM APIs were added to ich9 in 6f1426ab, the getter for sci_int was
> written using uint32_t. However, the object property is uint8_t. This
> fixes the getter for correctness.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  hw/isa/lpc_ich9.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 99517c3946..9f4e00dddd 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -631,9 +631,7 @@ static void ich9_lpc_get_sci_int(Object *obj, Visitor=
 *v, const char *name,
>                                   void *opaque, Error **errp)
>  {
>      ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> -    uint32_t value =3D lpc->sci_gsi;
> -
> -    visit_type_uint32(v, name, &value, errp);
> +    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
>  }
>
>  static void ich9_lpc_add_properties(ICH9LPCState *lpc)
> @@ -641,7 +639,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc=
)
>      static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
>      static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
>
> -    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint32",
> +    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
>                          ich9_lpc_get_sci_int,
>                          NULL, NULL, NULL, NULL);
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_=
CMD,
> --
> 2.20.1
>


--=20
Marc-Andr=C3=A9 Lureau

