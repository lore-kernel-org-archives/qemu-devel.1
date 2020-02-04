Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BABC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A187F2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCxRw3eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A187F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35261 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz25h-000106-TI
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz1uY-00039V-Hx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz1uW-000513-Ck
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:22:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz1uW-0004zE-8j
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iovDLNoc/aaV7T/YjbmaaKxt+XmFxKAWYJbpYkotqeY=;
 b=ZCxRw3eTxDNvKCIF9Z3MoNuWfzI7z6W3axoxITg+acxUYPHJJMsEppeZuy8p6WsFBMH5Tu
 uepfPVqo3OX6GdZvGJukgrt0b89BCEWfe9cNbZEPlNLYnKOhGLahSP28SBL5KlCOu48Lxd
 /o72dvB12rAw0vlyR9qO1Mmabshx/bY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-_VU4pbEhMrSGSaJVC7o5EQ-1; Tue, 04 Feb 2020 12:22:47 -0500
Received: by mail-wr1-f71.google.com with SMTP id p8so3773105wrw.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 09:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+cEDik+BziY9zTJtr0AGp2TU/x/lenNfN/avvbGE/rc=;
 b=nqy3K/FuU9ZWTFD8Dtw+u70CeHP95yuDvDpd4i7mlQoj/8gKkpWIceOCSFe+AOMEWX
 hUu2sHrYzv6OFERJdmTUo32xWpHNWKpUI1Jze2A9AxgpAp7KUAL6wNl3+0q5FPevGUTU
 BpcLj3FWryw3jbXbundigMcnosVx2GmK581LDvHv6arGQa8b2W9PjkADi/SwQYjOrPhq
 rZQaMTAKecwOG3Hg2LQEcN6c2m3evJK2Q3c/BCkAF+DpX8PKLtp2VQRXFllgOybUPTP2
 0QFSBmUgXKBN4Utu70BIQx1wab7I9Jl2NEXILIw4+7QNP2g1c85wwez77Pn6RymeG0Wk
 me3w==
X-Gm-Message-State: APjAAAWupgMvW5CEeWeNB75vvlTrb+oaFzuOAZoCrssUqEIGDRvJnI1R
 r3gZVRC7yhAKqP4No11VVmlUSUPt1s5lII2jE0Mv65Kf0Lwgfmhi11SNbv8pCl/OjzPraZarPk8
 eI47fQaeBCoQ5qfg=
X-Received: by 2002:adf:f491:: with SMTP id l17mr25426758wro.149.1580836966595; 
 Tue, 04 Feb 2020 09:22:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzs+0t8Th7wYlPPKTX+mWXu2ye7f14N+NnNn2mHpBjrFW5IzCDH7UN7VQMdcvo/O2tRdIVhA==
X-Received: by 2002:adf:f491:: with SMTP id l17mr25426745wro.149.1580836966418; 
 Tue, 04 Feb 2020 09:22:46 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id i16sm5000868wmb.36.2020.02.04.09.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 09:22:45 -0800 (PST)
Subject: Re: [PATCH] build: move TARGET_GPROF to config-host.mak
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200204161104.21077-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <22083262-66e8-50bb-196c-9c84791a7cb3@redhat.com>
Date: Tue, 4 Feb 2020 18:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204161104.21077-1-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: _VU4pbEhMrSGSaJVC7o5EQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 5:11 PM, Paolo Bonzini wrote:
> TARGET_GPROF is the same for all targets, write it to
> config-host.mak instead.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   bsd-user/syscall.c   | 6 +++---
>   configure            | 4 +++-
>   linux-user/exit.c    | 4 ++--
>   linux-user/signal.c  | 2 +-
>   tests/check-block.sh | 2 +-
>   5 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> index 0d45b654bb..d38ec7a162 100644
> --- a/bsd-user/syscall.c
> +++ b/bsd-user/syscall.c
> @@ -330,7 +330,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>  =20
>       switch(num) {
>       case TARGET_FREEBSD_NR_exit:
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>           _mcleanup();
>   #endif
>           gdb_exit(cpu_env, arg1);
> @@ -432,7 +432,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
>  =20
>       switch(num) {
>       case TARGET_NETBSD_NR_exit:
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>           _mcleanup();
>   #endif
>           gdb_exit(cpu_env, arg1);
> @@ -511,7 +511,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>  =20
>       switch(num) {
>       case TARGET_OPENBSD_NR_exit:
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>           _mcleanup();
>   #endif
>           gdb_exit(cpu_env, arg1);
> diff --git a/configure b/configure
> index 5095f01728..08c28e73db 100755
> --- a/configure
> +++ b/configure
> @@ -6771,6 +6771,9 @@ fi
>   if test "$l2tpv3" =3D "yes" ; then
>     echo "CONFIG_L2TPV3=3Dy" >> $config_host_mak
>   fi
> +if test "$gprof" =3D "yes" ; then
> +  echo "CONFIG_GPROF=3Dy" >> $config_host_mak
> +fi
>   if test "$cap_ng" =3D "yes" ; then
>     echo "CONFIG_LIBCAP_NG=3Dy" >> $config_host_mak
>   fi
> @@ -7951,7 +7954,6 @@ alpha)
>   esac
>  =20
>   if test "$gprof" =3D "yes" ; then
> -  echo "TARGET_GPROF=3Dy" >> $config_target_mak
>     if test "$target_linux_user" =3D "yes" ; then
>       cflags=3D"-p $cflags"
>       ldflags=3D"-p $ldflags"
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index a362ef67d2..1594015444 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -18,7 +18,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qemu.h"
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>   #include <sys/gmon.h>
>   #endif
>  =20
> @@ -28,7 +28,7 @@ extern void __gcov_dump(void);
>  =20
>   void preexit_cleanup(CPUArchState *env, int code)
>   {
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>           _mcleanup();
>   #endif
>   #ifdef CONFIG_GCOV
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5ca6d62b15..02f860ecb9 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -509,7 +509,7 @@ void signal_init(void)
>       act.sa_flags =3D SA_SIGINFO;
>       act.sa_sigaction =3D host_signal_handler;
>       for(i =3D 1; i <=3D TARGET_NSIG; i++) {
> -#ifdef TARGET_GPROF
> +#ifdef CONFIG_GPROF
>           if (i =3D=3D SIGPROF) {
>               continue;
>           }
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index 679aedec50..ad320c21ba 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -16,7 +16,7 @@ if [ "$#" -ne 0 ]; then
>       format_list=3D"$@"
>   fi
>  =20
> -if grep -q "TARGET_GPROF=3Dy" *-softmmu/config-target.mak 2>/dev/null ; =
then
> +if grep -q "CONFIG_GPROF=3Dy" config-host.mak 2>/dev/null ; then
>       echo "GPROF is enabled =3D=3D> Not running the qemu-iotests."
>       exit 0
>   fi
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


