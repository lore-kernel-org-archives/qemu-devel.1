Received: from eggs.gnu.org ([2001:4830:134:3::10]:51551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <snaipe@diacritic.io>) id 1ceePg-0000Cf-Lr
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <snaipe@diacritic.io>) id 1ceePd-0002ZN-Ir
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:01:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170217085800.28873-1-snaipe@diacritic.io>
References: <20170216085857.23501-1-snaipe@diacritic.io>
	<20170217085800.28873-1-snaipe@diacritic.io>
From: "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>
Date: Fri, 17 Feb 2017 09:00:22 +0000
Message-ID: <CAK_MOSfBOJn6Zqo2Z9E8pLZLsuTJZ37HQo_1bp4XdU3iG55D1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] syscall: fixed mincore(2) not failing with
 ENOMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, snaipe@arista.com, Franklin Snaipe Mathieu <snaipe@diacritic.io>, Riku Voipio <riku.voipio@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Ignore this patch, this was sent again by mistake.

2017-02-17 8:57 GMT+00:00 Franklin Snaipe Mathieu <snaipe@diacritic.io>:
> From: "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>
>
> The current implementation of the mincore(2) syscall sets errno to
> EFAULT when the region identified by the first two parameters is
> invalid.
>
> This goes against the man page specification, where mincore(2) should
> only fail with EFAULT when the third parameter is an invalid address;
> and fail with ENOMEM when the checked region does not point to mapped
> memory.
>
> Signed-off-by: Franklin "Snaipe" Mathieu <snaipe@diacritic.io>
> Cc: Riku Voipio <riku.voipio@linaro.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  linux-user/syscall.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9be8e9530e..733e0009e1 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11061,11 +11061,16 @@ abi_long do_syscall(void *cpu_env, int num, abi=
_long arg1,
>      case TARGET_NR_mincore:
>          {
>              void *a;
> +            ret =3D -TARGET_ENOMEM;
> +            a =3D lock_user(VERIFY_READ, arg1, arg2, 0);
> +            if (!a) {
> +                goto fail;
> +            }
>              ret =3D -TARGET_EFAULT;
> -            if (!(a =3D lock_user(VERIFY_READ, arg1,arg2, 0)))
> -                goto efault;
> -            if (!(p =3D lock_user_string(arg3)))
> +            p =3D lock_user_string(arg3);
> +            if (!p) {
>                  goto mincore_fail;
> +            }
>              ret =3D get_errno(mincore(a, arg2, p));
>              unlock_user(p, arg3, ret);
>              mincore_fail:
> --
> 2.11.0
>



--=20
Franklin "Snaipe" Mathieu
=F0=9F=9D=B0 https://diacritic.io
