Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7BC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5C12080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnJuuOQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5C12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLME-0004p3-LI
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLJo-00087m-Kj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:52:40 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132]:34989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLJm-0000r8-Dm
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:52:40 -0400
Received: by mail-lf1-x132.google.com with SMTP id w11so7882988lfn.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=uVCOUmVn5yFZWifRDuSrqGvFKaFGSvPXKSHiMJfANL4=;
 b=CnJuuOQOY/ELxAWe94z8OUyVa/SJ35CXjL0Nx7HyeLVnqpR9KaOLHXNgljZvCUySyS
 y5TIdOaq332rJmXGUSHQUIQ8C/pgvlJDRDFTP5tWIe6CrGWvUk1seTwnbu7SxGGkf90A
 q3a32ynylb5CnqLv6Gk92JZoyAUBB0zmYUe9aQ39Sy1kw3ekPvHPfrvEJsse6GnKzt7q
 fmO+ysw38/NEOOio0OqNC3CJ88dLyCyWNjwTpISl2RJYwyZXOvArac1nlX4ArYtOwoqe
 vpMmN5++0S56rzeOMwMyWJb3OzPx0scEgMltvdV8GdyE+2CJQf0zFTC+ktcsWfhne6yn
 meUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=uVCOUmVn5yFZWifRDuSrqGvFKaFGSvPXKSHiMJfANL4=;
 b=ofuJTYR6kiPUMfYwNcdR33AzVN1WejwUGqj6Qj5MmeExgOucXgKJhoNNDwzXPC0hIW
 WTyDT6bR2sdY4kGYW1J0xIyvgnPlJxTLBHWK1aX7hQfwYyDMeKsF+pY8p0ibtdlw26ZE
 VCmU3MkTcDucBd+c9Y79UOs9CZA9Y0/qVRSYAk6Qba1f7T0eCgA/mHyl5oDgJpaEU4WU
 8zNt/98UAJi+vqhM9TRf0azvkDtkdLvH1GiJYbFhvVv+Ixl6SKqI/wl2OSaTtJYvVU69
 b7kDJTdUnpBp6T9rZ7JFmQITS7sFuVJPBufg3nXBIS4/bFo9egMw/rk8ksWF8UdmNO7B
 gwew==
X-Gm-Message-State: AOAM533jFk3j/I/P5NxoxKP9Ujx/EZptSdvMcIs1BAFC9qMEAnK1u9oF
 307HZEacf5iZtCVPSW/6XeZq6J49kWnftXEGJns=
X-Google-Smtp-Source: ABdhPJww69Yv+iqjSZi6fAFQXi4I+pVb8Yccs+wSMCUNfYy+ZzKlKNI8ZlKEBFFvOnsqL7tbU87b2Og/92akaE3T8qg=
X-Received: by 2002:ac2:42c2:: with SMTP id n2mr10651203lfl.117.1599501156234; 
 Mon, 07 Sep 2020 10:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200907121127.136243-1-thuth@redhat.com>
In-Reply-To: <20200907121127.136243-1-thuth@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 01:52:24 +0800
Message-ID: <CAE2XoE_99nATg7+3uz5rOqW08ZouiOaMzgo94CKrqVZ9CPtXNQ@mail.gmail.com>
Subject: Re: [PULL 00/14] Gitlab-CI improvements and related fixes
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003c3c3405aebce252"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x132.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003c3c3405aebce252
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2020 at 8:11 PM Thomas Huth <thuth@redhat.com> wrote:

