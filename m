Received: from eggs.gnu.org ([2001:4830:134:3::10]:37082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eZcch-0007uP-V8
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eZcce-0005et-QN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:10:23 -0500
From: Laurent Vivier <lvivier@redhat.com>
References: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
	<20180106004722.1152-2-joserz@linux.vnet.ibm.com>
	<1bd6f03c-a0da-0d67-509d-45881b14561d@redhat.com>
Message-ID: <9b7eda5a-119f-f505-fc0f-2da3939075b9@redhat.com>
Date: Thu, 11 Jan 2018 14:10:10 +0100
MIME-Version: 1.0
In-Reply-To: <1bd6f03c-a0da-0d67-509d-45881b14561d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/1] spapr: Check SMT based on
 KVM_CAP_PPC_SMT_POSSIBLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 11/01/2018 12:29, Laurent Vivier wrote:
> On 06/01/2018 01:47, Jose Ricardo Ziviani wrote:
>> Power9 supports 4 HW threads/core but it's possible to emulate
>> doorbells to implement virtual SMT. KVM has the KVM_CAP_PPC_SMT_POSSIBLE
>> which returns a bitmap with all SMT modes supported by the host.
>>
>> Today, QEMU forces the SMT mode based on PVR compat table, this is
>> silently done in spapr_fixup_cpu_dt. Then, if user passes thread=8 the
>> guest will end up with 4 threads/core without any feedback to the user.
>> It is confusing and will crash QEMU if a cpu is hotplugged in that
>> guest.
>>
>> This patch makes use of KVM_CAP_PPC_SMT_POSSIBLE to check if the host
>> supports the SMT mode so it allows Power9 guests to have 8 threads/core
>> if desired.
>>
>> Reported-by: Satheesh Rajendran <satheera@in.ibm.com>
>> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c       | 14 +++++++++++++-
>>  hw/ppc/trace-events  |  1 +
>>  target/ppc/kvm.c     |  5 +++++
>>  target/ppc/kvm_ppc.h |  6 ++++++
>>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> According to the tests I have done on P9 and P8, you should also set
> vsmt to the max value found in KVM_CAP_PPC_SMT_POSSIBLE to keep the same
> vcpu_id on a P8 and P9 with the same configuration "-smp
> W,sockets=X,cores=Y,threads=Z".
> 
> This is required for migration.
> 
> The formula is in spapr_cpu_core_realize():
> 
> cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i);
> 

I think spapr->vsmt should be set to something like
"ppc_compat_max_threads(cpu) & kvmppc_cap_smt_possible()" to set vsmt to
the maximum value for the compat mode but it doesn't seem easy to do as
"cpu" is not available in spapr_set_vsmt_mode().

Thanks,
Laurent
