Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D4C2BA17
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 22:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0162076E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 22:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzeU59+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0162076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKUvv-0008Gz-LI
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 18:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jKUue-0007kv-3x
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jKUuY-0007mC-V1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:35:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jKUuY-0007aH-Fa
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:35:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id h9so10385086wrc.8
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tv9yJrf1Vicm0q8uvzAut78SaCiAudqPpg9rHmYqaU0=;
 b=pzeU59+2VbLyzvLn93UmUhvkreDN3jWne5StopjZTlmSfj/A5OVtqDd85nQYIx0/CS
 XcnEmK6oPbjSakgF2PiCv6nXAEZPBUpNRcCJzcECI6N3Of0zXAN4ZN2IvfrBcyy9N1HV
 /Fo3xo+EMHetfA2/Swl2Wev3bOueCFA5KJ27FwRA+THvqAXDq0KtUVLVJUxMRvPnmey/
 HqiJkJXpSDQBbMXG8mYocp+4Zl6gXmnUSYiI1hqcNcIwl9n+nMjgUvNmWkRseOxHF6fd
 HvkgwMeU3jAi5zHvdqJGOojoFyl08ZQC9DpmRSckwmjFXXZEZswodFGI9WJyJBViDodB
 EVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tv9yJrf1Vicm0q8uvzAut78SaCiAudqPpg9rHmYqaU0=;
 b=EApRgfovZnVYrZcO9KbBqxOSuURsDr6HlEEOwzXmy68iD6yEV0OoRC+r4NPHTI1LOl
 JZh5WvURbT54fK+lUWgVzkt7Eta+D1iRj9qCRX4fiGVZQrd63NoA7Mh3Cz2zAGycRRZg
 DaLhxSxAddb2TSSYppM93fVvfcUz2fCE8iQHSTgMcWTu+MvXZijWaYUC894dOIMJNomq
 new5FD1zCo10htLFQyxFYFJt5P5S6VU29ZJe3RjBAxkAg1EPyFhkgTx/a8/z8aOnjJmP
 diAhrRIo3ESStMqgadn8IZLR5r90C2/78qqqdBULrUU8scQq2o7wZQzYaUFKHVWP3dJH
 wL4w==
X-Gm-Message-State: AGi0PubZ9bS5I5khWKoOx1wjjBa27cmHdV2LwwSCNfXsbiKkUsqAUf6a
 GYQCEkXOG1+Q2/IvM/GJjmTro0Yv35JmAqSyA4g=
X-Google-Smtp-Source: APiQypJlKHTBV+5qN7TKK9Ylriv3/JYruw82gKtjsmyxI+FSBn/pXGwYcbzJKDgpZRm9on9tnssF0+R1LyhnLKo5cTM=
X-Received: by 2002:adf:a459:: with SMTP id e25mr4033016wra.402.1585953335052; 
 Fri, 03 Apr 2020 15:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200403135306.665493-1-berrange@redhat.com>
 <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
 <813a6453-0cc1-2ee7-20fb-3ba624aad57a@redhat.com>
In-Reply-To: <813a6453-0cc1-2ee7-20fb-3ba624aad57a@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 4 Apr 2020 00:35:15 +0200
Message-ID: <CAHiYmc4Sb0c3pqbOfD=tJf9xvC6rJcOH4kxB=1KZ64Cp-ty58g@mail.gmail.com>
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002a8d4205a26a89ae"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002a8d4205a26a89ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

