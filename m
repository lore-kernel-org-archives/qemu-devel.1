Received: from eggs.gnu.org ([2001:4830:134:3::10]:34630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJiwS-0002rn-Sl
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJiwO-0004kz-T2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:13:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJiwO-0004kl-KJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:13:16 -0400
Date: Fri, 18 May 2018 14:13:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180518171311.GB25013@localhost.localdomain>
References: <1526568841-35372-1-git-send-email-mst@redhat.com>
	<20180517184658.GA1543@localhost.localdomain>
	<20180517225316-mutt-send-email-mst@kernel.org>
	<20180518160431.GX25013@localhost.localdomain>
	<20180518195139-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518195139-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] kvm: rename HINTS_DEDICATED to
 KVM_HINTS_REALTIME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

On Fri, May 18, 2018 at 08:01:49PM +0300, Michael S. Tsirkin wrote:
> On Fri, May 18, 2018 at 01:04:31PM -0300, Eduardo Habkost wrote:
> > CCing qemu-devel, as I'm now discussing userspace.
> > 
> > On Thu, May 17, 2018 at 10:55:33PM +0300, Michael S. Tsirkin wrote:
> > > On Thu, May 17, 2018 at 03:46:58PM -0300, Eduardo Habkost wrote:
> > > > On Thu, May 17, 2018 at 05:54:24PM +0300, Michael S. Tsirkin wrote:
> > > > > HINTS_DEDICATED seems to be somewhat confusing:
> > > > > 
> > > > > Guest doesn't really care whether it's the only task running on a host
> > > > > CPU as long as it's not preempted.
> > > > > 
> > > > > And there are more reasons for Guest to be preempted than host CPU
> > > > > sharing, for example, with memory overcommit it can get preempted on a
> > > > > memory access, post copy migration can cause preemption, etc.
> > > > > 
> > > > > Let's call it KVM_HINTS_REALTIME which seems to better
> > > > > match what guests expect.
> > > > > 
> > > > > Also, the flag most be set on all vCPUs - current guests assume th.
> > > > > Note so in the documentation.
> > > > > 
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  Documentation/virtual/kvm/cpuid.txt  | 6 +++---
> > > > >  arch/x86/include/uapi/asm/kvm_para.h | 2 +-
> > > > >  arch/x86/kernel/kvm.c                | 8 ++++----
> > > > >  3 files changed, 8 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> > > > > index d4f33eb8..ab022dc 100644
> > > > > --- a/Documentation/virtual/kvm/cpuid.txt
> > > > > +++ b/Documentation/virtual/kvm/cpuid.txt
> > > > > @@ -72,8 +72,8 @@ KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
> > > > >  
> > > > >  flag                               || value || meaning
> > > > >  ==================================================================================
> > > > > -KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit to
> > > > > -                                   ||       || determine if there is vCPU pinning
> > > > > -                                   ||       || and there is no vCPU over-commitment,
> > > > > +KVM_HINTS_REALTIME                 ||     0 || guest checks this feature bit to
> > > > > +                                   ||       || determine that vCPUs are never
> > > > > +                                   ||       || preempted for an unlimited time,
> > > > >                                     ||       || allowing optimizations
> > > > 
> > > > My understanding of the original patch is that the intention is
> > > > to tell the guest that it is very unlikely to be preempted,
> > > > so it
> > > > can choose a more appropriate spinlock implementation.  This
> > > > description implies that the guest will never be preempted, which
> > > > is much stronger guarantee.
> > > 
> > > Note:
> > > 
> > > ...  for an unlimited time.
> > 
> > Which still sounds like a stronger guarantee than the original
> > description.  But:
> > 
> > > 
> > > > 
> > > > Isn't this new description incompatible with existing usage of
> > > > the hint, which might include people who just use vCPU pinning
> > > > but no mlock?
> > > 
> > > Without mlock you should always use pv spinlocks.
> > > 
> > > Otherwise you risk blocking on a lock taken by
> > > a VCPU that is in turn blocked on IO, where the IO
> > > is not completing because CPU is being used up
> > > spinning.
> > 
> > So the stronger guarantee seems necessary.
> > 
> > Now what should host userspace do if the user is trying to run an
> > existing configuration where the CPUID hint was set but memory is
> > not pinned?
> 
> As much as we'd like to be helpful and validate input, you need a real
> time host too. I'm not sure how we'd find out - I suggest we do not
> bother for now.

I'm worried that people will start enabling the flag in all kinds
of scenarios where the guarantees can't be kept, and make the
meaning of the flag in practice completely different from its
documented meaning.

So I'd like to either detect cases where it's obviously wrong to
enable the flag, or document the requirements very clearly on
QEMU documentation.

-- 
Eduardo
