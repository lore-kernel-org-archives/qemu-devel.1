Received: from eggs.gnu.org ([2001:4830:134:3::10]:35259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZks4-0008SM-O8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZks3-0004oo-Jp
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:26:32 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZks3-0004nw-DJ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:26:31 -0400
Received: by mail-wm0-x231.google.com with SMTP id m85so27586052wma.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:26:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-28-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-28-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:26:09 +0100
Message-ID: <CAFEAcA86cuTukJ4HXVKDjewpxy2myPU1Gdbn671zqxJq6d09Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 27/35] syscall: fix dereference of
 undefined pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Clang's scan-build-5.0 reports:
>
> linux-user/syscall.c:5581:9: warning: Dereference of undefined pointer va=
lue
>     if (*host_rt_dev_ptr !=3D 0) {
>         ^~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fcd20fa276..e79b5baec4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5524,7 +5524,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, u=
int8_t *buf_temp,
>      int target_size;
>      void *argptr;
>      abi_ulong *target_rt_dev_ptr;
> -    unsigned long *host_rt_dev_ptr;
> +    unsigned long *host_rt_dev_ptr =3D NULL;
>      abi_long ret;
>      int i;
>
> @@ -5570,6 +5570,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, u=
int8_t *buf_temp,
>      unlock_user(argptr, arg, 0);
>
>      ret =3D get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
> +    assert(host_rt_dev_ptr);

There's not much point in this assert because it doesn't
tell us anything we're not about to find out immediately
by dereferencing the pointer...

>      if (*host_rt_dev_ptr !=3D 0) {
>          unlock_user((void *)*host_rt_dev_ptr,
>                      *target_rt_dev_ptr, 0);
> --
> 2.13.3

thanks
-- PMM
