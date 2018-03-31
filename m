Received: from eggs.gnu.org ([2001:4830:134:3::10]:37549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2JpY-0002hW-Ln
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 12:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2JpV-0004cr-IL
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 12:58:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2JpV-0004aK-7x
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 12:58:13 -0400
References: <20180331162336.20158-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8500c798-619a-54f8-7073-abeae0427b67@vivier.eu>
Date: Sat, 31 Mar 2018 18:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180331162336.20158-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix mq_getsetattr
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Lionel Landwerlin <lionel.landwerlin@openwide.fr>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Aurelien Jarno <aurelien@aurel32.net>

Le 31/03/2018 à 18:23, Max Filippov a écrit :
> mq_getsetattr implementation does not set errno correctly in case of
> error. Also in the presence of both 2nd and 3rd arguments it calls both
> mq_getattr and mq_setattr, whereas only the latter call would suffice.
> 
> Don't call mq_getattr in the presence of the 3rd argument. Use get_errno
> to set errno value.
> 
> This fixes test rt/tst-mqueue2 from the glibc testsuite.
> 
> Cc: Lionel Landwerlin <lionel.landwerlin@openwide.fr>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/syscall.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 18ea79140f16..8b364551c311 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12092,15 +12092,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          {
>              struct mq_attr posix_mq_attr_in, posix_mq_attr_out;
>              ret = 0;

you can remove this line

> -            if (arg3 != 0) {
> -                ret = mq_getattr(arg1, &posix_mq_attr_out);
> -                copy_to_user_mq_attr(arg3, &posix_mq_attr_out);
> -            }
>              if (arg2 != 0) {
>                  copy_from_user_mq_attr(&posix_mq_attr_in, arg2);
> -                ret |= mq_setattr(arg1, &posix_mq_attr_in, &posix_mq_attr_out);
> +                ret = mq_setattr(arg1, &posix_mq_attr_in, &posix_mq_attr_out);

you can call get_errno(mq_setattr(..)) here...

> +            } else if (arg3 != 0) {
> +                ret = mq_getattr(arg1, &posix_mq_attr_out);

and get_errno(q_getattr(..)) here.

>              }
> -
> +            if (arg3 != 0) {

you should also check ret < 0 before copying to arg3

> +                copy_to_user_mq_attr(arg3, &posix_mq_attr_out);
> +            }
> +            ret = get_errno(ret);

you can remove this line if you call get_errno() directly before.


>          }
>          break;
>  #endif
> 

Thanks,
Laurent
