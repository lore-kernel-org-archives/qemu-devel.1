Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6936EC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F33214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfzlDVGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F33214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9psI-0007Px-CJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 08:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9prN-0006n6-15
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9prL-0002jR-Jj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:12:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i9prL-0002jC-CV
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568635918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=17WD0nVxljDzm3o40Oz2gLib+S4SFISJaDGPpRM5RJw=;
 b=FfzlDVGwpIPHMOxAEfXuK/RU1ypN1GHmSthi7GxqFOCFbW/HqSRZFFqo1mNla1RNWeOQ3f
 kba0SQAMSIE+VGuS954EJH4AwXfEe5yg83pnq3G6jMO8gvRJmfzoTpjWGOr1dhAfH8UQDu
 vz6q5jtzyBubb1tXMl9hkHs03KQLp3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-gAcSoA0vN2yxyGjYkq0WFQ-1; Mon, 16 Sep 2019 08:11:57 -0400
Received: by mail-wr1-f71.google.com with SMTP id z8so5960052wrs.14
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5DVTHvqOu6nKBfLneUjMAg25wAmlgg3qXoALvsCWNGg=;
 b=a6OctcKdeiB5956Pvo1ZpnW7fL1OgDF9VjcKTBc2fr52TNOJ/PLE2ezSGqhBIr9SjP
 iUxntivz3YY9BBywcj1osgJl7HVXbf2wCweYrFrrDwCRoQT1ofAybxFaAeQdCuE2/wWW
 jnZzHHr35uxoc4i1BAl3U1lyW+sHc518juknDKdjduhmCJ9Jm8L4okQx+IvwSisyrc47
 dXUfcBgu5AjcJc+wAdun7IQKImV6si01QkVtgR8mTLq3FiCeEGg5cB5HZbOg8C5SHuil
 mvn7uvBemvav544v6YScmcjD8Dire+kXXQkx5ZkaGphMnsNLXxOQ0/sfUDBblwNqEJq6
 LpNQ==
X-Gm-Message-State: APjAAAW5sWiJiE/Ntm4xmZ7ofx+yaLwIwn9HBdI8NySdVH3DV25JWEEW
 IDrhJY8rYH4ljwDy8npbS5SK15TrhxVL3sf/ikZL4Tps8JDGqgxOExzqZxgfGl3vH3Rh507F0Hn
 c67vJniYskJFGJRo=
X-Received: by 2002:adf:b3c1:: with SMTP id x1mr42485418wrd.33.1568635916442; 
 Mon, 16 Sep 2019 05:11:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/dkJujENyM7EBUHlAmYwRrfpe9awj5BVfOC5np7cHa3yTJiVX16InvvhWl/lTbB4fUUEKWQ==
X-Received: by 2002:adf:b3c1:: with SMTP id x1mr42485407wrd.33.1568635916270; 
 Mon, 16 Sep 2019 05:11:56 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t203sm14007205wmf.42.2019.09.16.05.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 05:11:55 -0700 (PDT)
To: James Le Cuirot <chewi@gentoo.org>, qemu-devel@nongnu.org
References: <20190914145155.19360-1-chewi@gentoo.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6f0b46b7-6e12-55bc-9e87-6919a124c1f3@redhat.com>
Date: Mon, 16 Sep 2019 14:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190914145155.19360-1-chewi@gentoo.org>
Content-Language: en-US
X-MC-Unique: gAcSoA0vN2yxyGjYkq0WFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
Subject: Re: [Qemu-devel] [PATCH] configure: Add xkbcommon configure options
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/19 4:51 PM, James Le Cuirot wrote:
> This dependency is currently "automagic", which is bad for distributions.
>=20

Fixes: 6a021536e23
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: James Le Cuirot <chewi@gentoo.org>
> ---
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/configure b/configure
> index 30aad233d1..30544f52e6 100755
> --- a/configure
> +++ b/configure
> @@ -1521,6 +1521,10 @@ for opt do
>    ;;
>    --disable-libpmem) libpmem=3Dno
>    ;;
> +  --enable-xkbcommon) xkbcommon=3Dyes
> +  ;;
> +  --disable-xkbcommon) xkbcommon=3Dno
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1804,6 +1808,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
>    capstone        capstone disassembler support
>    debug-mutex     mutex debugging support
>    libpmem         libpmem support
> +  xkbcommon       xkbcommon support
> =20
>  NOTE: The object files are built at the place where configure is launche=
d
>  EOF
>=20