>  Hi Peter,
>
> the following changes since commit
> 7c37270b3fbe3d034ba80e488761461676e21eb4:
>
>   Merge remote-tracking branch
> 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06
> 16:23:55 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-07
>
> for you to fetch changes up to 88e74b6122bb40852b1c98befd47a572f0c06930:
>
>   target/microblaze: Collected fixes for env->iflags (2020-09-07 12:34:17
> +0200)
>
> ----------------------------------------------------------------
> * Fixes for cross-compiling with MinGW / compiling with MSYS2
> * Enable cross-compiler builds in the Gitlab CI
> * Improvements / fixes for the crypto tests in the Gitlab CI
> * Fix for the "make check-acceptance" microblaze failure
>   (required to get the Gitlab CI green again)
> ----------------------------------------------------------------
>
> Alex Benn=C3=A9e (1):
>       tests/docker: add python3-setuptools the docker images
>
> Daniel P. Berrang=C3=A9 (2):
>       crypto: fix build with gcrypt enabled
>       gitlab: expand test coverage for crypto builds
>
> Paolo Bonzini (1):
>       tests/qtest: do not list ahci-test twice
>
> Richard Henderson (1):
>       target/microblaze: Collected fixes for env->iflags
>
> Thomas Huth (6):
>       tests/Makefile: test-image-locking needs CONFIG_POSIX
>       dockerfiles/debian-win64-cross: Download WHPX MinGW headers
>       configure: Allow automatic WHPX detection
>       stubs: Move qemu_timer_notify_cb() and remove qemu_notify_event()
> stub
>       stubs: Move qemu_fd_register stub to util/main-loop.c
>       gitlab-ci: Add cross-compiling build tests
>
> Yonggang Luo (3):
>       tests: handling signal on win32 properly
>
Hi thomas, this have already been queued by Bonzini, you have to skip this.

>       tests: fixes test-vmstate.c compile error on msys2
>
Hi Bonzini, the int compiling error are fixed by this commit

>       tests: Fixes building test-util-filemonitor.c on msys2/mingw
>
Hi Bonzini, the mkdir error are fixed by this commit

