Received: from eggs.gnu.org ([2001:4830:134:3::10]:40546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eJmMz-0003Ue-OT
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eJmMu-0004K4-Q1
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:20:41 -0500
Received: from mail-db5eur01on0112.outbound.protection.outlook.com
	([104.47.2.112]:39267
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1eJmMu-0004JH-A4
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:20:36 -0500
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
Date: Tue, 28 Nov 2017 23:20:27 +0300
MIME-Version: 1.0
In-Reply-To: <20171128195817.GA29077@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, rkagan@virtuozzo.com

On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
> Hi,
>
> On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
>> Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
>> introduced and set by default exposing l3 to the guest.
>>
>> The motivation behind it was that in the Linux scheduler, when waking up
>> a task on a sibling CPU, the task was put onto the target CPU's runqueue
>> directly, without sending a reschedule IPI.  Reduction in the IPI count
>> led to performance gain.
>>
>> However, this isn't the whole story.  Once the task is on the target
>> CPU's runqueue, it may have to preempt the current task on that CPU, be
>> it the idle task putting the CPU to sleep or just another running task.
>> For that a reschedule IPI will have to be issued, too.  Only when that
>> other CPU is running a normal task for too little time, the fairness
>> constraints will prevent the preemption and thus the IPI.
>>
>> This boils down to the improvement being only achievable in workloads
>> with many actively switching tasks.  We had no access to the
>> (proprietary?) SAP HANA benchmark the commit referred to, but the
>> pattern is also reproduced with "perf bench sched messaging -g 1"
>> on 1 socket, 8 cores vCPU topology, we see indeed:
>>
>> l3-cache	#res IPI /s	#time / 10000 loops
>> off		560K		1.8 sec
>> on		40K		0.9 sec
>>
>> Now there's a downside: with L3 cache the Linux scheduler is more eager
>> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
>> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
>> sched pipe -i 100000" gives
>>
>> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
>> off		200 (no K)	230		0.2 sec
>> on		400K		330K		0.5 sec
>>
>> In a more realistic test, we observe 15% degradation in VM density
>> (measured as the number of VMs, each running Drupal CMS serving 2 http
>> requests per second to its main page, with 95%-percentile response
>> latency under 100 ms) with l3-cache=on.
>>
>> We think that mostly-idle scenario is more common in cloud and personal
>> usage, and should be optimized for by default; users of highly loaded
>> VMs should be able to tune them up themselves.
>>
> There's one thing I don't understand in your test case: if you
> just found out that Linux will behave worse if it assumes that
> the VCPUs are sharing a L3 cache, why are you configuring a
> 8-core VCPU topology explicitly?
>
> Do you still see a difference in the numbers if you use "-smp 8"
> with no "cores" and "threads" options?
>
This is quite simple. A lot of software licenses are bound to the amount
of CPU __sockets__. Thus it is mandatory in a lot of cases to set topology
with 1 socket/xx cores to reduce the amount of money necessary to
be paid for the software.

Den
