Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A60C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DFE217AB
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhsbK8cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DFE217AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabjW-0004OT-2W
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iabHW-0006BF-V8
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iabHS-00029w-IO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:05:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iabHS-0001uf-7U
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:05:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id f129so13928345wmf.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J9JetO+uhJXA5OT8wAQIKGJ1b25Un92xYXGpLfxp5oY=;
 b=DhsbK8cAFsaCAlVAMiVxICNCpqi3OESlZiB2UHbSTAZpcETCc5UOBnzYdfOMV1Sv/h
 rG+nC9o81r5fXxQIkgjc+90Fgow8rzk81i6MGsVqqrVgUV5zZg6+p6+QJv0PS50Bqktj
 tcJanpW/hV0f6Hpsg3hPjdAEVS6GRSFJcRA1V+5lkwCcOHPAHHFJQR0UPTnPanQ7TKa3
 h/kkFHTxYTRHpEL0KiaP+l257Eeq4WuHjWfJzcF9X3c+h/FjhyU90LWV4nv9RtZwnyj/
 TKFs5KcEr8HURaVMsGNUv9AornGxR9Mhd0CFiEG3clTkvoAIrlhjQhXb8RqkSwxjf7Te
 7TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J9JetO+uhJXA5OT8wAQIKGJ1b25Un92xYXGpLfxp5oY=;
 b=ZKqK1ZYo5bcHDvbCiRN41oVY4X8vhK5zh8M2c2dMH5MuqItM/pg/aJmM05DV8yYwz0
 kz/gXMfcW8yAvtCDrPPfsRrAvwnGXD7EvdRpmicOv3qNqrVT32MU2OAoPdSpanWXAXtA
 LyEwQlY7Zh+KqQiR54Jw1Jx2EnI0xMWvMSBQudpbH1GkEvdwQdrWjc7RYTlbTPNXX37p
 kqq++90LqTP7kUsJ9i1wrRkcRMvKuLWtrcewIJXm+x3hAXPRPriNBPq1YpG1heBTqQNp
 aYe4Fxsn4RWkQ9TRNqsG2JOeGSCRVp3z/4QWmUltowgNb6QNhdYVfxOZPm515/XEjJNj
 77bw==
X-Gm-Message-State: APjAAAUTFxy5ZlypAMdgX60+lD8TiBdUaKomxeBVgESV5RxhXjAaFmie
 bAjDNpoTyI4usXV6v3nZibhldKH9jw0msJZHSTY=
X-Google-Smtp-Source: APXvYqxT7cTQK/Xs1jA2VVA4ALckISk+Yv9+B1enKTbLqYQTzyFkpcjwVebulzuzuDzS05RSrmqGcHO9xHTLdMsdFFo=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr12594677wmi.107.1575014730534; 
 Fri, 29 Nov 2019 00:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20191128164810.54279-1-felipe@nutanix.com>
 <20191128164810.54279-3-felipe@nutanix.com>
In-Reply-To: <20191128164810.54279-3-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Nov 2019 12:05:18 +0400
Message-ID: <CAJ+F1C+p_Sz6abgsYAyty4BwLDX4=rFTSnSV82E6ioVVpLRWdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ich9: fix getter type for sci_int property
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

On Thu, Nov 28, 2019 at 8:48 PM Felipe Franciosi <felipe@nutanix.com> wrote=
:
>
> When QOM APIs were added to ich9 in 6f1426ab, the getter for sci_int was
> written using uint32_t. However, the object property is uint8_t. This
> fixes the getter for correctness.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/isa/lpc_ich9.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index f5526f9c3b..3a9c4f0503 100644
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

