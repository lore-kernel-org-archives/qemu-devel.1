Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719BFECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAAF2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCS2vIt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAAF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47799 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xu4-0006ND-EN
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7xsk-0005jF-KC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7xsi-0005Su-Bl
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:21:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7xsh-0005SL-5N
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:21:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id i1so22852924wro.4
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ABj6REDl+eM7rq9wdnf/XUjTWkAy1e45wCDFx1DSgmo=;
 b=lCS2vIt5tbbulCE9PQzSd0IyAPa1/RgOFcmNBfWyj22RGZBvsqfEXvahZm1FUc8ypC
 cE3u310I8PR33qYzIAfqHNCGfjoPyVfnN6QfQaMo480qpZwgteihyASbb6AvrOFZsDBn
 9TMvqSDWPIz+Rw/T+E6QCFFgMw83khl/t9bPcW4AFLGb1c2MovPI06bkbIGRN5o+RhNO
 yUVqBnNPNE1XBsJ0BMel5XUZITtV5kd8T4hdQxXawZmKTz32RbLlfNZcPe7X4beXsVI4
 oQhc7IsQNpFLOcmqyxJvMiMdJNjcxY0CGxBk/7mxCWdDp36QChap1QF8aZyQPsbEZGo8
 +m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ABj6REDl+eM7rq9wdnf/XUjTWkAy1e45wCDFx1DSgmo=;
 b=fipmXMR7sOtkapQZf9aZuh/fjtR6ThJIzRw3hHzj5pYJBbsnj/lOSUp/i0OpcGQ7SN
 AJ8E6MVXzcQQvCePwqxFZ5pd7bbVFt55jOL/VZjLiFsGg1O+YdgoWWo3WjrYk1GSevVd
 xbRrZ0IdyFFa+GHWg5EaRAtkRJd9qk3QJIbGeO8hXhxxXxPvl+47FOPF4v3+cwSfB3to
 w/toPITGAlu2EUk6STkvBJOJyPiCDZrbqLi+8z3Y73ZPMAHZ/0tn+hKMYJic7ByKWGCv
 XSZUPnRf6nSALI6K0J//QKwWbCyRqGAxi4maWS0z+GuONCQgTpM/2ICNL8kqOkJPJAm+
 gHUQ==
X-Gm-Message-State: APjAAAWFz6XjgdUHY3X8LvAcTfycztUb5+NCdBFm8FIvC6hhju4MgRGM
 PvIfO5eKL0uWxHND9MZZDYLVOck8vBw=
X-Google-Smtp-Source: APXvYqz/ZQMXcd6+HxuT82iRLdBwMYwczeAllM2o5MzbzdCMFbCzXnACfGuJ1VwDgaWfuJA+XG2PmA==
X-Received: by 2002:adf:a357:: with SMTP id d23mr1391952wrb.18.1568190094284; 
 Wed, 11 Sep 2019 01:21:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e20sm2243421wme.3.2019.09.11.01.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:21:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2519D1FF87;
 Wed, 11 Sep 2019 09:21:33 +0100 (BST)
References: <cover.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <9b8662b94d89030b1f33193246c645baac2eedd7.1568170994.git.maozhongyi@cmss.chinamobile.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
In-reply-to: <9b8662b94d89030b1f33193246c645baac2eedd7.1568170994.git.maozhongyi@cmss.chinamobile.com>
Date: Wed, 11 Sep 2019 09:21:33 +0100
Message-ID: <877e6f1bw2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 1/3] tests/migration: mem leak fix
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
Cc: laurent@vivier.eu, tony.nguyen@bt.com, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Mao Zhongyi <maozhongyi@cmss.chinamobile.com> writes:

> =E2=80=98data=E2=80=99 has the possibility of memory leaks=EF=BC=8C so us=
e the
> glic macros g_autofree recommended by CODING_STYLE.rst

nit: glib

> to automatically release the memory that returned from
> g_malloc().
>
> Cc: armbru@redhat.com
> Cc: laurent@vivier.eu
> Cc: tony.nguyen@bt.com
> Cc: alex.bennee@linaro.org
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/migration/stress.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index d9aa4afe92..6cbb2d49d3 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -170,10 +170,10 @@ static unsigned long long now(void)
>  static int stressone(unsigned long long ramsizeMB)
>  {
>      size_t pagesPerMB =3D 1024 * 1024 / PAGE_SIZE;
> -    char *ram =3D malloc(ramsizeMB * 1024 * 1024);
> +    g_autofree char *ram =3D malloc(ramsizeMB * 1024 * 1024);
>      char *ramptr;
>      size_t i, j, k;
> -    char *data =3D malloc(PAGE_SIZE);
> +    g_autofree char *data =3D malloc(PAGE_SIZE);
>      char *dataptr;
>      size_t nMB =3D 0;
>      unsigned long long before, after;
> @@ -186,7 +186,6 @@ static int stressone(unsigned long long ramsizeMB)
>      if (!data) {
>          fprintf(stderr, "%s (%d): ERROR: cannot allocate %d bytes of RAM=
: %s\n",
>                  argv0, gettid(), PAGE_SIZE, strerror(errno));
> -        free(ram);
>          return -1;
>      }
>
> @@ -198,8 +197,6 @@ static int stressone(unsigned long long ramsizeMB)
>      memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
>
>      if (random_bytes(data, PAGE_SIZE) < 0) {
> -        free(ram);
> -        free(data);
>          return -1;
>      }
>
> @@ -227,9 +224,6 @@ static int stressone(unsigned long long ramsizeMB)
>              }
>          }
>      }
> -
> -    free(data);
> -    free(ram);
>  }


--
Alex Benn=C3=A9e

