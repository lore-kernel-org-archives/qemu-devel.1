Received: from eggs.gnu.org ([2001:4830:134:3::10]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cWjTY-0007xe-S4
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cWjTU-0001Tf-SM
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:48:28 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cWjTU-0001TL-Lo
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:48:24 -0500
Received: by mail-wm0-x231.google.com with SMTP id r126so70479840wmr.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 04:48:24 -0800 (PST)
References: <20170124143346.22240-1-alex.bennee@linaro.org>
	<20170124143346.22240-6-alex.bennee@linaro.org>
	<20170126105346.GH6879@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170126105346.GH6879@lemon>
Date: Thu, 26 Jan 2017 12:48:20 +0000
Message-ID: <87efzq9ecr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] new debian-multiarch-cross.docker:
 a cross-compiling docker guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>


Fam Zheng <famz@redhat.com> writes:

> On Tue, 01/24 14:33, Alex Bennée wrote:
>> This provides a basic Debian install with access to the emdebian cross
>> compilers for armhf, arm64, mipsel and ppc64el. On its own it provides
>> the basic cross build essentials for building any of those
>> architectures. More complex cross-compilations would need to install
>> library dependencies on top of this image.
>>
>> An example use:
>>
>>   docker run --rm -it \
>>     -v /home/alex/lsrc/qemu/qemu.git/:/home/alex/lsrc/qemu/qemu.git/ \
>>     --user=alex:alex \
>>     -w /home/alex/lsrc/qemu/qemu.git/arm-linux-user/tests \
>>     -e CROSS_CC="arm-linux-gnueabihf-gcc" \
>>     debian:cross make -f ../../tests/tcg/arm/Makefile
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - add clang (keep shippable happy)
>>   - rm adduser code (done direct now)
>>   - add aptitude (useful for debugging package clashes)
>> ---
>>  .../dockerfiles/debian-multiarch-cross.docker      | 45 ++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/debian-multiarch-cross.docker
>>
>> diff --git a/tests/docker/dockerfiles/debian-multiarch-cross.docker b/tests/docker/dockerfiles/debian-multiarch-cross.docker
>> new file mode 100644
>> index 0000000000..749fdf07e1
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/debian-multiarch-cross.docker
>> @@ -0,0 +1,45 @@
>> +#
>> +# Docker multiarch cross-compiler target
>> +#
>> +# This docker target is builds on Debian and Emdebian's cross compiler targets
>> +# to build distro with a selection of cross compilers for building test binaries.
>> +#
>> +# This does not include the build dependancies for QEMU as there are
>> +# so many there are unresolvable clashes.
>> +#
>> +FROM debian:stable-slim
>> +
>> +# Setup some basic tools we need
>> +RUN apt update
>> +RUN apt install -yy curl aptitude
>> +
>> +# Setup Emdebian
>> +RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
>> +RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
>> +
>> +# Duplicate deb line as deb-src
>> +RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>> +
>> +# Add the foriegn architectures we want
>> +RUN dpkg --add-architecture armhf
>> +RUN dpkg --add-architecture arm64
>> +RUN dpkg --add-architecture mipsel
>> +RUN dpkg --add-architecture ppc64el
>> +
>> +#FIXME: Currently these cause clashes due to multi-arch being an ongoig process
>
> "ongoing"?
>
>> +#RUN dpkg --add-architecture mips
>> +#RUN dpkg --add-architecture powerpc
>> +
>> +# Final update
>> +RUN apt update
>> +
>> +# Install the crossbuild essential packages
>> +# FIXME: crossbuild-essential-powerpc has a clash with '/lib/ld.so.1'
>> +RUN apt install -yy clang crossbuild-essential-arm64 crossbuild-essential-armhf crossbuild-essential-mipsel crossbuild-essential-ppc64el
>> +
>> +# Before you can actually build something you need to install its build dependancies.
>> +# This is best done in a child container as architecture specific -dev packages have a habit of clashing with
>> +# each other because not everything is fully complient with the multiarch specififcation.
>
> "compliant"?
>
>> +#
>> +# To install the QEMU build dependacnies you need to run:
>> +# RUN apt-get build-dep -yy -a armhf qemu
>> --
>> 2.11.0
>>
>
> Does this image work with our tests, such as "make
> docker-test-quick@debian-multiarch-cross"? If not let's put it into a different
> folder okay?

There is no particular reason why it couldn't be included in the docker
targets. We can either expand the existing build.sh to include a
dependency step or add a new build script for use here.

--
Alex Bennée
