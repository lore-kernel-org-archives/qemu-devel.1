Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E5C35249
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC1020643
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=packet.com header.i=@packet.com header.b="wC11HHeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC1020643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=packet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy12f-0005G8-FG
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 17:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ed@packet.com>) id 1iy11z-0004p4-Lj
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ed@packet.com>) id 1iy11x-00013D-4D
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:14:23 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e]:45910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ed@packet.com>) id 1iy11w-00011l-Mb
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:14:21 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id g7so3105736vkl.12
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packet.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aFSIv4SEqNFI+s/8Ss2jWRqMNqmn5t9VFPynk7suoZ8=;
 b=wC11HHeAN2Qlo+TMUp3x8jA/oXihsAU4/M7KugIpWyN2GDHfZePM1amp2KV0O8ZI2x
 4XVxgeQsVHSBqwK2qEffsOVAMihWK/rjOb2hHm/gEVviwWHXJU4FyvPCiirZ5TJ3isjZ
 EhUW+Xlak4Xlc7EVgoMV5x5DARjFWrayPP3K9HD7j771TRlkza1TOl41eH3iiWY2utG1
 baUsHFTWkZzmCm3wX1pEY30sxc3pibdwjbyKp6W7fssXb0eMoFQhG0JcfBEpL0SLCcrv
 HW1BhiyTm24Dt9air70a2pZdtweJZvP+YztxzNRz+ERdbDkeIpwJUwA8FaGHYgwmuzno
 p0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aFSIv4SEqNFI+s/8Ss2jWRqMNqmn5t9VFPynk7suoZ8=;
 b=JmeL0fUL9AEg0mTAEYmWDle7TkJXgGdjEd8NbvZkmLtMoz+PH9cGNNNtU8oL0zA1OA
 tm4RM5jG6PqGMw1frdfdr2Cv2Zb9aTBNn8LllMpr3KWRVrixx5KQF2NP7FOv81J2GrJD
 dKczKAiFDVipzyqAtPJIlTCtRBwJn9GQO/Vb0VL9zSqqaY/q2jSNaBNvNvGGY269GWXc
 cPm1XSqkwh2+wS9yF9YXHXgmdjnOmJOhJogqO3edNYyBAFVpAoO+ainSQaWLFWkF/UB3
 m//xH9X6Vweewb5xJsy7HPZLSQsBM2Ft/yUj+0/USWb3ygZANn9Ho78PoGFj/X/ATrKQ
 Riyw==
X-Gm-Message-State: APjAAAUlBiHbTugeDl+5PNlvw6xZZcrQkT7FieOUD/INAg8uZr+5uFMa
 1M5CMi8QlOPkMcpmmXTLpx93SF2jIAmSJWn13f3Bc8Iv9Hw=
X-Google-Smtp-Source: APXvYqx331RVp20yxEq/BqpXTWANv4Y0ypQbdjwD9OuhvYYMNhgM2Sodi1yUSyN6K+gO475orRT0ydHUFbxcsu65ty0=
X-Received: by 2002:a1f:9e86:: with SMTP id h128mr10503709vke.44.1580595259092; 
 Sat, 01 Feb 2020 14:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-12-alex.bennee@linaro.org>
 <ea3262e1-43b0-8382-a5b9-aff969e7145a@redhat.com>
In-Reply-To: <ea3262e1-43b0-8382-a5b9-aff969e7145a@redhat.com>
From: Ed Vielmetti <ed@packet.com>
Date: Sat, 1 Feb 2020 17:13:41 -0500
Message-ID: <CA+Gavy4oQfPRa0WFe3Vewa3dCuvH5p3XPCrY4uoaAg=5G_Ux8w@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] .travis.yml: probe for number of available
 processors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f3c666059d8b02ae"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a2e
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f3c666059d8b02ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Philippe.

For reference, the two machine types in typical use in the Packet system
can be referenced as follows:

c1.large.arm - 96-core Cavium (Marvell) ThunderX
c2.large.arm - 32-core Ampere eMag

