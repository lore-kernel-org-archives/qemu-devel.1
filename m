Received: from eggs.gnu.org ([2001:4830:134:3::10]:57074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOR7v-0007sD-2b
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOR7s-0008Ib-G1
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:40:23 -0500
References: <20171129191215.11323-1-david@redhat.com>
	<3f0c7605-4090-c1f6-c40d-06aab9a3e992@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <626bacaa-c24a-1cc0-14a7-d9ea4592b2f5@redhat.com>
Date: Mon, 11 Dec 2017 17:40:09 +0100
MIME-Version: 1.0
In-Reply-To: <3f0c7605-4090-c1f6-c40d-06aab9a3e992@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] cpus: make pause_all_cpus() play with
 SMP on single threaded TCG
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


>  int vm_stop(RunState state)
>  {
>      if (qemu_in_vcpu_thread()) {
> @@ -1818,7 +1809,8 @@ int vm_stop(RunState state)
>           * FIXME: should not return to device code in case
>           * vm_stop() has been requested.
>           */
> -        cpu_stop_current();
> +        qemu_cpu_stop(current_cpu);
> +        cpu_exit(current_cpu);

We're doing the cpu_exit() now after the broadcast, is this ok?

Also we drop the check for current_cpu, I assume this is also ok.

>          return 0;
>      }
> 

-- 

Thanks,

David / dhildenb
