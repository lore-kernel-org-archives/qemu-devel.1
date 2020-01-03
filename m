Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48BC3276F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EE4217F4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf2Lzd2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EE4217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inCxB-0004ki-Bg
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 21:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1inCvb-0002qO-P8
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1inCva-0004xQ-Mi
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:43:07 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1inCva-0004ve-Ex; Thu, 02 Jan 2020 21:43:06 -0500
Received: by mail-lj1-x242.google.com with SMTP id z22so37753000ljg.1;
 Thu, 02 Jan 2020 18:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+7cA0d0Hyi5444bKwVYHxmPS0oGCkXfU/S2Nefqv/E4=;
 b=sf2Lzd2hOuHlbhMGyxYZNV5Cvzh+3KLU8lTMbdmKHMjHNh0igsRrL4XjCAk4yRP8vf
 s/OjWrR6da7a2LVtU5DeediGnZbXeF4F/Dp76/g8PuMr8i2mtdYPg7S9M+ZZeqxXx30p
 eUi2GAw68sH8XnxlQNcJj5TJ7E1NyzlKLM6xa91OJqT7SYkm84GvPH23zQggZ2daCl0a
 rjrQ+GkiLEecFyt2uN+r94Qft6M0goUgtbv3NLqccuBOLRS4kibs2CdOTPxFJghJ69Xw
 DyrwAnU6vA74NzWNMy9eMT/YARCg2dl7x2Qryev3G/6DA+nfrE7iGijvPqyBDAPm6NKl
 XeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+7cA0d0Hyi5444bKwVYHxmPS0oGCkXfU/S2Nefqv/E4=;
 b=e3W2egTjOhGsXM1pUhCn5zHC0G8DFn+aDLT8iYgW37ho0kjebaqPIORQYh4n2H/9Qt
 UjVGzpcCqMZ0wCBhItWvSyEOlovucNKb9+Dr3XnOA0TUI3hmWjQK+tYn/WoazkgFaKv9
 4F3NWm6E71Tn88Y0x6oNwn3C3Zxj7IO7cL7Xnf0ID2znRcpRtb7PUvGYrO4BT8NzWGY+
 JEuPJmTQhGEx2F20sBSkreyvvcVB1BRg6FTnxB2WUtsCcsJEpJMmfeqP1cm6bpn8EXQt
 oGFCoDR6DailBtZq8GMlzwat4XsSs95093XKALiTyrK5FI27uQXTIgnZ9SVEvB1wZdFi
 dinA==
X-Gm-Message-State: APjAAAWIpQUv51hk5TuVNyNqdpPVJJsJNRj+xCsD6OJyXwIYNzj4k2zX
 D4dOnvPesJIVaFvjIDOr5M8xF/ptCbn8mIAJiVQ=
X-Google-Smtp-Source: APXvYqyJxH2lgoAOxeOFfTY00+cTVDLIOj+633dJyMoRWo0yvp9dCGNnnSHzqXFAwBHgUhI2yRIUMyNLZY/V6IVminE=
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr20605277ljj.4.1578019385388;
 Thu, 02 Jan 2020 18:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20200101112303.20724-1-philmd@redhat.com>
 <20200101112303.20724-5-philmd@redhat.com>
In-Reply-To: <20200101112303.20724-5-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jan 2020 18:42:38 -0800
Message-ID: <CAKmqyKPGWZh1a6vQk2TF=crN2yK7ZxpAvre55wx_-cuOMLrp9w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] configure: Remove tcg/ from the preprocessor
 include search list
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 1, 2020 at 3:25 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> All tcg includes are relative to the repository root directory,
> we can safely remove the tcg/ directory from the include search
> path list.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configure b/configure
> index 940bf9e87a..74dad08580 100755
> --- a/configure
> +++ b/configure
> @@ -7436,7 +7436,6 @@ elif test "$ARCH" =3D "riscv32" || test "$ARCH" =3D=
 "riscv64" ; then
>  else
>    QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
>  fi
> -QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
>
>  echo "TOOLS=3D$tools" >> $config_host_mak
>  echo "ROMS=3D$roms" >> $config_host_mak
> --
> 2.21.0
>
>

