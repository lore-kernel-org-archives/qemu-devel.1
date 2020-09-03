Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F1AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1874C2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRleeiyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1874C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiPc-0006HK-6I
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDiOx-0005qb-S4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:07:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDiOv-00016H-Ko
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599113231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7meDXL96i3v+4g65OMta2kw/XdZJGQOw0J/QeISxTc=;
 b=YRleeiyu2gBxqKzaWwboMttNss56wVNf72oIREw3Ll2qwD+08C84K8FM8Ik9maEOtskn9c
 XD2abfvmI44SFGWFqhrsEArbcRG2pA+o3ObMMkP26K/APvfYkLwdpdH50uNICIbTfH32ud
 hb9772ZUXxBb6XmRocYPcsu/yz482og=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-qq-dvcpSNxejNjvEcQgNHA-1; Thu, 03 Sep 2020 02:07:09 -0400
X-MC-Unique: qq-dvcpSNxejNjvEcQgNHA-1
Received: by mail-ed1-f69.google.com with SMTP id x23so829915eds.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 23:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K7meDXL96i3v+4g65OMta2kw/XdZJGQOw0J/QeISxTc=;
 b=Bu4+T+XWeLA/d7t5CnmkRYvNPXDbxxa6bSVOK446T8VDE3JXKK+8bGqiztKY5gharb
 XyZra8DQ17k4IZa1wsfESJBDWTyGcNj6igVO7J1Q6Mr58MvqYrWQEM5U2vPnRUQDPolw
 xOQ8ZVuT8kLPUO3POlGYVWD9jcnHtKZzXoHXnGuqRl3L8rOt22i9xh3uY0Uor5y+IRpf
 iR+XChW8vH01M+JaDrmlD6vMokxFwvu/4LpUCp+s0rZq6qjE3BxvK8qXKPJ+b0644JGx
 FL+qnkbxKjGE+ZjvjjUPuGbIIfsjcjAlALRHhhZNELP6lown1QvGjWdQyoCQddzzK88/
 RWmg==
X-Gm-Message-State: AOAM533L8oMNO6G5icecOU6y2jjcpC+Kl+FTjHnCizyQT2NPvCTdssby
 AYRU9RT9JAMB55LpjRtnT+B9dqfhnYOp90/vikaHUTGejJl1Jj+NZXougOmlx6Ckq2CzqsYxFDL
 yCo4saVIAnlu7RT+HnR33ptB4QapZZKQ=
X-Received: by 2002:a05:6402:10c6:: with SMTP id
 p6mr590228edu.76.1599113227811; 
 Wed, 02 Sep 2020 23:07:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwpsh5g6+5URig8yxknmAUHvnwbCock0pRxPTKsGatQvX2WMCMvn8i5FrDMrefS2YLfmGAhM4PNbwuDJic844=
X-Received: by 2002:a05:6402:10c6:: with SMTP id
 p6mr590211edu.76.1599113227575; 
 Wed, 02 Sep 2020 23:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200903054503.425435-1-thuth@redhat.com>
In-Reply-To: <20200903054503.425435-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 08:06:55 +0200
Message-ID: <CABgObfZ-Bc84nrFUSY16N-yR1cLu4AdVf+thheyryu3mWoJzJg@mail.gmail.com>
Subject: Re: [PATCH] stubs: Move qemu_fd_register stub to util/main-loop.c
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e2ba8e05ae628f81"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e2ba8e05ae628f81
Content-Type: text/plain; charset="UTF-8"

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Il gio 3 set 2020, 07:45 Thomas Huth <thuth@redhat.com> ha scritto:

