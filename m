Received: from eggs.gnu.org ([2001:4830:134:3::10]:52352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fa2jk-00019N-0U
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fa2jf-0007dn-2i
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:35:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fa2je-0007dH-T5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:35:35 -0400
References: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70e55631-b112-b9b8-7296-ef6975bd4bf2@redhat.com>
Date: Mon, 2 Jul 2018 19:35:30 +0200
MIME-Version: 1.0
In-Reply-To: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: fix '-cpu ?' output for host cpu type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 02/07/2018 18:56, Greg Kurz wrote:
> Since commit d6dcc5583e7, '-cpu ?' shows the description of the
> X86_CPU_TYPE_NAME("max") for the host CPU model:
> 
> Enables all features supported by the accelerator in the current host
> 
> instead of the expected:
> 
> KVM processor with all supported host features
> 
> or
> 
> HVF processor with all supported host features
> 
> This is caused by the early use of kvm_enabled() and hvf_enabled() in
> a class_init function. Since the accelerator isn't configured yet, both
> helpers return false unconditionally.
> 
> A QEMU binary will only be compiled with one of these accelerators, not
> both. The appropriate description can thus be decided at build time.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/i386/cpu.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1e6a7d0a7504..e5da60b28973 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2838,13 +2838,13 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
>      xcc->host_cpuid_required = true;
>      xcc->ordering = 8;
>  
> -    if (kvm_enabled()) {
> -        xcc->model_description =
> -            "KVM processor with all supported host features ";
> -    } else if (hvf_enabled()) {
> -        xcc->model_description =
> -            "HVF processor with all supported host features ";
> -    }
> +#if defined(CONFIG_KVM)
> +    xcc->model_description =
> +        "KVM processor with all supported host features ";
> +#elif defined(CONFIG_HVF)
> +    xcc->model_description =
> +        "HVF processor with all supported host features ";
> +#endif
>  }
>  
>  static const TypeInfo host_x86_cpu_type_info = {
> 

Queued, thanks.

Paolo
