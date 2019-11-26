Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7E5C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDC920722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amZeZymM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDC920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWWc-0003IQ-1y
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWTN-0000cq-G4
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWOH-0000DK-Ba
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:40:10 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iZWOH-0000Cs-5X
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:40:09 -0500
Received: by mail-wr1-x441.google.com with SMTP id i12so21415538wro.5
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0RAomX3zz/O2lEkeFLM4f19+KCfbzwZm7dq5h/O5n80=;
 b=amZeZymMZlHgcOeMvgp54Cz7Irvahm1tCcQR3fFNZluhfjgNuiNDGIDB7bPOp56R33
 EQI3PI2XvMNi4h8rSGhhE2lMIMBYRAya9Z5kArpRzoz/vaJqDfCeo4vGFKfiU6Sc0Ez6
 +52I6fH0scEbSSQiC+ZrwtdTphRQ8odkigjnhMmkUwb3Oq3mYIn6ZVKYi7fJny+iRDbW
 ZC+6HYeK+QCUmAEOR79akHiDy8tDZ3kjctq3Um3c4O+vMfYd/AzFYjmENuUxux3MK+d4
 nibhSZ5xt4AY5Lpn9AmPPa4AwjLUMIezBIyWRK8dLabKUa+XZpp+X82cbYrQTbggHJPD
 fZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0RAomX3zz/O2lEkeFLM4f19+KCfbzwZm7dq5h/O5n80=;
 b=G04Szlk1/PtZRPn77qvRG/MhYGak092oUteMa170OlKUPzJtpmOTBxB4jsFjPuYJ0t
 sZjPPvdgmrrByMQ18behS4TnGAiiHoMaei6R72uZtQtevQoEs2TJfDdLppkaWXBJ+P+m
 gSAF5/xuDvCJaLftd3X3cuEQ6QABV+LYhXlF6WfW4q7mTA9qe6TufCsRX/1Xh4R9AF0K
 eYqkFwlqakHFoqxVgp29fbt2mPaqeDa5AULhV12xQyuGvROqy/Syed8C/cX/ubWZUJza
 AexEXti8osFm97JIYSPLecqsJUapNBLgcU7wVZxuMKIt4u4GNfGmhASj2QPE74yvYRhl
 RnAQ==
X-Gm-Message-State: APjAAAUg6IVHdF7itE0VVWL7aqnD1nX0lGtMwcbC3Uweqq34zoFiPg0s
 fhOAW6TNeqE55YH25SppOr+DOPBSM2WToe0tIKI=
X-Google-Smtp-Source: APXvYqz1OjizoYTBKUfyYfiSV8D6Z1Dz6HI1NCXiYkhHBV4pujtIe+P8k6R2Dhd/JG2+kzNr8ELLy5XeaC4hsrCKxCE=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr33558713wro.370.1574757608176; 
 Tue, 26 Nov 2019 00:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20191125153619.39893-1-felipe@nutanix.com>
 <20191125153619.39893-4-felipe@nutanix.com>
In-Reply-To: <20191125153619.39893-4-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Nov 2019 12:39:54 +0400
Message-ID: <CAJ+F1CL-td89QeHeqvY3oVp4JpA9XJdyZbsMozawu7m7OnXeZA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ich9: Simplify ich9_lpc_initfn
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 7:37 PM Felipe Franciosi <felipe@nutanix.com> wrote=
:
>
> Currently, ich9_lpc_initfn simply serves as a caller to
> ich9_lpc_add_properties. This simplifies the code a bit by eliminating
> ich9_lpc_add_properties altogether and executing its logic in the parent
> object initialiser function.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

yep, /me like simpler code,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/isa/lpc_ich9.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 240979885d..232c7916f3 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -636,27 +636,22 @@ static void ich9_lpc_get_sci_int(Object *obj, Visit=
or *v, const char *name,
>      visit_type_uint8(v, name, &value, errp);
>  }
>
> -static void ich9_lpc_add_properties(ICH9LPCState *lpc)
> +static void ich9_lpc_initfn(Object *obj)
>  {
> +    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> +
>      static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
>      static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
>
> -    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
> +    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
>                          ich9_lpc_get_sci_int,
>                          NULL, NULL, NULL, NULL);
> -    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_=
CMD,
> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_ACPI_ENABLE_CMD,
>                                    &acpi_enable_cmd, true, NULL);
> -    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE=
_CMD,
> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_ACPI_DISABLE_CMD,
>                                    &acpi_disable_cmd, true, NULL);
>
> -    ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
> -}
> -
> -static void ich9_lpc_initfn(Object *obj)
> -{
> -    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> -
> -    ich9_lpc_add_properties(lpc);
> +    ich9_pm_add_properties(obj, &lpc->pm, NULL);
>  }
>
>  static void ich9_lpc_realize(PCIDevice *d, Error **errp)
> --
> 2.20.1
>


--
Marc-Andr=C3=A9 Lureau

