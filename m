Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A6C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70F020652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN4cWiQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70F020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLU9c-0003eW-3u
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:54:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hLU8J-00033U-8V
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hLU8I-00067S-77
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:53:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hLU8H-000677-US
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:53:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id a12so21358387wrq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=2HwaQh7uvLdq7tWjiACqCaZo8AMqwG+z74IpjuMcIEo=;
	b=jN4cWiQlEks7Kv80XjHCf59rVPi1Jj1oD1F/EelAJ26rI5aG1M6W4PtQ7xY1e09jab
	SZFm/hc7bE8eQr+Vz4b1/QjtQNnJl+NXFlF2Q1RAtiZXoMH0PWC3P4FdwrzNwl0jiSt0
	eSF5zkKPgkZbGGkBN+9kdkqroGBy6BYajO33YYUXCoPfRnXwKmI8AzIoWUQ7LQ4RiK6i
	KDCJJfu5EXjrLmWE9e0FBi1FJMO00OSL+ooIbrSBoFs4Zv5scxbpfVhftrEDWrYa50Xu
	RnM/QwatCBIWJCyGKMHAHLijrg5cBQP+jblpw+SDnV40L9Xq/s3xJUE+chvlyqljzwi2
	pd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=2HwaQh7uvLdq7tWjiACqCaZo8AMqwG+z74IpjuMcIEo=;
	b=oiJ/ImAGnZL1Ce6FyqkDoXTZecc/hUFy9N4UJ4nVIIiRTotSvtHCBZEVYbFui//fsW
	WfDK/Vqnu8EE+6HawpVjcmRN3DsBWXdUHGtsBaFxSc4I6oWJdq/KU2PLAbP81AyGXZae
	CFGStpRF3rt6eDI4yPLAVyDQ5leQeWLb912S3hg13vOOv3CuMQ1U+r6hCM+SAziEERt/
	aM2epMrY0oQxVxNYhQN1rVh2kTtIXVB1DDILjwnc9HZCTznJ02ox96S5dPm8OjSm4Q2R
	wg3AeoBER26F+ooIPXrNnqqISd8LukRvEi0/XaHfFKmsmbQC+xv/3nzKWwkwxEiZQ1W7
	ygfg==
X-Gm-Message-State: APjAAAUYWFIrmST1Ey/pV1NlkpIlmRe8FmWLGysNsrtbMVyYJ5LyvXxY
	8zUNv55JHVOhzF5SC6DddvYY7wlxI6yIT4ygp7s=
X-Google-Smtp-Source: APXvYqyohwJNEmv915yUHfX+xxGkDQqSVC9NmVvJU1tVOsLLfOCnF8N+YMhrdVUE1LfL93Z1Cj405q7ysGaaPo+oYec=
X-Received: by 2002:adf:f309:: with SMTP id i9mr43904908wro.258.1556636000341; 
	Tue, 30 Apr 2019 07:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190425145420.8888-1-stefanha@redhat.com>
In-Reply-To: <20190425145420.8888-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Apr 2019 16:53:08 +0200
Message-ID:
 <CAJ+F1CLYjF8SQv0v8c-hfbPcFYgZdg1P-MVeB8nS_AXTy4eMDA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430145308.5dShOAhIAwtc98bxHHg9SFkgbQEEWV-sNSxaBy9XSVA@z>

Hi

On Thu, Apr 25, 2019 at 4:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> qemu.org hosts git repository mirrors of all submodules.  Update
> .gitmodules to use the mirrors and not the upstream repositories.
>
> Mirroring upstream repositories ensures that QEMU continues to build
> even when upstream repositories are deleted or temporarily offline.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Stefan, do you prepare a pullreq?

> ---
>  .gitmodules | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/.gitmodules b/.gitmodules
> index aa77ce6f50..2857eec763 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -39,19 +39,19 @@
>         url =3D https://git.qemu.org/git/capstone.git
>  [submodule "roms/seabios-hppa"]
>         path =3D roms/seabios-hppa
> -       url =3D https://github.com/hdeller/seabios-hppa.git
> +       url =3D https://git.qemu.org/git/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>         path =3D roms/u-boot-sam460ex
>         url =3D https://git.qemu.org/git/u-boot-sam460ex.git
>  [submodule "tests/fp/berkeley-testfloat-3"]
>         path =3D tests/fp/berkeley-testfloat-3
> -       url =3D https://github.com/cota/berkeley-testfloat-3
> +       url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
>  [submodule "tests/fp/berkeley-softfloat-3"]
>         path =3D tests/fp/berkeley-softfloat-3
> -       url =3D https://github.com/cota/berkeley-softfloat-3
> +       url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
>  [submodule "roms/edk2"]
>         path =3D roms/edk2
> -       url =3D https://github.com/tianocore/edk2.git
> +       url =3D https://git.qemu.org/git/edk2.git
>  [submodule "slirp"]
>         path =3D slirp
> -       url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
> +       url =3D https://git.qemu.org/git/libslirp.git
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

