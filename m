Received: from eggs.gnu.org ([2001:4830:134:3::10]:37171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD7Mn-0002uP-VC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD7Mj-0008A1-4W
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD7Mi-00089n-Um
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:48:37 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-24-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7cdf62f5-34fa-4158-b3a5-fe4bf985d937@redhat.com>
Date: Tue, 23 May 2017 12:48:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-24-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/31] target/s390x: Use unwind data for
 helper_lctlg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 23.05.2017 05:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 8 ++++----
>  target/s390x/translate.c  | 1 -
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 902290c..26960e4 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -821,20 +821,20 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
>  #if !defined(CONFIG_USER_ONLY)
>  void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  {
> +    uintptr_t ra = GETPC();
>      S390CPU *cpu = s390_env_get_cpu(env);
>      bool PERchanged = false;
> -    int i;
>      uint64_t src = a2;
> -    uint64_t val;
> +    uint32_t i;
>  
>      for (i = r1;; i = (i + 1) % 16) {
> -        val = cpu_ldq_data(env, src);
> +        uint64_t val = cpu_ldq_data_ra(env, src, ra);
>          if (env->cregs[i] != val && i >= 9 && i <= 11) {
>              PERchanged = true;
>          }
>          env->cregs[i] = val;
>          HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%" PRIx64 "\n",
> -                   i, src, env->cregs[i]);
> +                   i, src, val);

I think you should mention in the patch description that you've fixed
the HELPER_LOG here, too. Apart from that:

Reviewed-by: Thomas Huth <thuth@redhat.com>
