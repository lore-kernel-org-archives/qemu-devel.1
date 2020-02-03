Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFABC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F112080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLUM7fwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F112080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeVn-0004R3-D7
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iyeUu-0003pF-9n
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iyeUt-0002XF-3t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:22:52 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iyeUs-0002W3-Tu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:22:51 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so17937239wma.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QKEp+jXKKLuQr1KAJEcdARvkI43mrP8FJZo8RoWhiW0=;
 b=PLUM7fwtt6sj3QnCBOZdRZa3dCDhDZkdgrQtWW1rocc1X20D/RYOSKNAKvBlJiVcbe
 I8VMBwzjFmn0aZ2q7ut6l1XC94GNV5JDbXxGLmaSP4Z9oVrv4re5BA5xWSxanZOdDE1m
 SYt/Meua9IdgZifF3V0yEtC/+lzAXhWyucf05YVYBSTuH6gjtCumgXxfdf45uA8Um0W6
 uCkN8bTIFbYCQRlCU+Us6bmjiW+U6XfrwDdKZsp2Sb3pqGl4Gr9j8ylkOjveDH7s27R/
 7SbHJcpA8Dlc1ZVMYX/21pStFIUe/ClLy/So00RR35IOjwhuelOpv6262XV+BBEkK67I
 p6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QKEp+jXKKLuQr1KAJEcdARvkI43mrP8FJZo8RoWhiW0=;
 b=X58ji74I31DJs4bAzoLSIpgtsYB6s4/QR9PNiPtUiV86lVw37Z8WAWvspx11ubLNBo
 9FgPVI/rRUb6C22G3gHgNnnEgHY1e6QlrpoZkFvu7RpMzO4vAwjvt8pJAvwdopYUTH80
 mgFy/Tj1CJUNTp9j+jIW8niwhIEnvV49APlKvljdY/3caigynPWzmb1k52o7UPbeZ/ZM
 E554xidNLTsRixydv2CsbAQWdrIoQmhHZwRHnEZ0/+DCpYDPSKcVowTuuBE88taQtHew
 DRNeXXYnX329tPMSMkO0IWc9MkaDgALUOk+3kZfiv+qKwheBhKG4t6rEDWLvtV9YNyUj
 /Wuw==
X-Gm-Message-State: APjAAAXfpLaAfQx0kJQ54653omYQ+7ALJYYH8qighs/mYAjUzOZECTdo
 oNlj355EwR2lQQ/kH0M8c6pb9koSqoia6oLuaIV5tX3f
X-Google-Smtp-Source: APXvYqz6Q67QPy4nRD47jlmxhhK3uDMUjxg7w3NR2wXlOLyr0+34dX1OxTO0uhKoYcoeWvlqH1ffMewlu/d5atKa3Zg=
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr30888252wmj.4.1580746968175; 
 Mon, 03 Feb 2020 08:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20191114144725.2310-1-marcandre.lureau@redhat.com>
In-Reply-To: <20191114144725.2310-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Feb 2020 17:22:34 +0100
Message-ID: <CAJ+F1CKuWLxd-es8h1pggW152crviTLKFg7FAs3N-J7SJPUn1A@mail.gmail.com>
Subject: Re: [PATCH v3] qemu-gdb: add an Object pretty printer
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 3:50 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Inspired by GObject/GType pretty printer.
>
> Example:
> machine_set_accel (obj=3D0x555556807550 [pc-i440fx-4.0-machine],...
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
>  scripts/qemu-gdb.py | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  mode change 100644 =3D> 100755 scripts/qemu-gdb.py
>
> diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
> old mode 100644
> new mode 100755
> index f2a305c42e..b9fc1d10d4
> --- a/scripts/qemu-gdb.py
> +++ b/scripts/qemu-gdb.py
> @@ -18,6 +18,9 @@ import gdb
>
>  import os, sys
>
> +if sys.version_info[0] < 3:
> +    int =3D long
> +
>  # Annoyingly, gdb doesn't put the directory of scripts onto the
>  # module search path. Do it manually.
>
> @@ -44,3 +47,58 @@ coroutine.CoroutinePCFunction()
>  # Default to silently passing through SIGUSR1, because QEMU sends it
>  # to itself a lot.
>  gdb.execute('handle SIGUSR1 pass noprint nostop')
> +
> +
> +def is_object(val):
> +    def is_object_helper(type):
> +        if str(type) =3D=3D "Object":
> +            return True
> +
> +        while type.code =3D=3D gdb.TYPE_CODE_TYPEDEF:
> +            type =3D type.target()
> +
> +        if type.code !=3D gdb.TYPE_CODE_STRUCT:
> +            return False
> +
> +        fields =3D type.fields()
> +        if len (fields) < 1:
> +            return False
> +
> +        first_field =3D fields[0]
> +        return is_object_helper(first_field.type)
> +
> +    type =3D val.type
> +    if type.code !=3D gdb.TYPE_CODE_PTR:
> +        return False
> +    type =3D type.target()
> +    return is_object_helper (type)
> +
> +
> +def object_class_name(instance):
> +    try:
> +        inst =3D instance.cast(gdb.lookup_type("Object").pointer())
> +        klass =3D inst["class"]
> +        typ =3D klass["type"]
> +        return typ["name"].string()
> +    except RuntimeError:
> +        pass
> +
> +
> +class ObjectPrinter:
> +    def __init__(self, val):
> +        self.val =3D val
> +
> +    def to_string(self):
> +        name =3D object_class_name(self.val)
> +        if name:
> +            return ("0x%x [%s]")% (int(self.val), name)
> +        return  ("0x%x") % (int(self.val))
> +
> +
> +def lookup_type(val):
> +    if is_object(val):
> +        return ObjectPrinter(val)
> +    return None
> +
> +
> +gdb.pretty_printers.append(lookup_type)
> --
> 2.24.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

