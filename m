Received: from eggs.gnu.org ([2001:4830:134:3::10]:33584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPp6-0000qS-NL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPp5-0001eR-Q4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:38:20 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPp5-0001bc-J9
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:38:19 -0400
Received: by mail-qt0-x241.google.com with SMTP id c5-v6so787189qth.5
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:38:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5fb3e032-bd7d-092f-b6da-f33ba7ff9530@amsat.org>
Date: Mon, 25 Jun 2018 08:38:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180625111935.26108-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 10/10] linux-user: add gcov support to
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Hi Alex,

On 06/25/2018 08:19 AM, Alex Bennée wrote:
> As we don't always take the normal exit path when running a guest we
> can skip the normal exit destructors where gcov normally dumps it's
> info. The GCC manual suggests long running programs use __gcov_dump()
> to flush out the coverage state periodically so we use that here.

Shouldn't we also check for this symbol in the ./configure script?

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/exit.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index aed8713fae..14e94e28fa 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -19,10 +19,17 @@
>  #include "qemu/osdep.h"
>  #include "qemu.h"
>  
> +#ifdef CONFIG_GCOV
> +extern void __gcov_dump(void);
> +#endif
> +
>  void preexit_cleanup(CPUArchState *env, int code)
>  {
>  #ifdef TARGET_GPROF
>          _mcleanup();
> +#endif
> +#ifdef CONFIG_GCOV
> +        __gcov_dump();
>  #endif
>          gdb_exit(env, code);
>  }
> 