16:44 Pet, 03.04.2020. Eric Blake <eblake@redhat.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 4/3/20 9:02 AM, Eric Blake wrote:
> > On 4/3/20 8:53 AM, Daniel P. Berrang=C3=A9 wrote:
> >> Running configure directly from the source directory is a build
> >> configuration that will go away in future. It is also not currently
> >> covered by any automated testing. Display a deprecation warning if
> >> the user attempts to use an in-srcdir build setup, so that they are
> >> aware that they're building QEMU in an undesirable manner.
> >>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> ---
> >>
> >> Changed in v4:
> >>    - Adopted Eric's suggested wording
> >
> >> +if test "$in_srcdir" =3D "yes"; then
> >> +    echo
> >> +    echo "WARNING: SUPPORT FOR BUILDING IN THE SOURCE DIR IS
DEPRECATED"
> >> +    echo
> >> +    echo "Support for running the 'configure' script directly from
the"
> >> +    echo "source directory is deprecated. In-tree builds are not
> >> covered"
> >> +    echo "by automated testing and thus may not correctly build QEMU.=
"
> >> +    echo "Users are recommended to use a separate build directory:"
> >> +    echo
> >> +    echo "  $ mkdir build"
> >> +    echo "  $ cd build"
> >> +    echo "  $ ../configure"
> >> +    echo "  $ make"
> >
> > Late question, but:
> >
> > Since this is just a warning, we still manage to complete the
> > ./configure run, including whatever generated files it leaves in-tree.
> > Is there any additional step we need to recommend prior to 'mkdir
build'
> > that will clean up the in-tree artifacts, so that the user then
> > attempting the VPATH build won't still have a broken build due to the
> > leftovers from the in-tree attempt?  'make distclean', perhaps?
> >
> > /me starts testing; I'll reply back once it finishes...
>
> tl;dr: 'make distclean' isn't perfect (it still leaves 2 directories
> behind), but does clean up a lot of directories and .mak files, and IS
> necessary before you can build in the subdirectory; but at least make
> warns you.  Still, I'd prefer adding that step in the warning, rather
> than getting an error several steps later.
>
> On a fresh git checkout:
>
> $ ./configure
> ...
> $ git clean -dfxn
> Would remove aarch64-linux-user/
> Would remove aarch64-softmmu/
> Would remove aarch64_be-linux-user/
> Would remove alpha-linux-user/
> Would remove alpha-softmmu/
> Would remove arm-linux-user/
> Would remove arm-softmmu/
> Would remove armeb-linux-user/
> Would remove config-all-disas.mak
> Would remove config-host.mak
> Would remove config.log
> Would remove config.status
> Would remove cris-linux-user/
> Would remove cris-softmmu/
> Would remove docs/sphinx/__pycache__/
> Would remove hppa-linux-user/
> Would remove hppa-softmmu/
> Would remove i386-linux-user/
> Would remove i386-softmmu/
> Would remove linux-headers/asm
> Would remove lm32-softmmu/
> Would remove m68k-linux-user/
> Would remove m68k-softmmu/
> Would remove microblaze-linux-user/
> Would remove microblaze-softmmu/
> Would remove microblazeel-linux-user/
> Would remove microblazeel-softmmu/
> Would remove mips-linux-user/
> Would remove mips-softmmu/
> Would remove mips64-linux-user/
> Would remove mips64-softmmu/
> Would remove mips64el-linux-user/
> Would remove mips64el-softmmu/
> Would remove mipsel-linux-user/
> Would remove mipsel-softmmu/
> Would remove mipsn32-linux-user/
> Would remove mipsn32el-linux-user/
> Would remove moxie-softmmu/
> Would remove nios2-linux-user/
> Would remove nios2-softmmu/
> Would remove or1k-linux-user/
> Would remove or1k-softmmu/
> Would remove ppc-linux-user/
> Would remove ppc-softmmu/
> Would remove ppc64-linux-user/
> Would remove ppc64-softmmu/
> Would remove ppc64abi32-linux-user/
> Would remove ppc64le-linux-user/
> Would remove riscv32-linux-user/
> Would remove riscv32-softmmu/
> Would remove riscv64-linux-user/
> Would remove riscv64-softmmu/
> Would remove rx-softmmu/
> Would remove s390x-linux-user/
> Would remove s390x-softmmu/
> Would remove sh4-linux-user/
> Would remove sh4-softmmu/
> Would remove sh4eb-linux-user/
> Would remove sh4eb-softmmu/
> Would remove sparc-linux-user/
> Would remove sparc-softmmu/
> Would remove sparc32plus-linux-user/
> Would remove sparc64-linux-user/
> Would remove sparc64-softmmu/
> Would remove tests/qemu-iotests/common.env
> Would remove tests/qgraph/
> Would remove tests/tcg/config-aarch64-linux-user.mak
> Would remove tests/tcg/config-aarch64-softmmu.mak
> Would remove tests/tcg/config-aarch64_be-linux-user.mak
> Would remove tests/tcg/config-alpha-linux-user.mak
> Would remove tests/tcg/config-alpha-softmmu.mak
> Would remove tests/tcg/config-arm-linux-user.mak
> Would remove tests/tcg/config-arm-softmmu.mak
> Would remove tests/tcg/config-armeb-linux-user.mak
> Would remove tests/tcg/config-cris-linux-user.mak
> Would remove tests/tcg/config-cris-softmmu.mak
> Would remove tests/tcg/config-hppa-linux-user.mak
> Would remove tests/tcg/config-hppa-softmmu.mak
> Would remove tests/tcg/config-i386-linux-user.mak
> Would remove tests/tcg/config-i386-softmmu.mak
> Would remove tests/tcg/config-lm32-softmmu.mak
> Would remove tests/tcg/config-m68k-linux-user.mak
> Would remove tests/tcg/config-m68k-softmmu.mak
> Would remove tests/tcg/config-mips-linux-user.mak
> Would remove tests/tcg/config-mips-softmmu.mak
> Would remove tests/tcg/config-mips64-linux-user.mak
> Would remove tests/tcg/config-mips64-softmmu.mak
> Would remove tests/tcg/config-mips64el-linux-user.mak
> Would remove tests/tcg/config-mips64el-softmmu.mak
> Would remove tests/tcg/config-mipsel-linux-user.mak
> Would remove tests/tcg/config-mipsel-softmmu.mak
> Would remove tests/tcg/config-mipsn32-linux-user.mak
> Would remove tests/tcg/config-mipsn32el-linux-user.mak
> Would remove tests/tcg/config-ppc-linux-user.mak
> Would remove tests/tcg/config-ppc-softmmu.mak
> Would remove tests/tcg/config-ppc64-linux-user.mak
> Would remove tests/tcg/config-ppc64-softmmu.mak
> Would remove tests/tcg/config-ppc64abi32-linux-user.mak
> Would remove tests/tcg/config-ppc64le-linux-user.mak
> Would remove tests/tcg/config-riscv64-linux-user.mak
> Would remove tests/tcg/config-riscv64-softmmu.mak
> Would remove tests/tcg/config-s390x-linux-user.mak
> Would remove tests/tcg/config-s390x-softmmu.mak
> Would remove tests/tcg/config-sh4-linux-user.mak
> Would remove tests/tcg/config-sh4-softmmu.mak
> Would remove tests/tcg/config-sh4eb-linux-user.mak
> Would remove tests/tcg/config-sh4eb-softmmu.mak
> Would remove tests/tcg/config-sparc64-linux-user.mak
> Would remove tests/tcg/config-sparc64-softmmu.mak
> Would remove tests/tcg/config-x86_64-linux-user.mak
> Would remove tests/tcg/config-x86_64-softmmu.mak
> Would remove tests/tcg/config-xtensa-linux-user.mak
> Would remove tests/tcg/config-xtensa-softmmu.mak
> Would remove tests/tcg/config-xtensaeb-linux-user.mak
> Would remove tests/tcg/config-xtensaeb-softmmu.mak
> Would remove tilegx-linux-user/
> Would remove tricore-softmmu/
> Would remove unicore32-softmmu/
> Would remove x86_64-linux-user/
> Would remove x86_64-softmmu/
> Would remove xtensa-linux-user/
> Would remove xtensa-softmmu/
> Would remove xtensaeb-linux-user/
> Would remove xtensaeb-softmmu/
> $ make distclean
> ...
> $ git clean -dfxn
> Would remove docs/sphinx/__pycache__/
> Would remove tests/qgraph/
> $ ./configure
> ...
> $ mkdir build
> $ cd build
> $ ../configure
> $ make
> Makefile:58: *** This is an out of tree build but your source tree
> (/home/eblake/qemu-tmp) seems to have been used for an in-tree build.
> You can fix this by running "make distclean && rm -rf *-linux-user
> *-softmmu" in your source tree.  Stop.
> $ cd ..
> $ make distclean && rm -rf *-linux-user *-softmmu
> $ cd build
> $ make
> ...
>

