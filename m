Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C34C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B38205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNcdypmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B38205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtAg-0000pp-Eu
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYt71-0002ih-0b
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:15:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYt6y-0006PN-AT
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:15:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so7422219wrt.5
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DLQjpBAe8uF5P0rudKhqE5NWkCXNwXzM2lTgTRFnpi4=;
 b=dNcdypmCzOhI3Os4Yx7PsqRd+8I15RcO7esAa5aQVqq+ej6EFYfTBbcvc4quWClx/y
 Tuwn0QFfYeajoOg3652tjy3xD0UNMODJGCFBHyWJJuS92REpyjYMvN24KYILgK1wEAyd
 QPaUds3q0ZBLARL7mWCgImqia3QiteZktH+L6leAxv6iyhylY6BSd07jb5QaC1zeS5cA
 NXXB0wVi9C19ZM0ffAP4U+1bWlPgGfYv5bGfDElIu9by4h0jmPbDFG4bEIhBpR1rp47e
 XxLXKWXCzsswWccuF4BJUq3H3J1vFB7jrWPmSVO/BEnnGIlhrUqO96zHtBSWcftuGYcC
 stUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DLQjpBAe8uF5P0rudKhqE5NWkCXNwXzM2lTgTRFnpi4=;
 b=SFfN3DZAgVMnPcE7pIsFNp9Si9kzMwRhPGTA5scdSHCbo876YCBmJX01nGODk1sexw
 gKaBqJ+cifzM2v4K+WHIIofXB5A1DoSzpIqT1C6YCbyvPBXTdaMEhpsnuGcbQUxvoi7g
 HgVwsAdAjKBbx570RymzCwM4Ki9yHaGcsC8inihBGsotrFb8b+5V2zjkZR7EYqIEwwsW
 fVeHsiA1CLCH5Y4YR9Zfa9WrwCazUZBsHa7aQAwOLeHlDs8ZLm/zTcS98GCQgnuUi1cI
 65A0iNtFCMEayJ/4Fsgi6otQdNtDkfWJDN4cg2QGCBAGUC9Df/uGp6Rq+Wv6I49/b1wZ
 6+hQ==
X-Gm-Message-State: AGi0PuZomokpiY+5aFKwquU74J98M0cyFtxxVb35ZIjbw9B3kDLyUw5T
 sYUDIMhrWy08QQPIbhl2OpWonw==
X-Google-Smtp-Source: APiQypLlLByXY2bd4aYQFsdPF+Lr/qx+SRwKN4uj0aooSoDXPCavfV886uhVIQCt5x3wsj+O6H599Q==
X-Received: by 2002:adf:8401:: with SMTP id 1mr32226933wrf.241.1589382952203; 
 Wed, 13 May 2020 08:15:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x24sm29514157wrd.51.2020.05.13.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 08:15:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 84F8B1FF7E;
 Wed, 13 May 2020 16:15:48 +0100 (BST)
References: <20200513120147.21443-1-f4bug@amsat.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] tests/docker: Kludge <linux/swab.h> breakage by pinning
 linux-libc-dev
In-reply-to: <20200513120147.21443-1-f4bug@amsat.org>
Date: Wed, 13 May 2020 16:15:48 +0100
Message-ID: <87a72beuhn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Salvatore Bonaccorso <carnil@debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Linux kernel commit d5767057c9a [1] aimed to fix an issue with the
> swab() declaration, but doing so it introduced the BITS_PER_LONG
> definition, without using the kernel __ prefix, leading to odd
> failures in userland code using kernel uapi headers, such:
>
>       CC      block/file-posix.o
>     In file included from include/qemu/timer.h:4,
>                      from include/qemu/timed-average.h:29,
>                      from include/block/accounting.h:28,
>                      from include/block/block_int.h:27,
>                      from block/file-posix.c:30:
>     /usr/include/linux/swab.h: In function `__swab':
>     include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluate=
s to 0 [-Werror=3Dundef]
>        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BIT=
S_PER_BYTE)
>           |                                  ^~~~~~
>     include/qemu/bitops.h:20:41: error: missing binary operator before to=
ken "("
>        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BIT=
S_PER_BYTE)
>           |                                         ^
>     cc1: all warnings being treated as errors
>     make: *** [rules.mak:69: block/file-posix.o] Error 1
>
> The issue has been fixed in Linux kernel commit 467d12f5c78 [2].
> Some distributions already backported the first commit, but still
> lack the second one.
>
> This is the case for Debian Buster.
> The linux-libc-dev package contains the Linux kernel headers.
> Kernel commit d5767057c9a has been backported in package
> commit 1fb0eb7956 "Update to 4.19.116" [3], see debian/changelog:
>
>   +linux (4.19.116-1) UNRELEASED; urgency=3Dmedium
>   ...
>   +    - uapi: rename ext2_swab() to swab() and share globally in swab.h
>
> The previous released update before it is debian/4.19.98-1,
> released as debian/4.19.98-1+deb10u1.
>
> We can find this package in the Debian snapshot archives,
> luckily archived on 2020-04-28 21:20:54 (see [4]).
>
> QEMU use Debian based Docker images for most of its cross-builds,
> which are tested by our Shippable CI jobs. The current broken
> package makes most of our CI red. We can kludge this by using the
> latest package released before the breakage. Do so by pinning
> the package version (apt hold), and using the snapshot archives,
> similar to commit b4048a7cd1.
> We'll revert once the fix is backported on Debian.

May as well mention:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D960271

>
> Reference to commits:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dd5767057c9a
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D467d12f5c78
> [3] https://salsa.debian.org/kernel-team/linux/-/commit/1fb0eb7956
> [4] http://snapshot.debian.org/package/linux/4.19.98-1%2Bdeb10u1/#linux-l=
ibc-dev_4.19.98-1:2b:deb10u1
>
> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Shippable green again:
> https://app.shippable.com/github/philmd/qemu/runs/759/summary/console
> ---
>  tests/docker/dockerfiles/debian10.docker | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
> index 0769700a41..d7084ac283 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -9,6 +9,15 @@
>  #
>  FROM debian:buster-slim
>=20=20
> + # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> +ENV DEBIAN_SNAPSHOT_DATE "20200428T212054Z"
> +RUN sed -i \
> +    "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-val=
id-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE}=
 \2%" \
> +    /etc/apt/sources.list
> +RUN sed -i \
> +    "s%^deb \(https\?://\)security.debian.org/debian-security/\? \(.*\)%=
deb [check-valid-until=3Dno] \1snapshot.debian.org/archive/debian-security/=
${DEBIAN_SNAPSHOT_DATE} \2%" \
> +    /etc/apt/sources.list
> +
>  # Duplicate deb line as deb-src
>  RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
>=20=20
> @@ -35,4 +44,11 @@ RUN apt update && \
>          texinfo \
>          $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut =
-d\  -f2)
>=20=20
> +# Install common build utilities
> +RUN apt update && \
> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt install -y --allow-downgrades \
> +        linux-libc-dev=3D4.19.98-1+deb10u1 && \
> +    apt-mark hold linux-libc-dev
> +

Do we need this bit? Surely if we have a snapshot URL we don't need to
hold the package as it will never get updated?

>  ENV FEATURES docs


--=20
Alex Benn=C3=A9e

