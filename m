Received: from eggs.gnu.org ([209.51.188.92]:37196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbWE-0007NP-Ka
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbWD-0001kC-Jh
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:10:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIbW8-0001df-51
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:10:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so15029146wmd.0
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 09:09:58 -0700 (PDT)
References: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a9008f1-34f7-ecb8-9ccb-c129f56236ec@redhat.com>
Date: Mon, 22 Apr 2019 18:09:55 +0200
MIME-Version: 1.0
In-Reply-To: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hvf: Add missing break statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Zhang <tgfbeta@me.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On 4/22/19 5:42 AM, Chen Zhang via Qemu-devel wrote:
> In target/i386/hvf/hvf.c, a break statement was probably missing in `hvf_vcpu_exec()`, in handling EXIT_REASON_HLT.
> 
> These lines seemed to be equivalent to `kvm_handle_halt()`.
> 

Fixes: c97d6d2cdf97

> Signed-off-by: Chen Zhang <tgfbeta@me.com>
> ---
>  target/i386/hvf/hvf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 42f9447303..2751c8125c 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -708,6 +708,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>                  !(idtvec_info & VMCS_IDT_VEC_VALID)) {
>                  cpu->halted = 1;
>                  ret = EXCP_HLT;
> +                break;

Oops... I'm surprised no compiler warned about this yet...

This probably mean:
- This code is not covered by Continuous Integration
- Upstream maintainers are not building this code
- Upstream is not running this code

Please tell me I'm wrong!

Meanwhile:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>              }
>              ret = EXCP_INTERRUPT;
>              break;
> 