But, Eric, while, to some extent I understand your motivation and the idea,
there are still features working in in-tree builds only (some coccinele
scenarios, and some gcov-related scenarios - and perhaps others that nobody
seems to care to try to find out at all), and not in out-of tree builds.
And, now, if I understand well your proposal, and supposing that I use gcov
in-tree build (since I have to), this will stop me from doing out-of-tree
builds in this QEMU directory, since my in-tree gcov build will be
destroyed.

OK, I can use two separate directories as a workaround, but what bothers me
is that such proposal makes my workflow more complicated, driven by almost
obsesive desire to eradicate in-tree builds, instead on focusing on making
sure that out-of-build tree supports absolutely all and the same
functionality as in-tree builds, which is, I repeat, not the case right now=
.

Further, now speaking to Daniel, I don't have anything from the fact that
all CI tests are done with out-of-tree builds, if the feature I use works
only in in-tree builds. The whole message has some vieled disregarding tone
for people forced to use in-tree builds, and I see it as very close to
"pulling the rug under people" for such cases, and Peter said this should
not be happening.

Of course, many peaple are so wonderful when it comes to "exterminating"
in-tree builds, but when it comes to efforts to make sure everything works
in out-of-tree builds as in in-tree builds, suddenly everybody disappears,
don't have bandwith, don't care for something that doesn't affect them,
seem not to want to even think about such cases, etc.etc. Disappointing!

