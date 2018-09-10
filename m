Received: from eggs.gnu.org ([2001:4830:134:3::10]:56811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzJwZ-0008LQ-Kp
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzJwJ-00085A-SE
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:01:21 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzJwC-0007yd-NW
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:01:02 -0400
Received: by mail-wm0-x242.google.com with SMTP id s12-v6so21103646wmc.0
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 04:00:59 -0700 (PDT)
References: <20180908191735.22861-1-cota@braap.org>
	<20180908191735.22861-3-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180908191735.22861-3-cota@braap.org>
Date: Mon, 10 Sep 2018 12:00:56 +0100
Message-ID: <87a7opd3br.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: add floating point tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>


Emilio G. Cota <cota@braap.org> writes:

> By leveraging berkeley's softfloat and testfloat.
>
> fp-test.c is derived from testfloat's testsoftfloat.c. To ease
> the tracking of upstream changes to the latter file, fp-test.c
> keeps the original camel-case variable naming, and includes
> most new code via wrap.inc.c.
>
> Most changes to the original code are simple style changes,
> although a couple of not-so-subtle modifications have been
> made (noted with XXX in the code), namely:
>
> - We do not test ROUND_ODD, since not all of our primitives
>   support it (e.g. fp16)
>
> - Do not test !exact in round-to-integer, since it is not
>   implemented in QEMU (this flag was added to softfloat v3).
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  configure              |    2 +
>  tests/fp/platform.h    |   41 ++
>  tests/fp/fp-test.c     | 1052 ++++++++++++++++++++++++++++++++++++++++
>  tests/fp/wrap.inc.c    |  600 +++++++++++++++++++++++
>  tests/Makefile.include |    3 +
>  tests/fp/.gitignore    |    1 +
>  tests/fp/Makefile      |  591 ++++++++++++++++++++++
>  7 files changed, 2290 insertions(+)

<snip>

> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 87c81d1dcc..363f133101 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -657,6 +657,9 @@ tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-ut=
il-obj-y)
>  tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-=
obj-y)
>  tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-ob=
j-y)
>
> +tests/fp/%:
> +	$(MAKE) -C $(dir $@) $(notdir $@)
> +

This isn't enough to cause the build to be included in make check or
indeed be run. Perhaps that should be included in a new patch in the
series?

>  tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
>  	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
>  	hw/core/bus.o \
<snip>

--
Alex Benn=C3=A9e
