Received: from eggs.gnu.org ([209.51.188.92]:38580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzlKU-0003UW-T2
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzlKR-0007st-T7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzlKR-0007rb-K1
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:48:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C56B5B0ADA
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 16:48:05 +0000 (UTC)
References: <20190301163346.6545-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6075dc0-8bf1-fbdf-17d6-ea86d98c7aea@redhat.com>
Date: Fri, 1 Mar 2019 10:48:04 -0600
MIME-Version: 1.0
In-Reply-To: <20190301163346.6545-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: automatically pick python3 is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

On 3/1/19 10:33 AM, Daniel P. Berrang=C3=A9 wrote:
> Unless overridden via an env var or configure arg, QEMU will only look
> for the 'python' binary in $PATH. This is unhelpful on distros which
> are only shipping Python 3.x (eg Fedora) in their default install as,
> if they comply with PEP 394, the bare 'python' binary won't exist.
>=20
> This changes configure so that by default it will search for all three
> common python binaries, preferring to find Python 3.x versions.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  configure | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index 540bee19ba..ef2e5bf9f5 100755
> --- a/configure
> +++ b/configure
> @@ -902,7 +902,10 @@ fi
> =20
>  : ${make=3D${MAKE-make}}
>  : ${install=3D${INSTALL-install}}
> -: ${python=3D${PYTHON-python}}
> +# We prefer python 3.x. A bare 'python' is traditionally
> +# python 2.x, but some distros have it as python 3.x, so
> +# we check that before python2
> +: ${python=3D${PYTHON-python3 python python2}}

If I run with PYTHON=3D'/path with spaces/to/mypython',

>  : ${smbd=3D${SMBD-/usr/sbin/smbd}}
> =20
>  # Default objcc to clang if available, otherwise use CC
> @@ -1797,8 +1800,20 @@ EOF
>  exit 0
>  fi
> =20
> -if ! has $python; then
> -  error_exit "Python not found. Use --python=3D/path/to/python"
> +try_python=3D"$python"
> +python=3D
> +for binary in $try_python

then this ignores my request (trying '/path', 'with', and
'spaces/to/mypython', none of which works).

I think a better approach would be:

python=3D
for binary in "${PYTHON-python3}" python python2

> +do
> +    if has $binary

if has "$binary"

> +    then
> +       python=3D$binary
> +       break
> +    fi
> +done
> +
> +if test -z "$python"
> +then
> +    error_exit "Python not found. Use --python=3D/path/to/python"
>  fi
> =20
>  # Note that if the Python conditional here evaluates True we will exit
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
