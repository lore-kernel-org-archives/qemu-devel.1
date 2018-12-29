Received: from eggs.gnu.org ([208.118.235.92]:57708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gdGdC-0005A4-Qe
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 10:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gdGRG-0004qx-Rk
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 10:22:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:11904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gdGRG-0004TH-Bq
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 10:22:10 -0500
Date: Sat, 29 Dec 2018 23:26:43 +0800
From: Yang Weijiang <weijiang.yang@intel.com>
Message-ID: <20181229152642.GA6590@localhost.localdomain>
References: <cover.1545806972.git.weijiang.yang@intel.com>
	<30d79c2d6fa0658cd2818c21da852fd4dfeeae1c.1545806972.git.weijiang.yang@intel.com>
	<97d6366b-df95-cf00-d652-3176547ae5ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d6366b-df95-cf00-d652-3176547ae5ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] Add CET SHSTK and IBT CPUID
 feature-word definitions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com, Zhang Yi <yi.z.zhang@linux.intel.com>

On Fri, Dec 28, 2018 at 03:25:10PM +0100, Paolo Bonzini wrote:
Thanks a lot Paolo for the comments!

I'll fix the issue in next version.

> On 26/12/18 09:25, Yang Weijiang wrote:
> > @@ -1233,6 +1252,14 @@ static const ExtSaveArea x86_ext_save_areas[] = {
> >            { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
> >              .offset = offsetof(X86XSaveArea, pkru_state),
> >              .size = sizeof(XSavePKRU) },
> > +    [XSTATE_CET_U_BIT] = {
> > +            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
> > +            .offset = offsetof(X86XSaveArea, cet_u),
> 
> These offsets are incorrect, since supervisor states are only stored in
> the compacted format.  In fact, in patch 4, supervisor states should
> return 0 in CPUID(EAX=0Dh,ECX=n).EBX.
> 
> You can use offset == 0 to distinguish supervisor and user states, so
> that supervisor states are skipped in xsave_area_size and x86_cpu_reset.
> 
> Thanks,
> 
> Paolo
> 
> > +            .size = sizeof(XSaveCETU) },
> > +    [XSTATE_CET_S_BIT] = {
> > +            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
> > +            .offset = offsetof(X86XSaveArea, cet_s),
> > +            .size = sizeof(XSaveCETS) },
> >  };
> >  
> >  static uint32_t xsave_area_size(uint64_t mask)
