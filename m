Received: from eggs.gnu.org ([2001:4830:134:3::10]:40765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIxJq-0000B3-OR
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIxJl-0007NM-3w
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:22:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fIxJk-0007Mz-VY
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:22:13 -0400
Date: Wed, 16 May 2018 17:22:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180516172121-mutt-send-email-mst@kernel.org>
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
	<20180417205913.GC29865@localhost.localdomain>
	<02887fa6-d7c8-bc39-6e65-3c3caec5b903@redhat.com>
	<20180419195610.GA29865@localhost.localdomain>
	<98f48c44-e55a-2bd2-0d41-5643f35bce68@redhat.com>
	<20180419215320.GC29865@localhost.localdomain>
	<20180512010007-mutt-send-email-mst@kernel.org>
	<c4f7f4bd-80ce-3d84-fb0d-a7ac22333afd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f7f4bd-80ce-3d84-fb0d-a7ac22333afd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v2] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Wed, May 16, 2018 at 02:44:24PM +0200, Paolo Bonzini wrote:
> On 12/05/2018 00:12, Michael S. Tsirkin wrote:
> >> Maybe it's a better idea than overloading an option that is only
> >> expected to control a CPUID bit.
> > Well -realtime would be a bit confusing in that it enables mlock by
> > default.
> 
> Currently, the only suboption of "-realtime" is mlock, which means that
> the only three valid uses of it are
> 
> 	-realtime mlock=on
> 	-realtime mlock=off
> 	-realtime ''
> 
> We can change the default, I think.  Only the third would change
> meaning, and it's a slightly crazy way to use the option.
> 
> > From pure API point of view, hint-dedicated looks good since
> > it seems to say "optimize for a dedicated host CPU" and
> > it's a hint in that guests keep working if you violate this
> > slightly once in a while.
> > 
> > But I agree there's a problem: right now "kvm-" means "KVM PV"
> > as opposed to e.g. HV enlightened gusts.
> > So if you enable hyperv and also want to disable halt existing,
> > what then? What should kvm-hint-dedicated=on do?
> 
> kvm-hint-dedicated=on only sets the CPUID bit, which Linux for example
> uses that to disable pv spinlocks.  "-realtime dedicated-cpus=on" only
> disables the vmexits.  You can use the two independently.

But when would you want to use the two independently?

> Thanks,
> 
> Paolo
> 
> > So how about a new hint-dedicated=on cpu flag?  We can have that set
> > kvm-hint-dedicated if kvm PV is enabled.
> > 
