Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A2BC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CE22072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHKtrO23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CE22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioPBg-00081s-1u
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 05:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioPAt-0007LG-AX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioPAs-0005he-2I
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:59:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioPAr-0005gh-V7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578304788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTe2S/qKyy6usxHbnOSlZI6zVERzDLKtbGzepRnHNso=;
 b=dHKtrO23KcVs3oQzKmE+TPW7hvbSwEQBHdaPZ7SCyrCzH/izF0U9XU6alpYIu8gonDMdzt
 utUSNPN5ilW/9wv+OPHReQ4232PdHgWk3WuYbdmstkHXLpYETqcbz/zk/fHj2a3evkwaeu
 L4KVs5ew1Ds0Z6KDGGXcM/8FCEK3E18=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-LRQusaexNJGkax7dtZrEHA-1; Mon, 06 Jan 2020 04:59:47 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so1848391wrp.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 01:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=toeKQXHi8c85WI9A7K/0KFPyElcbcdM7Z+eyv09AMos=;
 b=aog5W7WA879TActF6QpqrP47DM9hMDGJ09ZY95VmWUumkRRhb/W+bh9DhQxrzqoIxD
 5DcXIOvv7HFj4StaF6LLnWhjMWmAgw/FysiV/LxxKo75MVWt2JhF9lIITrmbBOJO7WW7
 gLeq8xQqlq9cpzi2uoXhGpIpl2x+yokgNmdT7TbKEcnZ+pNY88RO8qEhEMWHt2VVFtKJ
 7m0cxjzbQyjckyD2o+qFiCaJfYvwYQnfxhjl0jqlQnAqtQimHV7Fbz8JwR4vdTTqLb/S
 e879/UX+comCjVrdtV0KL08WLw7/Hv72rqzP2jxKp+FX9FtsvZKbWduFaSChilUqzbJa
 oL8w==
X-Gm-Message-State: APjAAAW599bS8G51G/rWmp0YKpwcgIy0oTygN0hDEe5ly8RFSMpGz5RB
 hmFSGHYPG3H/4bEgJEld5hIMBYEoTS0BwZEe3Fahadi4XWIACmYrSw/6yQzrNykW6F8RRgpTt5L
 l1fTfo3vEDPoXns8=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr105200899wrc.69.1578304786035; 
 Mon, 06 Jan 2020 01:59:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd5z47fiYRlYCJH1pipBY4S3zhQhJTWl/h57Pvf/HpBTvieRUt8BthhJLjRpM6NGdzztAQUQ==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr105200869wrc.69.1578304785755; 
 Mon, 06 Jan 2020 01:59:45 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id z21sm22907261wml.5.2020.01.06.01.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 01:59:45 -0800 (PST)
Subject: Re: [PATCH v2] ui: Print available display backends with '-display
 help'
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20200106093313.17081-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3a9700da-5d9b-6dfd-c0dd-a0871392fadf@redhat.com>
Date: Mon, 6 Jan 2020 10:59:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106093313.17081-1-huth@tuxfamily.org>
Content-Language: en-US
X-MC-Unique: LRQusaexNJGkax7dtZrEHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 10:33 AM, Thomas Huth wrote:
> We already print availabled devices with "-device help", or available
> backends with "-netdev help" or "-chardev help". Let's provide a way
> for the users to query the available display backends, too.
>=20
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   v2: Now it should work with modules, too
>=20
>   include/ui/console.h |  1 +
>   ui/console.c         | 15 +++++++++++++++
>   vl.c                 |  5 +++++
>   3 files changed, 21 insertions(+)
>=20
> diff --git a/include/ui/console.h b/include/ui/console.h
> index f981696848..b7e1a8e6c0 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -440,6 +440,7 @@ void qemu_display_register(QemuDisplay *ui);
>   bool qemu_display_find_default(DisplayOptions *opts);
>   void qemu_display_early_init(DisplayOptions *opts);
>   void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
> +void qemu_display_help(void);
>  =20
>   /* vnc.c */
>   void vnc_display_init(const char *id, Error **errp);
> diff --git a/ui/console.c b/ui/console.c
> index 82d1ddac9c..9556b5d8dd 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -2330,6 +2330,21 @@ void qemu_display_init(DisplayState *ds, DisplayOp=
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

Consider updating the manpage too:

-- >8 --
diff --git a/qemu-options.hx b/qemu-options.hx
index e9d6231438..d86ec0332a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1585,8 +1585,9 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
  STEXI
  @item -display @var{type}
  @findex -display
-Select type of display to use. This option is a replacement for the
-old style -sdl/-curses/... options. Valid values for @var{type} are
+Select type of display to use. Use @code{-display help} to list
+available displays. This option is a replacement for the old style
+-sdl/-curses/... options. Valid values for @var{type} are
  @table @option
  @item sdl
  Display video output via SDL (usually in a separate graphics
---

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


