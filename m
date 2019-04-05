Received: from eggs.gnu.org ([209.51.188.92]:49219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hCOkv-0005Ai-UG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hCOku-0005X0-17
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:19:41 -0400
Received: from mail-bgr052101128103.outbound.protection.outlook.com
	([52.101.128.103]:49989
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hCOks-0005Vf-Hv
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:19:39 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 5 Apr 2019 13:19:26 +0000
Message-ID: <20190405131923.GB20411@rkaganb.sw.ru>
References: <20190329141832.22882-1-vkuznets@redhat.com>
	<20190329141832.22882-4-vkuznets@redhat.com>
In-Reply-To: <20190329141832.22882-4-vkuznets@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1058AA5721BE124C927FF5B0E3F848E2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/8] i386/kvm: document existing Hyper-V
 enlightenments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>

On Fri, Mar 29, 2019 at 03:18:27PM +0100, Vitaly Kuznetsov wrote:
> Currently, there is no doc describing hv-* CPU flags, people are
> encouraged to get the information from Microsoft Hyper-V Top Level
> Functional specification (TLFS). There is, however, a bit of QEMU
> specifics.

This is appreciated a lot, thanks for doing this!

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  docs/hyperv.txt | 180 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 docs/hyperv.txt
>=20
> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> new file mode 100644
> index 0000000000..397f2517b8
> --- /dev/null
> +++ b/docs/hyperv.txt
> @@ -0,0 +1,180 @@
> +Hyper-V Enlightenments
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +1. Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +In some cases when implementing a hardware interface in software is slow=
, KVM
> +implements its own paravirtualized interfaces. This works well for Linux=
 as
> +guest support for such features is added simultaneously with the feature=
 itself.
> +It may, however, be hard-to-impossible to add support for these interfac=
es to
> +proprietary OSes, namely, Microsoft Windows.
> +
> +KVM on x86 implements Hyper-V Enlightenments for Windows guests. These f=
eatures
> +make Windows and Hyper-V guests think they're running on top of a Hyper-=
V
> +compatible hypervisor and use Hyper-V specific features.
> +
> +
> +2. Setup
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +No Hyper-V enlightenments are enabled by default by either KVM or QEMU. =
In
> +QEMU, individual enlightenments can be enabled through CPU flags, e.g:
> +
> +  qemu-system-x86_64 --enable-kvm --cpu host,hv_relaxed,hv_vpindex,hv_ti=
me, ...
> +
> +Sometimes there are dependencies between enlightenments, QEMU is suppose=
d to
> +check that the supplied configuration is sane.
> +
> +When any set of the Hyper-V enlightenments is enabled, QEMU changes hype=
rvisor
> +identification (CPUID 0x40000000..0x4000000A) to Hyper-V. KVM identifica=
tion
> +and features are kept in leaves 0x40000100..0x40000101.
> +
> +
> +3. Existing enlightenments
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +3.1. hv-relaxed
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This feature tells guest OS to disable watchdog timeouts as it is runnin=
g on a
> +hypervisor. It is known that some Windows versions will do this even whe=
n they
> +see 'hypervisor' CPU flag.
> +
> +3.2. hv-vapic
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Provides so-called VP Assist page MSR to guest allowing it to work with =
APIC
> +more efficiently. In particular, this enlightenment allows paravirtualiz=
ed
> +(exit-less) EOI processing.
> +
> +3.3. hv-spinlocks=3Dxxx
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Enables paravirtualized spinlocks. The parameter indicates how many time=
s
> +spinlock acquisition should be attempted before indicating the situation=
 to the
> +hypervisor. A special value 0xffffffff indicates "never to retry".
> +
> +3.4. hv-vpindex
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Provides HV_X64_MSR_VP_INDEX (0x40000002) MSR to the guest which has Vir=
tual
> +processor index information. This enlightenment makes sense in conjuncti=
on with
> +hv-synic, hv-stimer and other enlightenments which require the guest to =
know its
> +Virtual Processor indices (e.g. when VP index needs to be passed in a
> +hypercall).
> +
> +3.5. hv-runtime
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Provides HV_X64_MSR_VP_RUNTIME (0x40000010) MSR to the guest. The MSR ke=
eps the
> +virtual processor run time in 100ns units. This gives guest operating sy=
stem an
> +idea of how much time was 'stolen' from it (when the virtual CPU was pre=
empted
> +to perform some other work).
> +
> +3.6. hv-crash
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Provides HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 (0x40000100..0x4000010=
5) and
> +HV_X64_MSR_CRASH_CTL (0x40000105) MSRs to the guest. These MSRs are writ=
ten to
> +by the guest when it crashes, HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 M=
SRs
> +contain additional crash information. This information is outputted in Q=
EMU log
> +and through QAPI.
> +Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL causes=
 guest
> +to shutdown. This effectively blocks crash dump generation by Windows.

Hmm, why?

> +
> +3.7. hv-time
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Enables two Hyper-V-specific clocksources available to the guest: MSR-ba=
sed
> +Hyper-V clocksource (HV_X64_MSR_TIME_REF_COUNT, 0x40000020) and Referenc=
e TSC
> +page (enabled via MSR HV_X64_MSR_REFERENCE_TSC, 0x40000021). Both clocks=
ources
> +are per-guest, Reference TSC page clocksource allows for exit-less time =
stamp
> +readings. Using this enlightenment leads to significant speedup of all t=
imestamp
> +related operations.
> +
> +3.8. hv-synic
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Enables Hyper-V Synthetic interrupt controller - an extension of a local=
 APIC.
> +When enabled, this enlightenment provides additional communication facil=
ities
> +to the guest: SynIC messages and Events. This is a pre-requisite for
> +implementing VMBus devices (not yet in QEMU). Additionally, this enlight=
enment
> +is needed to enable Hyper-V synthetic timers. SynIC is controlled throug=
h MSRs
> +HV_X64_MSR_SCONTROL..HV_X64_MSR_EOM (0x40000080..0x40000084) and
> +HV_X64_MSR_SINT0..HV_X64_MSR_SINT15 (0x40000090..0x4000009F)
> +
> +Requires: hv-vpindex
> +
> +3.9. hv-stimer
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Enables Hyper-V synthetic timers. There are four synthetic timers per vi=
rtual
> +CPU controlled through HV_X64_MSR_STIMER0_CONFIG..HV_X64_MSR_STIMER3_COU=
NT
> +(0x400000B0..0x400000B7) MSRs. These timers can work either in single-sh=
ot or
> +periodic mode. It is known that certain Windows versions revert to using=
 RTC
> +extensively when this enlightenment is not provided; this leads to signi=
ficant
> +CPU consumption, even when virtual CPU is idle.

I think it'll rather use HPET if available.  I'm also not sure the idle
vCPU scenario was one that motivated for implementing paravirtualized
timers.

> +
> +Requires: hv-vpindex, hv-synic, hv-time
> +
> +3.10. hv-tlbflush
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Enables paravirtualized TLB shoot-down mechanism. On x86 architecture, r=
emote
> +TLB flush procedure requires sending IPIs and waiting for other CPUs to =
perform
> +local TLB flush. In virtualized environment some virtual CPUs may not ev=
en be
> +scheduled at the time of the call and may not require flushing (or, flus=
hing
> +may be postponed until the virtual CPU is scheduled). hv-tlbflush enligh=
tenment
> +implements TLB shoot-down through hypervisor enabling the optimization.
> +
> +Requires: hv-vpindex
> +
> +3.11. hv-ipi
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Enables paravirtualized IPI send mechanism. HvCallSendSyntheticClusterIp=
i
> +hypercall may target more than 64 virtual CPUs simultaneously, doing the=
 same
> +through APIC requires more than one access (and thus exit to the hypervi=
sor).
> +
> +Requires: hv-vpindex
> +
> +3.12. hv-vendor-id=3Dxxx
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This changes Hyper-V identification in CPUID 0x40000000.EBX-EDX from the=
 default
> +"Microsoft Hv". The parameter should be no longer than 12 characters. Ac=
cording
> +to the specification, guests shouldn't use this information and it is un=
known
> +if there is a Windows version which acts differently.
> +Note: hv-vendor-id is not an enlightenment and thus doesn't enable Hyper=
-V
> +identification when specified without some other enlightenment.
> +
> +3.13. hv-reset
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Provides HV_X64_MSR_RESET (0x40000003) MSR to the guest allowing it to r=
eset
> +itself by writing to it. Even when this MSR is enabled, it is not a reco=
mmended
> +way for Windows to perform system reboot and thus it may not be used.
> +
> +3.14. hv-frequencies
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Provides HV_X64_MSR_TSC_FREQUENCY (0x40000022) and HV_X64_MSR_APIC_FREQU=
ENCY
> +(0x40000023) allowing the guest to get its TSC/APIC frequencies without =
doing
> +measurements.
> +
> +3.15 hv-reenlightenment
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The enlightenment is nested specific, it targets Hyper-V on KVM guests. =
When
> +enabled, it provides HV_X64_MSR_REENLIGHTENMENT_CONTROL (0x40000106),
> +HV_X64_MSR_TSC_EMULATION_CONTROL (0x40000107)and HV_X64_MSR_TSC_EMULATIO=
N_STATUS
> +(0x40000108) MSRs allowing the guest to get notified when TSC frequency =
changes
> +(only happens on migration) and keep using old frequency (through emulat=
ion in
> +the hypervisor) until it is ready to switch to the new one. This, in con=
junction
> +with hv-frequencies, allows Hyper-V on KVM to pass stable clocksource (R=
eference
> +TSC page) to its own guests.
> +
> +Recommended: hv-frequencies
> +
> +3.16. hv-evmcs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The enlightenment is nested specific, it targets Hyper-V on KVM guests. =
When
> +enabled, it provides Enlightened VMCS feature to the guest. The feature
> +implements paravirtualized protocol between L0 (KVM) and L1 (Hyper-V)
> +hypervisors making L2 exits to the hypervisor faster. The feature is Int=
el-only.
> +Note: some virtualization features (e.g. Posted Interrupts) are disabled=
 when
> +hv-evmcs is enabled. It may make sense to measure your nested workload w=
ith and
> +without the feature to find out if enabling it is beneficial.
> +
> +Requires: hv-vapic
> +
> +
> +4. Useful links
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Hyper-V Top Level Functional specification and other information:
> +https://github.com/MicrosoftDocs/Virtualization-Documentation
> --=20
> 2.20.1
>=20

Thanks,
Roman.
