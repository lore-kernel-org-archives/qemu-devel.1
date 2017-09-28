Received: from eggs.gnu.org ([2001:4830:134:3::10]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dxOEn-0006tK-Kr
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dxOEm-0005hc-M0
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:07:41 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:53019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dxOEm-0005hA-GF
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:07:40 -0400
Received: by mail-it0-x244.google.com with SMTP id c195so520303itb.1
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 19:07:39 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170925075458.18047-1-famz@redhat.com>
References: <20170925075458.18047-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 27 Sep 2017 23:07:36 -0300
Message-ID: <CAAdtpL5j_9qh2bmzpmx3ULgCFr8TkMF4AgUZF=7Ka66=3diD3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Don't mount ccache db if NOUSER=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, Sep 25, 2017 at 4:54 AM, Fam Zheng <famz@redhat.com> wrote:
> With NOUSER=3D1 the container runs code as root, which may create
> privileged files that will not be be accssible next time. Skip ccache
> dir mount in this case.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
> index 0e4f159619..6f9ea196a7 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -143,9 +143,11 @@ docker-run: docker-qemu-src
>                         -e EXTRA_CONFIGURE_OPTS=3D"$(EXTRA_CONFIGURE_OPTS=
)" \
>                         -e V=3D$V -e J=3D$J -e DEBUG=3D$(DEBUG)          =
     \
>                         -e SHOW_ENV=3D$(SHOW_ENV)                        =
 \
> -                       -e CCACHE_DIR=3D/var/tmp/ccache                  =
 \
> +                       $(if $(NOUSER),,                                \
> +                               -e CCACHE_DIR=3D/var/tmp/ccache          =
 \
> +                               -v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z=
 \
> +                       )                                               \
>                         -v $$(readlink -e $(DOCKER_SRC_COPY)):/var/tmp/qe=
mu:z$(COMMA)ro \
> -                       -v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z       \
>                         $(IMAGE)                                        \
>                         /var/tmp/qemu/run                               \
>                         $(TEST), "  RUN $(TEST) in ${IMAGE}")
> --
> 2.13.5
>
