Received: from eggs.gnu.org ([2001:4830:134:3::10]:48238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpYB-00073U-21
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpYA-00055i-B2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:55:23 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjpYA-00055P-4v
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:55:22 -0500
Received: by mail-wr0-x22c.google.com with SMTP id l37so76574795wrc.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:55:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303112503.32277-1-ppandit@redhat.com>
References: <20170303112503.32277-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 15:55:00 +0000
Message-ID: <CAFEAcA_V8azXLLptxqNWBwkY7wJZzK+YkZHd6RfHEVS-NoXXBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>, Jann Horn <jannh@google.com>

On 3 March 2017 at 11:25, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Limit the number of arguments passed to execve(2) call from
> a user program, as large number of them could lead to a bad
> guest address error.
>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  linux-user/syscall.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9be8e95..c545c12 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7766,6 +7766,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #endif
>      case TARGET_NR_execve:
>          {
> +#define ARG_MAX 65535
>              char **argp, **envp;
>              int argc, envc;
>              abi_ulong gp;
> @@ -7794,6 +7795,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                  envc++;
>              }
>
> +            if (argc > ARG_MAX || envc > ARG_MAX) {
> +                fprintf(stderr,
> +                        "argc(%d), envc(%d) exceed %d\n", argc, envc, ARG_MAX);
> +                ret = -TARGET_EFAULT;
> +                break;
> +            }
>              argp = alloca((argc + 1) * sizeof(void *));
>              envp = alloca((envc + 1) * sizeof(void *));

This code is already supposed to handle "argument string too big",
see commit a6f79cc9a5e.

What's the actual bug case we're trying to handle here?

EFAULT looks like a decidedly odd error to return here, too.

thanks
-- PMM
