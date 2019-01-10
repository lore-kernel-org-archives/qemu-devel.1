Received: from eggs.gnu.org ([209.51.188.92]:39666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghd0u-00026r-KA
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghd0t-00011W-Ms
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:17:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ghd0s-00010R-SP
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:16:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id u4so12060152wrp.3
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:16:58 -0800 (PST)
References: <20181101183705.5422-1-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181101183705.5422-1-philmd@redhat.com>
Date: Thu, 10 Jan 2019 16:16:55 +0000
Message-ID: <87y37sv66g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Use a stable snapshot for Debian
 Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The Debian Sid repository is not garanteed to be stable, as his
> 'unstable' name suggest :)
> To allow quick testing, packages are pushed various time a day,
> which my be annoying when trying to use it for stable development
> (which is not recommended, but Sid provides edge packages we use
> for testing).
>
> Debian provides repositories snapshots which are suitable for our
> use. Pick a recent date that works. When required, update to newer
> releases will be easy.
>
> This fixes current issues with this image:
>
>   $ make docker-image-debian-sid
>   [...]
>   The following packages have unmet dependencies:
>    build-essential : Depends: dpkg-dev (>=3D 1.17.11) but it is not going=
 to be installed
>    git : Depends: perl but it is not going to be installed
>          Depends: liberror-perl but it is not going to be installed
>    pkg-config : Depends: libdpkg-perl but it is not going to be installed
>    texinfo : Depends: perl (>=3D 5.26.2-6) but it is not going to be inst=
alled
>              Depends: libtext-unidecode-perl but it is not going to be in=
stalled
>              Depends: libxml-libxml-perl but it is not going to be instal=
led
>   E: Unable to correct problems, you have held broken packages.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/debian-sid.docker | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/do=
ckerfiles/debian-sid.docker
> index 9a3d168705..4e4cda0ba5 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -13,6 +13,10 @@
>
>  FROM debian:sid-slim
>
> +# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> +ENV DEBIAN_SNAPSHOT_DATE "20181030"
> +RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [ch=
eck-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHO=
T_DATE} \2%" /etc/apt/sources.list
> +

OK after much debugging and re-building I realise this isn't the whole
fix. We need to base the snapshot on an older docker image otherwise we
run into the problem of trying to downgrade. In my tree I've done:

  # This must be earlier than the snapshot date we are aiming for
  FROM debian:sid-20181011-slim

  # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
  ENV DEBIAN_SNAPSHOT_DATE "20181030"

If this patch hasn't already gone in via a Fam PR I'll include it in my
testing/next.

--
Alex Benn=C3=A9e
