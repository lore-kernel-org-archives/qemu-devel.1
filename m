Received: from eggs.gnu.org ([2001:4830:134:3::10]:38512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdekX-0007Uv-4x
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdekR-0000Sm-RT
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:10:37 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdekR-0000SI-Kf
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:10:31 -0500
Received: by mail-wr0-x236.google.com with SMTP id k90so171732537wrc.3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:10:31 -0800 (PST)
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-3-alex.bennee@linaro.org>
	<20170214140049.GB12294@lemon.lan>
	<20170214142727.GB20715@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170214142727.GB20715@lemon.lan>
Date: Tue, 14 Feb 2017 15:10:49 +0000
Message-ID: <87efz0vmdi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] new: debian docker targets for
 cross-compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Tue, 02/14 22:00, Fam Zheng wrote:
>> On Tue, 02/14 10:07, Alex Bennée wrote:
>> > This provides a basic Debian install with access to the emdebian cross
>> > compilers. The debian-armhf-cross and debian-arm64-cross targets build
>> > on the basic Debian image to allow cross compiling to those targets.
>> >
>> > To build against the cross compiler a cross-compile prefix needs to be
>> > set in the configure options, for example:
>> >
>> >   make docker-test-build@debian-arm64-cross \
>> >     EXTRA_CONFIGURE_OPTS="--cross-prefix=aarch64-linux-gnu-" \
>> >     TARGET_LIST="aarch64-softmmu,aarch64-linux-user"
>>
>> If cross-compile is the only meaningful way to use this image, we probably
>> should bake the configure option into the dockerfile and pick it up
>> automatically in common.rc.  What do you think?
>
> The example change is like this:
>
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 21657e87c6..6865689bb5 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -29,7 +29,7 @@ build_qemu()
>      config_opts="--enable-werror \
>                   ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
>                   --prefix=$PWD/install \
> -                 $EXTRA_CONFIGURE_OPTS \
> +                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
>                   $@"
>      echo "Configure options:"
>      echo $config_opts
> diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
> index 04212629f7..fc1c135e74 100644
> --- a/tests/docker/dockerfiles/debian-arm64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
> @@ -10,3 +10,4 @@ RUN dpkg --add-architecture arm64
>  RUN apt update
>  RUN apt install -yy crossbuild-essential-arm64
>  RUN apt-get build-dep -yy -a arm64 qemu
> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-

Yeah that seems like a good idea. Then a make
docker-test-build@debian-armhf-cross will work as expected ;-)

--
Alex Bennée