Sincerely,
Aleksandar

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--0000000000002a8d4205a26a89ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">16:44 Pet, 03.04.2020. Eric Blake &lt;<a href=3D"mailto:ebla=
ke@redhat.com">eblake@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 4/3/20 9:02 AM, Eric Blake wrote:<br>
&gt; &gt; On 4/3/20 8:53 AM, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; &gt;&gt; Running configure directly from the source directory is a bui=
ld<br>
&gt; &gt;&gt; configuration that will go away in future. It is also not cur=
rently<br>
&gt; &gt;&gt; covered by any automated testing. Display a deprecation warni=
ng if<br>
&gt; &gt;&gt; the user attempts to use an in-srcdir build setup, so that th=
ey are<br>
&gt; &gt;&gt; aware that they&#39;re building QEMU in an undesirable manner=
.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Reviewed-by: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.c=
om">eblake@redhat.com</a>&gt;<br>
&gt; &gt;&gt; Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt;<br>
&gt; &gt;&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; &gt;&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; &gt;&gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:=
berrange@redhat.com">berrange@redhat.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Changed in v4:<br>
&gt; &gt;&gt; =C2=A0=C2=A0 - Adopted Eric&#39;s suggested wording<br>
&gt; &gt; <br>
&gt; &gt;&gt; +if test &quot;$in_srcdir&quot; =3D &quot;yes&quot;; then<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;WARNING: SUPPORT FOR BUILDING =
IN THE SOURCE DIR IS DEPRECATED&quot;<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;Support for running the &#39;c=
onfigure&#39; script directly from the&quot;<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;source directory is deprecated=
. In-tree builds are not <br>
&gt; &gt;&gt; covered&quot;<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;by automated testing and thus =
may not correctly build QEMU.&quot;<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;Users are recommended to use a=
 separate build directory:&quot;<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;=C2=A0 $ mkdir build&quot;<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;=C2=A0 $ cd build&quot;<br>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;=C2=A0 $ ../configure&quot;<br=
