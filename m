Received: from eggs.gnu.org ([2001:4830:134:3::10]:34275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOkbM-0003Fj-LG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOkbJ-0007kU-IG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:00:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOkbJ-0007jn-E9
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:00:17 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-2-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <caf6dd92-f5b5-b94b-708a-084c76f5ab46@redhat.com>
Date: Fri, 1 Jun 2018 09:00:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/33] linux-user: Split out do_syscall1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu

On 06/01/2018 02:30 AM, Richard Henderson wrote:
> There was supposed to be a single point of return for do_syscall
> so that tracing works properly.  However, there are a few bugs
> in that area.  It is significantly simpler to simply split out
> an inner function to enforce this.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 89 +++++++++++++++++++++++++++-----------------
>   1 file changed, 54 insertions(+), 35 deletions(-)
> 

> @@ -7977,28 +7979,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>       void *p;
>       char *fn;
>   
> -#if defined(DEBUG_ERESTARTSYS)

> +abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> +                    abi_long arg2, abi_long arg3, abi_long arg4,
> +                    abi_long arg5, abi_long arg6, abi_long arg7,
> +                    abi_long arg8)
> +{
> +    CPUState *cpu = ENV_GET_CPU(cpu_env);
> +    abi_long ret;
> +
> +#if defined(DEBUG_ERESTARTSYS)

Code motion, but...

> +    /* Debug-only code for exercising the syscall-restart code paths
> +     * in the per-architecture cpu main loops: restart every syscall
> +     * the guest makes once before letting it through.
> +     */
> +    {
> +        static bool flag;
> +        flag = !flag;
> +        if (flag) {
> +            return -TARGET_ERESTARTSYS;
> +        }
> +    }
> +#endif
> +#ifdef DEBUG

...it looks inconsistent to mix '#if defined()' with '#ifdef' in the 
same function.  Worth cleaning up while you do this refactoring?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