The Ampere data sheet from their OEM (Lenovo) is below.

https://amperecomputing.com/wp-content/uploads/2019/01/Lenovo_ThinkSystem_H=
R330A_20190118.pdf

Memory configuration of both systems is 128G so that should not be a need
to adjust for.

The Travis systems are indeed using the c2.large.arm builds within an LXD
container. There may be other limits provided to each container there, but
certainly you want to use more than 3 cores. The Travis machines are
specially configured with NVMe instead of SSD disk, which helps IO quite a
bit.

Configuring optimal builds across a variety of multi-core systems can be
hard to tune for optimal performance. Depending on the system - and they
vary a lot - you might or might not get more performance from adding more
cores, as sometimes you start to max out memory bandwidth. As a concrete
example, note that the Marvell ThunderX2 configuration will report 4
hardware threads per core to the system, making you think that you can do
`make -j 224`, but if you do timings on actual throughput often you'll be
better off with `make -j 56`, apparently due to scheduling leading to
contention between threads.

I concur with your decision to run the test suite single-threaded. Unless
the test environment has been designed from the start to use lots of cores,
my observation is that lots of real-world test suites have unavoidable
dependencies in test run order, and generally make optimistic assumptions
about machine state between tests.

Happy to be a resource for any other performance issues, and if you run
into anything fun I'm also happy to relate it to my friends at Ampere who
have been tracking perf and regressions across a wide set of operating and
open source packages. Also, I am always and forever looking for people who
have interest and tools and good intuition about how to make the best use
out of machines with many cores.

thanks

Ed

