Received: from eggs.gnu.org ([2001:4830:134:3::10]:50262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gDRyN-000521-AG
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gDRyJ-0006RG-RK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:25:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gDRyJ-0006FF-1w
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:25:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id 193-v6so3157336wme.3
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:25:29 -0700 (PDT)
References: <38a2dbae-42d8-ab2d-2e21-056794945677@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <38a2dbae-42d8-ab2d-2e21-056794945677@linaro.org>
Date: Fri, 19 Oct 2018 11:25:27 +0100
Message-ID: <877eiensh4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] check-tcg failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On aa64, "cross-compiling" to aa32, with
>
> CC=3Darm-linux-gnueabihf-gcc

So this is different from ./configure --cross-cc=3Darch-linux-gnueabihf-

>
> configure determines
>
> aarch64-linux-user/config-target.mak:CROSS_CC_GUEST=3D"aarch64-linux-gnu-=
gcc"
> aarch64-linux-user/config-target.mak:CROSS_CC_GUEST_STATIC=3Dy
> aarch64-softmmu/config-target.mak:CROSS_CC_GUEST=3D"aarch64-linux-gnu-gcc"
> aarch64-softmmu/config-target.mak:CROSS_CC_GUEST_STATIC=3Dy
> arm-linux-user/config-target.mak:CROSS_CC_GUEST=3D"cc"
> arm-linux-user/config-target.mak:CROSS_CC_GUEST_STATIC=3Dy
> arm-softmmu/config-target.mak:CROSS_CC_GUEST=3D"cc"
> arm-softmmu/config-target.mak:CROSS_CC_GUEST_STATIC=3Dy
>
> which results in
>
>   BUILD   arm guest-tests with cc
> cc: error: unrecognized command line option =E2=80=98-marm=E2=80=99; did =
you mean =E2=80=98-fasm=E2=80=99?
>
> Because of course cc is the aa64 host compiler.

Hmm the build target is determined by check_define which uses $cc so I'm
guessing all those setting cross_FOO to host_cc should be using cc
instead?

In fact looking deeper I'm not sure what HOST_CC is meant to be used
for. We export it to make but the only place I can find it in the source
tree is:

$(feat-dst)gen-features: $(feat-src)gen-features.c
	$(call quiet-command,$(HOST_CC) $(QEMU_INCLUDES) -o $@ $<,"CC","$(TARGET_D=
IR)gen-features")

As part of s390x - weird.

>
>
> r~


--
Alex Benn=C3=A9e
