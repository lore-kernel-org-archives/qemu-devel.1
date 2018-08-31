Received: from eggs.gnu.org ([2001:4830:134:3::10]:59356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fvfvi-0004kA-Cu
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fvfvc-0008Cd-P7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:41:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fvfva-00089o-O2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:41:19 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180829135814.GE2412@work-vm> (David Alan Gilbert's message of
	"Wed, 29 Aug 2018 14:58:15 +0100")
References: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
	<CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
	<87k1ohxik4.fsf@trasno.org>
	<3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
	<20180828172739.GA10175@work-vm>
	<19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
	<20180829135814.GE2412@work-vm>
Reply-To: quintela@redhat.com
Date: Fri, 31 Aug 2018 11:41:03 +0200
Message-ID: <87d0tyoouo.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Query] Live Migration between machines with
 different processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, Auger Eric <eric.auger@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Liguori <aliguori@us.ibm.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Jaggi, Manish (Manish.Jaggi@cavium.com) wrote:
>
>> Just to add what happens in ARM64 case, qemu running on Machine A sends cpu state information to Machine B.
>> This state contains MIDR value, and so Processor ID value is compared in KVM and not in qemu (correcting myself).
>> 
>> IIRC, Peter/Eric please point if there is something incorrect in the below flow...
>> 
>> (Machine B)
>> target/arm/machine.c: cpu_post_load()
>> 		- updates cpu->cpreg_values[i] : which includes MIDR (processor ID register)
>> 
>> 		- calls write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)
>> 
>> 				target/arm/kvm.c: write_list_to_kvmstate
>> 				- calls => kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
>> 
>> 					=> and it eventually lands up IIRC in Linux code in 
>> 
>> 							=> arch/arm64/kvm/sys_regs.c : set_invariant_sys_reg(u64 id, void __user *uaddr)
>> 							 	/* This is what we mean by invariant: you can't change it. */
>> 								if (r->val != val)
>> 									return -EINVAL;
>> 								Note: MIDR_EL1 is invariant register.
>> result: Migration fails on Machine B.
>> 
>> A few points:
>> - qemu on arm64 is invoked with -machine virt and -cpu as host. So we don't explicitly define which cpu. 
>
> Note that even on x86 we don't guarantee as much about '-cpu host', what
> we expect to work for migration is that if you pick a   '-cpu amodel'
> and both hosts support the feature flags required by 'amodel' then it
> should work.

I really think that the right approach here is not using -cpu host.  You
do the full work, create a model as David says, and be sure that you car
run that model on both cpus.  It is a lot of work, but it is the only
way to make sure that this is going to work long term.

>> - In case Machine A and Machine B have almost same Core and the
>> delta may-not have any effect on qemu operation, migration should
>> work by just looking into whitelist.
>> whitelist can be given as a parameter for qemu on machine B.
>> 
>> qemu-system-aarch64 -whitelist <ids separated by commas>
>> 
>> (This is my proposal)
>> 
>> - So in cpu_post_load (Machine B) qemu can lookup whitelist and
>> replace the MIDR with the one at Machine B.
>> Sounds good?
>> 
>> - Juan raised a point about clock speed, I am not sure it will have
>> any effect on arm since qemu is run with -cpu host param.
>> I could be wrong here, Peter/Eric can you please correct me...
>
> Clock speed is only really a problem for things like timestamp counters;
> some cores let you scale them; for those that don't then yes it's a bit
> odd.

This was just one example that I thought on top of my head.  Other thing
that I remember was that at some point, if you migrated to a cpu with
hyperthreading, you lost half of your performance counters.  I still
think that you need to create a proper model, and work from there.

Later, Juan.
