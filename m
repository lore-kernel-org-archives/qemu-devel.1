Received: from eggs.gnu.org ([2001:4830:134:3::10]:34223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZDhB-0000KQ-P8
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 06:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZDh8-0001S8-KU
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 06:01:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:33448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dZDh8-0001Ru-DJ
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 06:01:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dZDh5-0005i5-I4
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 10:00:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7D9462E80CE
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 10:00:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Jul 2017 09:54:29 -0000
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Reply-To: Bug 1661386 <1661386@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170202204510.26617.69309.malonedeb@wampee.canonical.com>
	<20170208084952.6259.59626.malone@wampee.canonical.com>
Message-Id: <CAJs94EZcKKb6i1ApTRVXnHvOiFBGNk-j6j5vcEK2TX0YQzDXvg@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1661386] Re: Assertion `ret ==
 cpu->kvm_msr_buf->nmsrs' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

2017-02-08 11:49 GMT+03:00 Paolo Bonzini <bonzini@gnu.org>:
>> Does qemu follow recommendations from section 4.3?
>
> All that QEMU does is initialize MSR values and QEMU is talking to KVM,
> not to the processor; KVM in turn talks to the host kernel's perf
> subsystem.
>
> It's the host kernel's perf subsystem that needs to follow Intel's
> recommendation.  In particular, QEMU is setting CPUID to the values
> retrieved by
>
>     perf_get_x86_pmu_capability(&cap);

I can not find this function mentioned in qemu master sources.

The only thing I see is that has_msr_architectural_pmu is set to be
true in kvm_arch_init_vcpu() if 0xA EAX has non-zero version. This is
not enough according to the Intel specs.

>
> so perhaps it's perf_get_x86_pmu_capability that misreads the
> performance monitoring capabilities provided by ESX.  Please attach
> dmesg logs from starting the host with loglevel=3D9, as well as "x86info
> -a" output from the host, to see if perf misses some problematic
> CPUID/MSR combination.
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1661386
>
> Title:
>   Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed
>
> Status in QEMU:
>   New
>
> Bug description:
>   Hello,
>
>
>   I see the following when try to run qemu from master as the following:
>
>   # ./x86_64-softmmu/qemu-system-x86_64 --version
>   QEMU emulator version 2.8.50 (v2.8.0-1006-g4e9f524)
>   Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
>   # ./x86_64-softmmu/qemu-system-x86_64 -machine accel=3Dkvm -nodefaults
>   -no-reboot -nographic -cpu host -vga none  -kernel .build.kernel.kvm
>   -initrd .build.initrd.kvm -append 'panic=3D1 no-kvmclock console=3DttyS0
>   loglevel=3D7' -m 1024 -serial stdio
>   qemu-system-x86_64: /home/matwey/lab/qemu/target/i386/kvm.c:1849:
>   kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
>
>   First broken commit has been bisected:
>
>   commit 48e1a45c3166d659f781171a47dabf4a187ed7a5
>   Author: Paolo Bonzini <pbonzini@redhat.com>
>   Date:   Wed Mar 30 22:55:29 2016 +0200
>
>       target-i386: assert that KVM_GET/SET_MSRS can set all requested MSRs
>
>       This would have caught the bug in the previous patch.
>
>       Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
>   My cpuinfo is the following:
>
>   processor       : 0
>   vendor_id       : GenuineIntel
>   cpu family      : 6
>   model           : 44
>   model name      : Intel(R) Xeon(R) CPU           X5675  @ 3.07GHz
>   stepping        : 2
>   microcode       : 0x14
>   cpu MHz         : 3066.775
>   cache size      : 12288 KB
>   physical id     : 0
>   siblings        : 2
>   core id         : 0
>   cpu cores       : 2
>   apicid          : 0
>   initial apicid  : 0
>   fpu             : yes
>   fpu_exception   : yes
>   cpuid level     : 11
>   wp              : yes
>   flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx rdtscp lm=
 constant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc=
 aperfmperf pni pclmulqdq vmx ssse3 cx16 sse4_1 sse4_2 popcnt aes hyperviso=
r lahf_lm ida arat epb dtherm tpr_shadow vnmi ept vpid
>   bugs            :
>   bogomips        : 6133.55
>   clflush size    : 64
>   cache_alignment : 64
>   address sizes   : 40 bits physical, 48 bits virtual
>   power management:
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1661386/+subscriptions


-- =

With best regards,
Matwey V. Kornilov

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1661386

Title:
  Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed

Status in QEMU:
  New

Bug description:
  Hello,

  =

  I see the following when try to run qemu from master as the following:

  # ./x86_64-softmmu/qemu-system-x86_64 --version
  QEMU emulator version 2.8.50 (v2.8.0-1006-g4e9f524)
  Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
  # ./x86_64-softmmu/qemu-system-x86_64 -machine accel=3Dkvm -nodefaults
  -no-reboot -nographic -cpu host -vga none  -kernel .build.kernel.kvm
  -initrd .build.initrd.kvm -append 'panic=3D1 no-kvmclock console=3DttyS0
  loglevel=3D7' -m 1024 -serial stdio
  qemu-system-x86_64: /home/matwey/lab/qemu/target/i386/kvm.c:1849:
  kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

  First broken commit has been bisected:

  commit 48e1a45c3166d659f781171a47dabf4a187ed7a5
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Wed Mar 30 22:55:29 2016 +0200

      target-i386: assert that KVM_GET/SET_MSRS can set all requested MSRs
      =

      This would have caught the bug in the previous patch.
      =

      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  My cpuinfo is the following:

  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 44
  model name      : Intel(R) Xeon(R) CPU           X5675  @ 3.07GHz
  stepping        : 2
  microcode       : 0x14
  cpu MHz         : 3066.775
  cache size      : 12288 KB
  physical id     : 0
  siblings        : 2
  core id         : 0
  cpu cores       : 2
  apicid          : 0
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 11
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx rdtscp lm c=
onstant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc a=
perfmperf pni pclmulqdq vmx ssse3 cx16 sse4_1 sse4_2 popcnt aes hypervisor =
lahf_lm ida arat epb dtherm tpr_shadow vnmi ept vpid
  bugs            :
  bogomips        : 6133.55
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 40 bits physical, 48 bits virtual
  power management:

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1661386/+subscriptions
