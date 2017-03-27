Received: from eggs.gnu.org ([2001:4830:134:3::10]:59105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csXEH-0003xv-QW
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csXEE-00068z-KW
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:10:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:37252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1csXEE-00068L-EC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:10:46 -0400
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
	<20170327154636.GI28530@thinpad.lan.raisama.net>
From: Alexander Graf <agraf@suse.de>
Message-ID: <c14eb231-10d1-63cb-ed14-8b7cd131b7b0@suse.de>
Date: Mon, 27 Mar 2017 18:10:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170327154636.GI28530@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org



On 27/03/2017 17:46, Eduardo Habkost wrote:
> On Mon, Mar 27, 2017 at 04:26:50PM +0200, Alexander Graf wrote:
>> KVM allows trap and emulate (read: NOP) of the MONITOR and MWAIT
>> instructions. There is work undergoing to enable actual execution
>> of these inside of KVM, but nobody really wants to expose the feature
>> to the guest by default, as it would eat up all of the host CPU.
>
> Isn't this something that should be reported using
> KVM_GET_EMULATED_CPUID? (QEMU still doesn't know how to use
> KVM_GET_EMULATED_CPUID, however.)

Depends how you look at it. In KVM land there are basically 3 ways to 
deal with MONITOR/MWAIT:

   1) #VMEXIT on every execution, treat them as NOP
   2) let the guest natively execute them (looks like a busy loop for 
the host, but saves power)
   3) be smart in KVM about it, add actual emulation and adaptively 
allow for native mwait execution or emulated mwait which means we can 
run inside host context

>> So today there is no streamlined way to actually notify the guest that
>> it's ok to execute MONITOR / MWAIT, even when we want to explicitly
>> leave the guest in guest context.
>
> I'm not familiar with the variables involved in this decision.
> How exactly would somebody (human or software) determine if it's
> really ok to let the guest execute MONITOR / MWAIT?
>
> Under what circumstances do you expect this to be used? Is this
> just for debugging and development?

The main reason this is bubbling up at all are IPC intensive workloads. 
Imagine you have the following:

CPU0 goes idle (waiting on something)
CPU1 wants to wake up CPU0 (because wait time is over)

In a normal KVM environment what you get is that

CPU0 calls HLT (going into KVM to do other work)
CPU1 triggers IPI via emulated APIC to wake up CPU0

However with actual native MWAIT what happens is

CPU0 calls MWAIT, stays in guest context ("wasting" CPU time)
CPU1 writes a byte to a memory location, waking up CPU0

With that scheme, you get your IPC latency down by a *huge* margin.


When is that useful? When you only have a single VM on your host for 
example, so you want virtual machines for the sake of administration, 
not for overprovisioning.

>
>>
>> This patch adds a new -cpu parameter called "mwait" which - when
>> enabled - force enables the MONITOR / MWAIT CPUID flag, even when
>> the underlying accel framework does not explicitly advertise support.
>>
>
> If you really want something that makes QEMU ignore what the
> accel code is reporting, I would prefer a syntax that could be
> used for other features too, like "-cpu ...,monitor=force".

That sounds like a pretty nice idea and much more scalable. Let me see 
if I can somehow pull that off :).


Alex
