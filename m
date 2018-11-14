Received: from eggs.gnu.org ([208.118.235.92]:59397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMttH-0000zH-Dj
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMttB-0003vP-EW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:03:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gMtt7-0003tp-RR
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:03:19 -0500
References: <20181113184641.4492-1-peter.maydell@linaro.org>
	<20181113184641.4492-3-peter.maydell@linaro.org>
	<163db126-4441-3e4a-2dd0-1334c6ef4fb9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a2e6935-d76b-ca8f-1e9f-63454dc1b7dc@redhat.com>
Date: Wed, 14 Nov 2018 13:02:55 +0100
MIME-Version: 1.0
In-Reply-To: <163db126-4441-3e4a-2dd0-1334c6ef4fb9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] scripts/coverity-scan: Add Docker
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, patches@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 13/11/2018 20:37, Philippe Mathieu-Daud=C3=A9 wrote:
> Calling "make docket-image-fedora" you can reduce this script to:
>=20
> -- >8 --
> FROM qemu:fedora
> ENV PACKAGES \
> =C2=A0=C2=A0=C2=A0 $PACKAGES \
> =C2=A0=C2=A0=C2=A0 alsa-lib-devel \
> =C2=A0=C2=A0=C2=A0 curl \
> =C2=A0=C2=A0=C2=A0 cyrus-sasl-devel \
> =C2=A0=C2=A0=C2=A0 libepoxy-devel \
> =C2=A0=C2=A0=C2=A0 libgbm-devel \
> =C2=A0=C2=A0=C2=A0 libiscsi-devel \
> =C2=A0=C2=A0=C2=A0 libnfs-devel \
> =C2=A0=C2=A0=C2=A0 libseccomp-devel \
> =C2=A0=C2=A0=C2=A0 libudev-devel \
> =C2=A0=C2=A0=C2=A0 pulseaudio-libs-devel \
> =C2=A0=C2=A0=C2=A0 rdma-core-devel \
> =C2=A0=C2=A0=C2=A0 wget \
> =C2=A0=C2=A0=C2=A0 xfsprogs-devel

... these can actually be moved to
tests/docker/dockerfiles/fedora.docker, improving the coverage...
>=20
> RUN dnf install -y $PACKAGES
> RUN rpm -q $PACKAGES | sort > /packages.txt

... and removing the need for these two.

> ENV COVERITY_TOOL_BASE=3D/coverity-tools
> COPY run-coverity-scan run-coverity-scan
> RUN --mount=3Dtype=3Dsecret,id=3Dcoverity.token,required ./run-coverity=
-scan
> --update-tools-only --tokenfile /run/secrets/coverity.token

If the tokenfile is not needed when updating the tools, you could also
move the Dockerfile to tests/docker/dockerfiles/fedora-coverity.docker
and just do "make docker-image-fedora-coverity"

> +    # TODO: how do you get 'docker build' to print the output of the
> +    # commands it is running to its stdout? This would be useful for d=
ebug.

With make docker-image-*, you can just pass V=3D1.

Paolo
