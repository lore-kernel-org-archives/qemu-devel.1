Received: from eggs.gnu.org ([2001:4830:134:3::10]:42487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dz2lo-0008OO-Sq
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dz2ln-0006ly-Gj
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:36:36 -0400
Received: from mail-yw0-x22f.google.com ([2607:f8b0:4002:c05::22f]:49628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dz2ln-0006kI-C5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:36:35 -0400
Received: by mail-yw0-x22f.google.com with SMTP id x64so3750131ywe.6
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 08:36:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <a53dca17-d9c2-d721-d71d-6cacb8481223@gmx.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9326d662-0b0f-69bd-10f4-307661718525@twiddle.net>
Date: Mon, 2 Oct 2017 11:36:31 -0400
MIME-Version: 1.0
In-Reply-To: <a53dca17-d9c2-d721-d71d-6cacb8481223@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-hppa first steps
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
List-ID: <qemu-devel.nongnu.org>

On 10/01/2017 04:27 PM, Helge Deller wrote:
> What I'm absolutely missing knowledge in is the emulation code in
> qemu to really be able to emulate the missing hppa assembler instructions.
> For example, the space registers, some other PSW bits, and so on.

[CC-ing the list for posterity]

For emulating system, I believe that we will require TARGET_LONG_BITS == 64
(even for pa1.1), and make our space registers 32 bits wide (even for pa2.0).
Thus we will always have a 64-bit virtual address space and never (as is
architecturally allowable) a 96-bit virtual address space.

There may be clever things we can do with mmu_idx to speed things up for
running Linux, which makes very little use of space registers.  However to
begin let us open-code exactly what the hardware does and afterward see what
needs to be optimized:

  pa1.1 or pa2.0 with psw.w=0:
	gva = space{0:31} : offset{0:31}
            = (space << 32) | (offset & 0x0000_0000_ffff_ffff)

  pa2.0 with psw.w=1:
	gva = space{0:1} : (space{2:31} | offset{2:31}) : offset{32:63}
            = (space << 32) | (offset & 0x3fff_ffff_ffff_ffff)

We may want to store the space registers in env pre-shifted as a uint64_t to
minimize the operations required to compute the GVA at runtime.

You'll want helper functions to compute this both directly in C and with TCG
operations for the translator.  They'd be no-ops for -linux-user.

Implementing the space registers themselves should be straight-forward.  There
are comments in many (most?) of the places that should be modified.  Take care
to leave -linux-user unmodified.

Let's take the rest case-by-case as it comes up?


r~
