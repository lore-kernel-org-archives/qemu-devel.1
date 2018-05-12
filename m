Received: from eggs.gnu.org ([2001:4830:134:3::10]:52489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fHPOP-0007LK-9X
	for qemu-devel@nongnu.org; Sat, 12 May 2018 03:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fHPOM-0006QW-8t
	for qemu-devel@nongnu.org; Sat, 12 May 2018 03:56:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fHPOM-0006QL-3r
	for qemu-devel@nongnu.org; Sat, 12 May 2018 03:56:34 -0400
References: <20180512045950.12386-1-richard.henderson@linaro.org>
	<20180512045950.12386-5-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fc763c88-2baa-07f6-8e00-fe966bcf0f21@redhat.com>
Date: Sat, 12 May 2018 09:56:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180512045950.12386-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/s390x: Fix brace Werror with
 clang 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>

On 12.05.2018 06:59, Richard Henderson wrote:
> The warning is
> 
> target/s390x/misc_helper.c:209:21: error: suggest
>       braces around initialization of subobject [-Werror,-Wmissing-braces]
>     SysIB sysib = { 0 };
>                     ^
>                     {}
> 
> While the original code is correct, and technically exactly correct
> as per ISO C89, both GCC and Clang support plain empty set of braces
> as an extension.
> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/misc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index e0b23c1fd1..1f834f35ef 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -206,7 +206,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
>      const MachineState *ms = MACHINE(qdev_get_machine());
>      uint16_t total_cpus = 0, conf_cpus = 0, reserved_cpus = 0;
>      S390CPU *cpu = s390_env_get_cpu(env);
> -    SysIB sysib = { 0 };
> +    SysIB sysib = { };
>      int i, cc = 0;
>  
>      if ((r0 & STSI_R0_FC_MASK) > STSI_R0_FC_LEVEL_3) {
> 

Very strange that this is reported as an error if it is technically the
right thing to do. Anyhow, to make compilers happy:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
