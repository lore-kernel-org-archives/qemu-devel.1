Received: from eggs.gnu.org ([209.51.188.92]:38908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1go3WH-0005qN-B2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1go3WG-0004Bm-JT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1go3WG-0004BN-DF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:56 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so17244450wrt.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 01:47:55 -0800 (PST)
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-3-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190125192719.15339-3-philmd@redhat.com>
Date: Mon, 28 Jan 2019 09:47:52 +0000
Message-ID: <874l9tnmev.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] XXX oslib-posix: Ignore
 fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Previous to OpenBSD 6.3 [1], fcntl(F_SETFL) is not permitted on memory
> devices. Do not assert fcntl failures on OpenBSD.
> This fixes:
>
>   $ lm32-softmmu/qemu-system-lm32
>   assertion "f !=3D -1" failed: file "util/oslib-posix.c", line 247, func=
tion "qemu_set_nonblock"
>   Abort trap (core dumped)
>
> [1] The fix seems https://github.com/openbsd/src/commit/c2a35b387f9d3c
>   "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
>   the memory devices (/dev/null, /dev/zero, etc) need to permit them."

I assume set_nonblock is called on more than just these special devices?
Is there anyway to check this on OpenBSD or is it just an anonymous fd
at this point?

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  util/oslib-posix.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4ce1ba9ca4..064c3ae2f7 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -244,7 +244,9 @@ void qemu_set_nonblock(int fd)
>      f =3D fcntl(fd, F_GETFL);
>      assert(f !=3D -1);
>      f =3D fcntl(fd, F_SETFL, f | O_NONBLOCK);
> +#ifndef __OpenBSD__
>      assert(f !=3D -1);
> +#endif
>  }
>
>  int socket_set_fast_reuse(int fd)


--
Alex Benn=C3=A9e
