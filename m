Received: from eggs.gnu.org ([2001:4830:134:3::10]:49081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWKkz-0007CR-U9
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWKkw-0001Or-Im
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:33:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWKkw-0001OM-BC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:33:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so10323480wrw.1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 04:33:50 -0800 (PST)
References: <20181210114654.31433-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a4de25d8-0b3b-07c5-f49b-a4bccad4a623@redhat.com>
Date: Mon, 10 Dec 2018 13:33:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181210114654.31433-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/i386/kvm.c: Don't mark cpuid_data
 as QEMU_PACKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, patches@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/10/18 12:46 PM, Peter Maydell wrote:
> clang complains about taking the address of a packed
> member of a struct:
> 
> target/i386/kvm.c:1245:27: warning: taking address of packed member 'cpuid' of class or structure '' may result in an unaligned pointer value [-Waddress-of-packed-member]
>     c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
>                           ^~~~~~~~~~~~~~~~
> target/i386/kvm.c:1297:31: warning: taking address of packed member 'cpuid' of class or structure '' may result in an unaligned pointer value [-Waddress-of-packed-member]
>         c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
>                               ^~~~~~~~~~~~~~~~
> 
> The kernel's definitions of struct kvm_cpuid2 and struct
> kvm_cpuid_entry2 are carefully set up with padding fields
> so that there is no between-struct padding anyway, so
> the QEMU_PACKED annotation is unnecessary and might result
> in the compiler generating worse code. Drop it, and instead
> assert at build time that there is no stray padding.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/i386/kvm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index b2401d13ea7..739cf8c8ea1 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -864,7 +864,15 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      struct {
>          struct kvm_cpuid2 cpuid;
>          struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
> -    } QEMU_PACKED cpuid_data;
> +    } cpuid_data;
> +    /*
> +     * The kernel defines these structs with padding fields so there
> +     * should be no extra padding in our cpuid_data struct.
> +     */
> +    QEMU_BUILD_BUG_ON(sizeof(cpuid_data) !=
> +                      sizeof(struct kvm_cpuid2) +
> +                      sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
> +
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
>      uint32_t limit, i, j, cpuid_i;
> 
