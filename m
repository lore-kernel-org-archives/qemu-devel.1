Received: from eggs.gnu.org ([2001:4830:134:3::10]:55485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7lYi-0002g3-5S
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7lYd-0005Hg-Pu
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:40 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7lYd-0005Ea-DO
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:07:35 -0400
Date: Wed, 3 Oct 2018 14:07:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181003180731.GA26376@flamenco>
References: <20181002212921.30982-1-cota@braap.org>
	<20181002212921.30982-3-cota@braap.org> <87h8i3l75j.fsf@linaro.org>
	<a01a9547-d182-daaf-724a-5a836dd9ff02@redhat.com>
	<20181003154844.GA27366@flamenco>
	<91494a20-1090-3e3f-e099-ed06bd6e0e51@redhat.com>
	<20181003170219.GA9925@flamenco>
	<d966f99b-4a37-4a00-0267-50adabb3675f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d966f99b-4a37-4a00-0267-50adabb3675f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Oct 03, 2018 at 19:05:51 +0200, Paolo Bonzini wrote:
> On 03/10/2018 19:02, Emilio G. Cota wrote:
> >> For reads I agree, but you may actually get a torn read if the writer
> >> doesn't use atomic_set.
> >
> > But you cannot get a torn read if all reads that don't hold the lock
> > are coming from the same thread that performed the write.
> 
> Ah, so you are relying on copy_tlb_helper(_locked) being invoked only
> from the vCPU thread (as opposed to someone else doing tlb_flush)?

Yes. tlb_flush_nocheck is always run by the owner thread--tlb_flush
checks for this, and if !qemu_cpu_is_self(cpu) then it schedules
async work on the owner thread.

> Maybe it's worth adding a comment if that's what I missed.

I'll send a v2 with an updated comment and a debug-only assert
in the copy helper.

Thanks,

		E.
