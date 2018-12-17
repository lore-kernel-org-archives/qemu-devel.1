Received: from eggs.gnu.org ([2001:4830:134:3::10]:47133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYsUO-00035e-SS
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYsUK-0006GQ-1p
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:59:16 -0500
Received: from chuckie.co.uk ([82.165.15.123]:52795
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gYsUI-00064n-1M
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:59:11 -0500
References: <20181213050453.9677-1-cota@braap.org>
	<20181213050453.9677-68-cota@braap.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b0ebafa1-bbab-b93f-961e-afb3a376d8da@ilande.co.uk>
Date: Mon, 17 Dec 2018 12:58:58 +0000
MIME-Version: 1.0
In-Reply-To: <20181213050453.9677-68-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 67/73] sparc: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>

On 13/12/2018 05:04, Emilio G. Cota wrote:

> Soon we will call cpu_has_work without the BQL.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sparc/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 88427283c1..54bffc1a6c 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -709,6 +709,8 @@ static bool sparc_cpu_has_work(CPUState *cs)
>      SPARCCPU *cpu = SPARC_CPU(cs);
>      CPUSPARCState *env = &cpu->env;
>  
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
>             cpu_interrupts_enabled(env);
>  }
> @@ -870,7 +872,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
>  
>      cc->class_by_name = sparc_cpu_class_by_name;
>      cc->parse_features = sparc_cpu_parse_features;
> -    cc->has_work = sparc_cpu_has_work;
> +    cc->has_work_with_iothread_lock = sparc_cpu_has_work;
>      cc->do_interrupt = sparc_cpu_do_interrupt;
>      cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
>      cc->dump_state = sparc_cpu_dump_state;

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
