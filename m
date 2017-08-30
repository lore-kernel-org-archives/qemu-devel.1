Received: from eggs.gnu.org ([2001:4830:134:3::10]:39748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn8Ou-0006Or-58
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn8Or-0006qE-0j
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dn8Oq-0006q1-Px
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:11:40 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-11-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f20906d2-20eb-3d5f-d7b3-16e42f6def20@redhat.com>
Date: Wed, 30 Aug 2017 21:11:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170830170601.15855-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/11] target/s390x: use
 trigger_pgm_exception() in s390_cpu_handle_mmu_fault()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 19:06, David Hildenbrand wrote:
> This looks cleaner.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 2ac36535f7..f5f5967833 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -59,8 +59,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
>  {
>      S390CPU *cpu = S390_CPU(cs);
>  
> -    cs->exception_index = EXCP_PGM;
> -    cpu->env.int_pgm_code = PGM_ADDRESSING;
> +    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_AUTO);
>      /* On real machines this value is dropped into LowMem.  Since this
>         is userland, simply put this someplace that cpu_loop can find it.  */
>      cpu->env.__excp_addr = address;

trigger_pgm_exception() additionally sets int_pgm_ilen ... I assume
that's OK here? A comment in the patch description would be helpful.

 Thomas