>
&gt; &gt;&gt; +=C2=A0=C2=A0=C2=A0 echo &quot;=C2=A0 $ make&quot;<br>
&gt; &gt; <br>
&gt; &gt; Late question, but:<br>
&gt; &gt; <br>
&gt; &gt; Since this is just a warning, we still manage to complete the <br=
>
&gt; &gt; ./configure run, including whatever generated files it leaves in-=
tree. <br>
&gt; &gt; Is there any additional step we need to recommend prior to &#39;m=
kdir build&#39; <br>
&gt; &gt; that will clean up the in-tree artifacts, so that the user then <=
br>
&gt; &gt; attempting the VPATH build won&#39;t still have a broken build du=
e to the <br>
&gt; &gt; leftovers from the in-tree attempt?=C2=A0 &#39;make distclean&#39=
;, perhaps?<br>
&gt; &gt; <br>
&gt; &gt; /me starts testing; I&#39;ll reply back once it finishes...<br>
&gt;<br>
&gt; tl;dr: &#39;make distclean&#39; isn&#39;t perfect (it still leaves 2 d=
irectories <br>
&gt; behind), but does clean up a lot of directories and .mak files, and IS=
 <br>
&gt; necessary before you can build in the subdirectory; but at least make =
<br>
&gt; warns you.=C2=A0 Still, I&#39;d prefer adding that step in the warning=
, rather <br>
&gt; than getting an error several steps later.<br>
&gt;<br>
&gt; On a fresh git checkout:<br>
&gt;<br>
&gt; $ ./configure<br>
&gt; ...<br>
&gt; $ git clean -dfxn<br>
&gt; Would remove aarch64-linux-user/<br>
&gt; Would remove aarch64-softmmu/<br>
&gt; Would remove aarch64_be-linux-user/<br>
&gt; Would remove alpha-linux-user/<br>
&gt; Would remove alpha-softmmu/<br>
&gt; Would remove arm-linux-user/<br>
&gt; Would remove arm-softmmu/<br>
&gt; Would remove armeb-linux-user/<br>
&gt; Would remove config-all-disas.mak<br>
&gt; Would remove config-host.mak<br>
&gt; Would remove config.log<br>
&gt; Would remove config.status<br>
&gt; Would remove cris-linux-user/<br>
&gt; Would remove cris-softmmu/<br>
&gt; Would remove docs/sphinx/__pycache__/<br>
&gt; Would remove hppa-linux-user/<br>
&gt; Would remove hppa-softmmu/<br>
&gt; Would remove i386-linux-user/<br>
&gt; Would remove i386-softmmu/<br>
&gt; Would remove linux-headers/asm<br>
&gt; Would remove lm32-softmmu/<br>
&gt; Would remove m68k-linux-user/<br>
&gt; Would remove m68k-softmmu/<br>
&gt; Would remove microblaze-linux-user/<br>
&gt; Would remove microblaze-softmmu/<br>
&gt; Would remove microblazeel-linux-user/<br>
&gt; Would remove microblazeel-softmmu/<br>
&gt; Would remove mips-linux-user/<br>
&gt; Would remove mips-softmmu/<br>
&gt; Would remove mips64-linux-user/<br>
&gt; Would remove mips64-softmmu/<br>
&gt; Would remove mips64el-linux-user/<br>
&gt; Would remove mips64el-softmmu/<br>
&gt; Would remove mipsel-linux-user/<br>
&gt; Would remove mipsel-softmmu/<br>
&gt; Would remove mipsn32-linux-user/<br>
&gt; Would remove mipsn32el-linux-user/<br>
&gt; Would remove moxie-softmmu/<br>
&gt; Would remove nios2-linux-user/<br>
&gt; Would remove nios2-softmmu/<br>
&gt; Would remove or1k-linux-user/<br>
&gt; Would remove or1k-softmmu/<br>
&gt; Would remove ppc-linux-user/<br>
&gt; Would remove ppc-softmmu/<br>
&gt; Would remove ppc64-linux-user/<br>
&gt; Would remove ppc64-softmmu/<br>
&gt; Would remove ppc64abi32-linux-user/<br>
&gt; Would remove ppc64le-linux-user/<br>
&gt; Would remove riscv32-linux-user/<br>
&gt; Would remove riscv32-softmmu/<br>
&gt; Would remove riscv64-linux-user/<br>
&gt; Would remove riscv64-softmmu/<br>
&gt; Would remove rx-softmmu/<br>
&gt; Would remove s390x-linux-user/<br>
&gt; Would remove s390x-softmmu/<br>
&gt; Would remove sh4-linux-user/<br>
&gt; Would remove sh4-softmmu/<br>
&gt; Would remove sh4eb-linux-user/<br>
&gt; Would remove sh4eb-softmmu/<br>
&gt; Would remove sparc-linux-user/<br>
&gt; Would remove sparc-softmmu/<br>
&gt; Would remove sparc32plus-linux-user/<br>
&gt; Would remove sparc64-linux-user/<br>
&gt; Would remove sparc64-softmmu/<br>
&gt; Would remove tests/qemu-iotests/common.env<br>
&gt; Would remove tests/qgraph/<br>
&gt; Would remove tests/tcg/config-aarch64-linux-user.mak<br>
&gt; Would remove tests/tcg/config-aarch64-softmmu.mak<br>
&gt; Would remove tests/tcg/config-aarch64_be-linux-user.mak<br>
&gt; Would remove tests/tcg/config-alpha-linux-user.mak<br>
&gt; Would remove tests/tcg/config-alpha-softmmu.mak<br>
&gt; Would remove tests/tcg/config-arm-linux-user.mak<br>
&gt; Would remove tests/tcg/config-arm-softmmu.mak<br>
&gt; Would remove tests/tcg/config-armeb-linux-user.mak<br>
&gt; Would remove tests/tcg/config-cris-linux-user.mak<br>
&gt; Would remove tests/tcg/config-cris-softmmu.mak<br>
&gt; Would remove tests/tcg/config-hppa-linux-user.mak<br>
&gt; Would remove tests/tcg/config-hppa-softmmu.mak<br>
&gt; Would remove tests/tcg/config-i386-linux-user.mak<br>
&gt; Would remove tests/tcg/config-i386-softmmu.mak<br>
&gt; Would remove tests/tcg/config-lm32-softmmu.mak<br>
&gt; Would remove tests/tcg/config-m68k-linux-user.mak<br>
&gt; Would remove tests/tcg/config-m68k-softmmu.mak<br>
&gt; Would remove tests/tcg/config-mips-linux-user.mak<br>
&gt; Would remove tests/tcg/config-mips-softmmu.mak<br>
&gt; Would remove tests/tcg/config-mips64-linux-user.mak<br>
&gt; Would remove tests/tcg/config-mips64-softmmu.mak<br>
&gt; Would remove tests/tcg/config-mips64el-linux-user.mak<br>
&gt; Would remove tests/tcg/config-mips64el-softmmu.mak<br>
&gt; Would remove tests/tcg/config-mipsel-linux-user.mak<br>
&gt; Would remove tests/tcg/config-mipsel-softmmu.mak<br>
&gt; Would remove tests/tcg/config-mipsn32-linux-user.mak<br>
&gt; Would remove tests/tcg/config-mipsn32el-linux-user.mak<br>
&gt; Would remove tests/tcg/config-ppc-linux-user.mak<br>
&gt; Would remove tests/tcg/config-ppc-softmmu.mak<br>
&gt; Would remove tests/tcg/config-ppc64-linux-user.mak<br>
&gt; Would remove tests/tcg/config-ppc64-softmmu.mak<br>
&gt; Would remove tests/tcg/config-ppc64abi32-linux-user.mak<br>
&gt; Would remove tests/tcg/config-ppc64le-linux-user.mak<br>
&gt; Would remove tests/tcg/config-riscv64-linux-user.mak<br>
&gt; Would remove tests/tcg/config-riscv64-softmmu.mak<br>
&gt; Would remove tests/tcg/config-s390x-linux-user.mak<br>
&gt; Would remove tests/tcg/config-s390x-softmmu.mak<br>
&gt; Would remove tests/tcg/config-sh4-linux-user.mak<br>
&gt; Would remove tests/tcg/config-sh4-softmmu.mak<br>
&gt; Would remove tests/tcg/config-sh4eb-linux-user.mak<br>
&gt; Would remove tests/tcg/config-sh4eb-softmmu.mak<br>
&gt; Would remove tests/tcg/config-sparc64-linux-user.mak<br>
&gt; Would remove tests/tcg/config-sparc64-softmmu.mak<br>
&gt; Would remove tests/tcg/config-x86_64-linux-user.mak<br>
&gt; Would remove tests/tcg/config-x86_64-softmmu.mak<br>
&gt; Would remove tests/tcg/config-xtensa-linux-user.mak<br>
&gt; Would remove tests/tcg/config-xtensa-softmmu.mak<br>
&gt; Would remove tests/tcg/config-xtensaeb-linux-user.mak<br>
&gt; Would remove tests/tcg/config-xtensaeb-softmmu.mak<br>
&gt; Would remove tilegx-linux-user/<br>
&gt; Would remove tricore-softmmu/<br>
&gt; Would remove unicore32-softmmu/<br>
&gt; Would remove x86_64-linux-user/<br>
&gt; Would remove x86_64-softmmu/<br>
&gt; Would remove xtensa-linux-user/<br>
&gt; Would remove xtensa-softmmu/<br>
&gt; Would remove xtensaeb-linux-user/<br>
&gt; Would remove xtensaeb-softmmu/<br>
&gt; $ make distclean<br>
&gt; ...<br>
&gt; $ git clean -dfxn<br>
&gt; Would remove docs/sphinx/__pycache__/<br>
&gt; Would remove tests/qgraph/<br>
&gt; $ ./configure<br>
&gt; ...<br>
&gt; $ mkdir build<br>
&gt; $ cd build<br>
&gt; $ ../configure<br>
&gt; $ make<br>
&gt; Makefile:58: *** This is an out of tree build but your source tree <br=
>
&gt; (/home/eblake/qemu-tmp) seems to have been used for an in-tree build. =
<br>
&gt; You can fix this by running &quot;make distclean &amp;&amp; rm -rf *-l=
inux-user <br>
&gt; *-softmmu&quot; in your source tree.=C2=A0 Stop.<br>
&gt; $ cd ..<br>
&gt; $ make distclean &amp;&amp; rm -rf *-linux-user *-softmmu<br>
&gt; $ cd build<br>
&gt; $ make<br>
&gt; ...<br>
&gt;</p>
<p dir=3D"ltr">But, Eric, while, to some extent I understand your motivatio=
n and the idea, there are still features working in in-tree builds only (so=
me coccinele scenarios, and some gcov-related scenarios - and perhaps other=
s that nobody seems to care to try to find out at all), and not in out-of t=
ree builds. And, now, if I understand well your proposal, and supposing tha=
t I use gcov in-tree build (since I have to), this will stop me from doing =
out-of-tree builds in this QEMU directory, since my in-tree gcov build will=
 be destroyed.</p>
