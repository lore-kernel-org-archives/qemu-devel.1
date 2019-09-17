Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D518FC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22362067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2UInnrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22362067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACqh-0003bj-Jp
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iACox-0002J9-VL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iACov-0006Jg-Mg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:43:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iACov-0006Iy-CY
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:43:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id 7so3257536wme.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SG/WcaoGxaX7MGJKGkNPY8Ua4ajn7nVTz+0Zp24VhXI=;
 b=K2UInnrpY9PdDvsvl3mWJSNsUVN9MDD7K5+UbNo2hQH+Jr4bxHpCKE9N061ArZP0F9
 rjH7PmrZ82CDeDod38Rp03WTGrYWV51sPsNcjQqCLXW0DwWV+H90+V4g5BMJd1/lY4tR
 U71yr+vAF+RJndHod3PJA+WUd+EEyC4Qnr8eVL/Wpy8Dbhn5rP53Z51IRS/4kpgJhujU
 cdEUzLrN8RHbz1qvhQ2BzUl91wQUKwOPY45vx+FD5uW4bhkvwWAsBHSpWbv85OGwFHnX
 fVIM0QsCqXK/dy0BzWPDBIaDImEs4spAhvROQ4KV6RGBaiR4ji1fUjjj1KH1HGo2BuJm
 aHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SG/WcaoGxaX7MGJKGkNPY8Ua4ajn7nVTz+0Zp24VhXI=;
 b=mb2G1LBxoCa2bLoS0tvqcxpqI93T6xcnM0ea95KWoNFYeHb+ScSGDIxPat3ueLtmPV
 VKtFHos6qj3vBRpiirEbEVXFieUpkGwdDB2vyCcDMW68a5f7FLfu/SbNMz9uyx4pGOPx
 JwpO8ye+w2MvmNa7d97IgestIq4nsZWLtYXj2KuKfJP8OY06c4g1MTrJlGkIPdm+YNCf
 MotOdmlkt4a+hFFAz/EkPi4vSebALCFIF+oBmg26vkWtBR3LahVlIMKRSxVCktmZQxsf
 P9buZtFq0gWD827ZJPXgQ60sEdQfxEIf+EwSf4CJlPyXFiF8rpXJhyCRpbXV9bg4FJqq
 zPJQ==
X-Gm-Message-State: APjAAAUQn85J/WtiowOfzKgkmM4rmE5V1fAxam7LotmyLI/ropH1ES9u
 rtvyI784UYfcDDUPgu0MC8Ciu9DGZ9GUqLJdkJU=
X-Google-Smtp-Source: APXvYqxVRhzyfQy+jwzgt7ROKuGTSgLM36VEvnWEhDoaC+E33PWHy8zaWG9LAL3JZApUCb234/aiQpP5+0FuDz5GV8g=
X-Received: by 2002:a1c:2144:: with SMTP id h65mr3544906wmh.114.1568724179380; 
 Tue, 17 Sep 2019 05:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190917122512.15320-1-johannes@sipsolutions.net>
In-Reply-To: <20190917122512.15320-1-johannes@sipsolutions.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Sep 2019 16:42:35 +0400
Message-ID: <CAJ+F1CJb_82Ut3gH8PAvq4aQhyUAa5eP4J8iwRSPavCwX3HxVA@mail.gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] libvhost-user-glib: use
 g_main_context_get_thread_default()
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
Cc: QEMU <qemu-devel@nongnu.org>, Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 4:26 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> If we use NULL, we just get the main program default mainloop
> here. Using g_main_context_get_thread_default() has basically
> the same effect, but it lets us start different devices in
> different threads with different mainloops, which can be useful.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user-glib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhos=
t-user/libvhost-user-glib.c
> index 824c7780de61..53f1ca4cdd73 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.c
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -89,7 +89,7 @@ vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
>      src->gfd.events =3D cond;
>
>      g_source_add_poll(gsrc, &src->gfd);
> -    id =3D g_source_attach(gsrc, NULL);
> +    id =3D g_source_attach(gsrc, g_main_context_get_thread_default());
>      g_assert(id);
>
>      return gsrc;
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

