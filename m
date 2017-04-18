Received: from eggs.gnu.org ([2001:4830:134:3::10]:58693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0SQm-0006NQ-34
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0SQh-0007mm-4I
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:40:28 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d0SQg-0007m5-Us
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:40:23 -0400
Received: by mail-pg0-x242.google.com with SMTP id 34so30380451pgx.3
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 05:40:22 -0700 (PDT)
Date: Tue, 18 Apr 2017 21:40:17 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170418124017.GA2471@lianli.shorne-pla.net>
References: <20170418061551.196582-1-mithro@mithis.com>
	<20170418061551.196582-3-mithro@mithis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418061551.196582-3-mithro@mithis.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] target/openrisc: Implement EPH bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tim 'mithro' Ansell <mithro@mithis.com>
Cc: qemu-devel@nongnu.org, Jia Liu <proljc@gmail.com>

On Tue, Apr 18, 2017 at 04:15:51PM +1000, Tim 'mithro' Ansell wrote:
> Exception Prefix High (EPH) control bit of the Supervision Register
> (SR).
> 
> The significant bits (31-12) of the vector offset address for each
> exception depend on the setting of the Supervision Register (SR)'s EPH
> bit and the Exception Vector Base Address Register (EVBAR).
> 
> If SR[EPH] is set, the vector offset is logically ORed with the offset
> 0xF0000000.
> 
> This means if EPH is;
>  * 0 - Exceptions vectors start at EVBAR
>  * 1 - Exception vectors start at EVBAR | 0xF0000000
> 
> Signed-off-by: Tim 'mithro' Ansell <mithro@mithis.com>

Acked-by: Stafford Horne <shorne@gmail.com>

Thanks, I will queue this with my other changes unless anyone has any
objections.

> ---
>  target/openrisc/interrupt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index 78f0ba9421..2c91fab380 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -69,6 +69,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>          if (env->cpucfgr & CPUCFGR_EVBARP) {
>              vect_pc |= env->evbar;
>          }
> +        if (env->sr & SR_EPH) {
> +            vect_pc |= 0xf0000000;
> +        }
>          env->pc = vect_pc;
>      } else {
>          cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
> -- 
> 2.12.1
> 
