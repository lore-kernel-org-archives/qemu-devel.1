Received: from eggs.gnu.org ([2001:4830:134:3::10]:38896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpprL-0005Mu-N3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpprE-0003R2-Ac
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpprE-0003Qm-4u
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 02:00:08 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-10-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6742b40c-7cec-fc54-a274-e25fc25eb86b@redhat.com>
Date: Thu, 7 Sep 2017 07:59:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/19] target/s390x: use
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
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 04.09.2017 17:43, David Hildenbrand wrote:
> This looks cleaner. linux-user will not use the ilen field, so setting
> it doesn't do any harm.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 361f970db3..14d3160e92 100644
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
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