>
>  .gitlab-ci.d/crossbuilds.yml                       | 113
> +++++++++++++++++++++
>  .gitlab-ci.yml                                     |  69 +++++++++++++
>  MAINTAINERS                                        |   1 +
>  configure                                          |   3 +
>  crypto/meson.build                                 |  42 ++++++--
>  meson.build                                        |   5 +
>  stubs/cpu-get-icount.c                             |   5 -
>  stubs/fd-register.c                                |   6 --
>  stubs/meson.build                                  |   3 +-
>  stubs/notify-event.c                               |   6 --
>  stubs/qemu-timer-notify-cb.c                       |   8 ++
>  target/microblaze/cpu.c                            |  11 ++
>  target/microblaze/cpu.h                            |   3 +-
>  target/microblaze/helper.c                         |  17 ++--
>  target/microblaze/translate.c                      |   4 +-
>  tests/Makefile.include                             |   2 +
>  tests/docker/dockerfiles/centos7.docker            |   2 +
>  tests/docker/dockerfiles/centos8.docker            |   1 +
>  tests/docker/dockerfiles/debian-win64-cross.docker |   9 +-
>  tests/docker/dockerfiles/debian10.docker           |   1 +
>  tests/docker/dockerfiles/debian9.docker            |   1 +
>  tests/qtest/meson.build                            |   1 -
>  tests/test-replication.c                           |   4 +
>  tests/test-util-filemonitor.c                      |   4 +-
>  tests/test-vmstate.c                               |   4 +-
>  util/main-loop.c                                   |   4 +
>  26 files changed, 285 insertions(+), 44 deletions(-)
>  create mode 100644 .gitlab-ci.d/crossbuilds.yml
>  delete mode 100644 stubs/fd-register.c
>  delete mode 100644 stubs/notify-event.c
>  create mode 100644 stubs/qemu-timer-notify-cb.c
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003c3c3405aebce252
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2020 at 8:11 PM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0Hi Pete=
r,<br>
<br>
the following changes since commit 7c37270b3fbe3d034ba80e488761461676e21eb4=
:<br>
<br>
=C2=A0 Merge remote-tracking branch &#39;remotes/kraxel/tags/ui-20200904-pu=
ll-request&#39; into staging (2020-09-06 16:23:55 +0100)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/huth/qemu.git" rel=3D"noreferrer" targ=
et=3D"_blank">https://gitlab.com/huth/qemu.git</a> tags/pull-request-2020-0=
9-07<br>
<br>
for you to fetch changes up to 88e74b6122bb40852b1c98befd47a572f0c06930:<br=
>
<br>
=C2=A0 target/microblaze: Collected fixes for env-&gt;iflags (2020-09-07 12=
:34:17 +0200)<br>
<br>
----------------------------------------------------------------<br>
* Fixes for cross-compiling with MinGW / compiling with MSYS2<br>
* Enable cross-compiler builds in the Gitlab CI<br>
* Improvements / fixes for the crypto tests in the Gitlab CI<br>
* Fix for the &quot;make check-acceptance&quot; microblaze failure<br>
=C2=A0 (required to get the Gitlab CI green again)<br>
----------------------------------------------------------------<br>
<br>
Alex Benn=C3=A9e (1):<br>
=C2=A0 =C2=A0 =C2=A0 tests/docker: add python3-setuptools the docker images=
<br>
<br>
Daniel P. Berrang=C3=A9 (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto: fix build with gcrypt enabled<br>
=C2=A0 =C2=A0 =C2=A0 gitlab: expand test coverage for crypto builds<br>
<br>
Paolo Bonzini (1):<br>
=C2=A0 =C2=A0 =C2=A0 tests/qtest: do not list ahci-test twice<br>
<br>
Richard Henderson (1):<br>
=C2=A0 =C2=A0 =C2=A0 target/microblaze: Collected fixes for env-&gt;iflags<=
br>
<br>
Thomas Huth (6):<br>
=C2=A0 =C2=A0 =C2=A0 tests/Makefile: test-image-locking needs CONFIG_POSIX<=
br>
=C2=A0 =C2=A0 =C2=A0 dockerfiles/debian-win64-cross: Download WHPX MinGW he=
aders<br>
=C2=A0 =C2=A0 =C2=A0 configure: Allow automatic WHPX detection<br>
=C2=A0 =C2=A0 =C2=A0 stubs: Move qemu_timer_notify_cb() and remove qemu_not=
ify_event() stub<br>
=C2=A0 =C2=A0 =C2=A0 stubs: Move qemu_fd_register stub to util/main-loop.c<=
br>
=C2=A0 =C2=A0 =C2=A0 gitlab-ci: Add cross-compiling build tests<br>
<br>
Yonggang Luo (3):<br>
=C2=A0 =C2=A0 =C2=A0 tests: handling signal on win32 properly<br></blockquo=
te><div>Hi thomas, this have already been queued by Bonzini, you have to sk=
ip this.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 tests: fixes test-vmstate.c compile error on msys2<br>=
</blockquote><div>Hi=C2=A0Bonzini, the int compiling error are fixed by thi=
s commit=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 tests: Fixes building test-util-filemonitor.c on msys2=
/mingw<br></blockquote><div>Hi=C2=A0Bonzini, the mkdir error are fixed by t=
his commit</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"></blockqu=
ote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0.gitlab-ci.d/crossbuilds.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 113 +++++++++++++++++++++<br>
=C2=A0.gitlab-ci.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 69 +++++++++++++<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0crypto/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 42 ++++++--<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
=C2=A0stubs/cpu-get-icount.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 =
-<br>
=C2=A0stubs/fd-register.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 --<br>
=C2=A0stubs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +-<br>
=C2=A0stubs/notify-event.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 --<br>
=C2=A0stubs/qemu-timer-notify-cb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 ++<br>
=C2=A0target/microblaze/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 ++<br>
=C2=A0target/microblaze/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0target/microblaze/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 ++--<br>
=C2=A0target/microblaze/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+<br>
=C2=A0tests/docker/dockerfiles/centos7.docker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0tests/docker/dockerfiles/centos8.docker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0tests/docker/dockerfiles/debian-win64-cross.docker |=C2=A0 =C2=A09 +-=
<br>
=C2=A0tests/docker/dockerfiles/debian10.docker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0tests/docker/dockerfiles/debian9.docker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0tests/qtest/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 -<br>
=C2=A0tests/test-replication.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0tests/test-util-filemonitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0tests/test-vmstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A04 +-<br>
=C2=A0util/main-loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +<br>
=C2=A026 files changed, 285 insertions(+), 44 deletions(-)<br>
=C2=A0create mode 100644 .gitlab-ci.d/crossbuilds.yml<br>
=C2=A0delete mode 100644 stubs/fd-register.c<br>
=C2=A0delete mode 100644 stubs/notify-event.c<br>
=C2=A0create mode 100644 stubs/qemu-timer-notify-cb.c<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000003c3c3405aebce252--

