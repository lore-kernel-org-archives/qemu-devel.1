Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E7DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B778C20739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+I4RHQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B778C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuXU-0000gR-WD
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkuWr-00007w-TU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:12:21 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkuWq-00027I-5Q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:12:21 -0400
Received: by mail-ej1-x641.google.com with SMTP id q19so18643868eja.7
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bw5EWZwJdryTfD1cOARTbA9YOCUGnb5fS9W5xNi/UjY=;
 b=G+I4RHQLs5qqAf8ncXRvJvCxiOm83LbrupfnbqR6q0ile1FqUQ7l/WfHN/r7/zO1Yq
 FESkBuTSFrIcghdVKNNpB5+PCPY55oKcaHmgvVmKjR6NoPfyK2SHqmEEjIGmWzMhPeJp
 baTt43JzDnAq2diGPqrNlfsyimAMoB6v2n8qRifZnJXdtMmQmd6PehkSu0V3H1nUXn6e
 W2rqp+yuSEc5FqMEWu5B+2id57TKWxxot2T8BdjXh3rTiXAdHTrwLDIhczsJoBtpk3Mj
 x4lwX4xWuUe1zLEDy9HaWQTV/prsn6sxXMxzrSkL+P4UtFBk6IGEfWF+7lJ9C38Df9vQ
 FYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bw5EWZwJdryTfD1cOARTbA9YOCUGnb5fS9W5xNi/UjY=;
 b=hc/RuTQpYFxXf6ICzdTmcL0RZSHEPnRi1u2DVIJ8bdiw5nMWLWliAPf1fqcnus69g7
 eF3rt38wdLmcCdc1UC9cPdMdnp2QLZjoc8f6yXpJjD6pn9Aq4Sj0skLQg/NgKmbau7s6
 /WyBjZtEFPWNsQJ7BE2RYjNIPXg8H6AtRcj8OMo1lJ3JohiSHza1gFeiKzXMQhDa5ZlA
 Ode6R+Rc3E99bWXNNpTcBt7J4MVUgIbpoGDnD6DSwd2YpZojpOp0WcshdhRdr6/BGzjt
 CPkMYH5CftSutJ8HONoyI6kj/WrULEI43gIppQZM629H24qryZPKHoTKmPUYGXOjaouS
 EozA==
X-Gm-Message-State: AOAM531s7wzZ+IuSoyikxFVXiLrTkWHN9s6TlwosfH3zbyYIoUlgCAGR
 kUbYuSTLdwPi40sy85ZAOOrIXwNVYgKdRyUuTLg=
X-Google-Smtp-Source: ABdhPJwGItUbaZFUp5dwEyNxmIIZ6JVTj6rUjnkd2kAICWTtzRrluDW3KEbisVpw2sYDwnPFIAmxhnmLI6O2wIfst7Y=
X-Received: by 2002:a17:906:46d0:: with SMTP id
 k16mr26747416ejs.76.1592248338038; 
 Mon, 15 Jun 2020 12:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200611114523.15584-1-aleksandar.qemu.devel@gmail.com>
 <20200611114523.15584-2-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200611114523.15584-2-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 15 Jun 2020 21:12:07 +0200
Message-ID: <CAL1e-=gJb++0hYtUDC+haB3fNeThO8=yFO8waHS1h4Dw6utEKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] translations: Add Swedish language
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Sebastian Rasmussen <sebras@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 1:52 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> From: Sebastian Rasmussen <sebras@gmail.com>
>
> This patch adds translation of QEMU to Swedish.
>
> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---

Applied to MIPS+misc queue.

>  po/sv.po | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 po/sv.po
>
> diff --git a/po/sv.po b/po/sv.po
> new file mode 100644
> index 0000000000..1e430edd65
> --- /dev/null
> +++ b/po/sv.po
> @@ -0,0 +1,75 @@
> +# Swedish translation of qemu po-file.
> +# This file is put in the public domain.
> +# Sebastian Rasmussen <sebras@gmail.com>, 2019.
> +#
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: QEMU 2.12.91\n"
> +"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
> +"PO-Revision-Date: 2019-08-16 21:19+0200\n"
> +"Last-Translator: Sebastian Rasmussen <sebras@gmail.com>\n"
> +"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
> +"Language: sv\n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=3DUTF-8\n"
> +"Content-Transfer-Encoding: 8bit\n"
> +"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
> +"X-Generator: Poedit 2.2.3\n"
> +
> +msgid " - Press Ctrl+Alt+G to release grab"
> +msgstr " - Tryck Ctrl+Alt+G f=C3=B6r att sluta f=C3=A5nga"
> +
> +msgid " [Paused]"
> +msgstr " [Pausad]"
> +
> +msgid "_Pause"
> +msgstr "_Paus"
> +
> +msgid "_Reset"
> +msgstr "_Starta om"
> +
> +msgid "Power _Down"
> +msgstr "St=C3=A4ng _ner"
> +
> +msgid "_Quit"
> +msgstr "_Avsluta"
> +
> +msgid "_Fullscreen"
> +msgstr "_Helsk=C3=A4rm"
> +
> +msgid "_Copy"
> +msgstr "_Kopiera"
> +
> +msgid "Zoom _In"
> +msgstr "Zooma _in"
> +
> +msgid "Zoom _Out"
> +msgstr "Zooma _ut"
> +
> +msgid "Best _Fit"
> +msgstr "Anpassad _storlek"
> +
> +msgid "Zoom To _Fit"
> +msgstr "Zooma ti_ll anpassad storlek"
> +
> +msgid "Grab On _Hover"
> +msgstr "F=C3=A5nga vi_d hovring"
> +
> +msgid "_Grab Input"
> +msgstr "F=C3=A5n_ga inmatning"
> +
> +msgid "Show _Tabs"
> +msgstr "Visa _flika"
> +
> +msgid "Detach Tab"
> +msgstr "Frig=C3=B6r flik"
> +
> +msgid "Show Menubar"
> +msgstr "Visa menyrad"
> +
> +msgid "_Machine"
> +msgstr "_Maskin"
> +
> +msgid "_View"
> +msgstr "_Visa"
> --
> 2.20.1
>
>

