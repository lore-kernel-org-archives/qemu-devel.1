Received: from eggs.gnu.org ([2001:4830:134:3::10]:54787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrewoates@gmail.com>) id 1friWb-0004Ax-D1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrewoates@gmail.com>) id 1friQ7-0004iS-M3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:32:32 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrewoates@gmail.com>)
	id 1friQ7-0004gO-Hn
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:32:27 -0400
Received: by mail-ua1-f66.google.com with SMTP id q12-v6so9506917ual.2
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 04:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180816011903.39816-1-andrew@andrewoates.com>
	<b45d87b9-38ac-427a-8622-ac9c49350511@redhat.com>
	<CAAVLcG6m_x2p4r9dqD6B2qG-Z_G_iTh5rAubS44PRM2-Mqnpkw@mail.gmail.com>
	<f3c28dc7-a16e-1451-5bb6-090c6e13cf84@redhat.com>
In-Reply-To: <f3c28dc7-a16e-1451-5bb6-090c6e13cf84@redhat.com>
From: Andrew Oates <andrew@andrewoates.com>
Date: Mon, 20 Aug 2018 07:32:13 -0400
Message-ID: <CAAVLcG6yDfYTVSmWa1Fdw=C6guhMczRFMkU4vAxUaL6ibTAvPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-i386: fix segment limit check in
 ljmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, Andrew Oates <aoates@google.com>

On Mon, Aug 20, 2018 at 6:06 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/08/2018 20:04, Andrew Oates wrote:
> >>> [1] this is an invalid configuration (in protected mode the L bit is
> >>> reserved and should be set to zero), but qemu doesn't enforce that.
> >
> > Is there a central place to do that sort of validation?  We could do it
> > in load_segment_ra, but that doesn't feel quite right.  Otherwise it's
> > whack-a-mole to check validity at every place a code segment is
> > referenced---but maybe that's ok, there probably aren't too many of them.
> >
> > WDYT?
>
> To find them you have to look for the calls to cpu_x86_load_seg_cache.
>
> However, the L bit is simply ignored in the descriptor cache outside
> 64-bit mode (at least that's what you can guess from the Intel manual's
> 26.3 CHECKING AND LOADING GUEST STATE, which is as close as you can get
> to an official explanation of the descriptor cache), so you'd have to
> take that into account too and do the check in the callers of
> cpu_x86_load_seg_cache.
>
> And in fact, the wording is a bit wishy-washy in both the Intel and AMD
> manuals, for example AMD says of bit 21 that
>
>         Generally, software should clear all reserved bits to 0, so they
>         can be defined in future revisions to the AMD64 architecture.
>
> so I am not 100% sure that the processor will actually raise an
> exception if L is 1.

That's good enough for me :)  My vote would be to continue to ignore
the L bit in 32-bit mode, then.  We should just remove the part that
implies qemu should enforce it from my patch commit message.

>
> Thanks,
>
> Paolo
