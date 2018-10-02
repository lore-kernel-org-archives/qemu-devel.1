Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7ETq-0007ca-Jg
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 02:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7ETn-0007vl-EQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 02:48:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g7ETn-0007vQ-09
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 02:48:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id a13-v6so793457wrt.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 23:48:22 -0700 (PDT)
References: <20180919175423.GA25553@flamenco> <87va71uijc.fsf@linaro.org>
	<20181001183423.GA27555@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181001183423.GA27555@flamenco>
Date: Tue, 02 Oct 2018 07:48:20 +0100
Message-ID: <87k1n0lu8b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ideas for improving TLB performance (help with TCG
 backend wanted)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Sep 20, 2018 at 01:19:51 +0100, Alex Benn=C3=A9e wrote:
>> If we are going to have an indirection then we can also drop the
>> requirement to scale the TLB according to the number of MMU indexes we
>> have to support. It's fairly wasteful when a bunch of them are almost
>> never used unless you are running stuff that uses them.
>
> So with dynamic TLB sizing, what you're suggesting here is to resize
> each MMU array independently (depending on their use rate) instead
> of using a single "TLB size" for all MMU indexes. Am I understanding
> your point correctly?

Not quite - I think it would overly complicate the lookup to have a
differently sized TLB lookup for each mmu index - even if their usage
patterns are different.

I just meant that if we already have the cost of an indirection we don't
have to ensure:

    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];
    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];

restrict their sizes so any entry in the 2D array can be indexed
directly from env. Currently CPU_TLB_SIZE/CPU_TLB_BITS is restricted by
the number of NB_MMU_MODES we have to support. But if each can be
flushed and managed separately we can have:

    CPUTLBEntry *tlb_table[NB_MMU_MODES];

And size CPU_TLB_SIZE for the maximum offset we can mange in the lookup
code. This is mainly driven by the varying
TCG_TARGET_TLB_DISPLACEMENT_BITS each backend has available to it.

>
> Thanks,
>
> 		E.


--
Alex Benn=C3=A9e
