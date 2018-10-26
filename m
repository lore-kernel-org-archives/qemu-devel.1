Received: from eggs.gnu.org ([2001:4830:134:3::10]:34506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFxdg-0004AV-75
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFxda-0006G3-Cm
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:38:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gFxdZ-0006EJ-Mn
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:38:34 -0400
Date: Fri, 26 Oct 2018 05:38:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181026083830.GM4096@habkost.net>
References: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
	<1539578845-37944-4-git-send-email-robert.hu@linux.intel.com>
	<20181024100612.GD4096@habkost.net>
	<1540522885.9361.1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1540522885.9361.1.camel@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/3] x86: define a new MSR based feature
 word -- FEATURE_WORDS_ARCH_CAPABILITIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: robert.hu@intel.com, pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org

On Fri, Oct 26, 2018 at 11:01:25AM +0800, Robert Hoo wrote:
> On Wed, 2018-10-24 at 07:06 -0300, Eduardo Habkost wrote:
> > On Mon, Oct 15, 2018 at 12:47:25PM +0800, Robert Hoo wrote:
> > > Note RSBA is specially treated -- no matter host support it or not,
> > > qemu
> > > pretends it is supported.
> > >=20
> > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> >=20
> > I am now wondering what else we need to be able to remove
> > CPUID_7_0_EDX_ARCH_CAPABILITIES from
> > feature_word_info[FEAT_7_0_EDX].unmigratable_flags.
> >=20
> > This series is necessary for that, be I think we still can't let
> > the VM be migrated if arch-capabilities is enabled and we're
> > running on a host that doesn't have MSR_IA32_ARCH_CAPABILITIES on
> > kvm_feature_msrs.
> >=20
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >=20
> > > ---
> > > =A0target/i386/cpu.c | 31 ++++++++++++++++++++++++++++++-
> > > =A0target/i386/cpu.h |=A0=A08 ++++++++
> > > =A0target/i386/kvm.c | 11 +++++++++++
> > > =A03 files changed, 49 insertions(+), 1 deletion(-)
> > >=20
> [...]
> > > =A0
> > > =A0typedef struct X86RegisterInfo32 {
> > > @@ -3696,7 +3717,15 @@ static uint32_t
> > > x86_cpu_get_supported_feature_word(FeatureWord w,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0wi-
> > > >cpuid.reg);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0case MSR_FEATURE_WORD:
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r =3D kvm_arch_get_supported_m=
sr_feature(kvm_state, wi-
> > > >msr.index);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Special case:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* No matter host status, IA=
32_ARCH_CAPABILITIES.RSBA
> > > [bit 2]
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* is always supported in gu=
est.
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (wi->msr.index =3D=3D MSR_I=
A32_ARCH_CAPABILITIES) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r =3D MSR_ARCH_CAP=
_RSBA;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r |=3D kvm_arch_get_supported_=
msr_feature(kvm_state,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0wi->msr.index);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> After I add the filtering out MSR feature, whose CPUID dependency fails
> , in x86_cpu_filter_features(), 1 issue comes out here:=20
>=20
> If running on an old platform that doesn't have ARCH_CAPABILITIES MSR,
> but we still pretends it here, then qemu will always print out
> "warning: host doesn't support requested feature: MSR(10AH).rsba [bit
> 2]", with -cpu 'host', which does not look comfortable.
> How about remove this hunk for now? leave it to when we fully decide
> how to handle ARCH_CAPABILITIES live-migration safely.=20

I will remove that hunk in x86-next, thanks for noting!

--=20
Eduardo
