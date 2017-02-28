Received: from eggs.gnu.org ([2001:4830:134:3::10]:55707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cipzf-0006Th-8H
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cipzc-00035V-4D
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:39 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cipzb-00035O-W0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:36 -0500
Received: by mail-qk0-x244.google.com with SMTP id n186so6232167qkb.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:11:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170227143028.16428-1-alex.bennee@linaro.org>
	<20170227143028.16428-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1aa607c9-8075-0845-9781-60447d42610e@amsat.org>
Date: Tue, 28 Feb 2017 19:11:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170227143028.16428-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] new: dockerfiles/debian-s390-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org

Hi Alex,

On 02/27/2017 11:30 AM, Alex Bennée wrote:
> This adds an s390 cross build target to our library of docker setups.
> There is an issue with the xfslibs-dev:s390x package having a clash so
> we do a || apt-get -f install to fixup the rest of the dependencies.
>
> This doesn't build on the debian.docker file as we are using the
> multilib compiler which is only available in stretch (the current
> testing repo).
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  tests/docker/dockerfiles/debian-s390x-cross.docker | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-s390x-cross.docker
>
> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
> new file mode 100644
> index 0000000000..bbb21ed088
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> @@ -0,0 +1,22 @@
> +#
> +# Docker s390 cross-compiler target
> +#
> +# This docker target is based on stretch (testing) as the stable build
> +# doesn't have the cross compiler available.
> +#
> +FROM debian:testing-slim
> +
> +# Duplicate deb line as deb-src
> +RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
> +
> +# Add the s390x architecture
> +RUN dpkg --add-architecture s390x
> +
> +# Grab the updated list of packages
> +RUN apt update
> +RUN apt dist-upgrade -yy

put both in same line since they are related (intermediate layer unuseful):

+RUN apt update && \
+    apt dist-upgrade -yy

> +RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
> +RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
> +
> +# Specify the cross prefix for this image (see tests/docker/common.rc)
> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
