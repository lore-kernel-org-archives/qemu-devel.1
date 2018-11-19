Received: from eggs.gnu.org ([2001:4830:134:3::10]:42332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gOrVn-0005B9-Vk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gOrVk-0001rz-PM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:55:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gOrVk-0001qY-Hk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:55:16 -0500
From: Bandan Das <bsd@redhat.com>
References: <1235.1542559249@dschgrazlin2.units.it>
Date: Mon, 19 Nov 2018 16:55:13 -0500
In-Reply-To: <1235.1542559249@dschgrazlin2.units.it> (balducci@units.it's
	message of "Sun, 18 Nov 2018 17:40:25 +0100")
Message-ID: <jpgefbgag1q.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balducci@units.it
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

balducci@units.it writes:

> hello
>
> I'm building qemu from source and happily using it since a bit
> (2.3.0)
>
> Since 3.1.0-rc0 (including latest 3.1.0-rc1) I'm no more able to start
> qemu, getting:
>
>     ----8<----
>     install:115> qemu
>     qemu: error: failed to set MSR 0x10a to 0x0
>     qemu: /home/balducci/tmp/install-us-d/qemu-3.1.0-rc1.d/qemu-3.1.0-rc0/target/i386/kvm.c:2185: kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
>     Aborted
>     ---->8----
>
I believe the check on whether MSR_IA32_ARCH_CAPABILITIES is present is
incomplete because it can return 0 for data. Can you try this:

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f524e7d929..4878ffb90b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2002,14 +2002,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
 #endif
 
     /* If host supports feature MSR, write down. */
-    if (kvm_feature_msrs) {
-        int i;
-        for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
-            if (kvm_feature_msrs->indices[i] == MSR_IA32_ARCH_CAPABILITIES) {
-                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+    if (kvm_arch_get_supported_msr_feature(kvm_state, MSR_IA32_ARCH_CAPABILITIES)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
                               env->features[FEAT_ARCH_CAPABILITIES]);
-                break;
-            }
     }
 
     /*


> I have no idea about what the reason might be, apologies.
>
> Actually, I have found a recent (2018-10-16) post which might be
> related to this (it mentions the same error message from qemu):
> https://lkml.org/lkml/2018/10/16/440; but I'm not in the position to
> go through. AFAICS, the commit mentioned in the link is present in the
> 4.19.2 kernel I'm using, so...?
>
> I can add that 3.0.0 works nicely (everything else unchanged,
> including running kernel 4.19.2)
>
> OTOH, 3.1.0-rc0 dumps the same error message if I boot into 4.17.14 or
> 4.18.16 kernels.
>
> I enclose my specs hoping that somebody can spot where the problem
> might be. I will be happy to send any other detail which might be
> useful.
>
> I suspect that this might be some problem on my side, as I couldn't
> find any similar report (apart some old (qemu-2.8.50) threads, that
> didn't help)
>
>
> thanks a lot in advance for any hint/help
>
> ciao
> gabriele
>
>
> Here are my specs:
>
> # --------------------------------
> # command to run qemu is:
> qemu -m 2G /opt/windog  \
>     -accel kvm,thread=multi \
>     -netdev user,id=net0,smb=/home/balducci \
>     -device rtl8139,netdev=net0
>
> # --------------------------------
> # qemu build configuration:
> --prefix=/opt/stow.d/versions/qemu-3.1.0-rc1/usr
> --libdir=/opt/stow.d/versions/qemu-3.1.0-rc1/usr/lib64
> --sysconfdir=/opt/stow.d/versions/qemu-3.1.0-rc1/etc
> --localstatedir=/var/run
> --docdir=/opt/stow.d/versions/qemu-3.1.0-rc1/usr/share/doc/qemu
> --target-list=x86_64-softmmu
> --audio-drv-list=alsa
>
>
> # --------------------------------
> install:154> uname -sr
> Linux 4.19.2
>
> # --------------------------------
> install:155> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 21
> model           : 48
> model name      : AMD Athlon(tm) X4 860K Quad Core Processor
> stepping        : 1
> microcode       : 0x6003106
> cpu MHz         : 3473.492
> cache size      : 2048 KB
> physical id     : 0
> siblings        : 4
> core id         : 0
> cpu cores       : 2
> apicid          : 16
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 13
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb bpext ptsc cpb hw_pstate ssbd vmmcall fsgsbase bmi1 xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold overflow_recov
> bugs            : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
> bogomips        : 7380.73
> TLB size        : 1536 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 48 bits physical, 48 bits virtual
> power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro [13]
>
> [...cpus 1 2 3 omitted...]
>
>
> # --------------------------------
> install:156> egrep KVM .config-4.19.2
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_KVM=y
> # CONFIG_KVM_INTEL is not set
> CONFIG_KVM_AMD=y
>
> [of course, I can send the whole kernel configuration file, if needed]
