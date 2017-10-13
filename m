Received: from eggs.gnu.org ([2001:4830:134:3::10]:35113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2xZy-0006Ai-Lr
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2xZt-0001WI-Nr
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e2xZt-0001VO-HQ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:52:29 -0400
References: <20171013102812.29648-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
Date: Fri, 13 Oct 2017 12:52:26 +0200
MIME-Version: 1.0
In-Reply-To: <20171013102812.29648-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 13.10.2017 12:28, Daniel P. Berrange wrote:
> The system compiler in OpenBSD is gcc 4.2.1 which is too
> old for our needs. If doing 'pkg_add gcc' you can get a
> much newer version (4.9.4 in OpenBSD 6.1) which works with
> QEMU. This installs binaries with two naming schemes:
>=20
>   $ pkg_info  -L gcc | grep bin
>   /usr/local/bin/ecpp
>   /usr/local/bin/egcc
>   /usr/local/bin/egcc-ar
>   /usr/local/bin/egcc-nm
>   /usr/local/bin/egcc-ranlib
>   /usr/local/bin/egcov
>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc
>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ar
>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-nm
>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ranlib
>   /usr/local/bin/x86_64-unknown-openbsd6.0-gcc-4.9.3
>=20
> We pick the short name this it won't change across OpenBSD
> releases.
>=20
> This means users don't need to manually pass custom --cc
> and --cxx args to configure to avoid immediate failure.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  configure | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/configure b/configure
> index 06f18ea9af..fcb7523933 100755
> --- a/configure
> +++ b/configure
> @@ -255,7 +255,21 @@ cross_prefix=3D""
>  audio_drv_list=3D""
>  block_drv_rw_whitelist=3D""
>  block_drv_ro_whitelist=3D""
> -host_cc=3D"cc"
> +
> +case `uname -s` in
> +    OpenBSD)
> +    # Default system cc in OpenBSD is unsufficient

s/unsufficient/insufficient/

> +    # we need the 'gcc' pkg added, whch provides

s/whch/which/

> +    # these modified binary names
> +    host_cc=3D"egcc"
> +    host_cxx=3D"eg++"
> +    ;;
> +         *)
> +    host_cc=3D"cc"
> +    host_cxx=3D"c++"
> +    ;;
> +esac

Do we really need such work-arounds in our configure script? GCC 4.2 is
really veeeery old nowadays, so if the OpenBSD folks refuse to update
the default in their distro, IMHO they should be punished by having to
select the C compiler manually everywhere.

 Thomas
