Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C2C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 09:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BAC206F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tp1MJYUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BAC206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI7vo-0000a6-1v
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 05:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jI7v9-0008QM-RC
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 05:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jI7v8-0004BB-GQ
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 05:38:27 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:35438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jI7v8-0004AF-6g
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 05:38:26 -0400
Received: by mail-ot1-x334.google.com with SMTP id v2so7923169oto.2
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g/zJORtGY4if+gy9Ga/swdJYKKDNY5arpp6n5BZ1Pi8=;
 b=Tp1MJYUlfyNRlj33z2au5YZytKIsKLN/nJ/DKMT/pr4hjJSr5bhY+r23zTIoBDGAlu
 efCwMbWqeL6IJSrmcUUuX50xehFdBKtPj19kIk2F7HpBMLaGavCmCKiZc4ek6rWUttfc
 /SuuZalGPsx/uJ4/0nT8QzwWanspti56hC1Fn5bfozQ+8tGUHuBVvThXaP1l9OK1XrEK
 9s0sYxL9VAwDW5ioxPKtzQ82rozh/+WUmO3FNYP3PY+Ll3gyDye9Sq771G7PrfFdbGm2
 XE3u7SsA3xbRuDGqgeElYIAk8YQufqaPOGwTeXyL43u8683FVK8i7UcHt1P09UgXruf3
 1Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/zJORtGY4if+gy9Ga/swdJYKKDNY5arpp6n5BZ1Pi8=;
 b=UB3xeKAd09sTKbvd45Agnyzxh3Jq2RExBU+Pt0iyCY9sTNkrtZSiWQtFvcXO2/zgQc
 kxB8DWJTgdVS0EpYzBIruIabic5Eap9TOoXtRylOle6fsUzXOyXZSHf/MFuk1ybc2MHj
 zZ7yY14RpnPk4PU7LMUUrV1MiDmGQv0qpDkxErXM2pYNn9qb1l+BlpIKrL12qRxjrKbp
 tjHNdLcRgdumnl8/kR4n0TIKgeK0gp3ivI8AXbGAhd/CrBt+b3V9YhmLXuLL9VjgsSIv
 nG1Brx17b6RHj4ag1IUqDkt8bbZVdUACmRNllRSU6xeMx6kOwc6oyWEVYhHmzTk6BPLJ
 4dWg==
X-Gm-Message-State: ANhLgQ3FgZF6IPhPL61+36NcLyxRoNr89jbU0JWKfilA+/YPlrY952AS
 iKpHxOjnjbO60J+WxOW23WTBeEjdnS/yYXDjqvxclA==
X-Google-Smtp-Source: ADFU+vvaefA+7W6YoMkg8og1ezhHYZlV+58tVW9N018g7dH01MdQxvIhwD13xMOhNgfRM/XsMYYVd0J57xTOaQRopvk=
X-Received: by 2002:a05:6830:18f4:: with SMTP id
 d20mr2141644otf.91.1585388305202; 
 Sat, 28 Mar 2020 02:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200327201501.1417-1-jsnow@redhat.com>
In-Reply-To: <20200327201501.1417-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Mar 2020 09:38:13 +0000
Message-ID: <CAFEAcA9EGZZS+=BEtmCM=cnqyW2QcdfBQpkwxQL7O4Yz+t6OvA@mail.gmail.com>
Subject: Re: [PULL 0/5] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 at 20:15, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b445831d:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-26 20:55:54 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to cbf4c9ac9c000f7caf1bfee031041b62d2b000c8:
>
>   cmd646-ide: use qdev gpio rather than qemu_allocate_irqs() (2020-03-27 14:30:08 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ---------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

