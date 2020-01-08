Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1966C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A263820673
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiDhQIbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A263820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCgD-0001cQ-Pw
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipCfT-0000xz-2d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipCfR-0002TD-Ee
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:50:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipCfR-0002Sf-Av
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578495040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElzOg0cO/2AmOn8KxOMJ1emVUK8fyK7zTxitNtvOxrE=;
 b=IiDhQIbA6AXepRC8uCa9eD2QRJdSeFuEY17ofhXcL3PTeWYS1nmDiTFhi/IfqXtmj0G4sD
 qmeB22X/Aq/OflP6aN+np3Y6LOQIW4ouhQFGTWJBZ4cJfEELjljbrS21q7DAvWA/E6hnjO
 2NRLCWfP0xyAgC0TT6GFrY+4Dzr2HuM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-o2J7jYAAOxml1HS0mXM9dA-1; Wed, 08 Jan 2020 09:50:39 -0500
Received: by mail-wm1-f71.google.com with SMTP id o24so458505wmh.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 06:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FJVrR+3Ob0SZCyHNwmFYN9uxzyQ0cdH8+Sws1PCFSeM=;
 b=Xv3WI8RkOdku5cPG4bWoCSTmX8zyLa8fkn8OO7NW00Hb63sTi/5FJZZ/Lt++/l0Tdw
 XRVFVDqYNI9fJ5Rk5p3aFx3H8oqy+9wYLcEBD0LuBn2ErH0YLDL67afoNzVmy2fVWfOW
 aHJ7wYCXE2tDtOVRar9NL7TdRu7ldn/ADFvGMhXCQ8o0At1qIcF1Ukz6F1uBtVzKabtC
 XdyL7eZsW3o3JCNK5itk1rJAvUwYJ7+AUrBBgYfFDwtCod5A6dBuhNk/BiywcMLbmK5m
 327Nu05gMJ0V2E8sbgA4Qt4SjsSoAY1Be//OeDcektHzLdlSZ8l6eGP/iN1Msup6gE5H
 X+sQ==
X-Gm-Message-State: APjAAAWLzZZLLOznSikhAFmRr+lku/uuvMcEFVp+FoU8OP6TuC+/+T+I
 C/mWXleTs82bVq80UYre96DU57QE7kikzOl1gHWtbjjNlX+Hq1hPj0R0fFKSGe9VsxHAeab9i8I
 6Hr1zkGfIXcMd6hU=
X-Received: by 2002:adf:f64b:: with SMTP id x11mr5236186wrp.355.1578495037794; 
 Wed, 08 Jan 2020 06:50:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCTmLqXlIcNq5mUImdwII5LoawnzI8I8xU9evrVKmW+KtX0DkxWQqqzlGuoXl+uRsV7KRckQ==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr5236170wrp.355.1578495037571; 
 Wed, 08 Jan 2020 06:50:37 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id k16sm4520958wru.0.2020.01.08.06.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:50:37 -0800 (PST)
Subject: Re: [PATCH v3] ui: Print available display backends with '-display
 help'
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20200108144702.29969-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2911df9-f4b3-dc80-3934-127d648243a2@redhat.com>
Date: Wed, 8 Jan 2020 15:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108144702.29969-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: o2J7jYAAOxml1HS0mXM9dA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 3:47 PM, Thomas Huth wrote:
> We already print availabled devices with "-device help", or available
> backends with "-netdev help" or "-chardev help". Let's provide a way
> for the users to query the available display backends, too.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v3: Mention -display help in the qemu-doc, too (as suggested by Philipp=
e)
>=20
>   include/ui/console.h |  1 +
>   qemu-options.hx      |  3 ++-
>   ui/console.c         | 15 +++++++++++++++
>   vl.c                 |  5 +++++
>   4 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 281f9c145b..f35b4fc082 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -442,6 +442,7 @@ void qemu_display_register(QemuDisplay *ui);
>   bool qemu_display_find_default(DisplayOptions *opts);
>   void qemu_display_early_init(DisplayOptions *opts);
>   void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
> +void qemu_display_help(void);
>  =20
>   /* vnc.c */
>   void vnc_display_init(const char *id, Error **errp);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e9d6231438..d593931664 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1586,7 +1586,8 @@ STEXI
>   @item -display @var{type}
>   @findex -display
>   Select type of display to use. This option is a replacement for the
> -old style -sdl/-curses/... options. Valid values for @var{type} are
> +old style -sdl/-curses/... options. Use @code{-display help} to list
> +the available display types. Valid values for @var{type} are

Nicer, thanks!

>   @table @option
>   @item sdl
>   Display video output via SDL (usually in a separate graphics
> diff --git a/ui/console.c b/ui/console.c
> index ac79d679f5..69339b028b 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -2333,6 +2333,21 @@ void qemu_display_init(DisplayState *ds, DisplayOp=
tions *opts)
>       dpys[opts->type]->init(ds, opts);
>   }
>  =20
> +void qemu_display_help(void)
> +{
> +    int idx;
> +
> +    printf("Available display backend types:\n");
> +    for (idx =3D DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
> +        if (!dpys[idx]) {
> +            ui_module_load_one(DisplayType_str(idx));
> +        }
> +        if (dpys[idx]) {
> +            printf("%s\n",  DisplayType_str(dpys[idx]->type));
> +        }
> +    }
> +}
> +
>   void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error *=
*errp)
>   {
>       int val;
> diff --git a/vl.c b/vl.c
> index 86474a55c9..ee15055ba2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1869,6 +1869,11 @@ static void parse_display(const char *p)
>   {
>       const char *opts;
>  =20
> +    if (is_help_option(p)) {
> +        qemu_display_help();
> +        exit(0);
> +    }
> +
>       if (strstart(p, "sdl", &opts)) {
>           /*
>            * sdl DisplayType needs hand-crafted parser instead of
>=20


