Received: from eggs.gnu.org ([2001:4830:134:3::10]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5Iz-0003fH-VL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5Iv-00064f-Kq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:20:13 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5Iv-00063H-Fz
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:20:09 -0400
Received: by mail-qk0-x243.google.com with SMTP id t79-v6so9349764qke.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 13:20:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-18-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <55a47a01-1f11-b4a9-fd7a-e7aa7443fdf8@amsat.org>
Date: Mon, 2 Jul 2018 17:20:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180702143021.18864-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 17/20] docker: debian-bootstrap.pre
 allow customising of variant/url
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On 07/02/2018 11:30 AM, Alex Bennée wrote:
> We default to the buildd variant as most of our images are for
> building. However lets give the user the ability to specify "minbase"
> if they want to create a simple base image for experimentation.
> 
> Allowing the tweaking of DEB_URL means we can also bootstrap other
> Debian based OS's. For example:
> 
>   make docker-binfmt-image-debian-ubuntu-bionic-arm64 \
>        DEB_ARCH=arm64 DEB_TYPE=bionic \
>        DEB_VARIANT=minbase DEB_URL=http://ports.ubuntu.com/ \
>        EXECUTABLE=./aarch64-linux-user/qemu-aarch64
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/debian-bootstrap.pre | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
> index 7c76dce663..56e1aa7a21 100755
> --- a/tests/docker/dockerfiles/debian-bootstrap.pre
> +++ b/tests/docker/dockerfiles/debian-bootstrap.pre
> @@ -32,6 +32,15 @@ if [ -z "${DEB_TYPE}" ]; then
>  
>  fi
>  
> +# The following allow finer grain control over the defaults
> +if [ -z "${DEB_VARIANT}" ]; then
> +    DEB_VARIANT=buildd
> +fi
> +
> +if [ -z "${DEB_URL}" ]; then
> +    DEB_URL="http://httpredir.debian.org/debian"
> +fi
> +
>  # We check in order for
>  #
>  #  - DEBOOTSTRAP_DIR pointing at a development checkout
> @@ -107,5 +116,5 @@ fi
>  
>  echo "Building a rootfs using ${FAKEROOT} and ${DEBOOTSTRAP} ${DEB_ARCH}/${DEB_TYPE}"
>  
> -${FAKEROOT} ${DEBOOTSTRAP} --variant=buildd --foreign --arch=$DEB_ARCH $DEB_TYPE . http://httpredir.debian.org/debian || exit 1
> +${FAKEROOT} ${DEBOOTSTRAP} --variant=$DEB_VARIANT --foreign --arch=$DEB_ARCH $DEB_TYPE . $DEB_URL || exit 1
>  exit 0
> 
