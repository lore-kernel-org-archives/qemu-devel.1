Received: from eggs.gnu.org ([2001:4830:134:3::10]:55470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT8oP-0008Nz-VF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT8oL-00063u-Ve
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:39:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fT8oL-000626-P5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:39:53 -0400
Date: Wed, 13 Jun 2018 17:39:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613163950.GK19901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604200701.GB3184@localhost.localdomain>
	<20180604202205.GH5867@char.us.oracle.com>
	<20180613101949.GL27901@redhat.com>
	<20180613160959.GF11438@char.us.oracle.com>
	<20180613162129.GI19901@redhat.com>
	<20180613163421.GB21340@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613163421.GB21340@char.us.oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: define the AMD 'amd-ssbd' CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Wed, Jun 13, 2018 at 12:34:21PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 13, 2018 at 05:21:29PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Jun 13, 2018 at 12:09:59PM -0400, Konrad Rzeszutek Wilk wrote=
:
> > > On Wed, Jun 13, 2018 at 11:19:49AM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > On Mon, Jun 04, 2018 at 04:22:05PM -0400, Konrad Rzeszutek Wilk w=
rote:
> > > > > On Mon, Jun 04, 2018 at 05:07:01PM -0300, Eduardo Habkost wrote=
:
> > > > > > On Fri, Jun 01, 2018 at 11:38:08AM -0400, Konrad Rzeszutek Wi=
lk wrote:
> > > > > > > AMD future CPUs expose _two_ ways to utilize the Intel equi=
valant
> > > > > > > of the Speculative Store Bypass Disable. The first is via
> > > > > > > the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the se=
cond
> > > > > > > is via the SPEC_CTRL MSR (0x48). The document titled:
> > > > > > > 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final=
.pdf
> > > > > > >=20
> > > > > > > gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR=
.
> > > > > > >=20
> > > > > > > A copy of this document is available at
> > > > > > >       https://bugzilla.kernel.org/show_bug.cgi?id=3D199889
> > > > > > >=20
> > > > > > > Anyhow, this means that on future AMD CPUs there will be  _=
two_ ways to
> > > > > > > deal with SSBD.
> > > > > >=20
> > > > > > Does anybody know if there are AMD CPUs where virt-ssbd won't
> > > > > > work and would require amd-ssbd to mitigate vulnerabilities?
> > > > > >=20
> > > > > > Also, do we have kernel arch/x86/kvm/cpuid.c patches, already=
?
> > > > >=20
> > > > > Not yet. They are being discussed right now. I figured I would =
send
> > > > > these patches out as a 'Hey, coming at you!', but failed to cha=
nge
> > > > > the title to be 'RFC'.
> > > > >=20
> > > > > > I prefer to add new CPUID flag names only after the flag name=
 is
> > > > > > already agreed upon on the kernel side.
> > > > >=20
> > > > > Of course. I will respin once that discussion has calmed down.
> > > >=20
> > > > Looks like the kernel side has merged now, and we'll need to rena=
me
> > > > the 2nd CPU bit from what I see.
> > >=20
> > > What name did you have in mind?
> >=20
> > IIUC from the kernel patches, it will be reported as 'amd-ssbd' and
> > 'amd-ssb-no' in /proc/cpuinfo, so only your second patch needs a simp=
le
> > tweak to match that naming.
>=20
> It will only report 'ssbd' but not 'amd-ssb-no' nor 'amd-ssbd'.
>=20
> If the cpufeature.h has "" in the comment section then it is hidden. Th=
at is:
>=20
> #define X86_FEATURE_MSR_SPEC_CTRL       ( 7*32+16) /* "" MSR SPEC_CTRL =
is implemented */
> ..sniup..
> +#define X86_FEATURE_AMD_SSBD           (13*32+24) /* "" Speculative St=
ore Bypass Disable */
> +#define X86_FEATURE_AMD_SSB_NO         (13*32+26) /* "" Speculative St=
ore Bypass is fixed in hardware. */
>=20
> are hidden ones, while:
> #define X86_FEATURE_SSBD                ( 7*32+17) /* Speculative Store=
 Bypass Disable */
>=20
> is visible.

Ah, thanks for explaining that !=20


> The code that finds the AMD_SSBD and sets the 'ssbd' is:
>=20
> +       if (cpu_has(c, X86_FEATURE_AMD_SSBD)) {
> +               set_cpu_cap(c, X86_FEATURE_SSBD);
> +               set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
> +               clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
> +       }
>=20
> Meaning the 'ssbd' will show up in /proc/cpuinfo

Given that, there's no exposed kernel naming we need to align with.

So personally I'd be fine with the current patches that exist, but
I'll defer to Eduardo for the final say, wrt amd-ssb-no vs amd-no-ssb.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
