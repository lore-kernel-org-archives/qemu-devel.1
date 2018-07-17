Received: from eggs.gnu.org ([2001:4830:134:3::10]:34821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSGv-0005LZ-9P
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSGs-00055U-4K
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:52:17 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:44075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSGr-000556-U0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:52:14 -0400
Received: by mail-ua0-x242.google.com with SMTP id k25-v6so983380uao.11
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:52:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <192d00d0-63b4-f354-f40f-50d802a80cf2@amsat.org>
Date: Tue, 17 Jul 2018 12:52:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 16/16] docker: ignore distro
 versioning of debootstrap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> We do a minimum version check for the debootstrap but if the distro
> has added their own minor version tick it would fail and fall-back to
> the SCM version. This is sub-optimal as the latest/greatest version
> may be broken at any one particular time. We fix that with a little
> sed magic on the version string before passing to our ugly shell
> versioning check.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/debian-bootstrap.pre | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
> index ea324d6e4a..3b0ef95374 100755
> --- a/tests/docker/dockerfiles/debian-bootstrap.pre
> +++ b/tests/docker/dockerfiles/debian-bootstrap.pre
> @@ -56,10 +56,13 @@ if [ -z $DEBOOTSTRAP_DIR ]; then
>      if [ -z $DEBOOTSTRAP ]; then
>          echo "No debootstrap installed, attempting to install from SCM"
>          NEED_DEBOOTSTRAP=true
> -    elif ! (echo "${MIN_DEBOOTSTRAP_VERSION}" ; "${DEBOOTSTRAP}" --version \
> -            | cut -d ' ' -f 2) | sort -t . -n -k 1,1 -k 2,2 -k 3,3 -c &>/dev/null; then
> -        echo "debootstrap too old, attempting to install from SCM"
> -        NEED_DEBOOTSTRAP=true
> +    else
> +        INSTALLED_VERSION=$(${DEBOOTSTRAP} --version | sed 's/debootstrap \([0-9\.]*\)[^0-9\.]*.*/\1/')
> +        if ! (echo "${MIN_DEBOOTSTRAP_VERSION}" ; echo "${INSTALLED_VERSION}") \
> +                | sort -t . -n -k 1,1 -k 2,2 -k 3,3 -C ; then
> +            echo "debootstrap too old, attempting to install from SCM"
> +            NEED_DEBOOTSTRAP=true
> +        fi
>      fi
>      if $NEED_DEBOOTSTRAP; then
>          DEBOOTSTRAP_SOURCE=https://salsa.debian.org/installer-team/debootstrap.git
> 
