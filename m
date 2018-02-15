Received: from eggs.gnu.org ([2001:4830:134:3::10]:33584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emOCv-0005mp-EC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emOCu-0007v5-Ew
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emOCu-0007v1-Ai
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:32 -0500
References: <20180215171611.11962-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2218393d-c61a-32c5-68bf-ffd993d209dc@redhat.com>
Date: Thu, 15 Feb 2018 12:24:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180215171611.11962-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: dump config.log when configure
 fails in docker job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 02/15/2018 11:16 AM, Daniel P. Berrang=C3=A9 wrote:
> When configure fails inside a docker job it is not easy to get access t=
o
> the config.log file. It is nicer for developers if we just splatter the
> contents of config.log to stdout upon failure
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/docker/common.rc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 7951555e3f..ecbea13443 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -30,7 +30,8 @@ build_qemu()
>                    $@"
>       echo "Configure options:"
>       echo $config_opts
> -    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS

The old code dies if either configure or make has non-zero exit status.

> +    $QEMU_SRC/configure $config_opts || cat config.log
> +    make $MAKEFLAGS

But this turns a failure of configure into a successful exit status=20
(presuming that cat doesn't also fail), which means we try the make no=20
matter whether configure succeeded.

Better might be:

$QEMU_SRC/configure $config_opts || { cat config.log; exit 1; }


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
