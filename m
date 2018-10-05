Received: from eggs.gnu.org ([2001:4830:134:3::10]:47428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8MS0-0001qa-AS
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8MFP-0003EB-9I
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:18:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8MFP-0003Dw-4p
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:18:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id p23so391032otf.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 02:18:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005084835.GB2285@work-vm>
References: <cover.1537868529.git.manish.jaggi@cavium.com>
	<CAFEAcA-_5MzdykGKja1sJggx2QVOUXT69NF-Ya2sE8RZFu53fA@mail.gmail.com>
	<20181004150522.sr2woe74vdlpo52k@kamzik.brq.redhat.com>
	<CAFEAcA_JfsuFknwTs=Mq1=A+WoSJSdYnC3NUZxQiuS=jdg0FfA@mail.gmail.com>
	<20181005084835.GB2285@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 10:17:50 +0100
Message-ID: <CAFEAcA-FuXeqp7LvuzSArh7TXYHm8WR18QOPD8VsubpnWP=+1w@mail.gmail.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, mjaggi@caviumnetworks.com, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "Nowicki,
	Tomasz" <Tomasz.Nowicki@cavium.com>

On 5 October 2018 at 09:48, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 4 October 2018 at 16:05, Andrew Jones <drjones@redhat.com> wrote:
>> > On Tue, Oct 02, 2018 at 02:07:38PM +0100, Peter Maydell wrote:
>> >> Hi; thanks for this patch. The issue I see with this patch
>> >> is that the KVM/ARM QEMU approach to system registers so far
>> >> has been "the kernel knows about these and it is in control".
>> >> So we ask the kernel for the list of registers, and just save
>> >> and restore those. That would suggest that if there are sysregs
>> >> where it's OK in fact to ignore a difference between two constant
>> >> register values, it should be the kernel doing the "actually, this
>> >> mismatch is OK" behaviour...
>> >
>> > I don't think the kernel should have to maintain all that logic. If a user
>> > wants to load guest registers, then the kernel should do it, as long as
>> > it's safe from the host's integrity/security PoV, and the hardware would
>> > actually support it. Anything that can only break the guest, but not the
>> > host, should be allowed. The KVM userspace can certainly ask the kernel
>> > what it recommends first (i.e. read the invariant registers first, before
>> > deciding what to write), but the decision of what to write should be left
>> > up to the user.
>>
>> I can see the logic of that approach. But right now QEMU
>> userspace knows basically nothing about the system registers
>> when we're using KVM: all that knowledge is in the kernel.
>> So we don't have a place really to put policy info (and
>> not really anywhere to put policy info that depends on the
>> host CPU type when mostly we let the kernel care about that).
>
> It would seem wrong to put this logic in the kernel because the
> priviliged code should be as small as possible.

Agreed. But if we want to move to "QEMU knows about all the
possible host CPUs" that's a fair-sized design change and
needs more than the minimalist approach this patch has.

thanks
-- PMM
