Received: from eggs.gnu.org ([2001:4830:134:3::10]:37005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcAKD-0008KP-RV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcAKC-0006Qo-QR
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:01:33 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcAKC-0006QE-KO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:01:32 -0400
Received: by mail-wm0-x231.google.com with SMTP id m85so169383461wma.1
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 06:01:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bc658e4a2e81593f75a3ae34b112be77efbb3e0a.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
	<bc658e4a2e81593f75a3ae34b112be77efbb3e0a.1501496349.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 14:01:10 +0100
Message-ID: <CAFEAcA-4_nqre=0BQSCgFtanNnVajubNH4r5SrG7Lg67QqeVRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 15/25] syscall: fix dereference of undefined
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 31 July 2017 at 11:21, Michael Tokarev <mjt@tls.msk.ru> wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> linux-user/syscall.c:5581:9: warning: Dereference of undefined pointer va=
lue
>     if (*host_rt_dev_ptr !=3D 0) {
>         ^~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 003943b736..71d45a9963 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5573,6 +5573,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, u=
int8_t *buf_temp,
>                                      field_types, THUNK_HOST);
>      }
>      unlock_user(argptr, arg, 0);
> +    assert(host_rt_dev_ptr);
>
>      ret =3D get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
>      if (*host_rt_dev_ptr !=3D 0) {
> --

This appears not to build with all versions of gcc; the ones in my
test set were fine but the gcc 4.6.3 that some of the travis
configs use complains:
linux-user/syscall.c: In function 'do_ioctl_rt':
linux-user/syscall.c:5577:37: error: 'host_rt_dev_ptr' may be used uninitia=
lized

It's not obvious to me that the compiler is wrong, either,
though why it complains about the assert but not the if()
I have no idea.

In any case, I'm going to revert this commit to fix the
Travis builds; we can have another go at it later.

thanks
-- PMM