> The linker of MinGW sometimes runs into the following problem:
>
> libqemuutil.a(util_main-loop.c.obj): In function `qemu_fd_register':
> /builds/huth/qemu/build/../util/main-loop.c:331: multiple definition of
>  `qemu_fd_register'
>
> libqemuutil.a(stubs_fd-register.c.obj):/builds/huth/qemu/stubs/fd-register.c:5:
>  first defined here
> collect2: error: ld returned 1 exit status
> /builds/huth/qemu/rules.mak:88: recipe for target
> 'tests/test-timed-average.exe'
>  failed
>
> qemu_fd_register() is defined in util/main-loop.c for WIN32, so let's
> simply
> move the stub also there in the #else part of the corresponding #ifndef
> to fix this problem.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  stubs/fd-register.c | 6 ------
>  stubs/meson.build   | 1 -
>  util/main-loop.c    | 4 ++++
>  3 files changed, 4 insertions(+), 7 deletions(-)
>  delete mode 100644 stubs/fd-register.c
>
> diff --git a/stubs/fd-register.c b/stubs/fd-register.c
> deleted file mode 100644
> index 63a4abdb20..0000000000
> --- a/stubs/fd-register.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "qemu/main-loop.h"
> -
> -void qemu_fd_register(int fd)
> -{
> -}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index e2dfedc2a7..e0b322bc28 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -9,7 +9,6 @@ stub_ss.add(files('cpu-get-clock.c'))
>  stub_ss.add(files('cpu-get-icount.c'))
>  stub_ss.add(files('dump.c'))
>  stub_ss.add(files('error-printf.c'))
> -stub_ss.add(files('fd-register.c'))
>  stub_ss.add(files('fdset.c'))
>  stub_ss.add(files('fw_cfg.c'))
>  stub_ss.add(files('gdbstub.c'))
> diff --git a/util/main-loop.c b/util/main-loop.c
> index f69f055013..217c8d6056 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -179,6 +179,10 @@ static int max_priority;
>  static int glib_pollfds_idx;
>  static int glib_n_poll_fds;
>
> +void qemu_fd_register(int fd)
> +{
> +}
> +
>  static void glib_pollfds_fill(int64_t *cur_timeout)
>  {
>      GMainContext *context = g_main_context_default();
> --
> 2.18.2
>
>

--000000000000e2ba8e05ae628f81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@re=
dhat.com">pbonzini@redhat.com</a>&gt;</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">Il gio 3 set 2020, 07:45 Thomas Huth &=
lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">The linker of MinGW sometimes runs=
 into the following problem:<br>
<br>
libqemuutil.a(util_main-loop.c.obj): In function `qemu_fd_register&#39;:<br=
>
/builds/huth/qemu/build/../util/main-loop.c:331: multiple definition of<br>
=C2=A0`qemu_fd_register&#39;<br>
libqemuutil.a(stubs_fd-register.c.obj):/builds/huth/qemu/stubs/fd-register.=
c:5:<br>
=C2=A0first defined here<br>
collect2: error: ld returned 1 exit status<br>
/builds/huth/qemu/rules.mak:88: recipe for target &#39;tests/test-timed-ave=
rage.exe&#39;<br>
=C2=A0failed<br>
<br>
qemu_fd_register() is defined in util/main-loop.c for WIN32, so let&#39;s s=
imply<br>
move the stub also there in the #else part of the corresponding #ifndef<br>
to fix this problem.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0stubs/fd-register.c | 6 ------<br>
=C2=A0stubs/meson.build=C2=A0 =C2=A0| 1 -<br>
=C2=A0util/main-loop.c=C2=A0 =C2=A0 | 4 ++++<br>
=C2=A03 files changed, 4 insertions(+), 7 deletions(-)<br>
=C2=A0delete mode 100644 stubs/fd-register.c<br>
<br>
diff --git a/stubs/fd-register.c b/stubs/fd-register.c<br>
deleted file mode 100644<br>
index 63a4abdb20..0000000000<br>
--- a/stubs/fd-register.c<br>
+++ /dev/null<br>
@@ -1,6 +0,0 @@<br>
-#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/main-loop.h&quot;<br>
-<br>
-void qemu_fd_register(int fd)<br>
-{<br>
-}<br>
diff --git a/stubs/meson.build b/stubs/meson.build<br>
index e2dfedc2a7..e0b322bc28 100644<br>
--- a/stubs/meson.build<br>
+++ b/stubs/meson.build<br>
@@ -9,7 +9,6 @@ stub_ss.add(files(&#39;cpu-get-clock.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;cpu-get-icount.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;dump.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;error-printf.c&#39;))<br>
-stub_ss.add(files(&#39;fd-register.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;fdset.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;fw_cfg.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;gdbstub.c&#39;))<br>
diff --git a/util/main-loop.c b/util/main-loop.c<br>
index f69f055013..217c8d6056 100644<br>
--- a/util/main-loop.c<br>
+++ b/util/main-loop.c<br>
@@ -179,6 +179,10 @@ static int max_priority;<br>
=C2=A0static int glib_pollfds_idx;<br>
=C2=A0static int glib_n_poll_fds;<br>
<br>
+void qemu_fd_register(int fd)<br>
+{<br>
+}<br>
+<br>
=C2=A0static void glib_pollfds_fill(int64_t *cur_timeout)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GMainContext *context =3D g_main_context_default();<br>
-- <br>
2.18.2<br>
<br>
</blockquote></div>

--000000000000e2ba8e05ae628f81--


