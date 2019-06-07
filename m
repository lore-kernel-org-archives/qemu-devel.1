Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3718EC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055042089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nP/yuxzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055042089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGYk-0005zV-AL
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZFms-0007K4-RY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZFmr-0003o4-HJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:24:10 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:44099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZFmr-0003mD-Bo
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:24:09 -0400
Received: by mail-oi1-x229.google.com with SMTP id e189so1538332oib.11
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uoFq3KrE19cNhjlwK1zdXG2o+2eu/MfrPz1AUAV0dgk=;
 b=nP/yuxzTVFU0PLmS1I7lXPeTdKpgvDYYo9q+9IvrFDt8z8xRa2+WhNh9LIlfpOXj9O
 az5PgsviAJyFi2HYDYX6ePSgRFdXIOm4C1aky8qIhiusWf8j3SuTIz+NG7/Hyz4SFGI4
 I1YfSNBGP7o5dkcwNQQ3ShFCBqfkntlQRVl9Qi9vKqUwGAJezBIkQq/py+B5vAhe3uye
 mSTVjJtNgPb1I04bx2CWjAiHzbns3ndHWm5WJj/WCfJAqKaaWEJbwJr9CDcUf1WJAYJv
 vzcJO67e9RSCncycgh1ZdSoUxlXypcZ8504vSP0yq9yDM+19xVm5mxAc/Mt94wgTmjqA
 nJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uoFq3KrE19cNhjlwK1zdXG2o+2eu/MfrPz1AUAV0dgk=;
 b=P/qfcnmM0Wqfo8dYnn35m+ZnTJLnKoRgRdwOLYhp8iXZNeoVJRFbXkuzm/37+ZoO/2
 1FcYkilvP4nsQiORrn16TyM6PX/Hz1MIviOvmG+JhWZsYps1zJH87DFP/d4nMhxb91UZ
 Hr3eZgXV6bBHE10bG+63V4uQ875FlIYNoI1UeYk9JV6i7Mdl6KdCD3L6PHe41T60MgB/
 iQNfHWS47r0d3iK2cXi8HI8XC+gUS+QhjUZoBcMZH4ZF19sVlk2BV/9hctK7RFFtmL1g
 zYYqYgCtyAG+U1pHyc+x91ht0GPmdQW8ddpzIUU0yGZZHlZtTonYaBENdqz749vX4OmN
 lo9A==
X-Gm-Message-State: APjAAAUVZ36vwR+4tTyatHY4ajPpstGyHkSAbV/rWEW2zfb4ISSZ28V3
 ciJf0zU+I8iN1Af1zcVawJG1QCNWJDkFCVx5I6D9Nw==
X-Google-Smtp-Source: APXvYqzYT6wDY6Pwn1bb/tXuC89G71Q4QzdOUBF4bhaXzVVrOdZDltbGSb9BLoxoNn3i2rUI2M4kpITnTr71FsFyd00=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
 d17mr3916467oic.170.1559917448192; 
 Fri, 07 Jun 2019 07:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190607131901.20107-1-kraxel@redhat.com>
In-Reply-To: <20190607131901.20107-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 15:23:56 +0100
Message-ID: <CAFEAcA-_nCUTZFygLF82=V4uUFowaViLU7BbUZKE6c07UyrCqg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 0/5] Ui 20190607 patches
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 14:21, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 0d74f3b4277a7ecb0ccb80c865797d11f8e466f5:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-06-06 14:09:14 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190607-pull-request
>
> for you to fetch changes up to 15ee0d9bc10b3de677ff6cd78b6dc9d5a7d40603:
>
>   egl-helpers: add modifier support to egl_dmabuf_import_texture() (2019-06-07 11:52:35 +0200)
>
> ----------------------------------------------------------------
> curses: 32bit build fix.
> egl: dmabuf modifier support.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (4):
>   console: add dmabuf modifier field.
>   vfio/display: set dmabuf modifier field
>   egl-helpers: add modifier support to egl_get_fd_for_texture().
>   egl-helpers: add modifier support to egl_dmabuf_import_texture()
>
> Max Reitz (1):
>   ui/curses: Fix build with -m32


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

