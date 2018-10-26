Received: from eggs.gnu.org ([2001:4830:134:3::10]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gFsa9-00027H-8l
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 23:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gFsNZ-000174-2i
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 23:01:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:64952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gFsNX-0000xl-Ts
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 23:01:40 -0400
Message-ID: <1540522885.9361.1.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Fri, 26 Oct 2018 11:01:25 +0800
In-Reply-To: <20181024100612.GD4096@habkost.net>
References: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
	<1539578845-37944-4-git-send-email-robert.hu@linux.intel.com>
	<20181024100612.GD4096@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org

On Wed, 2018-10-24 at 07:06 -0300, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 12:47:25PM +0800, Robert Hoo wrote:
> > Note RSBA is specially treated -- no matter host support it or not,
> > qemu
> > pretends it is supported.
> > 
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> 
> I am now wondering what else we need to be able to remove
> CPUID_7_0_EDX_ARCH_CAPABILITIES from
> feature_word_info[FEAT_7_0_EDX].unmigratable_flags.
> 
> This series is necessary for that, be I think we still can't let
> the VM be migrated if arch-capabilities is enabled and we're
> running on a host that doesn't have MSR_IA32_ARCH_CAPABILITIES on
> kvm_feature_msrs.
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> > ---
> >  target/i386/cpu.c | 31 ++++++++++++++++++++++++++++++-
> >  target/i386/cpu.h |  8 ++++++++
> >  target/i386/kvm.c | 11 +++++++++++
> >  3 files changed, 49 insertions(+), 1 deletion(-)
> > 
[...]
> >  
> >  typedef struct X86RegisterInfo32 {
> > @@ -3696,7 +3717,15 @@ static uint32_t
> > x86_cpu_get_supported_feature_word(FeatureWord w,
> >                                                          wi-
> > >cpuid.reg);
> >              break;
> >          case MSR_FEATURE_WORD:
> > -            r = kvm_arch_get_supported_msr_feature(kvm_state, wi-
> > >msr.index);
> > +            /* Special case:
> > +             * No matter host status, IA32_ARCH_CAPABILITIES.RSBA
> > [bit 2]
> > +             * is always supported in guest.
> > +             */
> > +            if (wi->msr.index == MSR_IA32_ARCH_CAPABILITIES) {
> > +                r = MSR_ARCH_CAP_RSBA;
> > +            }
> > +            r |= kvm_arch_get_supported_msr_feature(kvm_state,
> > +                        wi->msr.index);
> >              break;
After I add the filtering out MSR feature, whose CPUID dependency fails
, in x86_cpu_filter_features(), 1 issue comes out here: 

If running on an old platform that doesn't have ARCH_CAPABILITIES MSR,
but we still pretends it here, then qemu will always print out
"warning: host doesn't support requested feature: MSR(10AH).rsba [bit
2]", with -cpu 'host', which does not look comfortable.
How about remove this hunk for now? leave it to when we fully decide
how to handle ARCH_CAPABILITIES live-migration safely. 
> >          }
> >      } else if (hvf_enabled()) {
[...]
