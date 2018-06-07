Received: from eggs.gnu.org ([2001:4830:134:3::10]:51465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQqkD-0007Kf-Rk
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQqkA-0007vp-QG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:58:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQqkA-0007vX-KT
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:58:06 -0400
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75dd4f2c-e564-5557-8ccb-66857a7afafd@redhat.com>
Date: Thu, 7 Jun 2018 10:57:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180606173233.28080-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] glib: enforce the minimum required
 version and warn about old APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 06.06.2018 19:32, Daniel P. Berrang=C3=A9 wrote:
> There are two useful macros that can be defined before including
> glib.h that are related to the min required glib version
>=20
>  - GLIB_VERSION_MIN_REQUIRED
>=20
>    When this is defined, if code uses an API that was deprecated
>    in this version, or older, a compiler warning will be emitted.
>    This alerts maintainers to update their code to whatever new
>    replacement API is now recommended best practice.
>=20
>  - GLIB_VERSION_MAX_ALLOWED
>=20
>    When this is defined, if code uses an API that was introduced
>    in a version that is newer than the declared version, a compiler
>    warning will be emitted. This alerts maintainers if new code
>    accidentally uses functionality that won't be available on some
>    supported platforms.
>=20
> The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
> in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
> To workaround this Pragmas can be used to temporarily turn off the
> -Wdeprecated-declarations compiler warning, while a static inline
> compat function is implemented. This workaround is illustrated with the
> implementation of the g_strv_contains method to satisfy the test suite.

I wonder whether that's a little bit too much magic already. We could
also set GLIB_VERSION_MAX_ALLOWED to the version where we've already got
the work-arounds in place (i.e. to 2.44 here). If we introduce
additional code that uses other new functions from 2.41 - 2.44, this
should also be caught by the patchew CI builders?

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/glib-compat.h                    | 67 ++++++++++++++++++++++++
>  tests/docker/dockerfiles/centos6.docker  | 30 -----------
>  tests/docker/dockerfiles/min-glib.docker |  8 ---

The docker files are not directly related to this patch, are they? If
they are, please mention it in the patch description. If not, please
move this to a separate patch (or maybe into patch 1).

>  tests/test-qga.c                         |  2 -
>  4 files changed, 67 insertions(+), 40 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/centos6.docker
>  delete mode 100644 tests/docker/dockerfiles/min-glib.docker
>=20
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index 3b340ab33c..cfc3cba751 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -16,8 +16,73 @@
>  #ifndef QEMU_GLIB_COMPAT_H
>  #define QEMU_GLIB_COMPAT_H
> =20
> +/* Ask for warnings for anything that was marked deprecated in
> + * the defined version, or before. It is a candidate for rewrite.
> + */
> +#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
> +
> +/* Ask for warnings if code tries to use function that did not
> + * exist in the defined version. These risk breaking builds
> + */
> +#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
> +
> +_Pragma("GCC diagnostic push")
> +_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")

Why not "#pragma" ? I think that's a little bit more common?

 Thomas
