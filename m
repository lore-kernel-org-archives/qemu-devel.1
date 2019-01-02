Received: from eggs.gnu.org ([208.118.235.92]:49442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1geVMk-0002rV-DB
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1geVMh-0000hb-9G
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:30:38 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Wed, 2 Jan 2019 01:30:28 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CA6C4E@SHSMSX101.ccr.corp.intel.com>
References: <20181221124410.11920-1-pbonzini@redhat.com>
	<82D7661F83C1A047AF7DC287873BF1E172C97D77@SHSMSX101.ccr.corp.intel.com>
	<ed344ef0-c519-1c71-c0ad-fb523a5dc516@redhat.com>
	<20181229012805.GB6817@habkost.net>
In-Reply-To: <20181229012805.GB6817@habkost.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

> > On 25/12/18 09:23, Kang, Luwei wrote:
> > >> From: Qemu-devel
> > >> [mailto:qemu-devel-bounces+luwei.kang=3Dintel.com@nongnu.org] On
> > >> Behalf Of Paolo Bonzini
> > >> Sent: Friday, December 21, 2018 8:44 PM
> > >> To: qemu-devel@nongnu.org
> > >> Cc: ehabkost@redhat.com; qemu-stable@nongnu.org
> > >> Subject: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit
> > >> as unmigratable
> > >>
> > >> Marshaling of processor tracing MSRs is not yet implemented in QEMU,=
 mark the feature as unmigratable.
> > >
> > > Hi Paolo,
> > >     I think Intel PT has supported live migration. I don't understand=
 what you mean.
> > >
> > >     commit b77146e9a129bcdb60edc23639211679ae846a92
> > >     Author: Chao Peng <chao.p.peng@linux.intel.com>
> > >     Date:   Mon Mar 5 00:48:36 2018 +0800
> > >     i386: Add support to get/set/migrate Intel Processor Trace
> > > feature
> >
> > Indeed.  I had forgotten this patch because it was committed so long
> > before the kernel parts (which really should not happen, but Eduardo
> > and I miscommunicated on it).  Can you check that it still works?
>=20
> My mistake, sorry.  I should have checked the status of the kernel code b=
efore merging the original series, or waited for your review.
>=20
> I'm re-reading the code now and I'm worried about two things:
>=20
> The code will break if GET_SUPPORTED_CPUID returns INTEL_PT, but the MSR =
emulation code is not present yet.  Maybe it won't be an
> issue in practice because it happens only between the two Linux commits (=
commit 86f5201df0d3 "KVM: x86: Add Intel Processor Trace
> cpuid emulation" and commit bf8c55d8dc09 "KVM: x86: Implement Intel PT MS=
Rs read/write emulation") and shipping a kernel with the
> CPUID code without the MSR commit seems pointless.
>=20
> The kvm_arch_get_supported_cpuid() call inside kvm_get_msrs() looks suspi=
cious.  What should happen if we try to migrate to a host that
> returns a smaller number on kvm_arch_get_supported_cpuid(0x14, 1, R_EAX)?

Hi Eduardo,
    I think we have some discussion on this feature about live migration sa=
fe about two years ago. In order to make live migration safe, we set all th=
e values of PT CPUID as constant.
   I think what your concern is the number of address range (CPUID:14H.01.E=
AX[bit02:00]). Currently, it is a constant value (#define INTEL_PT_ADDR_RAN=
GES_NUM 0x2) for guest.
   1. if the hardware support < 2, Intel PT will not exposed to guest;
   2. if the hardware support >=3D 2, we just expose 2 to guest.
   So the number of address range in guest is always 2 if Intel PT is suppo=
rted in guest (there also have other pre-condition check).

The value of guest Intel PT CPUID information.
+        if (count =3D=3D 0) {
+            *eax =3D INTEL_PT_MAX_SUBLEAF;
+            *ebx =3D INTEL_PT_MINIMAL_EBX;
+            *ecx =3D INTEL_PT_MINIMAL_ECX;
+        } else if (count =3D=3D 1) {
+            *eax =3D INTEL_PT_MTC_BITMAP | INTEL_PT_ADDR_RANGES_NUM;
+            *ebx =3D INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
+        }

The condition check if we can expose Intel PT to guest.
+        if (!eax_0 ||
+           ((ebx_0 & INTEL_PT_MINIMAL_EBX) !=3D INTEL_PT_MINIMAL_EBX) ||
+           ((ecx_0 & INTEL_PT_MINIMAL_ECX) !=3D INTEL_PT_MINIMAL_ECX) ||
+           ((eax_1 & INTEL_PT_MTC_BITMAP) !=3D INTEL_PT_MTC_BITMAP) ||
+           ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
+                                           INTEL_PT_ADDR_RANGES_NUM) ||
+           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=3D
+                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {
+            /*
+             * Processor Trace capabilities aren't configurable, so if the
+             * host can't emulate the capabilities we report on
+             * cpu_x86_cpuid(), intel-pt can't be enabled on the current h=
ost.
+             */
+            env->features[FEAT_7_0_EBX] &=3D ~CPUID_7_0_EBX_INTEL_PT;
+            cpu->filtered_features[FEAT_7_0_EBX] |=3D CPUID_7_0_EBX_INTEL_=
PT;
+            rv =3D 1;
+        }


Thanks,
Luwei Kang
