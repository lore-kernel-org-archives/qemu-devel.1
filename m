Received: from eggs.gnu.org ([2001:4830:134:3::10]:56472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGQ0-0006MF-2H
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGPv-0004nz-5q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:27:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZGPv-0004m4-05
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:27:43 -0500
References: <20180110064706.49777-1-lepton@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec848ee7-85e7-de79-bb58-60ad12d33256@redhat.com>
Date: Wed, 10 Jan 2018 14:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180110064706.49777-1-lepton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: hax: Move
 hax_setup_qemu_emulator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <lepton@google.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, ehabkost@redhat.com

On 10/01/2018 07:47, Tao Wu wrote:
> hax_setup_qemu_emulator reference env->efer which is updated in
> hax_get_msrs, so it has to be called after hax_get_msrs. This fix
> the bug that sometimes dump_state show 32 bits regs even in 64 bits
> mode.
> 
> Signed-off-by: Tao Wu <lepton@google.com>
> ---
>  target/i386/hax-all.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index 3ce6950296..a933bd462d 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -887,9 +887,6 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
>              return -1;
>          }
>      }
> -    if (!set) {
> -        hax_setup_qemu_emulator(env);
> -    }
>      return 0;
>  }
>  
> @@ -1070,6 +1067,7 @@ static int hax_arch_get_registers(CPUArchState *env)
>          return ret;
>      }
>  
> +    hax_setup_qemu_emulator(env);
>      return 0;
>  }
>  
> 

Queued, thanks.

Please look into sharing the similar code in target/i386/kvm.c
(kvm_get_sregs), since the HAX code has some bugs (for example,
HF_CPL_MASK should be SS.DPL, not CS.DPL).

Paolo
