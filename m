Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eORH9-00069L-12
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eORH4-0007CX-W1
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:49:55 -0500
References: <20171129191319.11483-1-david@redhat.com>
	<f8e11154-00a7-745d-451b-38a3c6f42b6f@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a05893de-ce48-a797-1a12-8acb18419887@redhat.com>
Date: Mon, 11 Dec 2017 17:49:45 +0100
MIME-Version: 1.0
In-Reply-To: <f8e11154-00a7-745d-451b-38a3c6f42b6f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] cpu-exec: fix missed CPU kick during
 interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>


> atomic_mb_set can be a little faster on x86, so:
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index dfba5ebd29..4452cd9856 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -528,12 +528,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>  
>      /* Clear the interrupt flag now since we're processing
>       * cpu->interrupt_request and cpu->exit_request.
> +     * Ensure zeroing happens before reading cpu->exit_request or
> +     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
>       */
> -    atomic_set(&cpu->icount_decr.u16.high, 0);
> -    /* Ensure zeroing happens before reading cpu->exit_request or
> -     * cpu->interrupt_request. (also see cpu_exit())
> -     */
> -    smp_mb();
> +    atomic_mb_set(&cpu->icount_decr.u16.high, 0);
>  
>      if (unlikely(atomic_read(&cpu->interrupt_request))) {
>          int interrupt_request;
> 

Looks good to me! Thanks!


-- 

Thanks,

David / dhildenb
