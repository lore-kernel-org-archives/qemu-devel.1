Received: from eggs.gnu.org ([2001:4830:134:3::10]:34951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddpC-0006IE-AJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddpB-0004JI-1W
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:11:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cddpA-0004Im-Rt
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:11:20 -0500
Date: Tue, 14 Feb 2017 22:11:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214141117.GC12294@lemon.lan>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170214100733.22280-4-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] .shippable.yml: new CI provider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 02/14 10:07, Alex Benn=E9e wrote:
> Ostensibly Shippable offers a similar set of services as Travis.
> However they are focused on Docker container based work-flows so we
> can use our existing containers to run a few extra builds - in this
> case a bunch of cross-compiled targets on a Debian multiarch system.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> v3
>   - reduce matrix to armhf/arm64 which currently work
>   - use the make docker-image-* build stanzas
>   - add TARGET_LIST to each build
> ---
>  .shippable.yml | 23 +++++++++++++++++++++++
>  MAINTAINERS    |  1 +
>  2 files changed, 24 insertions(+)
>  create mode 100644 .shippable.yml
>=20
> diff --git a/.shippable.yml b/.shippable.yml
> new file mode 100644
> index 0000000000..e4fa159481
> --- /dev/null
> +++ b/.shippable.yml
> @@ -0,0 +1,23 @@
> +language: c
> +env:
> +  matrix:
> +    - IMAGE=3Ddebian-armhf-cross
> +      CROSS_PREFIX=3Darm-linux-gnueabihf-
> +      TARGET_LIST=3Darm-softmmu,arm-linux-user
> +    - IMAGE=3Ddebian-arm64-cross
> +      CROSS_PREFIX=3Daarch64-linux-gnu-
> +      TARGET_LIST=3Daarch64-softmmu,aarch64-linux-user
> +    - IMAGE=3Dcentos6
> +      TARGET_LIST=3Di386-softmmu,x86_64-softmmu
> +build:
> +  pre_ci:
> +    - make docker-image-${IMAGE}
> +  pre_ci_boot:
> +    image_name: qemu
> +    image_tag: ${IMAGE}
> +    pull: false
> +    options: "-e HOME=3D/root"
> +  ci:
> +    - unset CC
> +    - ./configure --cross-prefix=3D${CROSS_PREFIX} --target-list=3D${T=
ARGET_LIST}
> +    - make -j2

Looks cool!

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7afbadaa15..578888d32d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1805,6 +1805,7 @@ M: Alex Benn=E9e <alex.bennee@linaro.org>
>  L: qemu-devel@nongnu.org
>  S: Supported
>  F: .travis.yml
> +F: .shippable.yml
> =20
>  Documentation
>  -------------
> --=20
> 2.11.0
>=20
>=20

May I propose we merge 'docker testing' section of MAINTAINERS into 'buil=
d and
test automation' section? I don't know as much about travis (and shippabl=
e) but
I'm totally fine if you want to have docker tests under your umbrella, an=
d
it seems a logical step judging from their names.

Fam