On Fri, Jan 31, 2020 at 10:52 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> (Cc'ing Ed Vielmetti)
>
> On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
> > The arm64 hardware was especially hit by only building on 3 of the 32
> > available cores. Introduce a JOBS environment variable which we use
> > for all parallel builds. We still run the main checks single threaded
> > though so to make it easier to spot hangs.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >   .travis.yml | 20 +++++++++++---------
> >   1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 1b92f40eab..a600f508b0 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -85,6 +85,8 @@ git:
> >   # Common first phase for all steps
> >   before_install:
> >     - if command -v ccache ; then ccache --zero-stats ; fi
> > +  - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
>
> Yeah finally!
>
> Note, on the Cavium ThunderX CN88XX provided by Packet, Ed Vielmetti
> once suggested to use the --load-average make option due to Amdahl's
> law, and I noticed a minor speedup using -j96 -l47.5 (-l48 already
> starts to decrease).
>
> On https://docs.travis-ci.com/user/reference/overview/#linux I read
> "LXD compliant OS images for arm64 are run in Packet."
>
> Per
>
> https://travis-ci.community/t/what-machine-s-does-travis-use-for-arm64/55=
79/2
> the CPU seems to be a Ampere eMAG Skylark:
> https://en.wikichip.org/wiki/apm/microarchitectures/skylark
> Probably the eMAG 8180:
> https://en.wikichip.org/wiki/ampere_computing/emag/8180
>
> I don't know what would be the best limit for this CPU.
>
> Back to this patch, it indeed reduced the build time by 2+, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > +  - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
> >
> >   # Configure step - may be overridden
> >   before_script:
> > @@ -93,7 +95,7 @@ before_script:
> >
> >   # Main build & test - rarely overridden - controlled by TEST_CMD
> >   script:
> > -  - BUILD_RC=3D0 && make -j3 || BUILD_RC=3D$?
> > +  - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
> >     - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else
> $(exit $BUILD_RC); fi
> >   after_script:
> >     - if command -v ccache ; then ccache --show-stats ; fi
> > @@ -125,7 +127,7 @@ matrix:
> >         env:
> >           - BASE_CONFIG=3D"--enable-tools"
> >           - CONFIG=3D"--disable-user --disable-system"
> > -        - TEST_CMD=3D"make check-unit check-softfloat -j3"
> > +        - TEST_CMD=3D"make check-unit check-softfloat -j${JOBS}"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> >
> >
> > @@ -160,13 +162,13 @@ matrix:
> >       - name: "check-unit coroutine=3Ducontext"
> >         env:
> >           - CONFIG=3D"--with-coroutine=3Ducontext --disable-tcg"
> > -        - TEST_CMD=3D"make check-unit -j3 V=3D1"
> > +        - TEST_CMD=3D"make check-unit -j${JOBS} V=3D1"
> >
> >
> >       - name: "check-unit coroutine=3Dsigaltstack"
> >         env:
> >           - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-tcg"
> > -        - TEST_CMD=3D"make check-unit -j3 V=3D1"
> > +        - TEST_CMD=3D"make check-unit -j${JOBS} V=3D1"
> >
> >
> >       # Check we can build docs and tools (out of tree)
> > @@ -366,7 +368,7 @@ matrix:
> >       - name: "GCC check-tcg (user)"
> >         env:
> >           - CONFIG=3D"--disable-system --enable-debug-tcg"
> > -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> > +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> >
> >
> > @@ -375,7 +377,7 @@ matrix:
> >       - name: "GCC plugins check-tcg (user)"
> >         env:
> >           - CONFIG=3D"--disable-system --enable-plugins --enable-debug-=
tcg
> --target-list-exclude=3Dsparc64-linux-user"
> > -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> > +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> >
> >
> > @@ -383,7 +385,7 @@ matrix:
> >       - name: "GCC check-tcg (some-softmmu)"
> >         env:
> >           - CONFIG=3D"--enable-debug-tcg
> --target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
> > -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> > +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> >
> >
> > @@ -391,7 +393,7 @@ matrix:
> >       - name: "GCC plugins check-tcg (some-softmmu)"
> >         env:
> >           - CONFIG=3D"--enable-plugins --enable-debug-tcg
> --target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
> > -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> > +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> >
> >       - name: "[aarch64] GCC check-tcg"
> > @@ -500,7 +502,7 @@ matrix:
> >           - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
> >           - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
> >           -
> CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,armeb-linux-user=
,ppc-linux-user"
> > -        - TEST_CMD=3D"make install -j3"
> > +        - TEST_CMD=3D"make install -j${JOBS}"
> >           - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> >         script:
> >
>
>

--000000000000f3c666059d8b02ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Philippe.</div><div><br></div><div>For referen=
ce, the two machine types in typical use in the Packet system can be refere=
nced as follows:</div><div><br></div><div>c1.large.arm - 96-core Cavium (Ma=
rvell) ThunderX</div><div>c2.large.arm - 32-core Ampere eMag</div><div><br>=
</div><div>The Ampere data sheet from their OEM (Lenovo) is below.</div><di=
v><br></div><div><a href=3D"https://amperecomputing.com/wp-content/uploads/=
2019/01/Lenovo_ThinkSystem_HR330A_20190118.pdf">https://amperecomputing.com=
/wp-content/uploads/2019/01/Lenovo_ThinkSystem_HR330A_20190118.pdf</a></div=
><div><br></div><div>Memory configuration of both systems is 128G so that s=
hould not be a need to adjust for. <br></div><div><br></div><div>The Travis=
 systems are indeed using the c2.large.arm builds within an LXD container. =
There may be other limits provided to each container there, but certainly y=
ou want to use more than 3 cores. The Travis machines are specially configu=
red with NVMe instead of SSD disk, which helps IO quite a bit.<br></div><di=
v><br></div><div>Configuring optimal builds across a variety of multi-core =
systems can be hard to tune for optimal performance. Depending on the syste=
m - and they vary a lot - you might or might not get more performance from =
adding more cores, as sometimes you start to max out memory bandwidth. As a=
 concrete example, note that the Marvell ThunderX2 configuration will repor=
t 4 hardware threads per core to the system, making you think that you can =
do `make -j 224`, but if you do timings on actual throughput often you&#39;=
ll be better off with `make -j 56`, apparently due to scheduling leading to=
 contention between threads. </div><div><br></div><div>I concur with your d=
ecision to run the test suite single-threaded. Unless the test environment =
has been designed from the start to use lots of cores, my observation is th=
at lots of real-world test suites have unavoidable dependencies in test run=
 order, and generally make optimistic assumptions about machine state betwe=
en tests. <br></div><div><br></div><div>Happy to be a resource for any othe=
r performance issues, and if you run into anything fun I&#39;m also happy t=
o relate it to my friends at Ampere who have been tracking perf and regress=
ions across a wide set of operating and open source packages. Also, I am al=
ways and forever looking for people who have interest and tools and good in=
tuition about how to make the best use out of machines with many cores.</di=
v><div><br></div><div>thanks</div><div><br></div><div>Ed<br></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, J=
an 31, 2020 at 10:52 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">(Cc&#39;ing Ed Vielmetti)<br>
<br>
On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:<br>
&gt; The arm64 hardware was especially hit by only building on 3 of the 32<=
br>
&gt; available cores. Introduce a JOBS environment variable which we use<br=
>
&gt; for all parallel builds. We still run the main checks single threaded<=
br>
&gt; though so to make it easier to spot hangs.<br>
&gt; <br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.travis.yml | 20 +++++++++++---------<br>
&gt;=C2=A0 =C2=A01 file changed, 11 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.travis.yml b/.travis.yml<br>
&gt; index 1b92f40eab..a600f508b0 100644<br>
&gt; --- a/.travis.yml<br>
&gt; +++ b/.travis.yml<br>
&gt; @@ -85,6 +85,8 @@ git:<br>
&gt;=C2=A0 =C2=A0# Common first phase for all steps<br>
&gt;=C2=A0 =C2=A0before_install:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- if command -v ccache ; then ccache --zero-stats ;=
 fi<br>
&gt; +=C2=A0 - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))<br>
<br>
Yeah finally!<br>
<br>
Note, on the Cavium ThunderX CN88XX provided by Packet, Ed Vielmetti <br>
once suggested to use the --load-average make option due to Amdahl&#39;s <b=
r>
law, and I noticed a minor speedup using -j96 -l47.5 (-l48 already <br>
starts to decrease).<br>
<br>
On <a href=3D"https://docs.travis-ci.com/user/reference/overview/#linux" re=
l=3D"noreferrer" target=3D"_blank">https://docs.travis-ci.com/user/referenc=
e/overview/#linux</a> I read<br>
&quot;LXD compliant OS images for arm64 are run in Packet.&quot;<br>
<br>
Per <br>
<a href=3D"https://travis-ci.community/t/what-machine-s-does-travis-use-for=
-arm64/5579/2" rel=3D"noreferrer" target=3D"_blank">https://travis-ci.commu=
nity/t/what-machine-s-does-travis-use-for-arm64/5579/2</a> <br>
the CPU seems to be a Ampere eMAG Skylark:<br>
<a href=3D"https://en.wikichip.org/wiki/apm/microarchitectures/skylark" rel=
=3D"noreferrer" target=3D"_blank">https://en.wikichip.org/wiki/apm/microarc=
hitectures/skylark</a><br>
Probably the eMAG 8180:<br>
<a href=3D"https://en.wikichip.org/wiki/ampere_computing/emag/8180" rel=3D"=
noreferrer" target=3D"_blank">https://en.wikichip.org/wiki/ampere_computing=
/emag/8180</a><br>
<br>
I don&#39;t know what would be the best limit for this CPU.<br>
<br>
Back to this patch, it indeed reduced the build time by 2+, so:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
&gt; +=C2=A0 - echo &quot;=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=
=3D&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0# Configure step - may be overridden<br>
&gt;=C2=A0 =C2=A0before_script:<br>
&gt; @@ -93,7 +95,7 @@ before_script:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0# Main build &amp; test - rarely overridden - controlled b=
y TEST_CMD<br>
&gt;=C2=A0 =C2=A0script:<br>
&gt; -=C2=A0 - BUILD_RC=3D0 &amp;&amp; make -j3 || BUILD_RC=3D$?<br>
&gt; +=C2=A0 - BUILD_RC=3D0 &amp;&amp; make -j${JOBS} || BUILD_RC=3D$?<br>
&gt;=C2=A0 =C2=A0 =C2=A0- if [ &quot;$BUILD_RC&quot; -eq 0 ] ; then travis_=
retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi<br>
&gt;=C2=A0 =C2=A0after_script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- if command -v ccache ; then ccache --show-stats ;=
 fi<br>
