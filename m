Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A0C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796732082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6ZDvOcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796732082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1HP-0003EG-NS
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iz1Gh-0002mJ-Le
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iz1Gg-0003zu-DN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:41:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iz1Gg-0003gM-6C
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:41:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id w15so23961398wru.4
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4PhxhriFgbqpLQ2vOVeaQ94NquT6GxSmCo3IzsP/N1Y=;
 b=G6ZDvOcWWMX2kF6giH6tdACJvGeZQIeav4Yt4m3ZwRKU9ie0xfkK2nIFOJJFug8HtA
 MrH963B4Owsh6QVeEwzjbdlGxTOlNfQSjxIoPoVPj9NnCD2FrrO/c5TFPUKwmpY/pQgE
 EJtfyJspkN5TISUSu4X9iBW3+DnEe2dz6mrR4yf7vkptOOUP0R3y1f6DnaItb8Z110nB
 GwntlTr//RdC6xfrqvDpI8WbBLjquQoOncoM9Z9aNmSWKT78K+eryrEoZWcheBgCoOr5
 CjNgeQzzRH5rReAX/SOmFl+llt1TpryT3CKb8IcCOLDelJ9QOYkx6czO4DVW+eQGx0VY
 pZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4PhxhriFgbqpLQ2vOVeaQ94NquT6GxSmCo3IzsP/N1Y=;
 b=gCG4U4lutcL+dIZ8dki4wGEaajJal4NNuthtfvyruo5rmk94BPqB54hF9knTU7ulFz
 RQ9JKN5UjXd/ER9V+XTH8A1wxLKQ4HwtbwIXjnsb/4IJhv1BH5JAqKZsZw1qOehce38C
 YUG43uJbBsigSpO85XuLzTxJgqCZJ1DLDnmSamDYUMKuTFVW0/4rjXtw1kuRTfiFi+ZU
 zEtPsFOeRZqpkR5pPXuiPY8aR/pk9Qf+YhYxoMWoyfKXMoIqXdjDlgi5gfifRkrIwCdT
 C3NNvJWEhczlpa0JwqKrwTvfshaPOVy3sydZdKf+EWu+Mg4IxVsRTFWs9k9oGnQW0Vlp
 Sd3A==
X-Gm-Message-State: APjAAAUZsnwYWgQ+zNzXPBISkN0d5Stk6/1xr8J/+sadiVcyGTHlluEc
 al8hOWi86ipv8AWdR4oP575lFDj3nYdzUJXBfio=
X-Google-Smtp-Source: APXvYqx8VJ0HLSjKYdwE745BVaAK482Qg2AqOvhLmFoh8uFDZGebaPaYAhOf/iIE9xXNayViswKsp62LgzrldzdXUG4=
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr21856383wrx.381.1580834499041; 
 Tue, 04 Feb 2020 08:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20200204161104.21077-1-pbonzini@redhat.com>
In-Reply-To: <20200204161104.21077-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Feb 2020 17:41:27 +0100
Message-ID: <CAJ+F1C+i1bC+BCXLw=r+Q=Win6jcwvunqB8BsFN70SNArEDF2Q@mail.gmail.com>
Subject: Re: [PATCH] build: move TARGET_GPROF to config-host.mak
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 4, 2020 at 5:11 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> TARGET_GPROF is the same for all targets, write it to
> config-host.mak instead.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  bsd-user/syscall.c   | 6 +++---
>  configure            | 4 +++-
>  linux-user/exit.c    | 4 ++--
>  linux-user/signal.c  | 2 +-
>  tests/check-block.sh | 2 +-
>  5 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> index 0d45b654bb..d38ec7a162 100644
> --- a/bsd-user/syscall.c
> +++ b/bsd-user/syscall.c
> @@ -330,7 +330,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>
>      switch(num) {
>      case TARGET_FREEBSD_NR_exit:
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>          _mcleanup();
>  #endif
>          gdb_exit(cpu_env, arg1);
> @@ -432,7 +432,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
>
>      switch(num) {
>      case TARGET_NETBSD_NR_exit:
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>          _mcleanup();
>  #endif
>          gdb_exit(cpu_env, arg1);
> @@ -511,7 +511,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>
>      switch(num) {
>      case TARGET_OPENBSD_NR_exit:
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>          _mcleanup();
>  #endif
>          gdb_exit(cpu_env, arg1);
> diff --git a/configure b/configure
> index 5095f01728..08c28e73db 100755
> --- a/configure
> +++ b/configure
> @@ -6771,6 +6771,9 @@ fi
>  if test "$l2tpv3" =3D "yes" ; then
>    echo "CONFIG_L2TPV3=3Dy" >> $config_host_mak
>  fi
> +if test "$gprof" =3D "yes" ; then
> +  echo "CONFIG_GPROF=3Dy" >> $config_host_mak
> +fi
>  if test "$cap_ng" =3D "yes" ; then
>    echo "CONFIG_LIBCAP_NG=3Dy" >> $config_host_mak
>  fi
> @@ -7951,7 +7954,6 @@ alpha)
>  esac
>
>  if test "$gprof" =3D "yes" ; then
> -  echo "TARGET_GPROF=3Dy" >> $config_target_mak
>    if test "$target_linux_user" =3D "yes" ; then
>      cflags=3D"-p $cflags"
>      ldflags=3D"-p $ldflags"
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index a362ef67d2..1594015444 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -18,7 +18,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qemu.h"
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>  #include <sys/gmon.h>
>  #endif
>
> @@ -28,7 +28,7 @@ extern void __gcov_dump(void);
>
>  void preexit_cleanup(CPUArchState *env, int code)
>  {
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>          _mcleanup();
>  #endif
>  #ifdef CONFIG_GCOV
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5ca6d62b15..02f860ecb9 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -509,7 +509,7 @@ void signal_init(void)
>      act.sa_flags =3D SA_SIGINFO;
>      act.sa_sigaction =3D host_signal_handler;
>      for(i =3D 1; i <=3D TARGET_NSIG; i++) {
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>          if (i =3D=3D SIGPROF) {
>              continue;
>          }
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index 679aedec50..ad320c21ba 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -16,7 +16,7 @@ if [ "$#" -ne 0 ]; then
>      format_list=3D"$@"
>  fi
>
> -if grep -q "TARGET_GPROF=3Dy" *-softmmu/config-target.mak 2>/dev/null ; =
then
> +if grep -q "CONFIG_GPROF=3Dy" config-host.mak 2>/dev/null ; then
>      echo "GPROF is enabled =3D=3D> Not running the qemu-iotests."
>      exit 0
>  fi
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

