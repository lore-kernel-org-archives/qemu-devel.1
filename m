Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C64C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E522071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTwkEL7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E522071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuHp5-0004mM-25
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuHnJ-0003PT-2D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuHnH-0007n8-Nd
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:19:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuHnH-0007mx-Jx
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579706386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJ413CEhblNYn4vlH0sMsKpk3NfdKlbb1RoMYsQ5ywQ=;
 b=NTwkEL7e8eWfgmo+o59Y8pguc4Zl0Wsvv6Djf7Er09dHpMZxNep8D2zVezRjDRLkMarswn
 Vz77WuHxewLx8ndX6emc8QHL8tsVXrEbYIQobtD+cwq8ztrG2dcDFYEidC6Bdb8G/p0qJK
 FKW7O9I6VDilI2XBfi2bZI10XdJtlCI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-1VbEZKC9M8aX6N0VgkKBww-1; Wed, 22 Jan 2020 10:19:44 -0500
Received: by mail-wr1-f72.google.com with SMTP id z15so3242834wrw.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ACl4OiVG7EfrIBoQGUM/v3FBk4GqUZpMyeu22Ccacp0=;
 b=F0p2sh+Zo45weqB3sl3a+H9JWLsbS/5qr9xkZYayg/4S/UYLog5MTSvCjRD54QLrEY
 5/Se/zA+aO7XALJ9Xrtmcx/6NrLIoytHhj8+CVJRpilESA5gWYr8bOXdJZASJ3XA1uBQ
 qlpf8HG2vHy4QdIt1yo76fPS48wNk7/YJF+QdYCOp7+O4kCYtbs34EqU77nvGQXq+Yvs
 SmOq/atjxG3IJ1r30cHHmy6w14KEgEMbFORWDq5t81M8iY9Kho9iR9eCV0bXSPZMwn/0
 poBLpgaKcGHGC75uVQbwYlX+QYCkEFBPQ73bHHKrPfks/8JuvtC7qSN/3QRWlR0PybZS
 xHqw==
X-Gm-Message-State: APjAAAUaGZHRBVYHAyoVsKfvlyJOMVzCUqIR+RL2gzIkIik0Ujvl/Jcs
 c4hgdIZZztqt2hvCSMqoWOODRRagefLMtUBev00HVTSzhjRGnst67DTZE3nCgDyxh+k+GuKgKiR
 LOOn/3wS+LZlaXh0=
X-Received: by 2002:adf:f18b:: with SMTP id h11mr12514080wro.56.1579706378690; 
 Wed, 22 Jan 2020 07:19:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd5jJJ0M/JqNnHt5sxEPAVLgZMwoSNWdtIKV9wF3nB0e9hGdnJYNlzBBbRlibUwZvll0dHkA==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr12514054wro.56.1579706378387; 
 Wed, 22 Jan 2020 07:19:38 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id b67sm4726090wmc.38.2020.01.22.07.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:19:37 -0800 (PST)
Subject: Re: [PATCH v2 057/109] docs: Add docs/tools
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-58-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd9ddde9-9ae1-ff5b-c9d7-c11903bd7bcc@redhat.com>
Date: Wed, 22 Jan 2020 16:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-58-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: 1VbEZKC9M8aX6N0VgkKBww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, Peter Maydell <peter.maydell@linaro.org>,
 misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Peter who is currently doing modification is this.

On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Create docs/tools based on docs/dev based on docs/devel.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   Makefile             |  9 ++++++++-
>   docs/index.rst       |  1 +
>   docs/tools/conf.py   | 16 ++++++++++++++++
>   docs/tools/index.rst | 12 ++++++++++++
>   4 files changed, 37 insertions(+), 1 deletion(-)
>   create mode 100644 docs/tools/conf.py
>   create mode 100644 docs/tools/index.rst
>=20
> diff --git a/Makefile b/Makefile
> index 18f52d6270..2375a1f81c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -822,6 +822,7 @@ endef
>   install-sphinxdocs: sphinxdocs
>   =09$(call install-manual,interop)
>   =09$(call install-manual,specs)
> +=09$(call install-manual,tools)
>  =20
>   install-doc: $(DOCS) install-sphinxdocs
>   =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
> @@ -1009,7 +1010,10 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host=
.mak
>   # and handles "don't rebuild things unless necessary" itself.
>   # The '.doctrees' files are cached information to speed this up.
>   .PHONY: sphinxdocs
> -sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/inter=
op/index.html $(MANUAL_BUILDDIR)/specs/index.html
> +sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
> +            $(MANUAL_BUILDDIR)/interop/index.html \
> +            $(MANUAL_BUILDDIR)/specs/index.html \
> +            $(MANUAL_BUILDDIR)/tools/index.html
>  =20
>   # Canned command to build a single manual
>   # Arguments: $1 =3D manual name, $2 =3D Sphinx builder ('html' or 'man'=
)
> @@ -1029,6 +1033,9 @@ $(MANUAL_BUILDDIR)/interop/index.html: $(call manua=
l-deps,interop)
>   $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
>   =09$(call build-manual,specs,html)
>  =20
> +$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
> +=09$(call build-manual,tools,html)
> +
>   $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
>   =09$(call build-manual,interop,man)
>  =20
> diff --git a/docs/index.rst b/docs/index.rst
> index baa5791c17..f15ca17bf4 100644
> --- a/docs/index.rst
> +++ b/docs/index.rst
> @@ -13,4 +13,5 @@ Welcome to QEMU's documentation!
>      interop/index
>      devel/index
>      specs/index
> +   tools/index
>  =20
> diff --git a/docs/tools/conf.py b/docs/tools/conf.py
> new file mode 100644
> index 0000000000..f9f76ff597
> --- /dev/null
> +++ b/docs/tools/conf.py
> @@ -0,0 +1,16 @@
> +# -*- coding: utf-8 -*-
> +#
> +# QEMU documentation build configuration file for the 'tools' manual.
> +#
> +# This includes the top level conf file and then makes any necessary twe=
aks.
> +import sys
> +import os
> +
> +qemu_docdir =3D os.path.abspath("..")
> +parent_config =3D os.path.join(qemu_docdir, "conf.py")
> +exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
> +
> +# This slightly misuses the 'description', but is the best way to get
> +# the manual title to appear in the sidebar.
> +html_theme_options['description'] =3D u'Tools'
> +
> diff --git a/docs/tools/index.rst b/docs/tools/index.rst
> new file mode 100644
> index 0000000000..adbcd3bc72
> --- /dev/null
> +++ b/docs/tools/index.rst
> @@ -0,0 +1,12 @@
> +.. This is the top level page for the 'tools' manual.
> +
> +
> +QEMU tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This manual documents various tools included with QEMU.
> +
> +Contents:
> +
> +.. toctree::
> +   :maxdepth: 2
>=20


