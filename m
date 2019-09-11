Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146C4ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38472085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiwXBIsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38472085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xsP-0005Na-1p
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7xrX-0004K6-SW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7xrV-0004yO-P4
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:20:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7xrS-0004xK-GV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:20:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id t16so23435702wra.6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JO4c1BD4HgWjkDwdSldjPGwHAT1BaLDoDUuWEl6h8wk=;
 b=wiwXBIsEfRtCToGDXgo7xIcJOMPnOPenkvviNE/wdT9VyU7UA4IIXxNC+Oukjqig9n
 vX4JE6m383qY/h4YPz6zJI5KLEWCGRfEfvtEqshoao5kAPAFd5qw2qglhB3nVse/XKJJ
 bYIXOGTebFQ3e1fn74xmK0mi3iLFO4oltnApCbbf1uDIRqARzYwfzgEUm+WZTKMsT7h7
 mUZS/f23ULMXEyDQhGARveqpddJEREoDkER+QmYI7184ZVaLZJnWtoaZfBFjc1XmwkCF
 a0iqJGmQ+RXeZyizLoPWTTRhPQmUTgbLsIl+WAEgPD5m/Qd9T8YqCCz9Y6+KN4LMm555
 x8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JO4c1BD4HgWjkDwdSldjPGwHAT1BaLDoDUuWEl6h8wk=;
 b=gClur7+UQ7JOs3ll5B8srVGoZH//d4wHMCyYzQWK5imCgSKiobO/+dsf11Q5Vew167
 w3hivQ0Kw8yU1DpDnJBaWmvt3RN2S3pyLchMH8Z49FUhLObJdBpc0lJO3iKaycWyKBEk
 3z+syeF0g+3rSo1ioboMQCTHVrp2Ze3t7KQsbz7ZY9f9/ceYzDAk7UOjXxLa92FX5RIe
 A2ymDHtWMmx5cLtMKlZOMCVazKyMU/lSkcloAuZJZz8ZhM/fusGhbynyJiQmbn7aOTf7
 SaC/2foInXpbtZ3uMMHfYSN8OgXqFrTE9p1R2f3FaP26zXuZl7LhIOeLekUw0VEDHYwR
 ewqA==
X-Gm-Message-State: APjAAAXEdS9QxkwxCJnl9RZBytbLPI0ltRqs0pCO4jA1EWkA3XKVwax9
 IXykxbfJ35H26qsyOFa8sr5+og==
X-Google-Smtp-Source: APXvYqysSIy0xKTb4g6fK/Z/pc6DF5rumZhG5OvWQ/NQuomIMn4P042PlNTd1XMm3ewladkgNGGM+w==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr9527010wrm.112.1568190018931; 
 Wed, 11 Sep 2019 01:20:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c8sm7551068wrr.49.2019.09.11.01.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:20:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C015E1FF87;
 Wed, 11 Sep 2019 09:20:17 +0100 (BST)
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-4-alex.bennee@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
In-reply-to: <20190910193408.28917-4-alex.bennee@linaro.org>
Date: Wed, 11 Sep 2019 09:20:17 +0100
Message-ID: <878sqv1by6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 3/4] elf: move elf_ops.h into
 include/elf/ and rename
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Lets keep all the Elf manipulation bits together. Also rename the file
> to better reflect how it is used and add a little header to the file.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/core/loader.c                            | 4 ++--

It is arguable this could be a private header in hw/core as it is only
included in one place.

>  include/{hw/elf_ops.h =3D> elf/elf_ops.inc.h} | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>  rename include/{hw/elf_ops.h =3D> elf/elf_ops.inc.h} (98%)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index e0c6563e643..886179a4947 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -302,7 +302,7 @@ static void *load_at(int fd, off_t offset, size_t siz=
e)
>  #define elf_word        uint32_t
>  #define elf_sword        int32_t
>  #define bswapSZs	bswap32s
> -#include "hw/elf_ops.h"
> +#include "elf/elf_ops.inc.h"
>
>  #undef elfhdr
>  #undef elf_phdr
> @@ -324,7 +324,7 @@ static void *load_at(int fd, off_t offset, size_t siz=
e)
>  #define elf_sword        int64_t
>  #define bswapSZs	bswap64s
>  #define SZ		64
> -#include "hw/elf_ops.h"
> +#include "elf/elf_ops.inc.h"
>
>  const char *load_elf_strerror(int error)
>  {
> diff --git a/include/hw/elf_ops.h b/include/elf/elf_ops.inc.h
> similarity index 98%
> rename from include/hw/elf_ops.h
> rename to include/elf/elf_ops.inc.h
> index 1496d7e7536..a820bd821d5 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/elf/elf_ops.inc.h
> @@ -1,3 +1,12 @@
> +/*
> + * Macro expansions for Elf operations. This is included in a
> + * compilation unit with appropriate definitions for SZ and elf
> + * headers to generate utility functions for reading 32 and 64 bit elf
> + * headers.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
>  static void glue(bswap_ehdr, SZ)(struct elfhdr *ehdr)
>  {
>      bswap16s(&ehdr->e_type);			/* Object file type */


--
Alex Benn=C3=A9e

