Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCDDC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74F321582
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPNnku7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74F321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW18k-0007lo-Nd
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <havard@skinnemoen.net>)
 id 1kVzpm-0003ld-L2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:22:30 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <havard@skinnemoen.net>)
 id 1kVzpk-0000Le-Bx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:22:30 -0400
Received: by mail-ej1-x643.google.com with SMTP id dt13so3145782ejb.12
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NI09Uc39mli2ta8kC3GYABD4cNjyNFvZiFOE5UsnVSw=;
 b=tPNnku7faJA+E/2TYSj7yUWS8i5434gLayq9onzL6/KkTcCxq7bb1R1kDi9+c9ig8E
 98q+eeZqoFeVDcIxJfF+JgaJxXbJxhS9r8Av1KdxE+PZ08/3i8HqsalDMLnaVEQyhSjw
 Uk5iuM7uYLuuZaGPJCo869zdqoX5sKMnklJ0Jtkh/XUymVB+6HNSeb78reEL2i/OXc83
 c+tahLEY0vy6DSBAhSEz5inU9fBcjblYUZn8vtD+ihT47CFP+anaaGvH3Bdv7uF4vnD5
 0lAZUKydEpiPzWhU0NLm3qmRF1RvXwRidYa1Rh70PT4nAK1ai7th5aKWiKbKWUivbTWG
 efjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NI09Uc39mli2ta8kC3GYABD4cNjyNFvZiFOE5UsnVSw=;
 b=mPtOMGfuMm3JR+BeckbUkMnEDZ2oAhYxekZV6y7w4sdcRzzRgp6vS5Mc5ZuWjLUR9D
 aJnNWBun1ThTPAx4TO7v/FrQV6kV5+fJ77r0jOOGCNDRN04Ape2oZ/o84jFVpIFps0bd
 c5qESKm1zsjStCgcwDqWJG029G3jtxdPVVunjk9XTlyGekYW6DJv4jhBfvaRhsDPvWts
 RbhRlXkop+DBDYGomZwpLNzN9IwCkLYn4uzQnJmRMA5fi7+WoiIKfD6kQMfUSczHdczI
 qRzQvq++zZuBRYGmgh3i+6XBAacd+rVO8h7OdBAO2gN8xZBZ1GiT15/sOQ0N/xn4qz54
 SxVg==
X-Gm-Message-State: AOAM530oCTwgnyp2thj3HkhS45Kd99sqTFjBFSjAoQ2mQJcOwBErcmd5
 gyic5L5oAxVErg+PhGi8hrgQ7NxzScTbSdhEYTewqg==
X-Google-Smtp-Source: ABdhPJwWmU3jwHWDIK8jT0oniI87trq5WufXB56ZYMNdxUCkVus7eKewMGSo1EytBD2cPz7aoPj0occuWqPQogehEgo=
X-Received: by 2002:a17:906:3a49:: with SMTP id
 a9mr2842567ejf.95.1603470146005; 
 Fri, 23 Oct 2020 09:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201023150514.2734046-1-pbonzini@redhat.com>
In-Reply-To: <20201023150514.2734046-1-pbonzini@redhat.com>
From: =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>
Date: Fri, 23 Oct 2020 09:22:14 -0700
Message-ID: <CACiLriQHisqC1OC5YDgwcwo98RHZQPn_YCr334O2JKEYZQhrOA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: separate meson rerun from the rest of the ninja
 invocation
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007628ba05b258fc26"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=havard@skinnemoen.net; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 Oct 2020 13:42:48 -0400
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
Cc: =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@google.com>,
 qemu-devel@nongnu.org, Havard Skinnemoen <hskinnemoen@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007628ba05b258fc26
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 23, 2020 at 8:05 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> The rules to build Makefile.mtest are suffering from the "tunnel vision"
> problem that is common with recursive makefiles.  Makefile.mtest depends
> on build.ninja, but Make does not know when build.ninja needs to be
> rebuilt before creating Makefile.mtest.
>
> To fix this, separate the ninja invocation into the "regenerate build
> files" phase and the QEMU build phase.  Sentinel files such as
> meson-private/coredata.dat or build.ninja are used to figure out the
> phases that haven't run yet; however, because those files' timestamps
> are not guaranteed to be touched, the usual makefile stamp-file trick
> is used on top.
>

Thanks for the quick response. Unfortunately, it doesn't seem to work quite
right for me.

I think it should be possible to reproduce on unmodified upstream sources
like this:

