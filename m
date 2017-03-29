Received: from eggs.gnu.org ([2001:4830:134:3::10]:42983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct90i-0007sa-A3
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct90f-0003g9-5F
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ct90e-0003eH-W4
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:31:17 -0400
References: <20170329043257.20595-1-bobby.prani@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cabafab-801b-80c8-5476-db605c8edd73@redhat.com>
Date: Wed, 29 Mar 2017 10:31:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170329043257.20595-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Display AMD HT warning only for
 KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>



On 29/03/2017 06:32, Pranith Kumar wrote:
> TCG uses the AMD cpu which warns when we use hyperthreading. Disable
> the warning for TCG since it is not necessary.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7aa762245a..66242893b6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3647,7 +3647,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
>       * cs->nr_threads hasn't be populated yet and the checking is incorrect.
>       */
> -    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
> +    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned && kvm_enabled()) {
>          error_report("AMD CPU doesn't support hyperthreading. Please configure"
>                       " -smp options properly.");
>          ht_warned = true;

AMD Zen supports hyperthreading.  We should check if it uses the same
CPUID leaves and drop the if completely (but not in 2.9).

Paolo
