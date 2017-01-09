Received: from eggs.gnu.org ([2001:4830:134:3::10]:38117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cQYZa-0005Yd-GU
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cQYZX-0005dd-FC
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:57:10 -0500
Received: from mail-wj0-x22f.google.com ([2a00:1450:400c:c01::22f]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cQYZX-0005d7-93
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:57:07 -0500
Received: by mail-wj0-x22f.google.com with SMTP id i20so63839553wjn.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 03:57:05 -0800 (PST)
References: <20161214171244.26813-1-alex.bennee@linaro.org>
	<903503264.6427014.1482145774126.JavaMail.zimbra@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <903503264.6427014.1482145774126.JavaMail.zimbra@redhat.com>
Date: Mon, 09 Jan 2017 11:57:02 +0000
Message-ID: <87wpe4mooh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC/POC PATCH 0/4] Building TCG tests with
 emdebian cross compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Cc: bobby prani <bobby.prani@gmail.com>, marcandre lureau <marcandre.lureau@redhat.com>, peter maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


Marc-André Lureau <mlureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Hi Pranith,
>>
>> Here is a proof-of-concept series for you to consider rolling into the TCG
>> tests
>> cleanup. It uses the existing docker make machinery to build a Debian
>> image which has arm, arm64 and ppc64el cross compilers in it. Now if
>> you run:
>>
>>   make arm-tcg-tests
>>
>> It will do the requisite build of the docker image and then use that
>> to build the TCG tests in the appropriate build directory.
>>
>> These apply on top of your existing series. There is also a quick hack
>> to disable the running of the tests by default. I think we need two
>> stages, maybe a build-FOO-tcg-tests and run-FOO-tcg-tests.
>>
>> What do you think?
>
> I like the idea, as long as you can also run the tcg tests without
> docker.

Yes, the idea is the build deposits the test binaries in host systems
$QEMU_SRC/$arch-linux-user/tests (preferably statically linked) where
the test machinery can then pick them up and run them.

> How many of the qemu archs debian cross tools support? last
> time I looked there was annoying limitations, but I can't remember the
> details.

I think currently the emdebian compilers are arm, ppc and mips.

> crosstool-ng has perhaps more potential, especially if devs would
> share their config/samples (we could then have a cross-distro
> packaging with flatpack?)

Or simply a plain container which can hold pre-builts for the rarer
compilers?

There are a couple of problems I'm trying to solve.

The first is having a standard way to cross-build stuff so we can least
have a reference mechanism that is available to all devs. While we all
probably have random compilers sitting on our systems it would be nice
to have one method we could give new devs to say "this will build you
some foreign test binaries".

The second problem is as soon as you move away from simple libc
dependencies you start having to deal with development header
pre-requisites and that can get messy on your main system even with
multi-lib setups. A docker container can be created with all the
$FOO-arch dependencies for QEMU quite easily without breaking your main
machine. You simply need to run a "apt-get build-dep -a $ARCH qemu"
before the configure/build step.

It would be nice to come up with a solution to the proliferation of
containers though. The debootstrap container build script is generic but
currently we don't expose all the architecture variants in the make
system. We leave the user to build the containers they need and manually
call them for the build.

>
>> Alex Bennée (4):
>>   tests/docker: add basic user mapping support
>>   new tests/docker/dockerfiles/debian-multiarch-cross.docker
>>   tests/tcg: don't run tests by default
>>   tests/tcg/Makefile: use docker target for arm-tcg-tests
>>
>>  tests/docker/docker.py                             | 19 +++++++++++
>>  tests/docker/dockerfiles/debian-bootstrap.docker   |  3 ++
>>  .../dockerfiles/debian-multiarch-cross.docker      | 39
>>  ++++++++++++++++++++++
>>  tests/tcg/Makefile.include                         | 20 +++++++++--
>>  tests/tcg/arm/Makefile                             |  2 +-
>>  tests/tcg/misc/Makefile                            |  4 +--
>>  6 files changed, 81 insertions(+), 6 deletions(-)
>>  create mode 100644 tests/docker/dockerfiles/debian-multiarch-cross.docker
>>
>> --
>> 2.11.0
>>
>>


--
Alex Bennée