$ cd bin/opt/arm
$ ../../../configure --target-list=arm-softmmu
$ make check-qtest  # Feel free to interrupt after verifying that
npcm7xx_timer-test is run
$ cd -
$ git revert 19d50149c857e50ccb1ee35dd4277f9d4954877f
Removing tests/qtest/npcm7xx_timer-test.c
[meson-test 3ce2b719aa] Revert "tests/qtest: Add npcm7xx timer test"
 2 files changed, 563 deletions(-)
 delete mode 100644 tests/qtest/npcm7xx_timer-test.c
$ cd -
$ make check-qtest

After the revert, check-qtest still runs npcm7xx_timer-test. Note that it
doesn't fail because the patch I reverted only adds a new test, it doesn't
touch the device being tested.

If you run 'make check-qtest' again, npcm7xx_timer-test does not run.
Interestingly, it looks like Makefile.mtest gets regenerated here -- I
didn't notice that happening in the first run, nor does it happen if I run
make check-qtest a third time.

I pasted the output from the last two runs of make check-qtest here:
https://gist.github.com/hskinnemoen/1773edafeb190773661076e00fdc14de

Reported-by: Havard Skinnemoen <hskinnemoen@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile | 42 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 18f026eac3..007ad4d863 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -92,6 +92,8 @@ endif
>  ifeq ($(NINJA),)
>  .PHONY: config-host.mak
>  x := $(shell rm -rf meson-private meson-info meson-logs)
> +else
> +export NINJA
>  endif
>  ifeq ($(wildcard build.ninja),)
>  .PHONY: config-host.mak
> @@ -100,31 +102,46 @@ endif
>
>  # 1. ensure config-host.mak is up-to-date
>  config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios
> $(SRC_PATH)/VERSION
> -       @echo $@ is out-of-date, running configure
> +       @echo config-host.mak is out-of-date, running configure
>         @if test -f meson-private/coredata.dat; then \
>           ./config.status --skip-meson; \
>         else \
> -         ./config.status; \
> +         ./config.status && touch build.ninja.stamp; \
>         fi
>
> -# 2. ensure generated build files are up-to-date
> +# 2. meson.stamp exists if meson has run at least once (so ninja
> reconfigure
> +# works), but otherwise never needs to be updated
> +meson-private/coredata.dat: meson.stamp
> +meson.stamp: config-host.mak
> +       @touch meson.stamp
> +
> +# 3. ensure generated build files are up-to-date
>
> -ifneq ($(NINJA),)
>  # A separate rule is needed for Makefile dependencies to avoid -n
> -export NINJA
> +ifneq ($(MESON),)
> +build.ninja: build.ninja.stamp
> +build.ninja.stamp: meson.stamp
> +       $(NINJA) $(if $V,-v,) reconfigure && touch $@
> +endif
> +
> +ifneq ($(NINJA),)
>  Makefile.ninja: build.ninja
> -       $(quiet-@){ echo 'ninja-targets = \'; $(NINJA) -t targets all |
> sed 's/:.*//; $$!s/$$/ \\/'; } > $@
> +       $(quiet-@){ \
> +         echo 'ninja-targets = \'; \
> +         $(NINJA) -t targets all | sed 's/:.*//; $$!s/$$/ \\/'; \
> +         echo 'build-files = \'; \
> +         $(NINJA) -t query build.ninja | sed -n '1,/^  input:/d; /^
> outputs:/q; s/$$/ \\/p'; \
> +       } > $@.tmp && mv $@.tmp $@
>  -include Makefile.ninja
>  endif
>
>  ifneq ($(MESON),)
> -# The dependency on config-host.mak ensures that meson has run
> -Makefile.mtest: build.ninja scripts/mtest2make.py config-host.mak
> +Makefile.mtest: build.ninja scripts/mtest2make.py
>         $(MESON) introspect --targets --tests --benchmarks | $(PYTHON)
> scripts/mtest2make.py > $@
>  -include Makefile.mtest
>  endif
>
> -# 3. Rules to bridge to other makefiles
> +# 4. Rules to bridge to other makefiles
>
>  ifneq ($(NINJA),)
>  NINJAFLAGS = $(if $V,-v,) \
> @@ -135,7 +152,10 @@ ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
>  ninja-cmd-goals += $(foreach t, $(.tests), $(.test.deps.$t))
>
>  makefile-targets := build.ninja ctags TAGS cscope dist clean uninstall
> -ninja-targets := $(filter-out $(makefile-targets), $(ninja-targets))
> +# "ninja -t targets" also lists all prerequisites.  If build system
> +# files are marked as PHONY, however, Make will always try to execute
> +# "ninja reconfigure" to rebuild build.ninja.
> +ninja-targets := $(filter-out $(build-files) $(makefile-targets),
> $(ninja-targets))
>  .PHONY: $(ninja-targets) run-ninja
>  $(ninja-targets): run-ninja
>
> @@ -214,7 +234,7 @@ distclean: clean
>         rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
>         rm -f *-config-target.h *-config-devices.mak *-config-devices.h
>         rm -rf meson-private meson-logs meson-info compile_commands.json
> -       rm -f Makefile.ninja Makefile.mtest
> +       rm -f Makefile.ninja Makefile.mtest build.ninja.stamp meson.stamp
>         rm -f config.log
>         rm -f linux-headers/asm
>         rm -Rf .sdk
> --
> 2.26.2
>
>

--0000000000007628ba05b258fc26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Oct 23, 2020 at 8:05 AM Paolo Bon=
zini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;=
 wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">The rules to build Makefile.mtest are suffering from the=
 &quot;tunnel vision&quot;<br>
problem that is common with recursive makefiles.=C2=A0 Makefile.mtest depen=
ds<br>
on build.ninja, but Make does not know when build.ninja needs to be<br>
rebuilt before creating Makefile.mtest.<br>
<br>
To fix this, separate the ninja invocation into the &quot;regenerate build<=
br>
files&quot; phase and the QEMU build phase.=C2=A0 Sentinel files such as<br=
>
meson-private/coredata.dat or build.ninja are used to figure out the<br>
phases that haven&#39;t run yet; however, because those files&#39; timestam=
ps<br>
are not guaranteed to be touched, the usual makefile stamp-file trick<br>
is used on top.<br></blockquote><div><br></div><div>Thanks for the quick re=
sponse. Unfortunately, it doesn&#39;t seem to work quite right for me.</div=
><div><br></div><div>I think it should be possible to reproduce on unmodifi=
ed upstream sources like this:</div><div><br></div><div>$ cd bin/opt/arm</d=
iv><div>$ ../../../configure --target-list=3Darm-softmmu</div><div>$ make c=
heck-qtest=C2=A0 # Feel free to interrupt after verifying that npcm7xx_time=
r-test is run</div><div>$ cd -</div><div>$ git revert 19d50149c857e50ccb1ee=
35dd4277f9d4954877f<br></div><div>Removing tests/qtest/npcm7xx_timer-test.c=
<br>[meson-test 3ce2b719aa] Revert &quot;tests/qtest: Add npcm7xx timer tes=
t&quot;<br>=C2=A02 files changed, 563 deletions(-)<br>=C2=A0delete mode 100=
644 tests/qtest/npcm7xx_timer-test.c<br></div><div>$ cd -</div><div>$ make =
check-qtest</div><div><br></div><div>After the revert, check-qtest still ru=
ns npcm7xx_timer-test. Note that it doesn&#39;t fail because the patch I re=
verted only adds a new test, it doesn&#39;t touch the device being tested.<=
/div><div><br></div><div>If you run &#39;make check-qtest&#39; again, npcm7=
xx_timer-test does not run. Interestingly, it looks like Makefile.mtest get=
s regenerated here -- I didn&#39;t notice that happening in the first run, =
nor does it happen if I run make check-qtest a third time.</div><div><br></=
div><div>I pasted the output from the last two runs of make check-qtest her=
e:=C2=A0<a href=3D"https://gist.github.com/hskinnemoen/1773edafeb1907736610=
76e00fdc14de">https://gist.github.com/hskinnemoen/1773edafeb190773661076e00=
fdc14de</a></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
Reported-by: Havard Skinnemoen &lt;<a href=3D"mailto:hskinnemoen@gmail.com"=
 target=3D"_blank">hskinnemoen@gmail.com</a>&gt;<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0Makefile | 42 +++++++++++++++++++++++++++++++-----------<br>
=C2=A01 file changed, 31 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index 18f026eac3..007ad4d863 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -92,6 +92,8 @@ endif<br>
=C2=A0ifeq ($(NINJA),)<br>
=C2=A0.PHONY: config-host.mak<br>
=C2=A0x :=3D $(shell rm -rf meson-private meson-info meson-logs)<br>
+else<br>
+export NINJA<br>
=C2=A0endif<br>
=C2=A0ifeq ($(wildcard build.ninja),)<br>
=C2=A0.PHONY: config-host.mak<br>
@@ -100,31 +102,46 @@ endif<br>
<br>
=C2=A0# 1. ensure config-host.mak is up-to-date<br>
=C2=A0config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH=
)/VERSION<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0@echo $@ is out-of-date, running configure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0@echo config-host.mak is out-of-date, running c=
onfigure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @if test -f meson-private/coredata.dat; then \<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./config.status --skip-meson; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./config.status; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./config.status &amp;&amp; touch build.n=
inja.stamp; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-# 2. ensure generated build files are up-to-date<br>
+# 2. meson.stamp exists if meson has run at least once (so ninja reconfigu=
re<br>
+# works), but otherwise never needs to be updated<br>
+meson-private/coredata.dat: meson.stamp<br>
+meson.stamp: config-host.mak<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0@touch meson.stamp<br>
+<br>
+# 3. ensure generated build files are up-to-date<br>
<br>
-ifneq ($(NINJA),)<br>
=C2=A0# A separate rule is needed for Makefile dependencies to avoid -n<br>
-export NINJA<br>
+ifneq ($(MESON),)<br>
+build.ninja: build.ninja.stamp<br>
+build.ninja.stamp: meson.stamp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(NINJA) $(if $V,-v,) reconfigure &amp;&amp; to=
uch $@<br>
+endif<br>
+<br>
+ifneq ($(NINJA),)<br>
=C2=A0Makefile.ninja: build.ninja<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(quiet-@){ echo &#39;ninja-targets =3D \&#39;;=
 $(NINJA) -t targets all | sed &#39;s/:.*//; $$!s/$$/ \\/&#39;; } &gt; $@<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(quiet-@){ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;ninja-targets =3D \&#39;; \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(NINJA) -t targets all | sed &#39;s/:.*=
//; $$!s/$$/ \\/&#39;; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;build-files =3D \&#39;; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(NINJA) -t query build.ninja | sed -n &=
#39;1,/^=C2=A0 input:/d; /^=C2=A0 outputs:/q; s/$$/ \\/p&#39;; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} &gt; $@.tmp &amp;&amp; mv $@.tmp $@<br>
=C2=A0-include Makefile.ninja<br>
=C2=A0endif<br>
<br>
=C2=A0ifneq ($(MESON),)<br>
-# The dependency on config-host.mak ensures that meson has run<br>
-Makefile.mtest: build.ninja scripts/mtest2make.py config-host.mak<br>
+Makefile.mtest: build.ninja scripts/mtest2make.py<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(MESON) introspect --targets --tests --benchma=
rks | $(PYTHON) scripts/mtest2make.py &gt; $@<br>
=C2=A0-include Makefile.mtest<br>
=C2=A0endif<br>
<br>
-# 3. Rules to bridge to other makefiles<br>
+# 4. Rules to bridge to other makefiles<br>
<br>
=C2=A0ifneq ($(NINJA),)<br>
=C2=A0NINJAFLAGS =3D $(if $V,-v,) \<br>
@@ -135,7 +152,10 @@ ninja-cmd-goals =3D $(or $(MAKECMDGOALS), all)<br>
=C2=A0ninja-cmd-goals +=3D $(foreach t, $(.tests), $(.test.deps.$t))<br>
<br>
=C2=A0makefile-targets :=3D build.ninja ctags TAGS cscope dist clean uninst=
all<br>
-ninja-targets :=3D $(filter-out $(makefile-targets), $(ninja-targets))<br>
+# &quot;ninja -t targets&quot; also lists all prerequisites.=C2=A0 If buil=
d system<br>
+# files are marked as PHONY, however, Make will always try to execute<br>
+# &quot;ninja reconfigure&quot; to rebuild build.ninja.<br>
+ninja-targets :=3D $(filter-out $(build-files) $(makefile-targets), $(ninj=
a-targets))<br>
=C2=A0.PHONY: $(ninja-targets) run-ninja<br>
=C2=A0$(ninja-targets): run-ninja<br>
<br>
@@ -214,7 +234,7 @@ distclean: clean<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-plugins-ld.symbols qemu-plugins-ld64=
.symbols<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f *-config-target.h *-config-devices.mak *-=
config-devices.h<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf meson-private meson-logs meson-info comp=
ile_commands.json<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f Makefile.ninja Makefile.mtest<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f Makefile.ninja Makefile.mtest build.ninja=
.stamp meson.stamp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config.log<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f linux-headers/asm<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -Rf .sdk<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div>

--0000000000007628ba05b258fc26--

