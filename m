Received: from eggs.gnu.org ([2001:4830:134:3::10]:44294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1cyJLV-0004S0-Im
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1cyJLU-0002v9-Jv
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:34:09 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jmattson@google.com>) id 1cyJLU-0002tr-Dc
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:34:08 -0400
Received: by mail-wr0-x22a.google.com with SMTP id o21so18793948wrb.2
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 07:34:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4622E361-52AB-40F2-9915-45C48F0DBCD2@suse.de>
References: <1491911135-216950-1-git-send-email-agraf@suse.de>
	<CALMp9eT220btgiw7S-0cLswr1j=-OCuMwOAWuWS51EmNYYRuJw@mail.gmail.com>
	<4622E361-52AB-40F2-9915-45C48F0DBCD2@suse.de>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 12 Apr 2017 07:34:06 -0700
Message-ID: <CALMp9eR7AWETNZA1pSBXW2BWcrJXPk-Y1hbNvwu2Vq7Dkf6AjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: kvm list <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Gabriel L. Somlo" <gsomlo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

Actually, we have rejected commit 87c00572ba05aa8c ("kvm: x86: emulate
monitor and mwait instructions as nop"), so when we intercept
MONITOR/MWAIT, we synthesize #UD. Perhaps it is this difference from
vanilla kvm that motivates the following idea...

Since we're still not going to report MONITOR support in CPUID, the
only guests of consequence are paravirtual guests. What if a
paravirtual guest was aware of the fact that sometimes MONITOR/MWAIT
would work as architected, and sometimes they would raise #UD (or do
something else that's guest-visible, to indicate that the hypevisor is
intercepting the instructions). Such a guest could first try a
MONITOR/MWAIT-based idle loop and then fall back on a HLT-based idle
loop if the hypervisor rejected its use of MONITOR/MWAIT.

We already have the loose concept of "this pCPU has other things to
do," which is encoded in the variable-sized PLE window. With
MONITOR/MWAIT, the choice is binary, but a simple implementation could
tie the two together, by allowing the guest to use MONITOR/MWAIT
whenever the PLE window exceeds a certain threshold. Or the decision
could be left to the userspace agent.

On Tue, Apr 11, 2017 at 11:23 AM, Alexander Graf <agraf@suse.de> wrote:
>
>
>> Am 11.04.2017 um 19:10 schrieb Jim Mattson <jmattson@google.com>:
>>
>> This might be more useful if it could be dynamically toggled on and
>> off, depending on system load.
>
> What would trapping mwait (currently) buy you?
>
> As it stands today, before this patch, mwait is simply implemented as a nop, so enabling the trap just means you're wasting as much cpu time, but never send the pCPU idle. With this patch, the CPU at least has the chance to go idle.
>
> Keep in mind that this patch does *not* advertise the mwait cpuid feature bit to the guest.
>
> What you're referring to I guess is actual mwait emulation. That is indeed more useful, but a bigger patch than this and needs some more thought on how to properly cache the monitor'ed pages.
>
>
> Alex
>
>