<p dir=3D"ltr">OK, I can use two separate directories as a workaround, but =
what bothers me is that such proposal makes my workflow more complicated, d=
riven by almost obsesive desire to eradicate in-tree builds, instead on foc=
using on making sure that out-of-build tree supports absolutely all and the=
 same functionality as in-tree builds, which is, I repeat, not the case rig=
ht now.</p>
<p dir=3D"ltr">Further, now speaking to Daniel, I don&#39;t have anything f=
rom the fact that all CI tests are done with out-of-tree builds, if the fea=
ture I use works only in in-tree builds. The whole message has some vieled =
disregarding tone for people forced to use in-tree builds, and I see it as =
very close to &quot;pulling the rug under people&quot; for such cases, and =
Peter said this should not be happening.</p>
<p dir=3D"ltr">Of course, many peaple are so wonderful when it comes to &qu=
ot;exterminating&quot; in-tree builds, but when it comes to efforts to make=
 sure everything works in out-of-tree builds as in in-tree builds, suddenly=
 everybody disappears, don&#39;t have bandwith, don&#39;t care for somethin=
g that doesn&#39;t affect them, seem not to want to even think about such c=
ases, etc.etc. Disappointing!</p>
<p dir=3D"ltr">Sincerely,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt;<br>
&gt; -- <br>
&gt; Eric Blake, Principal Software Engineer<br>
&gt; Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<=
br>
&gt; Virtualization:=C2=A0 <a href=3D"http://qemu.org">qemu.org</a> | <a hr=
ef=3D"http://libvirt.org">libvirt.org</a><br>
&gt;<br>
&gt;<br>
</p>

--0000000000002a8d4205a26a89ae--

