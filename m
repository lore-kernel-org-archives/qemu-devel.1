Received: from eggs.gnu.org ([2001:4830:134:3::10]:39754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsc4q-0001Hn-B8
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsc4l-0001Oz-LE
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:58:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsc4l-0001Mq-1H
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:58:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id p12-v6so1680060pfh.2
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 15:58:06 -0700 (PDT)
References: <20180818190118.12911-1-richard.henderson@linaro.org>
	<20180818190118.12911-11-richard.henderson@linaro.org>
	<51f5ba46-f63a-e433-7e0b-82e72a643d79@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b19ce14e-2425-b4b8-3d52-82a65468f845@linaro.org>
Date: Wed, 22 Aug 2018 15:58:01 -0700
MIME-Version: 1.0
In-Reply-To: <51f5ba46-f63a-e433-7e0b-82e72a643d79@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 10/16] linux-user: Split out some simple
 file syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 08/21/2018 05:50 PM, Laurent Vivier wrote:
> I don't understand why you need/want to duplicate the list of syscalls here.
> 
> If I modify your patch as following, it works without duplicating the list:
> 
> diff --git a/linux-user/syscall-file.def.c b/linux-user/syscall-file.def.c
> new file mode 100644
> index 0000000000..78b1bd0467
> --- /dev/null
> +++ b/linux-user/syscall-file.def.c
> @@ -0,0 +1,13 @@
> +SYSCALL_DEF(close, ARG_DEC);
> +#ifdef TARGET_NR_open
> +SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
> +#endif
> +SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
> +SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
> +#ifdef TARGET_NR_readlink
> +SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
> +#endif
> +#ifdef TARGET_NR_readlinkat
> +SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
> +#endif
> +SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);

Sort-of interesting, but I do have other definitions of
syscall structures that do not use this macro.

Please look through e.g. patch 15 and suggest how I might
define mmap2 with your scheme.


r~
