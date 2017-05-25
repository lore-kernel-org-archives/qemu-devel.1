Received: from eggs.gnu.org ([2001:4830:134:3::10]:39924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDv1g-0004Qw-Oc
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDv1d-0003ct-Mc
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:50:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dDv1d-0003c2-H8
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:50:09 -0400
References: <1495634844-14777-1-git-send-email-dplotnikov@virtuozzo.com>
	<20170524155408.GF14372@rkaganb.sw.ru> <20170524172005.GB4623@amt.cnet>
	<20170525094004.GA27740@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82464a9c-765f-8de8-e600-fec6b13e4f8c@redhat.com>
Date: Thu, 25 May 2017 17:50:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170525094004.GA27740@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [svt-core] [PATCH] kvmclock: update
 system_time_msr address forcibly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org, den@virtuozzo.com



On 25/05/2017 11:40, Roman Kagan wrote:
>>>> +    kvmclock_struct_pa = env->system_time_msr & ~1ULL;
>>>> +
>>>>      if (!(env->system_time_msr & 1ULL)) {
>>>>          /* KVM clock not active */
>>>>          return 0;
>>> Roman.
>> Can't you avoid that call to each CPU? (ie fix the synchronization 
>> of the system time address problem in some other way?)
> Sorry, what call do you mean?  On one hand I suggested exactly to only
> call cpu_synchronize_state on the current (== first) cpu.  On the other,
> cpu_synchronize_state is heavier than just fetching a single msr.
> 
> Anyway kvmclock_current_nsec is only called in kvmclock_vm_state_change
> callback which is certainly not performance-critical, so IMO less new
> code here is better than more efficiency.
> 
> Or maybe I misunderstand your reason to request that the synchronization
> problem is fixed in some other way?

Denis's patch is problematic in that KVM_GET_MSRS should run in the VCPU
thread (using run_on_cpu).  cpu_synchronize_state() is heavier, but
solves this problem nicely.  Since it's not performance critical as you
say, calling cpu_synchronize_state() from kvmclock_current_nsec() seems
the best solution.

Paolo
