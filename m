Received: from eggs.gnu.org ([2001:4830:134:3::10]:48750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjaf-0003sn-29
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjaa-0004CD-F4
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:43:41 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVjaa-0004C5-AU
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:43:36 -0500
Received: by mail-qt0-x243.google.com with SMTP id l7so19277237qtd.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:43:36 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
	<4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
	<alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
	<7178d6dd-4252-ad60-e1f0-51acffcd393c@twiddle.net>
	<d3ca01a3-b8ed-93fd-235a-bd9b3adad838@ispras.ru>
	<7f9b740e-20d5-2a6e-eaba-ffef5851e754@twiddle.net>
	<alpine.DEB.2.11.1701231246360.2026@bulbul.intra.ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0b0b1136-ada6-f30e-a6b9-90263d55e7da@twiddle.net>
Date: Mon, 23 Jan 2017 10:43:31 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1701231246360.2026@bulbul.intra.ispras.ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/18] tcg: add support for 128bit vector
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 01/23/2017 02:30 AM, Kirill Batuzov wrote:
> Because 4 adds on 4 i32 registers work good only when the size of
> vector elements matches the size of scalar variables we use for
> representation of a vector. add_i16x8 will not be that great if we use
> 4 i32 variables: each will need to be split into two values, processed
> independently and merged back afterwards.

Certainly.  But that's pretty much exactly how they are processed now.  Usually
via a helper function that accepts an i64 input as a pair of i32 arguments.

> Scalar variables lack primitives to work with them as vectors of shorter
> values. This is one of the reasons I added v64 type instead of using i64
> for 64-bit vector operations. And this is the reason I'm so opposed to
> using them to represent vector types if vector registers are not
> supported by host. Handling vector operations with element size that
> does not match representation will be complicated, may require special
> handling for different operations and will produce a lot of if-s in code.

A lot of if's?  I've no idea what you're talking about.

A v64 type makes sense because generally we're going to allocate them to a
different register set than i64.  That said, i64 is perfectly adequate for
implementing add_i8x8:

  t0  = in1 & 0x7f7f7f7f7f7f7f7f
  t1  = in0 + t0;
  t2  = in1 & 0x8080808080808080
  out = t1 ^ t2

This is less expensive than addition by pieces if there are at least 4 pieces.

> The method I'm proposing can handle any operation regardless of
> representation. This includes handling situation where host supports
> vector registers but does not support required operation (for example 
> SSE/AVX does not support multiplication of vectors of 8-bit values).

Not for nothing but it's trivial to expand with punpcklbw, punpckhbw, pmullw,
pand, packuswb.  That said, if an expansion gets too complicated, it's still
better to move it into a helper than expand 16 * (load, op, store).


r~
