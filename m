Received: from eggs.gnu.org ([209.51.188.92]:34609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghwd9-000819-Jf
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghwd8-0005hl-K2
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:13:47 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghwd8-0005hT-Bh
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:13:46 -0500
Received: by mail-wr1-f43.google.com with SMTP id s12so15161698wrt.4
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:13:46 -0800 (PST)
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd4fba2b-ed56-b715-04f4-c2489b5430f6@redhat.com>
Date: Fri, 11 Jan 2019 14:13:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190110174516.21586-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 16/19] docker: Use a stable snapshot for
 Debian Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: ymankad@redhat.com, Fam Zheng <fam@euphon.net>

On 1/10/19 6:45 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
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
>    build-essential : Depends: dpkg-dev (>= 1.17.11) but it is not going to be installed
>    git : Depends: perl but it is not going to be installed
>          Depends: liberror-perl but it is not going to be installed
>    pkg-config : Depends: libdpkg-perl but it is not going to be installed
>    texinfo : Depends: perl (>= 5.26.2-6) but it is not going to be installed
>              Depends: libtext-unidecode-perl but it is not going to be installed
>              Depends: libxml-libxml-perl but it is not going to be installed
>   E: Unable to correct problems, you have held broken packages.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> [AJB: also tweak FROM to a earlier snapshot]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-sid.docker | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
> index 4e4cda0ba5..676941cb32 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -11,7 +11,12 @@
>  # updated and trigger a re-build.
>  #
>  
> -FROM debian:sid-slim
> +# This must be earlier than the snapshot date we are aiming for
> +FROM debian:sid-20181011-slim
> +
> +# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> +ENV DEBIAN_SNAPSHOT_DATE "20181030"
> +RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list

These 2 lines are now dup (probably because Fam's PR entered before this
series).

>  
>  # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
>  ENV DEBIAN_SNAPSHOT_DATE "20181030"
> 

Without the dup lines:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
