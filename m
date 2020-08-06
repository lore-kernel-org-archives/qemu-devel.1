Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4440CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E6B22CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNef9oiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E6B22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bZj-0001Ld-RY
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k3bZB-0000vt-Cy
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:48:01 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k3bZ9-0001qz-Fy
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:48:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id t14so8877116wmi.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KvgzoOXz0p2hw5PBbzJ9+wJNmCEzZWT9U8qAdLbRU4g=;
 b=rNef9oiYJhGS3UOtvhqqwOBCRqs5PH0/N8Inf2Vw9zFhPr8BEDxAWkm/rilCs7uZwa
 EsnrLsobRRSC9wOoPn9jKP/M++rBaqtZsdSfgs+jECHmp+6sqB0a3ItPTGl4Jr8Vo3xh
 hk8x2ynXUSvZxVCJfRWFu837ZPGRQk8ajUaP5pDxQpAInGygx3hFbUQYoQHaIScHN5m6
 gssl1zR7jZ1Can9jsevxYErOKWIoWngi4yDTFOSQ+GhAcKfumPxzaa6ELkwUDSI4nV72
 8D/U4bvMNzB/JjCtmHSGNgreHe0Ys0VMjX5q8j52afa3dJbRL3NYTvWFMfhq1ZocFxud
 dAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KvgzoOXz0p2hw5PBbzJ9+wJNmCEzZWT9U8qAdLbRU4g=;
 b=XlDWH0JWQBiMgBvq/MUh4G+egsvZR2cBQSH5u800vQASuBtfnBGhbFBFL8AgkS6+ei
 333hjVkTjCHMdHoe9d8AhIrTDVhKF8HNqfwYr6EdwjcrHzxnJZL40EE7q4teEGRkDFZe
 sWSJT5eHVLkxuosgqBy4W5f3fHbE491JpJc2GZ+a3XfaPdqJU1h5gk4N+Xp9l3hpzz9f
 s+jqSBnKCjaZ2xjFckj4jo21f9r8P3idE4heLakAy89/R+tmiLYaAe1Lc1A1hypgCJjA
 DFgyACzrHQzm0geB81zASyIhgrh3P8DSOW2bVK7dsQwM7eoHLahpYTfaub7WSZY//G5i
 W+VA==
X-Gm-Message-State: AOAM5333jwpdGbDEUe3zon/dj6H1681R4efJ66Rl7Yyjq52z8VsdU+uR
 JHisr/bQx4c5H0RfaNAO2qSVQIR8iqbfGNV1oSo=
X-Google-Smtp-Source: ABdhPJxqMw4rlVN7GgfvSbvK1FBeo/eS2vvCDjnsr8MwMwvIDjlzyOYalsbwvsIzOo3Vz94jMi32TR8Mm90LfR+RxGU=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr6896281wmh.55.1596703676429; 
 Thu, 06 Aug 2020 01:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200806081147.3123652-1-armbru@redhat.com>
 <20200806081147.3123652-3-armbru@redhat.com>
In-Reply-To: <20200806081147.3123652-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Aug 2020 12:47:44 +0400
Message-ID: <CAJ+F1CLjvzbr3C6YMdW7o6VYNiYHZz-47zXVsiL0b3WyV4GFdQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] qapi: Document event VSERPORT_CHANGE is rate-limited
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000071fb2205ac318ba4"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000071fb2205ac318ba4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Aug 6, 2020 at 12:13 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Commit e2ae6159de "virtio-serial: report frontend connection state via
> monitor" neglected to document the new event is rate-limited.  Fix
> that.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/char.json | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> diff --git a/qapi/char.json b/qapi/char.json
> index 8aeedf96b2..b4d66ec90b 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -562,6 +562,8 @@
>  #
>  # @open: true if the guest has opened the virtio-serial port
>  #
> +# Note: This event is rate-limited.
> +#
>  # Since: 2.1
>  #
>  # Example:
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000071fb2205ac318ba4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Aug 6, 2020 at 12:13 PM Markus Armbru=
ster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Commit e2ae6=
159de &quot;virtio-serial: report frontend connection state via<br>
monitor&quot; neglected to document the new event is rate-limited.=C2=A0 Fi=
x<br>
that.<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank">e=
blake@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qapi/char.json | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br></blockquote><div><br></div><div>R=
eviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@r=
edhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</div><div>=
 <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/qapi/char.json b/qapi/char.json<br>
index 8aeedf96b2..b4d66ec90b 100644<br>
--- a/qapi/char.json<br>
+++ b/qapi/char.json<br>
@@ -562,6 +562,8 @@<br>
=C2=A0#<br>
=C2=A0# @open: true if the guest has opened the virtio-serial port<br>
=C2=A0#<br>
+# Note: This event is rate-limited.<br>
+#<br>
=C2=A0# Since: 2.1<br>
=C2=A0#<br>
=C2=A0# Example:<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000071fb2205ac318ba4--

