Received: from eggs.gnu.org ([209.51.188.92]:39216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghyuz-0003hP-HP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghyuv-0005cR-28
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:40:18 -0500
References: <20190111113657.66195-1-frankja@linux.ibm.com>
	<20190111113657.66195-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2be2f28c-1c89-c985-7996-f30c25578446@redhat.com>
Date: Fri, 11 Jan 2019 16:40:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190111113657.66195-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x: Diag308 move common parameter
 checking into function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On 11.01.19 12:36, Janosch Frank wrote:
> Let's make that switch statement a bit shorter.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/diag.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index acb0f3d4af..cfd7222ddd 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -53,6 +53,22 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  #define DIAG_308_RC_NO_CONF         0x0102
>  #define DIAG_308_RC_INVALID         0x0402
>  
> +static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
> +                              uintptr_t ra)
> +{
> +    if ((r1 & 1) || (addr & 0x0fffULL)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
> +        return -EINVAL;
> +    }
> +    if (!address_space_access_valid(&address_space_memory, addr,
> +                                    sizeof(IplParameterBlock), true,

This is wrong, you would check for writing although you are only
reading. (true vs. false)

> +                                    MEMTXATTRS_UNSPECIFIED)) {
> +        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
> +        return -EFAULT;
> +    }
> +    return 0;
> +}
> +
>  void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  {
>      CPUState *cs = CPU(s390_env_get_cpu(env));
> @@ -81,14 +97,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>          break;
>      case 5:
> -        if ((r1 & 1) || (addr & 0x0fffULL)) {
> -            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
> -            return;
> -        }
> -        if (!address_space_access_valid(&address_space_memory, addr,
> -                                        sizeof(IplParameterBlock), false,
> -                                        MEMTXATTRS_UNSPECIFIED)) {
> -            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
> +        if (diag308_parm_check(env, r1, addr, ra)) {
>              return;
>          }
>          iplb = g_new0(IplParameterBlock, 1);
> @@ -111,14 +120,7 @@ out:
>          g_free(iplb);
>          return;
>      case 6:
> -        if ((r1 & 1) || (addr & 0x0fffULL)) {
> -            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
> -            return;
> -        }
> -        if (!address_space_access_valid(&address_space_memory, addr,
> -                                        sizeof(IplParameterBlock), true,
> -                                        MEMTXATTRS_UNSPECIFIED)) {
> -            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
> +        if (diag308_parm_check(env, r1, addr, ra)) {
>              return;
>          }
>          iplb = s390_ipl_get_iplb();
> 


-- 

Thanks,

David / dhildenb
