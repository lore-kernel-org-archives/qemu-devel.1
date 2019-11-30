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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2591C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 07:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD8320732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 07:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn4hHtww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD8320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaxZQ-0003Ks-VX
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 02:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaxYT-00027Y-5Y
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaxYS-0001yc-3u
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:52:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iaxYR-0001yF-U2
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:52:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id y5so17323037wmi.5
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 23:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=67rCHtSPHo/0ald1lYl365LzhnR9aoEOZWyZr0wOsoA=;
 b=Cn4hHtwwKwEztaYIYgXs23MnTk9u/Zdola00Xp/C9xvjgoD92LWmQ0zbIeyzhLB63V
 G+JB/X09vvp0z7TqxEhlQGEsphDvsgSD6QNTUCSLvPhprVytiknuXMdzggSTbT1LFH1I
 ic1SiOAuhgI5hejgAMsK2vPUcPni1LzVaRFW8RhNrlj03bievfW6pKhS6sKVMzJCpKwc
 jbXmEzrK9sx1+mKP6h9EXuIgjQqS8wrJgohuVgbhx8E9yuhwJm1zwIn4tay98Q/c+AxY
 haAlw6Gty2RebRAEiBp8El7WskErN9hCcUClyk+T9oIWOhS+5C71avhpwZeX3w1EcoGe
 8yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=67rCHtSPHo/0ald1lYl365LzhnR9aoEOZWyZr0wOsoA=;
 b=Md0k9Y4JvO8Q0v9CI/tphY1BCjagCTCjKcpesJUkbKyMH0HFjS7cMd63vHHMcUQc8a
 FrwZTnR8+6thi7+hVBVK9NKc4gdASFn77M2ZgEnXvmtrxrYKmVcsT4uaq/lf1uVL0D3z
 P03H6EsN219P8/3JFe2Bgg/pODRCz8NFCkQacSvRlRmp2iP/11bqwNxRU9/6LarEVLZT
 wvqSXesJT1apYGuLnzRqpZYPrRHocxp6pTo8yapxds1Adf9pMuz8lYBPYis/u8gJIhMq
 L/VPFxSh5VwTp+rJMgp5ZdkCOVghLwvjLtQz9YRv6+shXF2jVUCoBchESGkTxtFRAlhW
 sofA==
X-Gm-Message-State: APjAAAWD7M/KO5PLJ06+yWwemprus/1qAA72rvnVSPgYPGz7kwQCSdjc
 P1szhO6k08TTQNlQcQNotCGdvKKPTEfQpSfPjOo=
X-Google-Smtp-Source: APXvYqxoyb60w7Ylcw22AqHTMrYWPX5Q96DHjUoeRJBMPWyO9VgWVG1+Vvr/jmpvx7s1mEewY6lAlF7bjdEb2oDU3bE=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr18429276wmh.5.1575100354767; 
 Fri, 29 Nov 2019 23:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20191129174630.6922-1-felipe@nutanix.com>
 <20191129174630.6922-4-felipe@nutanix.com>
In-Reply-To: <20191129174630.6922-4-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 30 Nov 2019 11:52:22 +0400
Message-ID: <CAJ+F1C+9Nj-JzS8oqToY1LzYj+4w_emmUtUt5OYUvexdiR1w4w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ich9: Simplify ich9_lpc_initfn
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
> Currently, ich9_lpc_initfn simply serves as a caller to
> ich9_lpc_add_properties. This simplifies the code a bit by eliminating
> ich9_lpc_add_properties altogether and executing its logic in the parent
> object initialiser function.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/isa/lpc_ich9.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 9f4e00dddd..c40bb3c420 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -634,12 +634,14 @@ static void ich9_lpc_get_sci_int(Object *obj, Visit=
or *v, const char *name,
>      visit_type_uint8(v, name, &lpc->sci_gsi, errp);
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
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_=
CMD,
> @@ -647,14 +649,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lp=
c)
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE=
_CMD,
>                                    &acpi_disable_cmd, OBJ_PROP_FLAG_READ,=
 NULL);
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


--=20
Marc-Andr=C3=A9 Lureau

