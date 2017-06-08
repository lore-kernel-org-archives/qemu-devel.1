Received: from eggs.gnu.org ([2001:4830:134:3::10]:38896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIyiR-0008El-D3
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIyiN-00070T-Ff
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:47:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIyiN-00070J-9p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:47:11 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-15-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <642e6f75-0dd3-f893-b8b8-9f6a7ebaf7d4@redhat.com>
Date: Thu, 8 Jun 2017 16:47:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170606181948.16238-15-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/23] kvm-all: make async_safe_run_on_cpu
 safe on kvm too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 06/06/2017 20:19, Roman Kagan wrote:
> Wrap the bulk of kvm_cpu_exec with cpu_exec_start/end, so that kvm
> version can also enjoy performing certain operations while all vCPUs are
> quiescent.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  kvm-all.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kvm-all.c b/kvm-all.c
> index 494b925..85668fb 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -1974,6 +1974,7 @@ int kvm_cpu_exec(CPUState *cpu)
>      }
>  
>      qemu_mutex_unlock_iothread();
> +    cpu_exec_start(cpu);
>  
>      do {
>          MemTxAttrs attrs;
> @@ -2103,6 +2104,7 @@ int kvm_cpu_exec(CPUState *cpu)
>          }
>      } while (ret == 0);
>  
> +    cpu_exec_end(cpu);
>      qemu_mutex_lock_iothread();
>  
>      if (ret < 0) {
> 

This patch caught my eye, I'm applying it right now.

Paolo
