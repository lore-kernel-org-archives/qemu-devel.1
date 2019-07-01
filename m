Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F0C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5B12064B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1H1IU8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5B12064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxjT-00080B-MO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhxgj-0006As-A8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhxgf-0002ZM-IY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:53:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhxgb-0002TX-Ne
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:53:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so13749598otq.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=bgom+nP1QWgSFbrB0IS8xgnIOpgWEpmoZxXAbxaRQ8g=;
 b=A1H1IU8hMSJwB1xRkDnUCpJ+ZUE915ks9cQtjhVZmpFjTjnjbx3RzyBAYBeqcZhXbE
 9g9Zk9QnWlxdBNbpcDaQYZMapIgYb/jf7W3g918ItB7KqzJkLp5ExKwIWsfPm+yktchK
 j43wo2JNmEEZk+mj9lS6BkOqBCtCqGFKVyFYqpdkvI+lx7Pr58/P497rf/cRu6QZXWIy
 ZdKh4DNHdzoDPI8+LmeNEZm/SRtDnxrjrAIDz2HZX1c1oB8Mwq7lMrku1LVtdkCsBdiu
 CzophROA3XAxEz/rCLB7fHUOy2IKLoDV5/ZvOo0Z/kQF2NBcv0SuoqNbMf0LhxID7EfL
 HfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=bgom+nP1QWgSFbrB0IS8xgnIOpgWEpmoZxXAbxaRQ8g=;
 b=uJmqV/CY8xYS8b9PmS52WPXZQ+Dc6TCWBl6lTpCpYfQuOE+z3Rffjja/fl5x6Nfad5
 QypHxStnGwDbzEjkl/rUN38UVX6i7QTcmxKnLKc4KIgSKiPouh/HA978G8BBn+oX0AbT
 f/2MzVnFwy1IEK0BQI4JCYyE2YJiGRUeGiMj/HV0MfeSUjQVq/Lv0gzYA4XhuqkC2AoH
 0Igm28L5qN7ehtpmP1bLV1TAUDIxe7FqgDcdavaxb5F/xcnLB2q8RoP3BaKX6baqdzSA
 jE43YqmjyIwgY6xzUEeigKyC8xCSqxLP6DyxizKdcnQSfgLuc0B/DgQajDCci+dEKTyv
 Viqg==
X-Gm-Message-State: APjAAAVbZAjclHLldSolWbR44SCGH3KvNJbB8jcU0TQIcMVHEjKqVIqy
 ChB6hae29xJb2W1qDlwZRZR7xxb1GKYIYca2BY4=
X-Google-Smtp-Source: APXvYqy9F8qXLHcyPIvaJudQzkcx6izfiN3qVoJ3u/ze/jQyN6JQwSNlX8EZreEg/56CUh9SuwtwcGeD+xeUsvVWmtA=
X-Received: by 2002:a05:6830:c6:: with SMTP id
 x6mr19623330oto.64.1561992820729; 
 Mon, 01 Jul 2019 07:53:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 07:53:40 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 07:53:40 -0700 (PDT)
In-Reply-To: <20190701140143.32706-1-philmd@redhat.com>
References: <20190701140143.32706-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 16:53:40 +0200
Message-ID: <CAL1e-=iogUENT-RESCwCs+tjLD7DBqJ3GamLyythSdcqQ9M==g@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] tests/machine-none: Test recent MIPS cpus
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 1, 2019 4:45 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> w=
rote:
>
> The MIPS I7200 got added in commit d45942d908e, and the I6500
> in commit ca1ffd14ed8.
> Extend the coverage on the little-endian machines.
> The 4Kc and 20Kc are still covered by the big-endian machines.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  tests/machine-none-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 4c6d470798..5953d31755 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -36,9 +36,9 @@ static struct arch2cpu cpus_map[] =3D {
>      /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu
any */
>      /* FIXME: { "microblazeel", "any" }, doesn't work with -M none -cpu
any */
>      { "mips", "4Kc" },
> -    { "mipsel", "4Kc" },
> +    { "mipsel", "I7200" },
>      { "mips64", "20Kc" },
> -    { "mips64el", "20Kc" },
> +    { "mips64el", "I6500" },
>      { "moxie", "MoxieLite" },
>      { "nios2", "FIXME" },
>      { "or1k", "or1200" },
> --
> 2.20.1
>
>
