Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cVbtd-0003Bs-Fw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cVbtY-0006ii-Gq
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:30:45 -0500
Received: from bran.ispras.ru ([83.149.199.196]:57850 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cVbtY-0006hq-4X
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:30:40 -0500
Date: Mon, 23 Jan 2017 13:30:37 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <7f9b740e-20d5-2a6e-eaba-ffef5851e754@twiddle.net>
Message-ID: <alpine.DEB.2.11.1701231246360.2026@bulbul.intra.ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
	<4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
	<alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
	<7178d6dd-4252-ad60-e1f0-51acffcd393c@twiddle.net>
	<d3ca01a3-b8ed-93fd-235a-bd9b3adad838@ispras.ru>
	<7f9b740e-20d5-2a6e-eaba-ffef5851e754@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Sat, 21 Jan 2017, Richard Henderson wrote:

> On 01/19/2017 08:54 AM, Kirill Batuzov wrote:
> > 
> > Wrappers issue emulation code instead of operation if it is not supported by
> > host.
> > 
> > tcg_gen_add_i32x4 looks like this:
> > 
> > if (TCG_TARGET_HAS_add_i32x4) {
> >     tcg_gen_op3_v128(INDEX_op_add_i32x4, args[0], args[1], args[2]);
> > } else {
> >     for (i = 0; i < 4; i++) {
> >         tcg_gen_ld_i32(...);
> >         tcg_gen_ld_i32(...);
> >         tcg_gen_add_i32(...);
> >         tcg_gen_st_i32(...);
> >     }
> > }
> 
> To me that begs the question of why you wouldn't issue 4 adds on 4 i32
> registers instead.
>

Because 4 adds on 4 i32 registers work good only when the size of
vector elements matches the size of scalar variables we use for
representation of a vector. add_i16x8 will not be that great if we use
4 i32 variables: each will need to be split into two values, processed
independently and merged back afterwards. And when we create variable we
do not know which operations will be performed on it.

Scalar variables lack primitives to work with them as vectors of shorter
values. This is one of the reasons I added v64 type instead of using i64
for 64-bit vector operations. And this is the reason I'm so opposed to
using them to represent vector types if vector registers are not
supported by host. Handling vector operations with element size that
does not match representation will be complicated, may require special
handling for different operations and will produce a lot of if-s in code.

The method I'm proposing can handle any operation regardless of
representation. This includes handling situation where host supports
vector registers but does not support required operation (for example 
SSE/AVX does not support multiplication of vectors of 8-bit values).

-- 
Kirill
