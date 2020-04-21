Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36478C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0026A20672
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlsNxUeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0026A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqPg-0000ZN-5d
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQqNa-0006cU-5F
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQqNZ-00066a-4q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:43:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQqNY-00062w-Ms
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:43:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id k13so14707295wrw.7
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9GAsn5FGRD24k96jq5Eq8w9dxag0MtLH5Ga85ZNCR3I=;
 b=IlsNxUeEc84twfXN+HebcbiTaXURZFISq5MlqabMOfxkofncjTovm9PH+bKXFQZUz5
 a8L6mr4CfJQlo2hEMybbBrrKsAA2Q3nNmILwE5+WYPq7nhkkKUfa3/nSzVBJXzq365uv
 aNOKjBVEZ4KPvrT3A1DEDXDiBGcUbPxbvWk6fL/G2NkGzxGfkTXeO7RKhUXQveAiKRMV
 Ijzuuv1peu0ZN/sQBdw45HAI9Uk0KQj2PZMqip2wMiOgFxsxqbLXa8gdCY2BPuLgYm3W
 GrESgNn1rhQZG+YY5YNkFE1sXDsG2qyeWulBAXROXhHhrZkO4DUY+9tRCe8K6+oUSgfD
 E0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9GAsn5FGRD24k96jq5Eq8w9dxag0MtLH5Ga85ZNCR3I=;
 b=PualmQ18virHmKyO3x+am8VXPfpolWI68rvJJ3ERbcwMT5OEaDE2gVld5j7LSUEoZY
 jyxe+Cky6K+2wl4qZjl+W0P8DilryyG72+zNoa6d8eITrPL70EoWMaAW8TClPPWrNstC
 HSdflAEAG7ohbO8qb7lZyTkvzoTd/in6Ldvrk0UkOexJ1rCFCAbZejBQf5hOSRcWI2Iy
 LzQAdt4brascVlJIKvMvTi1xzlR2FjJRsmRv5u4noed+Y+SkrTDpXPir3BaVqeXrzP4K
 Nk70NvfLMwPnTYK3CY4x713nADtgBYcYDAMZnDMqg1eXXCMixCC8qkxlT3fLdv0hGUde
 imKg==
X-Gm-Message-State: AGi0PubazXz+he4bGqLF1435zs2O6NZi5a0GH0iCBqO60Mvb6VoFZhK7
 zcIZ+tupAZuA8Fcs9lXZWX7cDQ==
X-Google-Smtp-Source: APiQypIvCViB+2cammKn32B+F4ftiz8j8+L6GTnn4E9PpP0MudeITRhQsRuIxm7alsD0Flo8j2cQEQ==
X-Received: by 2002:adf:b344:: with SMTP id k4mr22684870wrd.76.1587465826066; 
 Tue, 21 Apr 2020 03:43:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 74sm3231946wrk.30.2020.04.21.03.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 03:43:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F1EBA1FF7E;
 Tue, 21 Apr 2020 11:43:43 +0100 (BST)
References: <20200421094216.24927-1-f4bug@amsat.org>
 <20200421094216.24927-3-f4bug@amsat.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/4] scripts/qemugdb: Remove shebang header
In-reply-to: <20200421094216.24927-3-f4bug@amsat.org>
Date: Tue, 21 Apr 2020 11:43:43 +0100
Message-ID: <871rohdsps.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> These scripts are loaded as plugin by GDB (and they don't
> have any __main__ entry point). Remove the shebang header.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  scripts/qemugdb/__init__.py  | 3 +--
>  scripts/qemugdb/aio.py       | 3 +--
>  scripts/qemugdb/coroutine.py | 3 +--
>  scripts/qemugdb/mtree.py     | 4 +---
>  scripts/qemugdb/tcg.py       | 1 -
>  5 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/qemugdb/__init__.py b/scripts/qemugdb/__init__.py
> index 969f552b26..da8ff612e5 100644
> --- a/scripts/qemugdb/__init__.py
> +++ b/scripts/qemugdb/__init__.py
> @@ -1,5 +1,4 @@
> -#!/usr/bin/python
> -
> +#
>  # GDB debugging support
>  #
>  # Copyright (c) 2015 Linaro Ltd
> diff --git a/scripts/qemugdb/aio.py b/scripts/qemugdb/aio.py
> index 2ba00c4444..d7c1ba0c28 100644
> --- a/scripts/qemugdb/aio.py
> +++ b/scripts/qemugdb/aio.py
> @@ -1,5 +1,4 @@
> -#!/usr/bin/python
> -
> +#
>  # GDB debugging support: aio/iohandler debug
>  #
>  # Copyright (c) 2015 Red Hat, Inc.
> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
> index 41e079d0e2..db61389022 100644
> --- a/scripts/qemugdb/coroutine.py
> +++ b/scripts/qemugdb/coroutine.py
> @@ -1,5 +1,4 @@
> -#!/usr/bin/python
> -
> +#
>  # GDB debugging support
>  #
>  # Copyright 2012 Red Hat, Inc. and/or its affiliates
> diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
> index 3030a60d3f..8fe42c3c12 100644
> --- a/scripts/qemugdb/mtree.py
> +++ b/scripts/qemugdb/mtree.py
> @@ -1,5 +1,4 @@
> -#!/usr/bin/python
> -
> +#
>  # GDB debugging support
>  #
>  # Copyright 2012 Red Hat, Inc. and/or its affiliates
> @@ -84,4 +83,3 @@ def print_item(self, ptr, offset =3D gdb.Value(0), leve=
l =3D 0):
>          while not isnull(subregion):
>              self.print_item(subregion, addr, level)
>              subregion =3D subregion['subregions_link']['tqe_next']
> -
> diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
> index 18880fc9a7..16c03c06a9 100644
> --- a/scripts/qemugdb/tcg.py
> +++ b/scripts/qemugdb/tcg.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/python
>  # -*- coding: utf-8 -*-
>  #
>  # GDB debugging support, TCG status


--=20
Alex Benn=C3=A9e