&gt; @@ -125,7 +127,7 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- BASE_CONFIG=3D&quot;--enable=
-tools&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--disable-use=
r --disable-system&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make check-unit check-=
softfloat -j3&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make check-unit check-=
softfloat -j${JOBS}&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CACHE_NAME=3D&quot;${TRAVIS_=
BRANCH}-linux-gcc-default&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -160,13 +162,13 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: &quot;check-unit coroutine=3Ducontex=
t&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--with-corout=
ine=3Ducontext --disable-tcg&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make check-unit -j3 V=
=3D1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make check-unit -j${JO=
BS} V=3D1&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: &quot;check-unit coroutine=3Dsigalts=
tack&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--with-corout=
ine=3Dsigaltstack --disable-tcg&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make check-unit -j3 V=
=3D1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make check-unit -j${JO=
BS} V=3D1&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0# Check we can build docs and tools (out of =
tree)<br>
&gt; @@ -366,7 +368,7 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: &quot;GCC check-tcg (user)&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--disable-sys=
tem --enable-debug-tcg&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j3 check-tcg V=
=3D1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j${JOBS} check-t=
cg V=3D1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CACHE_NAME=3D&quot;${TRAVIS_=
BRANCH}-linux-gcc-debug-tcg&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -375,7 +377,7 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: &quot;GCC plugins check-tcg (user)&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--disable-sys=
tem --enable-plugins --enable-debug-tcg --target-list-exclude=3Dsparc64-lin=
ux-user&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j3 check-tcg V=
=3D1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j${JOBS} check-t=
cg V=3D1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CACHE_NAME=3D&quot;${TRAVIS_=
BRANCH}-linux-gcc-debug-tcg&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -383,7 +385,7 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: &quot;GCC check-tcg (some-softmmu)&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--enable-debu=
g-tcg --target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-soft=
mmu&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j3 check-tcg V=
=3D1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j${JOBS} check-t=
cg V=3D1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CACHE_NAME=3D&quot;${TRAVIS_=
BRANCH}-linux-gcc-debug-tcg&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -391,7 +393,7 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: &quot;GCC plugins check-tcg (some-so=
ftmmu)&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--enable-plug=
ins --enable-debug-tcg --target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-s=
oftmmu,alpha-softmmu&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j3 check-tcg V=
=3D1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make -j${JOBS} check-t=
cg V=3D1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CACHE_NAME=3D&quot;${TRAVIS_=
BRANCH}-linux-gcc-debug-tcg&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: &quot;[aarch64] GCC check-tcg&quot;<=
br>
&gt; @@ -500,7 +502,7 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- BUILD_DIR=3D&quot;release/bu=
ild/dir&quot; SRC_DIR=3D&quot;../../..&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- BASE_CONFIG=3D&quot;--prefix=
=3D$PWD/dist&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--target-list=
=3Dx86_64-softmmu,aarch64-softmmu,armeb-linux-user,ppc-linux-user&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make install -j3&quot;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 - TEST_CMD=3D&quot;make install -j${JOBS}=
&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- QEMU_VERSION=3D&quot;${TRAVI=
S_TAG:1}&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CACHE_NAME=3D&quot;${TRAVIS_=
BRANCH}-linux-gcc-default&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0script:<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000f3c666059d8b02ae--

