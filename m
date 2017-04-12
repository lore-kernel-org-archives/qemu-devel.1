Received: from eggs.gnu.org ([2001:4830:134:3::10]:51243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyL9G-0005uP-6W
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 12:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyL9C-0003Rp-7b
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 12:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cyL9B-0003RT-V3
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 12:29:34 -0400
Date: Wed, 12 Apr 2017 19:29:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170412185249-mutt-send-email-mst@kernel.org>
References: <1491911135-216950-1-git-send-email-agraf@suse.de>
	<CALMp9eT220btgiw7S-0cLswr1j=-OCuMwOAWuWS51EmNYYRuJw@mail.gmail.com>
	<4622E361-52AB-40F2-9915-45C48F0DBCD2@suse.de>
	<CALMp9eR7AWETNZA1pSBXW2BWcrJXPk-Y1hbNvwu2Vq7Dkf6AjA@mail.gmail.com>
	<204f274d-697d-f9c6-8719-9bf91105f8b9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204f274d-697d-f9c6-8719-9bf91105f8b9@suse.de>
Subject: Re: [Qemu-devel] [PATCH v6] kvm: better MWAIT emulation for guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: Jim Mattson <jmattson@google.com>, kvm list <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Gabriel L. Somlo" <gsomlo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

On Wed, Apr 12, 2017 at 04:54:10PM +0200, Alexander Graf wrote:
> 
> 
> On 12.04.17 16:34, Jim Mattson wrote:
> > Actually, we have rejected commit 87c00572ba05aa8c ("kvm: x86: emulate
> > monitor and mwait instructions as nop"), so when we intercept
> > MONITOR/MWAIT, we synthesize #UD. Perhaps it is this difference from
> > vanilla kvm that motivates the following idea...
> 
> So you're not running upstream kvm? In that case, you can just not take this
> patch either :).
> 
> > Since we're still not going to report MONITOR support in CPUID, the
> > only guests of consequence are paravirtual guests. What if a
> 
> Only if someone actually implemented something for PV guests, yes.
> 
> The real motivation is to allow user space to force set the MONITOR CPUID
> flag. That way an admin can - if he really wants to - dedicate pCPUs to the
> VM.
> 
> I agree that we don't need the kvm pv flag for that. I'd be happy to drop
> that if everyone agrees.

I don't really agree we do not need the PV flag. mwait on kvm is
different from mwait on bare metal in that you are heavily penalized by
scheduler for polling unless you configure the host just so.
HLT lets you give up the host CPU if you know you won't need
it for a long time.

So while many people can get by with monitor cpuid (those that isolate
host CPUs) and it's a valuable option to have, I think a PV flag is also
a valuable option and can be set for more configurations.

Guest has an idle driver calling mwait on short waits and halt on longer
ones.  I'm in fact testing an idle driver using such a PV flag and will
post when ready (after vacation ~3 weeks from now probably).

> > paravirtual guest was aware of the fact that sometimes MONITOR/MWAIT
> > would work as architected, and sometimes they would raise #UD (or do
> > something else that's guest-visible, to indicate that the hypevisor is
> > intercepting the instructions). Such a guest could first try a
> > MONITOR/MWAIT-based idle loop and then fall back on a HLT-based idle
> > loop if the hypervisor rejected its use of MONITOR/MWAIT.
> 
> How would that work? That guest would have to atomically notify all other
> vCPUs that wakeup notifications now go via IPIs instead of cache line
> dirtying.
> 
> That's probably as much work to get right as it would be to just emulate
> MWAIT inside kvm ;).
> 
> > We already have the loose concept of "this pCPU has other things to
> > do," which is encoded in the variable-sized PLE window. With
> > MONITOR/MWAIT, the choice is binary, but a simple implementation could
> > tie the two together, by allowing the guest to use MONITOR/MWAIT
> > whenever the PLE window exceeds a certain threshold. Or the decision
> > could be left to the userspace agent.
> 
> I agree, and that's basically the idea I mentioned earlier with MWAIT
> emulation. We could (for well behaved guests) switch between emulating MWAIT
> and running native MWAIT.
> 
> 
> 
> Alex
