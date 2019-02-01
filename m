Received: from eggs.gnu.org ([209.51.188.92]:52621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcY5-0006AP-4p
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcY4-0005rf-5e
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:24:17 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpcY2-0005q2-0b
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:24:16 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so7905379wrx.9
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:24:13 -0800 (PST)
References: <20190131215611.29341-1-michael@walle.cc>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190131215611.29341-1-michael@walle.cc>
Date: Fri, 01 Feb 2019 17:24:10 +0000
Message-ID: <878syzv2v9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] lm32: convert to new common tcg
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>


Michael Walle <michael@walle.cc> writes:

> The main problem here is, that there is no prebuilt compiler packages. Th=
us
> I have to build the toolchain from scratch. I don't know if this is OK in
> the docker image.

Well you only have to do it the once - certainly I can't imagine a TCG
developer that hasn't built one or two toolchains in their time. Daniel
has been looking at getting our developer images hosted so that would
lower the cost as well.

I don't think it's a blocker.

> For now only binutils is built. But then, I'll have to
> pass the LD and AS environment variables, too. And it won't work with the
> native host cross toolchain - unless we'll probe for the assembler and
> linker, too.

When I did the original work I tried quite hard to keep to using CC for
everything (as an assembler and linker frontend). I think if it's going
to be difficult to keep doing that we'll want to pass a prefix env
variable to the images instead of piling on more variables. Something
like CROSS_COMPILE or CROSS_PREFIX. However that throws a bit of a spanner
in the works for my future plans of building larger test binaries without h=
aving
to deal with autoconf madness.

> Any ideas?

So a couple of ideas:

  - set CROSS_PREFIX and modify our submakes to pick that up if set
  - pass CROSS_PREFIX to docker.py and it expands CC/LD/AS for us

I'm open to other approaches though.

>
> Michael Walle (3):
>   tests/docker: add debian-lm32-cross image
>   tests/tcg: also pass AS and LD variables
>   tests/tcg/lm32: enable system tests
>
>  tests/docker/Makefile.include                     |   5 +-
>  tests/docker/dockerfiles/debian-lm32-cross.docker |  31 +++++++
>  tests/tcg/Makefile.include                        |  13 ++-
>  tests/tcg/lm32/Makefile                           | 106 ----------------=
------
>  tests/tcg/lm32/Makefile.include                   |   8 ++
>  tests/tcg/lm32/Makefile.softmmu-target            |  33 +++++++
>  6 files changed, 86 insertions(+), 110 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-lm32-cross.docker
>  delete mode 100644 tests/tcg/lm32/Makefile
>  create mode 100644 tests/tcg/lm32/Makefile.include
>  create mode 100644 tests/tcg/lm32/Makefile.softmmu-target


--
Alex Benn=C3=A9e
