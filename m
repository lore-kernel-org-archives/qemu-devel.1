Received: from eggs.gnu.org ([2001:4830:134:3::10]:58166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNQrh-0007YL-NR
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNQre-00075z-GP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:16:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNQre-00073o-6p
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:15:58 -0500
References: <20181114114400.15577-1-pbonzini@redhat.com>
	<20181114194208.GA500@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7648aa01-5458-bef1-9b65-f6ef83287e63@redhat.com>
Date: Fri, 16 Nov 2018 00:15:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181114194208.GA500@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpus: run work items for all vCPUs if
 single-threaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, alex.bennee@linaro.org

On 14/11/2018 20:42, Emilio G. Cota wrote:
> On Wed, Nov 14, 2018 at 12:44:00 +0100, Paolo Bonzini wrote:
>> This avoids the following deadlock:
>>
>> 1) a thread calls run_on_cpu for CPU 2 from a timer, and single_tcg_halt_cond
>> is signaled
>>
>> 2) CPU 1 is running and exits.  It finds no work item and enters CPU 2
>>
>> 3) because the I/O thread is stuck in run_on_cpu, the round-robin kick
>> timer never triggers, and CPU 2 never runs the work item
>>
>> 4) run_on_cpu never completes
> 
> I'm having trouble understanding (2)->(3).
> 
> When the vCPU thread enters CPU 2, shouldn't it detect that work is
> pending? As in:
> 
> 	/* assume cpu == cpu2 in the example above */
> 	while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
> 
> Both cpu->queued_work_first and cpu->exit_request will be set for cpu2.
> 
> I can see though how with an additional CPU the deadlock
> could happen. For example, the I/O thread does run_on_cpu(cpu3),
> which kicks cpu1 (i.e. the tcg_current_rr_cpu) and cpu3, but not cpu2.
> Then cpu1 exits, and cpu2 starts executing; unless cpu2 exits on its
> own volition, it will run forever.

Yes, the thread must call run_on_cpu for CPU *3* from a timer.

Paolo
