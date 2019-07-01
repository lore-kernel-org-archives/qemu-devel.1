Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF46C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E25E20673
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJJ1ui7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E25E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyev-0005bs-Vl
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:56:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50664)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hhydT-000423-EI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hhydR-0002fY-O5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:54:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hhydR-0002f1-Ga
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:54:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id w7so10344102oic.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yv/f4YJoC0tgXXbfwczIRT+9DE132JugGcQTrVjdzHg=;
 b=WJJ1ui7DFQgRRRCDws73ZRpfn4a4zftAe9k/3GuVevf5K9TaUDq0sTDy5jMOL3xixZ
 z+Lm57PlbPk5NwtuOhVOKTgiYcsrMoKe5tu+Fr8lQ1/w09+r86CtxJimogoE04t7GRW+
 WAFOQUJrlgGCVBVc/f4iNjn2f2WSqkeYnym9Y3/QULC3CromB98eOaSPiHAw/ZVZRI4l
 fSwIVMO5QxG/ZrnMYGwXyWwZote1aNsA3DblEVugOX5TgAM7yNPEbzByV/HYjLwz9H5k
 5OXghsYlk5K3sf/cr/fnWyEiNQjmiAxkHFMxAWbHr1TKQV0N3THwglQCPvVCfZQGKvyu
 exNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yv/f4YJoC0tgXXbfwczIRT+9DE132JugGcQTrVjdzHg=;
 b=CpXFc1j8KwS2/3wreyJ5C5FFaeMDIVNE/xhrE36qw9C+4OEiG3vWIgu1b1dvCLvL00
 yJ9zscdIvXYTVbeEjI3mFscht9n5wUO2grV0A2TFXi3WfmYLeCbqhIC1pOduKDTmc9aH
 K8aAFoIKPlRcqBfSKxlTnGjSXC82srWrT7lBYyLHfPErpRsW16kYq0S61pn56PatrjAR
 R9PSWqUakmblw5i0xFi3zvgC/kBMiu1V0icgWBxfyg6lrwAYdUobQ+kSoXgksKHAHruL
 dzABK9CUsb04sHaw+r6TNXwiXV4F3+fBy3oeIHXSi/BqhQMJ8JgnhCwximj2rPHz1f0H
 9Ckg==
X-Gm-Message-State: APjAAAUHWtXYmAjp4Bxkgop3bUUXJx/ylM4xt7GpXPya7QxWvA9QLhoj
 Ehzr6/gajc3LaolZ1zk+2FU8axBiBCMqD7DK/uk9fH9a
X-Google-Smtp-Source: APXvYqyqDi8OBxJ2nJXNW+kPBTbNVo/LAAYVOinETQfSey2E5yQcRKnFg0Ynr1/yXO2UXuezyXUzswdjwtj+mF45sYI=
X-Received: by 2002:aca:3602:: with SMTP id d2mr6801983oia.150.1561996468631; 
 Mon, 01 Jul 2019 08:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123558.30512-1-ppandit@redhat.com>
 <20190701123558.30512-4-ppandit@redhat.com>
In-Reply-To: <20190701123558.30512-4-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 1 Jul 2019 23:53:52 +0800
Message-ID: <CAKXe6SJTGdM9dE5uq+s5mEU87NiAjg-UH9u3xZTXE4M0i7g-Pw@mail.gmail.com>
To: P J P <ppandit@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 3/3] net: tap: refactor
 net_bridge_run_helper routine
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
Cc: Riccardo Schirone <rschiron@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:38=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Refactor 'net_bridge_run_helper' routine to avoid buffer
> formatting to prepare 'helper_cmd' and using shell to invoke
> helper command. Instead directly execute helper program with
> due arguments.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>


My two cents:
You do two things here(avoid buffer formatting and get rid of calling
shell),
I would suggest you split these into split patch.

Thanks,
Li Qiang


---
>  net/tap.c | 43 +++++++++----------------------------------
>  1 file changed, 9 insertions(+), 34 deletions(-)
>
> Update v3: remove buffer formatting and use of shell to invoke helper
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00071.html
>
> diff --git a/net/tap.c b/net/tap.c
> index e8aadd8d4b..bc9b3407a6 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -478,7 +478,6 @@ static int net_bridge_run_helper(const char *helper,
> const char *bridge,
>      sigset_t oldmask, mask;
>      int pid, status;
>      char *args[5];
> -    char **parg;
>      int sv[2];
>
>      sigemptyset(&mask);
> @@ -498,9 +497,6 @@ static int net_bridge_run_helper(const char *helper,
> const char *bridge,
>      }
>      if (pid =3D=3D 0) {
>          int open_max =3D sysconf(_SC_OPEN_MAX), i;
> -        char fd_buf[6+10];
> -        char br_buf[6+IFNAMSIZ] =3D {0};
> -        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15]=
;
>
>          for (i =3D 3; i < open_max; i++) {
>              if (i !=3D sv[1]) {
> @@ -508,39 +504,18 @@ static int net_bridge_run_helper(const char *helper=
,
> const char *bridge,
>              }
>          }
>
> -        snprintf(fd_buf, sizeof(fd_buf), "%s%d", "--fd=3D", sv[1]);
> +        args[0] =3D (char *)helper;
> +        args[1] =3D (char *)"--use-vnet";
> +        args[2] =3D g_strdup_printf("%s%d", "--fd=3D", sv[1]);
> +        args[3] =3D g_strdup_printf("%s%s", "--br=3D", bridge);
> +        args[4] =3D NULL;
>
> -        if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
> -            /* assume helper is a command */
> +        execv(helper, args);
>
> -            if (strstr(helper, "--br=3D") =3D=3D NULL) {
> -                snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=3D", brid=
ge);
> -            }
> +        g_free(args[2]);
> +        g_free(args[3]);
> +        fprintf(stderr, "failed to execute helper: %s\n", helper);
>
> -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
> -                     helper, "--use-vnet", fd_buf, br_buf);
> -
> -            parg =3D args;
> -            *parg++ =3D (char *)"sh";
> -            *parg++ =3D (char *)"-c";
> -            *parg++ =3D helper_cmd;
> -            *parg++ =3D NULL;
> -
> -            execv("/bin/sh", args);
> -        } else {
> -            /* assume helper is just the executable path name */
> -
> -            snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=3D", bridge);
> -
> -            parg =3D args;
> -            *parg++ =3D (char *)helper;
> -            *parg++ =3D (char *)"--use-vnet";
> -            *parg++ =3D fd_buf;
> -            *parg++ =3D br_buf;
> -            *parg++ =3D NULL;
> -
> -            execv(helper, args);
> -        }
>          _exit(1);
>
>      } else {
> --
> 2.21.0
>
>
