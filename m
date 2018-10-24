Received: from eggs.gnu.org ([2001:4830:134:3::10]:46365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFHS6-000149-0I
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFHS1-0004I5-UO
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:35:53 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49777)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gFHS1-0004Fr-Kf
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:35:49 -0400
References: <20181024023831.2529-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eac0b0b9-351f-20bf-c5e9-b4fb1f8885d1@vivier.eu>
Date: Wed, 24 Oct 2018 12:35:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181024023831.2529-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/flatload: fix initial stack
 pointer alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

On 24/10/2018 03:38, Max Filippov wrote:
> Stack pointer alignment code incorrectly adds stack_size to sp instead
> of subtracting it. It also does not take flat_argvp_envp_on_stack() into
> account when calculating stack_size. This results in initial stack
> pointer misalignment with certain set of command line arguments and
> environment variables and correct alignment for the same binary with a
> different set of arguments. This misalignment causes failures in the
> following tests in the testsuite of gcc built for xtensa uclinux:
> 
>   gcc.dg/torture/vshuf-v64qi.c
>   gcc.dg/torture/vshuf-v8sf.c
>   gcc.dg/torture/vshuf-v8si.c
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/flatload.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 2eefe55e5000..1893966b5b30 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -771,10 +771,12 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
>      /* Enforce final stack alignment of 16 bytes.  This is sufficient
>         for all current targets, and excess alignment is harmless.  */
>      stack_len = bprm->envc + bprm->argc + 2;
> -    stack_len += 3;	/* argc, arvg, argp */
> +    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* arvg, argp */
> +    stack_len += 1; /* argc */>      stack_len *= sizeof(abi_ulong);
> -    if ((sp + stack_len) & 15)
> -        sp -= 16 - ((sp + stack_len) & 15);
> +    if ((sp - stack_len) & 15) {
> +        sp -= ((sp - stack_len) & 15);
> +    }

If I understand correctly the purpose, I think it could be clearer like:

    sp = (sp - stack_len) & ~15;

Thanks,
Laurent
