Received: from eggs.gnu.org ([2001:4830:134:3::10]:39922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ePuma-0000vX-HP
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ePumW-0003Np-Gc
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:32:28 -0500
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:34833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ePumW-0003ML-0q
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:32:24 -0500
Received: by mail-it0-x236.google.com with SMTP id f143so21086312itb.0
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:32:23 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA_ZQmkJ0QLCaL=sehc6bvS=yDWtsDGd=wdwZBoePEp9Vg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9461c78b-2d1a-3cc0-18e1-e58d7eb51fe7@twiddle.net>
Date: Fri, 15 Dec 2017 12:32:20 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZQmkJ0QLCaL=sehc6bvS=yDWtsDGd=wdwZBoePEp9Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MTTCG and atomicity of loads and stores from QEMU
 C helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>

On 12/15/2017 12:14 PM, Peter Maydell wrote:
> We have a fair amount of code in QEMU which is helper functions
> written in C which make guest memory accesses -- the most common
> case being page table walk code.
> 
> Generally in CPU architectures the accesses by things like the
> page table walker have some atomicity guarantees. For instance
> Arm requires that reads of translation tables are single-copy-atomic
> (v8A Arm ARM rev B.a section B2.2.1). If we supported the
> hardware management of the Access flag (we don't currently) that
> wolud have to be an atomic read-modify-write of the descriptor
> memory (section D4.4.9).
> 
> What's the right API in QEMU to do these guest memory accesses with
> the required atomicity guarantees?

We don't have one, really.

> Currently target/arm uses
> address_space_ldq_le(), which turns into a ldq_he_p(), which is
> a memcpy(), which I don't think is guaranteed to be a 64-bit load.

There are conflicting goals here.  ldq_he_p needs to handle unaligned loads
(which would not be single-copy atomic on any host or guest).

We have also been relying on the compiler to turn a small, fixed size memcpy
into a single instruction on a host that itself supports unaligned loads.
Which happens to be true for x86, armv7, aa64, ppc64, s390x -- i.e. all
supported hosts besides mips and old aa32.

But we can't have it both ways.  We would need separate interfaces to specify
atomic or unaligned, but we can't do both at the same time.

> And I don't think we have an accessor function for doing an atomic
> read-modify-write, do we?

No.  There are some softmmu tcg helpers, but there are no user-only helpers
with the same function signature (there are some case-by-case ifdefs within
target/* to make up for this).  Nor are there accessors for doing atomic rmw on
physical addresses.

There is lots to clean up in this area and it needs some real thought.


r~
