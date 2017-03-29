Received: from eggs.gnu.org ([2001:4830:134:3::10]:34717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctHXv-0003Iv-8T
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctHXs-0007yv-43
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:38:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ctHXr-0007yW-V6
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:38:08 -0400
References: <20170329165251.28740-1-iwona260909@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <43ee4f25-8f1c-e580-5a55-e18b85b918a9@redhat.com>
Date: Wed, 29 Mar 2017 20:38:03 +0300
MIME-Version: 1.0
In-Reply-To: <20170329165251.28740-1-iwona260909@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hmp: fix "info cpu" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Iwona Kotlarska <iwona260909@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 03/29/2017 07:52 PM, Iwona Kotlarska wrote:
> Running "dump-guest-memory /dev/null 0 8192" results in segfault.
> Fix by checking if we have CPU.
>

Hi Iwona,
Thank you for contributing to the QEMU project.

Please state the whole command line that causes the problem,
not only the hmp command:

    Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256"
    and executing  "dump-guest-memory /dev/null 0 8192" results in segfault.
    Fix this by...

> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
> ---
>  target/i386/arch_dump.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 5a2e4be5d0..45cda6afb1 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -390,9 +390,10 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>      GuestPhysBlock *block;
>
>  #ifdef TARGET_X86_64
> -    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
> -
> -    lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);
> +    X86CPU *first_x86_cpu = NULL;
> +    first_x86_cpu = X86_CPU(first_cpu);

You didn't need to break the above in two lines,
but is not a big issue either.

> +    if (first_cpu != NULL)
> +        lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);

Please run: ./scripts/checkpatch.pl on the patch before you
submit to ensure coding style.
   You will see that we always use if { }; the patch has "DOS line endings".


You are welcome to submit the patch again.
In the meantime:
     Tested-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

>  #endif
>
>      if (lma) {
>

-- 
