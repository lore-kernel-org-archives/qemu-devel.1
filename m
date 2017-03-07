Received: from eggs.gnu.org ([2001:4830:134:3::10]:54887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1clJ2J-0004Rs-Cp
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1clJ2G-00081d-7Y
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:36:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47367
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1clJ2G-00081U-0w
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:36:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v27HYnPg129099
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 12:36:30 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 292049bx90-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 12:36:30 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 7 Mar 2017 12:36:29 -0500
References: <1488896348-13560-1-git-send-email-borntraeger@de.ibm.com>
	<878tohhzg7.fsf@linaro.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 7 Mar 2017 18:36:24 +0100
MIME-Version: 1.0
In-Reply-To: <878tohhzg7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <c0a559a1-f62b-dec6-9cdb-58eb27bc878e@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH/RFC] exec: add cpu_synchronize_state to
 cpu_memory_rw_debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 03/07/2017 04:35 PM, Alex Benn=C3=A9e wrote:
>=20
> Christian Borntraeger <borntraeger@de.ibm.com> writes:
>=20
>> I sometimes got "Cannot access memory" when using the x command
>> on the monitor. Turns out that the cpu env did contain stale data
>> (e.g. wrong control register content for page table origin).
>> We must synchronize the state of the CPU before walking the page
>> tables. A similar issues happens for a remote gdb, so lets
>> do the cpu_synchronize_state in cpu_memory_rw_debug.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  exec.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/exec.c b/exec.c
>> index aabb035..e754a03 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -43,6 +43,7 @@
>>  #include "exec/ioport.h"
>>  #include "sysemu/dma.h"
>>  #include "sysemu/numa.h"
>> +#include "sysemu/hw_accel.h"
>>  #include "exec/address-spaces.h"
>>  #include "sysemu/xen-mapcache.h"
>>  #include "trace-root.h"
>> @@ -3309,6 +3310,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ul=
ong addr,
>>      hwaddr phys_addr;
>>      target_ulong page;
>>
>> +    cpu_synchronize_state(cpu);
>>      while (len > 0) {
>>          int asidx;
>>          MemTxAttrs attrs;
>=20
> This seems like the wrong place to put it. Would we end up doing a
> potentially expensive sync operations for every byte/word we dump out?

kvm_synchronize_state is clever enough to only sync once. This function m=
ostly
seems to be for debugging stuff (gdb, monitor). Instead of adding the syn=
c
in several places putting it here is a big hammer but it probably fixes a=
ll places.
I fear that we will forget this in other places. No idea whats right.
=20
> Certainly when I was messing around with ARM KVM debug I did the
> synchronise state as we entered the debug handling (e.g.
> gdb_handle_packet/memory_dump)?
>=20
> --
> Alex Benn=C3=A9e
>=20
