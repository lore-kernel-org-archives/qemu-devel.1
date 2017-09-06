Received: from eggs.gnu.org ([2001:4830:134:3::10]:49261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpikh-00032i-5b
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 18:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpikc-0002fb-Ds
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 18:24:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpikc-0002fI-7B
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 18:24:50 -0400
Date: Wed, 6 Sep 2017 18:24:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170906222448.GA21183@flamenco>
References: <150471163020.18882.9386672218918089445.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150471163020.18882.9386672218918089445.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH] trace: Immediately apply per-vCPU state
 changes if a vCPU is being created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 06, 2017 at 18:27:10 +0300, Lluís Vilanova wrote:
> Right now, function trace_event_set_vcpu_state_dynamic() asynchronously enables
> events in the case a vCPU is executing TCG code. If the vCPU is being created
> this makes some events like "guest_cpu_enter" to not be traced.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  trace/control-target.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/trace/control-target.c b/trace/control-target.c
> index 4e36101997..0056da6a46 100644
> --- a/trace/control-target.c
> +++ b/trace/control-target.c
> @@ -88,13 +88,18 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
>              clear_bit(vcpu_id, vcpu->trace_dstate_delayed);
>              (*ev->dstate)--;
>          }
> -        /*
> -         * Delay changes until next TB; we want all TBs to be built from a
> -         * single set of dstate values to ensure consistency of generated
> -         * tracing code.
> -         */
> -        async_run_on_cpu(vcpu, trace_event_synchronize_vcpu_state_dynamic,
> -                         RUN_ON_CPU_NULL);
> +        if (vcpu->created) {
> +            /*
> +             * Delay changes until next TB; we want all TBs to be built from a
> +             * single set of dstate values to ensure consistency of generated
> +             * tracing code.
> +             */
> +            async_run_on_cpu(vcpu, trace_event_synchronize_vcpu_state_dynamic,
> +                             RUN_ON_CPU_NULL);
> +        } else {
> +            run_on_cpu_data ignored;
> +            trace_event_synchronize_vcpu_state_dynamic(vcpu, ignored);

I'd prefer RUN_ON_CPU_NULL here instead of the ignored param.
Other than that,

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
