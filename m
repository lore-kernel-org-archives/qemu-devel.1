Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B689C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D7820656
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHtKB1bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D7820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Z5S-0006No-24
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2Z1C-0003ks-J1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2Z1A-0003AP-Qa
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:48:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i2Z1A-00035L-9C
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:48:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id c5so2482996wmb.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G6Xz5b9mQGLHmuLuTvASA++wPnpdR1LdTE7PleJrzho=;
 b=hHtKB1bZRDBbewFTrp9jG8GS1+x5NruohJAm09biCTrhouQjfPK9kv1ExzGDrltrwN
 tPHURRpwOX/CNLRottPBbpEZO+KUddOmVvZoNj7RftPWSEW7UhWGdJiGNaHJewPtU5hU
 EXugG86AeF/wuaJxj/0yCb/p0VChJFGO5/n5VIiF8tH2cy5hii1JfbAGlbHumfYxhIvU
 pNJYKD+/8PhZZrAzcIYV01+AejZ8srin6JXmjaORurFP77CbUKX2/rn1YEyBfrgQoauW
 ATe07+9L67KrEcxZm5JgX8VAnR/AfSopkkIAkicNqamXIi/sFjlhvNp21clSid76UwrQ
 yTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G6Xz5b9mQGLHmuLuTvASA++wPnpdR1LdTE7PleJrzho=;
 b=UA0iTcnZ8ZK0WomoRhD2wFH3qmFL6WeCko3mINaD8x+VNwZHY+oHKfKZ6e+Pwys0N7
 Gi2i5tLg6FdyoW1HdFzMc6+ZnUDxWi+xZ2JOuW1cm0c5ws3UxI6SSEfA5jDJpA3QsJ7B
 eTHq7orYjmxkuM5M1T/2CMY3tpLwtoUyWK0b/9H7wsx6H5FbXv1QwV3ikjQ98QYDp+VD
 hD5zEUokqVKwv8tgTV9hSJ7AnQKAodR738MY1i0vdXoLanX2meYcVUxe0J9AGdBws2Gz
 67eQWJCn+gYH6eGEKftUGuO2g2R44XSKQ77al5hwfpdMg1B2/9lOStbqNV1xT4ITB5IB
 iE7w==
X-Gm-Message-State: APjAAAX39evtCdU9uBhdfc29p+a1ao5aB/Mk5NEnIbHQzDAmmONlS0Ul
 y3AW3R2hjP4ytZRw3DdCFm71gcEFPLiEC6Z6y3I=
X-Google-Smtp-Source: APXvYqwbfKJSCRtpviQIApT5V5ttEz9jPijxivzoO6vqMd/szPHHAQK+QgusVF55UeVmdLhLOxZWTO/j9obMU2/FXDc=
X-Received: by 2002:a05:600c:22c6:: with SMTP id
 6mr27666268wmg.5.1566902881030; 
 Tue, 27 Aug 2019 03:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190827083124.30791-1-johannes@sipsolutions.net>
In-Reply-To: <20190827083124.30791-1-johannes@sipsolutions.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Aug 2019 14:47:48 +0400
Message-ID: <CAJ+F1CJo+oo74_Y6c1PGKq4uULUKXwky3cxSpopxLVmcow-9_w@mail.gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] libvhost-user-glib: fix VugDev main fd
 cleanup
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
Cc: QEMU <qemu-devel@nongnu.org>, Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Aug 27, 2019 at 12:32 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> If you try to make a device implementation that can handle multiple
> connections and allow disconnections (which requires overriding the
> VHOST_USER_NONE handling), then glib will warn that we remove a src
> while it's still on the mainloop, and will poll() an FD that doesn't
> exist anymore.
>
> Fix this by just using the internal add_watch() function that has
> all necessary cleanups built in via the hashtable, rather than
> treating the "main" fd of a device specially.

It would be easier to see a backtrace of the error (under gdb with
G_DEBUG=3Dfatal_criticals)

>
> Fixes: 8bb7ddb78a1c ("libvhost-user: add glib source helper")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user-glib.c | 3 +--
>  contrib/libvhost-user/libvhost-user-glib.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhos=
t-user/libvhost-user-glib.c
> index 99edd2f3de45..a092a55c1d57 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.c
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -146,7 +146,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket=
,
>      dev->fdmap =3D g_hash_table_new_full(NULL, NULL, NULL,
>                                         (GDestroyNotify) g_source_destroy=
);
>
> -    dev->src =3D vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
> +    set_watch(&dev->parent, socket, VU_WATCH_IN, vug_watch, NULL);
>
>      return true;
>  }
> @@ -157,5 +157,4 @@ vug_deinit(VugDev *dev)
>      g_assert(dev);
>
>      g_hash_table_unref(dev->fdmap);
> -    g_source_unref(dev->src);

I think the main problem here is that src is not owned, since
vug_source_new() does g_source_unref(). This is looks unfortunate.

However, the source should be destroyed (detached from the main
context). I think this is ultimately what your change is about.

Imho, we should change the behaviour of the function to return a ref
source. This needs fixing the hashtable destroy callback. It will be
more consistent with other usages of the functions that also need
fixing in contrib/vhost-user-input/main.c for example.


>  }
> diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhos=
t-user/libvhost-user-glib.h
> index 64d539d93aba..32a6ec6df063 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.h
> +++ b/contrib/libvhost-user/libvhost-user-glib.h
> @@ -22,7 +22,6 @@ typedef struct VugDev {
>      VuDev parent;
>
>      GHashTable *fdmap; /* fd -> gsource */
> -    GSource *src;
>  } VugDev;
>
>  bool vug_init(VugDev *dev, uint16_t max_queues, int socket,
> --
> 2.23.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

