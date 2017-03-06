Received: from eggs.gnu.org ([2001:4830:134:3::10]:40590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckumM-0004eh-3E
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckumK-0006FW-Nz
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:42:30 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckumK-0006E5-FE
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:42:28 -0500
Received: by mail-wm0-x236.google.com with SMTP id n11so67962641wma.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 07:42:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170306071721.26708-2-ppandit@redhat.com>
References: <20170306071721.26708-1-ppandit@redhat.com>
	<20170306071721.26708-2-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 15:42:06 +0000
Message-ID: <CAFEAcA-hOsVBnw9gh-VBCr3Q7-+_m-2X3zHRuRnmzDLF8CmsZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: limit number of
 arguments to execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 6 March 2017 at 07:17, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Limit the number of arguments passed to execve(2) call from
> a user program, as large number of them could lead to a bad
> guest address error.
>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  linux-user/syscall.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> Update per: use gemu_log() to report error
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00750.html
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9be8e95..86a4a9c 100644
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
> @@ -7794,6 +7795,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                  envc++;
>              }
>
> +            if (argc > ARG_MAX || envc > ARG_MAX) {
> +                gemu_log("argc(%d), envc(%d) exceed %d\n", argc, envc, ARG_MAX);
> +                ret = -TARGET_E2BIG;
> +                break;
> +            }
>              argp = alloca((argc + 1) * sizeof(void *));
>              envp = alloca((envc + 1) * sizeof(void *));


We need to fix this by not using alloca(), not by imposing
an arbitrary limit that's still rather over-large for an
alloca allocation, as Eric suggested.

thanks
-- PMM
