Received: from eggs.gnu.org ([2001:4830:134:3::10]:35392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebPm1-0005gn-EK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebPlx-0000HM-9e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebPlx-0000GE-13
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:21 -0500
Date: Tue, 16 Jan 2018 09:51:13 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180116115113.GA627@localhost.localdomain>
References: <1515443797-10837-1-git-send-email-luwei.kang@intel.com>
	<20180112142252.GG6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E7630B@SHSMSX101.ccr.corp.intel.com>
	<97bf8d29-4009-6f61-f4bb-d128da5a4c9f@redhat.com>
	<20180115140455.GN6646@localhost.localdomain>
	<20180115142518.GN1602429@orkuz.home>
	<20180115143156.GO6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E776B5@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167E776B5@SHSMSX101.ccr.corp.intel.com>
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
To: "Kang, Luwei" <luwei.kang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>

On Tue, Jan 16, 2018 at 06:10:17AM +0000, Kang, Luwei wrote:
> > > On Mon, Jan 15, 2018 at 12:04:55 -0200, Eduardo Habkost wrote:
> > > > CCing libvirt developers.
> > > ...
> > > > This case is slightly more problematic, however: the new feature is
> > > > actually migratable (under very controlled circumstances) because of
> > > > patch 2/2, but it is not migration-safe[1].  This means libvirt
> > > > shouldn't include it in "host-model" expansion (which uses the
> > > > query-cpu-model-expansion QMP command) until we make the feature
> > > > migration-safe.
> > > >
> > > > For QEMU, this means the feature shouldn't be returned by
> > > > "query-cpu-model-expansion type=static model=max" (but it can be
> > > > returned by "query-cpu-model-expansion type=full model=max").
> > > >
> > > > Jiri, it looks like libvirt uses type=full on
> > > > query-cpu-model-expansion on x86.  It needs to use type=static[2],
> > > > or it will have no way to find out if a feature is migration-safe or
> > > > not.
> > > ...
> > > > [2] It looks like libvirt uses type=full because it wants to get
> > > >     all QOM property aliases returned.  In this case, one
> > > >     solution for libvirt is to use:
> > > >
> > > >     static_expansion = query_cpu_model_expansion(type=static, model)
> > > >     all_props = query_cpu_model_expansion(type=full,
> > > > static_expansion)
> > >
> > > This is exactly what libvirt is doing (with model = "host") ever since
> > > query-cpu-model-expansion support was implemented for x86.
> > 
> > Oh, now I see that the x86 code uses
> > QEMU_MONITOR_CPU_MODEL_EXPANSION_STATIC_FULL and not just QEMU_MONITOR_CPU_MODEL_EXPANSION_FULL.  Nice!
> > 
> 
> So, I need to add Intel PT feature in "X86CPUDefinition
> builtin_x86_defs[]" so that we can get this CPUID in specific
> CPU model not only "-cpu host". Is that right?

The problem is that you won't be able to add intel-pt to any CPU
model unless the feature is made migration-safe (by not calling
kvm_arch_get_supported_cpuid() from cpu_x86_cpuid()).

What's missing here is to either: (a) make cpu_x86_cpuid() return
host-independent data (it can be constant, or it can be
configurable on the command-line); or (b) add a mechanism to skip
intel-pt from "query-cpu-model-expansion type=static".  Probably
(a) is easier to implement, and it also makes the feature more
useful (by making it migration-safe).

> 
> Intel PT is first supported in Intel Core M and 5th generation
> Intel Core processors that are based on the Intel
> micro-architecture code name Broadwell but Intel PT use EPT is
> first supported in Ice Lake. Intel PT virtualization depend on
> PT use EPT.  I will add Intel PT to "Broadwell" CPU model and
> later to make sure a "Broadwell" guest can use Intel PT if the
> host is Ice Lake.

The "if the host is Ice Lake" part is problematic.  On
migration-safe CPU models (all of them except "max" and "host"),
the data seen on CPUID can't depend on the host at all.  It
should depend only on the machine-type + command-line options.

-- 
Eduardo
