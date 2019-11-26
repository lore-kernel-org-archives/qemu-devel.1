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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8405BC43215
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EC6206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LylHuu8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EC6206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWW9-0002hx-Hl
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWTK-0000Wx-8y
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWOR-0000Ln-Pd
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:40:20 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iZWOR-0000LU-Iw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:40:19 -0500
Received: by mail-wm1-x341.google.com with SMTP id g206so2209779wme.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WtOE8etY7xWBEq6eLoVzgO5P6Q/9tOOactLDktrwYWM=;
 b=LylHuu8w73qaDXDs662fLDpYDqsF1ga0dXfEiLfZxlKYYy5zRdm9jIrt8umAyqy6xK
 n2Lr0iU3J+nMZ8as3LWoZvUDxyGtE6a8SPJX3DVLHOQDYoYWDGo9CImfh7kbM9E9FABf
 qldl6PVBvlpY1KtbUibptNM3ciZvNV2VA0zRPFqvKwSy7dB8hTaxQXGIgFSM6m/mi/00
 PvlP60yHEWqrKbIBgUB1FgEhh4IOQmjFBBVGmSkZUZsYI5zQa82WRQZ5d8p3jzwO6EF9
 l2UOipzIjztXowt9gIx8pc5AVbq98r/ZokH273wEUTuA/14DKlId3/+jpNxwf90bLCPL
 +9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WtOE8etY7xWBEq6eLoVzgO5P6Q/9tOOactLDktrwYWM=;
 b=Q4dBQJ/Tj3hGOOc1YOtF06GhmH3hC+tkI68Lo842b0zOAiUDx9Azm1OaTwpoEY22oN
 7O3COYy0iqbDpHKsELXJiwl8XktEGlHbBKsCnROgw8kBu1v4KpmToh/5/YgTRK29X4An
 Y5df09WwlS/dLdGFO6MXWOkQZMtwCPI9vZmaP3vXr2RZa0U+brTvMothRtaEwf6m2CZe
 qcWPRsZd96+D8XH7B1wY79xj9psYuxuYNce2v65CaXmKEPwJw8kyIL/Fzh+L9ZcXk61z
 Ge8HVcGXxuSxdqtplGo9CeE6JgYlqzAGIoHZs/mThop8ArOWbHRri+2HnOkek5kf4uKG
 Hpdw==
X-Gm-Message-State: APjAAAWBVWJxUAWNtpn/RezaMPewj7oSHWSFFgnW8UJbcS4vIWTH/U2b
 IYXNsgnPxfN/GPACuuhrZR1x4NHThkKBN1CXxxI=
X-Google-Smtp-Source: APXvYqzQdVM1lts8kgT3f4T++w4J/g6h46IqD68W+MnsdDn7FVIFSoruHvUGX6moys/TIKK35Vw/M53fdaXveR3Aieo=
X-Received: by 2002:a7b:c748:: with SMTP id w8mr3184695wmk.114.1574757618549; 
 Tue, 26 Nov 2019 00:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20191125153619.39893-1-felipe@nutanix.com>
 <20191125153619.39893-3-felipe@nutanix.com>
In-Reply-To: <20191125153619.39893-3-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Nov 2019 12:40:04 +0400
Message-ID: <CAJ+F1CKLzVeduTWYpvT9+A==tNZ1nDGE7Q+rMhjEXL8mzWtLow@mail.gmail.com>
Subject: Re: [PATCH 2/4] ich9: fix getter type for sci_int property
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
> When QOM APIs were added to ich9 in 6f1426ab, the getter for sci_int was
> written using uint32_t. However, the object property is uint8_t. This
> fixes the getter for correctness.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Good catch! (I have a few like that in a series pending. This one I didn't =
spot)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


thanks


> ---
>  hw/isa/lpc_ich9.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 5555ce3342..240979885d 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -631,9 +631,9 @@ static void ich9_lpc_get_sci_int(Object *obj, Visitor=
 *v, const char *name,
>                                   void *opaque, Error **errp)
>  {
>      ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> -    uint32_t value =3D lpc->sci_gsi;
> +    uint8_t value =3D lpc->sci_gsi;
>
> -    visit_type_uint32(v, name, &value, errp);
> +    visit_type_uint8(v, name, &value, errp);
>  }
>
>  static void ich9_lpc_add_properties(ICH9LPCState *lpc)
> @@ -641,7 +641,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc=
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


--
Marc-Andr=C3=A9 Lureau

