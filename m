Received: from eggs.gnu.org ([2001:4830:134:3::10]:34111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceM9R-0007XE-R1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceM9Q-0007Yv-Sm
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:31:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ceM9Q-0007YZ-Mh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:31:12 -0500
Date: Thu, 16 Feb 2017 21:31:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170216133109.GD8817@lemon.lan>
References: <20170216123456.28621-1-alex.bennee@linaro.org>
	<20170216123456.28621-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170216123456.28621-4-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/4] .shippable.yml: new CI provider
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

On Thu, 02/16 12:34, Alex Benn=E9e wrote:
> Ostensibly Shippable offers a similar set of services as Travis.
> However they are focused on Docker container based work-flows so we
> can use our existing containers to run a few extra builds - in this
> case a bunch of cross-compiled targets on a Debian multiarch system.

Out of curiosity, what are the forms of build report from shippable servi=
ce?

>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> v3
>   - reduce matrix to armhf/arm64 which currently work
>   - use the make docker-image-* build stanzas
>   - add TARGET_LIST to each build
> ---
>  .shippable.yml | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 .shippable.yml
>=20
> diff --git a/.shippable.yml b/.shippable.yml
> new file mode 100644
> index 0000000000..4de8daf341
> --- /dev/null
> +++ b/.shippable.yml
> @@ -0,0 +1,21 @@
> +language: c
> +env:
> +  matrix:
> +    - IMAGE=3Ddebian-armhf-cross
> +      TARGET_LIST=3Darm-softmmu,arm-linux-user
> +    - IMAGE=3Ddebian-arm64-cross
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
> +    - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=3D${TARGET_LIST=
}
> +    - make -j2

It's a good surprise that our docker infrastructure fits in the shippable
framework pretty nicely. :)

Looks good to me without cross checking the shippable API:

Reviewed-by: Fam Zheng <famz@redhat.com>
