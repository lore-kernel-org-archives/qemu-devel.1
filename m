Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dr57y-0000jQ-SV
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dr57u-0006wu-Uq
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:30:34 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <333a9b48-d30d-03b9-83e4-52a24b2128f3@redhat.com>
Date: Sun, 10 Sep 2017 18:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <1505054255-2990-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] ppc: change CPUPPCState access_type
 from int to uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru

On 10/09/2017 16:37, Mark Cave-Ayland wrote:
> This change was suggested by Alexey in advance of a subsequent commit which
> adds access_type into vmstate_ppc_cpu.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h     |    4 ++--
>  target/ppc/machine.c |    4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 12f0949..59d1656 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1010,8 +1010,8 @@ struct CPUPPCState {
>      /* Next instruction pointer */
>      target_ulong nip;
>  
> -    int access_type; /* when a memory exception occurs, the access
> -                        type is stored here */
> +    uint8_t access_type; /* when a memory exception occurs, the access
> +                            type is stored here */

I think this breaks TCG as we have:

target/ppc/translate.c:

     82 void ppc_translate_init(void)
...
    191 
    192     cpu_access_type = tcg_global_mem_new_i32(cpu_env,
    193                                              offsetof(CPUPPCState, access_type), "access_type");
    194 
    195     done_init = 1;
    196 }

it expects an int32_t (or int).

Thanks,
Laurent
