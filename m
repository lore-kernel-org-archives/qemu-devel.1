Received: from eggs.gnu.org ([2001:4830:134:3::10]:52037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g85Wx-0006BJ-66
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g85Ww-00016B-F3
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:27:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g85Wv-000146-UD
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:27:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id e21-v6so9556925otk.10
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 08:27:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181004150522.sr2woe74vdlpo52k@kamzik.brq.redhat.com>
References: <cover.1537868529.git.manish.jaggi@cavium.com>
	<CAFEAcA-_5MzdykGKja1sJggx2QVOUXT69NF-Ya2sE8RZFu53fA@mail.gmail.com>
	<20181004150522.sr2woe74vdlpo52k@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Oct 2018 16:26:47 +0100
Message-ID: <CAFEAcA_JfsuFknwTs=Mq1=A+WoSJSdYnC3NUZxQiuS=jdg0FfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] [PATCH 0/3] qemu: arm: Migration between
 machines with different MIDR values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: mjaggi@caviumnetworks.com, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Jaggi,
	Manish" <Manish.Jaggi@cavium.com>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>

On 4 October 2018 at 16:05, Andrew Jones <drjones@redhat.com> wrote:
> On Tue, Oct 02, 2018 at 02:07:38PM +0100, Peter Maydell wrote:
>> Hi; thanks for this patch. The issue I see with this patch
>> is that the KVM/ARM QEMU approach to system registers so far
>> has been "the kernel knows about these and it is in control".
>> So we ask the kernel for the list of registers, and just save
>> and restore those. That would suggest that if there are sysregs
>> where it's OK in fact to ignore a difference between two constant
>> register values, it should be the kernel doing the "actually, this
>> mismatch is OK" behaviour...
>
> I don't think the kernel should have to maintain all that logic. If a user
> wants to load guest registers, then the kernel should do it, as long as
> it's safe from the host's integrity/security PoV, and the hardware would
> actually support it. Anything that can only break the guest, but not the
> host, should be allowed. The KVM userspace can certainly ask the kernel
> what it recommends first (i.e. read the invariant registers first, before
> deciding what to write), but the decision of what to write should be left
> up to the user.

I can see the logic of that approach. But right now QEMU
userspace knows basically nothing about the system registers
when we're using KVM: all that knowledge is in the kernel.
So we don't have a place really to put policy info (and
not really anywhere to put policy info that depends on the
host CPU type when mostly we let the kernel care about that).

>> For instance, it's probably OK to ignore a MIDR_EL1 difference
>> that just indicates a minor revision bump; but not to ignore
>> one that indicates you just tried to migrate a Cortex-A53
>> over to a Cavium CPU.
>
> If the user does that, then the guest will break - oh well. That's not the
> host kernel's problem.

Patching QEMU to ignore all attempts to write wrong values
to read-only registers would be easy. It just wouldn't
be very helpful to the user...

thanks
-- PMM
