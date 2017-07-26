Received: from eggs.gnu.org ([2001:4830:134:3::10]:59650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1daNJq-0007kH-IJ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1daNJm-0004lc-LE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:29:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1daNJm-0004kB-FP
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:29:42 -0400
Date: Wed, 26 Jul 2017 16:29:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170726162934.53f95124@nial.brq.redhat.com>
In-Reply-To: <1501049917-4701-2-git-send-email-wang.yi59@zte.com.cn>
References: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
	<1501049917-4701-2-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hmp: dump ids including socket-id,
 core-id and so on for 'info registers'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Wang <wang.yi59@zte.com.cn>
Cc: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, liu.yunh@zte.com.cn, Liu.Jianjun3@zte.com.cn

On Wed, 26 Jul 2017 02:18:36 -0400
Yi Wang <wang.yi59@zte.com.cn> wrote:

> This patch add output of CPUs' socket-id, core-id, thread-id and
> apic-id for 'info registers', which can be used for querying other
> hmp commands.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> ---
>  target/i386/helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index f63eb3d..a52f300 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -416,6 +416,14 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>      int eflags, i, nb;
>      char cc_op_name[32];
>      static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
> +    APICCommonState *s = APIC_COMMON(cpu->apic_state);
> +
> +    if (!s) {
> +        cpu_fprintf(f, "local apic state not available\n");
> +        return;
> +    }
drop this hunk

> +    cpu_fprintf(f, "(socket-id:%d core-id:%d thread-id:%d apic-id:%d)\n",
> +            cpu->socket_id, cpu->core_id, cpu->thread_id, s->id);
and print apic id only if cpu->apic_state is not NULL

>  
>      eflags = cpu_compute_eflags(env);
>  #ifdef TARGET_X86_64
