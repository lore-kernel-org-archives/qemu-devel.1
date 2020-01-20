Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651AFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312112073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzoFEAue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312112073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUuq-0007zd-6V
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itUft-0003ks-9v
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itUfo-0002EI-UT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:52:53 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itUfo-0002DX-MI
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:52:48 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so14005645wmc.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ro0KJeMJ1nY64zYwW38tAClp2psQe9pWZzMJrN43a7E=;
 b=mzoFEAuepaQj8tm5KEbuGihlBXEaynCpVncdwcuHCoAl+hMlg25+gla/bQdQbnmHM+
 XezuhzLSWDSQ86hxxLueoT1mjjZl5Dlq1a7AuQKUtqsme+lXKRqR+FDXHG3vB1a2iIHU
 meYpwaIM2+35sTEuE9YT7cPQrsjAxLdyKouBI+uAJtLOR8wHh4ORqTRC7gVnYXBdwAxS
 nJAotavaOyYPzKlYanKWfC2h814kokaTUXIpsaw7BkvmejgsavwhkmWmnJbC5h78vr/O
 03JmW2ElRNqIsD7ydfetjUwo8Tw/jb7+OFGaMNUFKEyew4/k/euoZ0pYLyNVv+qffy+D
 4o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ro0KJeMJ1nY64zYwW38tAClp2psQe9pWZzMJrN43a7E=;
 b=aCDzBo3x1ZmMmJM3HhWArB6+mRX3wG4kp1U96xzCpIlpwTZ+h89Nn8ZS0AlR0jpMka
 PYCiSxAmOdNBj1igsSL9BowTnU4VIY79QbAhnZRZwb3MnKcdowgKBwagso6u1zCqEuV8
 wrrXFgI7GXIrBWGIjQ3IJ+b4yeOn9RUJ1IgYkZTlDfX9Tlq4vgOO6sI0JOfKn3I7m8RA
 TuYNII4mXB6pJkhjlJLGbUnIz2vaywmHejpKh51z6Xdh9wUxY/bNpjhQocUCfpLf0AUV
 nT3q1mtvNvP5YdWO35aygGtVM4Ca5dS8U8BtM8pXC8h/GP/Jb797oE11zQEqHaye8x1g
 irng==
X-Gm-Message-State: APjAAAUZk4OQv9dH2SC1j1qca/k+Y85qEBf4y2BnDLyw91aKlOe5FxtG
 NDCXhm5AJ5vK48eC9+7R7wJzfA==
X-Google-Smtp-Source: APXvYqxfUE3gWjKVEBEZ7+zKMVX+rmS/11epGdIgj7msF8LjGZg34NIu1u9xPKvjak2Sl+NIDLYmiQ==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr18323247wmd.9.1579517567100; 
 Mon, 20 Jan 2020 02:52:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm47907776wrt.37.2020.01.20.02.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 02:52:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E14A1FF87;
 Mon, 20 Jan 2020 10:52:45 +0000 (GMT)
References: <20200116202558.31473-1-armbru@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
In-reply-to: <20200116202558.31473-1-armbru@redhat.com>
Date: Mon, 20 Jan 2020 10:52:44 +0000
Message-ID: <87lfq24cxv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
> modules" switched QAPISchema.visit() from
>
>     for entity in self._entity_list:
>
> effectively to
>
>     for mod in self._module_dict.values():
>         for entity in mod._entity_list:
>
> Visits in the same order as long as .values() is in insertion order.
> That's the case only for Python 3.6 and later.  Before, it's in some
> arbitrary order, which results in broken generated code.
>
> Fix by making self._module_dict an OrderedDict rather than a dict.
>
> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Well that certainly clears up a bunch of red. Can we apply it directly
as a build fix?

> ---
>  scripts/qapi/schema.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 0bfc5256fb..5100110fa2 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -795,7 +795,7 @@ class QAPISchema(object):
>          self.docs =3D parser.docs
>          self._entity_list =3D []
>          self._entity_dict =3D {}
> -        self._module_dict =3D {}
> +        self._module_dict =3D OrderedDict()
>          self._schema_dir =3D os.path.dirname(fname)
>          self._make_module(None) # built-ins
>          self._make_module(fname)


--=20
Alex Benn=C3=A9e

