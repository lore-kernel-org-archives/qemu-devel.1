Received: from eggs.gnu.org ([2001:4830:134:3::10]:47825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPoIW-0000Dn-4f
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPoIQ-0004CF-9D
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:09:16 -0400
Date: Mon, 4 Jun 2018 14:09:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180604140903.2629d329.cohuck@redhat.com>
In-Reply-To: <20180525113708.29856-7-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
	<20180525113708.29856-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 6/7] s390x/tcg: rearm the CKC timer
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, "Collin L . Walling" <walling@linux.ibm.com>

On Fri, 25 May 2018 13:37:07 +0200
David Hildenbrand <david@redhat.com> wrote:

> If the CPU data is migrated after the TOD clock, the CKC timer of a CPU
> is not rearmed. Let's rearm it when loading the CPU state.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/machine.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/s390x/machine.c b/target/s390x/machine.c
> index 84b4928755..53d226ff48 100644
> --- a/target/s390x/machine.c
> +++ b/target/s390x/machine.c
> @@ -34,6 +34,13 @@ static int cpu_post_load(void *opaque, int version_id)
>          return kvm_s390_vcpu_interrupt_post_load(cpu);
>      }
>  
> +#ifdef CONFIG_TCG
> +    if (tcg_enabled()) {
> +        /* Rearm the CKC timer if necessary */
> +        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);

Stub this out so the explicit CONFIG_TCG is not required? But I don't
care too much.

> +    }
> +#endif
> +
>      return 0;
>  }
>  
