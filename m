Received: from eggs.gnu.org ([2001:4830:134:3::10]:43888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtzts-0007UG-Tl
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtztp-0006M0-Qr
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:32:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dtztp-0006LY-Ik
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:32:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8IHTgY6057524
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 13:32:00 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2gsjxsqh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 13:31:59 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Sep 2017 18:31:57 +0100
References: <20170918160012.4317-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Sep 2017 19:31:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5c6f8432-84ec-e06a-22fe-9ddc24998adf@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/27] s390x: SMP for TCG (+ cleanups)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

David,

can you outline how much you tested KVM after these changes?  I assume we should
review/test the whole series properly?

On 09/18/2017 05:59 PM, David Hildenbrand wrote:
> This series contains:
> - properly implement local external interrupts for TCG
> - factor out KVM SIGP handling code into common code
> - implement missing SIGP orders for TCG handled by the kernel for KVM
>   (including STOP and RESTART interrupts)
> - make TCG use the new SIGP code - experimental SMP support for s390x TCG
> - refactor STFL(E) implementation for TCG
> - bunch of cleanups
> 
> Basically all SIGP instructions are fully supported.
> 
> Thanks to Aurelien Jarno for the initital prototype and showcasing that
> supporting experimental SMP code can be implemented quite easily.
> 
> TCG SMP on s390x - what works?
> - "-smp X,maxcpus=X" with both, single and multi threaded TCG
> - "-smp ... -device qemu-s390-cpu,id=cpuX,core-id=X"
> - system_powerdown, system_reset, shutdown, reboot, NMI
> - online/offline of CPUs from inside the guest
> 
> TCG SMP on s390x - what does not work?
> - Floating interrupts all target CPU 0. Don't offline it.
> - CPU hotplug after the machine/main loop has been fully setup
> -- the new CPU comes up, answers and sends emergency signals, but suddenly
>    the VM gets stuck. This is strange, as ordinary online/offline works
>    just fine.
> -- can be triggered by "cpu-add 1" + "system_reset". The system will hang
>    when trying to online CPUs. (note: in Linux code they are fully up and
>    running and already executed code)
> -- also if hotplugging with "-S", before anything has run. This is strange,
>    as "-device qemu-s390-cpu" works just fine.
> -- does not seem to be related to CPU setup/reset code, I checked that
> -- seems to be related to some TCG internals (as broken for single and
>    multi threaded TCG).
> -- common code seems to be somehow broken, not sure if this is even
>    expected to work (e.g. for single threaded TCG, hotplugged CPUs will
>    never get set "cpu->created = true". But doesn't seem to be related to
>    this)
> 
> 
> Based on: https://github.com/cohuck/qemu.git s390-next
> Available on: git@github.com:davidhildenbrand/qemu.git s390x-queue
> 
> 
> David Hildenbrand (27):
>   s390x: raise CPU hotplug irq after really hotplugged
>   s390x/cpumodel: fix max STFL(E) bit number
>   target/s390x: get rid of next_core_id
>   s390x: introduce and use S390_MAX_CPUS
>   s390/tcg: turn INTERRUPT_EXT into a mask
>   s390x/tcg: injection of emergency signals and extarnal calls
>   s390x/tcg: STOPPED cpus can never wake up
>   s390x/tcg: a CPU cannot switch state due to an interrupt
>   target/s390x: factor out handling of WAIT PSW into handle_wait()
>   s390x/kvm: pass ipb directly into handle_sigp()
>   s390x/kvm: generalize SIGP stop and restart interrupt injection
>   s390x/kvm: factor out storing of CPU status
>   target/s390x: proper cpu->be convertion in s390_store_status()
>   s390x/kvm: factor out storing of adtl CPU status
>   s390x/kvm: drop two debug prints
>   s390x/kvm: factor out SIGP code into sigp.c
>   s390x/kvm: factor out actual handling of STOP interrupts
>   s390x/tcg: implement SIGP SENSE RUNNING STATUS
>   s390x/tcg: implement SIGP SENSE
>   s390x/tcg: implement SIGP EXTERNAL CALL
>   s390x/tcg: implement SIGP EMERGENCY SIGNAL
>   s390x/tcg: implement SIGP CONDITIONAL EMERGENCY SIGNAL
>   s390x/tcg: implement STOP and RESET interrupts for TCG
>   s390x/tcg: flush the tlb on SIGP SET PREFIX
>   s390x/tcg: switch to new SIGP handling code
>   s390x/tcg: unlock NMI
>   s390x/tcg: refactor stfl(e) to use s390_get_feat_block()
> 
>  hw/s390x/s390-virtio-ccw.c  |  17 +-
>  target/s390x/Makefile.objs  |   1 +
>  target/s390x/cpu-qom.h      |   2 -
>  target/s390x/cpu.c          |  40 ++--
>  target/s390x/cpu.h          |  36 +++-
>  target/s390x/cpu_features.c |   2 +-
>  target/s390x/cpu_models.c   |   2 +
>  target/s390x/excp_helper.c  |  98 ++++++---
>  target/s390x/helper.c       | 115 ++++++++--
>  target/s390x/helper.h       |   4 +-
>  target/s390x/internal.h     |  15 ++
>  target/s390x/interrupt.c    |  70 +++++-
>  target/s390x/kvm-stub.c     |  13 +-
>  target/s390x/kvm.c          | 470 +++--------------------------------------
>  target/s390x/kvm_s390x.h    |   3 +-
>  target/s390x/misc_helper.c  | 114 ++++------
>  target/s390x/sigp.c         | 504 ++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/trace-events   |   4 +-
>  target/s390x/translate.c    |   6 +-
>  19 files changed, 896 insertions(+), 620 deletions(-)
>  create mode 100644 target/s390x/sigp.c
> 
