Received: from eggs.gnu.org ([2001:4830:134:3::10]:57225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecAQP-0001yV-C7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecAQJ-0000cc-MC
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:40:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecAQJ-0000cC-FM
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:40:07 -0500
References: <82D7661F83C1A047AF7DC287873BF1E167E7630B@SHSMSX101.ccr.corp.intel.com>
	<97bf8d29-4009-6f61-f4bb-d128da5a4c9f@redhat.com>
	<20180115140455.GN6646@localhost.localdomain>
	<20180115142518.GN1602429@orkuz.home>
	<20180115143156.GO6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E776B5@SHSMSX101.ccr.corp.intel.com>
	<20180116115113.GA627@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E79545@SHSMSX101.ccr.corp.intel.com>
	<20180118024232.GT627@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E7A61F@SHSMSX101.ccr.corp.intel.com>
	<20180118132415.GU627@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c67f0021-0ca0-413b-bb84-3ff54dd791de@redhat.com>
Date: Thu, 18 Jan 2018 14:39:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180118132415.GU627@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND v1 1/2] i386: Add Intel Processor
 Trace feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Kang, Luwei" <luwei.kang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>

On 18/01/2018 14:24, Eduardo Habkost wrote:
> However, if there's a simple way to make it possible to migrate
> between hosts with different CPUID[14h] data, it would be even
> better.  With the current KVM intel-pt implementation, what
> happens if the CPUID[14h] data seen by the guest doesn't match
> exactly the CPUID[14h] leaves from the host?

Some bits in there can be treated as CPU features (e.g. EBX bit 0 "CR3
filtering support").  Probably we should handle these in KVM right now.
KVM needs to compute a mask of valid 1 bits for IA32_RTIT_CTL based on
CPUID, and apply it when the MSR is written.  It also needs to whitelist
bits like we do for other feature words.  These include:

- CPUID[EAX=3D14h,ECX=3D0].EBX

- CPUID[EAX=3D14h,ECX=3D0].ECX except bit 31

- CPUID[EAX=3D14h,ECX=3D1].EAX bits 16:31 (if CPUID[EAX=3D14h,ECX=3D0].EB=
X[3]=3D1)

- CPUID[EAX=3D14h,ECX=3D1].EBX (if CPUID[EAX=3D14h,ECX=3D0].EBX[1]=3D1)

Others, currently only CPUID[EAX=3D14h,ECX=3D0].ECX[31] must match, there=
 is
no way to emulate the "wrong" value.

Others, currently only CPUID[EAX=3D14h,ECX=3D1].EAX[2:0] are numeric valu=
es,
and it's possible to emulate a lower value than the one in the processor.

CPUID[EAX=3D14h,ECX=3D0].EAX is the maximum subleaf.  It should be (barri=
ng
guest bugs) okay to always present leaf 1.

Paolo
