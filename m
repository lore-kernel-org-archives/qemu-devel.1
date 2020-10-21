Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEA6C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168BB22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtVEn6GZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168BB22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8jc-0008UN-Qs
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kV8gw-0005id-PB
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:37:50 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kV8gq-0005e3-7p
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:37:50 -0400
Received: by mail-ed1-x543.google.com with SMTP id x1so1588902eds.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+VVkhlQLWO9Utq6tZKTBXQJKQBGR0v46MXlIFHvNQdM=;
 b=YtVEn6GZO1PPrc/mcQtR4tfaGzirmonn+Vn6t1F6g+mg6Na/od/VmHi7p6JaKbxWzF
 vK5hfd7hMQEx48Rqwhj+fqonP/Vl1hcr5ZaKYzoYeUca6dA9gT/u+aKyE+h3StRMi+gq
 1NFyqdicGPVxgbsICX7T6CnVLdwfHcG5Lef2VABPFyYyRopGnaBci8WrIFl2o4h1l5WI
 VEXH1ACkgGmgKynhU/e4j/gxHSifVs0rXKONXWHWkpD1Qw4dIyA+3defEqmVRu26r30M
 AnRM31TRvFkCdzAXQ04zyt2Q6wZfjp0yMgDjGZwtcAnN2HHrxZ+q4WmWnyqxMX7tO7Ge
 6qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+VVkhlQLWO9Utq6tZKTBXQJKQBGR0v46MXlIFHvNQdM=;
 b=nlJJb7wEGeeV3HlYB6Wba1gkmw5hGyse9GjdDrWG3ooERUxAAUAZO50KxDdmZ14AVo
 8pinASF2Tp/tkz7HNutoYBIphYf/ggQuRLth64tojmavKBz6neSLYyKyVN/hNI9xxGHp
 T06HEkenKFBJobAoFNhv+Xa+XkoIOdmzlNjS7kzQJ/g85G3Fc3MifTyNeHsw7wrM3meq
 aQ9dgg2ZoPkrb0UrMuGClF4lGt6148dhrAGJueto4y2eZJOHfbNmA5Sy39is1Z9qvJGj
 YuWJQtN38Q/LdFy8Kqx1Gv9/v4xdYOpgvp2xIEi7RfjtPM/3hMxgtQHg7uFUmvmJPntu
 zh9Q==
X-Gm-Message-State: AOAM5332pSuajd7G8JKu3kxtzPiCjhvBSwRNANUN8LhVcFl7ZjiNkN+W
 yvjhUx/htBodDjjo3bqusI45/bTyqvM8r6y7BF4=
X-Google-Smtp-Source: ABdhPJxb0faR/scPicLzL9b4VBWOBp27XOFaVkYK3mnP+TlxtO/bMD7n6B4jTaba3I3tJVTiUIkqZ+zWFekvkWucoDc=
X-Received: by 2002:aa7:ca45:: with SMTP id j5mr1809668edt.245.1603265861824; 
 Wed, 21 Oct 2020 00:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201021071520.2168877-1-armbru@redhat.com>
 <20201021071520.2168877-4-armbru@redhat.com>
In-Reply-To: <20201021071520.2168877-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 21 Oct 2020 11:37:29 +0400
Message-ID: <CAJ+F1CLvg+nE0yHtpZB5M19EYmXHvebDzJ+NjXDVsKw8jWt1Og@mail.gmail.com>
Subject: Re: [PATCH 3/4] qga-win: Fix guest-get-devices error API violations
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002cb3c005b2296caf"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002cb3c005b2296caf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 11:19 AM Markus Armbruster <armbru@redhat.com>
wrote:

> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> qmp_guest_get_devices() is wrong that way: it calls error_setg() in a
> loop.
>
> If no iteration fails, the function returns a value and sets no error.
> Okay.
>
> If exactly one iteration fails, the function returns a value and sets
> an error.  Wrong.
>
> If multiple iterations fail, the function trips error_setv()'s
> assertion.
>
> Fix it to return immediately on error.
>
> Perhaps the failure to convert the driver version to UTF-8 should not
> be an error.  We could simply not report the botched version string
> instead.
>
> Drop a superfluous continue while there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qga/commands-win32.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index b01616a992..1efe3ba076 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2385,7 +2385,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>          device->driver_name =3D g_utf16_to_utf8(name, -1, NULL, NULL, NU=
LL);
>          if (device->driver_name =3D=3D NULL) {
>              error_setg(errp, "conversion to utf8 failed (driver name)");
> -            continue;
> +            return NULL;
>          }
>          slog("querying device: %s", device->driver_name);
>          hw_ids =3D ga_get_hardware_ids(dev_info_data.DevInst);
> @@ -2428,7 +2428,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>              NULL, NULL);
>          if (device->driver_version =3D=3D NULL) {
>              error_setg(errp, "conversion to utf8 failed (driver
> version)");
> -            continue;
> +            return NULL;
>          }
>          device->has_driver_version =3D true;
>
> @@ -2452,7 +2452,6 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>              cur_item->next =3D item;
>              cur_item =3D item;
>          }
> -        continue;
>      }
>
>      if (dev_info !=3D INVALID_HANDLE_VALUE) {
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002cb3c005b2296caf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 21, 2020 at 11:19 AM Mark=
us Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The=
 Error ** argument must be NULL, &amp;error_abort, &amp;error_fatal, or a<b=
r>
pointer to a variable containing NULL.=C2=A0 Passing an argument of the<br>
latter kind twice without clearing it in between is wrong: if the<br>
first call sets an error, it no longer points to NULL for the second<br>
call.<br>
<br>
qmp_guest_get_devices() is wrong that way: it calls error_setg() in a<br>
loop.<br>
<br>
If no iteration fails, the function returns a value and sets no error.<br>
Okay.<br>
<br>
If exactly one iteration fails, the function returns a value and sets<br>
an error.=C2=A0 Wrong.<br>
<br>
If multiple iterations fail, the function trips error_setv()&#39;s<br>
assertion.<br>
<br>
Fix it to return immediately on error.<br>
<br>
Perhaps the failure to convert the driver version to UTF-8 should not<br>
be an error.=C2=A0 We could simply not report the botched version string<br=
>
instead.<br>
<br>
Drop a superfluous continue while there.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandr=
e.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> </div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qga/commands-win32.c | 5 ++---<br>
=C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index b01616a992..1efe3ba076 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2385,7 +2385,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device-&gt;driver_name =3D g_utf16_to_utf=
8(name, -1, NULL, NULL, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (device-&gt;driver_name =3D=3D NULL) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;conv=
ersion to utf8 failed (driver name)&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slog(&quot;querying device: %s&quot;, dev=
ice-&gt;driver_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_ids =3D ga_get_hardware_ids(dev_info_d=
ata.DevInst);<br>
@@ -2428,7 +2428,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (device-&gt;driver_version =3D=3D NULL=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;conv=
ersion to utf8 failed (driver version)&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device-&gt;has_driver_version =3D true;<b=
r>
<br>
@@ -2452,7 +2452,6 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur_item-&gt;next =3D item;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur_item =3D item;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dev_info !=3D INVALID_HANDLE_VALUE) {<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000002cb3c005b2296caf--

