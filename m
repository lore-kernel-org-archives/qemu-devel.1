Received: from eggs.gnu.org ([2001:4830:134:3::10]:53382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sorear2@gmail.com>) id 1daGFA-0001Ns-9v
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sorear2@gmail.com>) id 1daGF9-0006y7-Dw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:56:28 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:35984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sorear2@gmail.com>) id 1daGF9-0006xQ-9E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:56:27 -0400
Received: by mail-qt0-x22d.google.com with SMTP id v29so20873163qtv.3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 23:56:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMU+Ekyxu9rwJ4s8xCGb87cSexfGweTmQ_Q7smLVWxjmbVqu_Q@mail.gmail.com>
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
	<CAMU+Ekyxu9rwJ4s8xCGb87cSexfGweTmQ_Q7smLVWxjmbVqu_Q@mail.gmail.com>
From: "Stefan O'Rear" <sorear2@gmail.com>
Date: Tue, 25 Jul 2017 23:56:24 -0700
Message-ID: <CADJ6UvPmrw1zPgbsFUpF6-_KjrkCj-wJnk04ou292TLOrwv0ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [sw-dev] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Hoult <bruce@hoult.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jul 25, 2017 at 9:37 AM, Bruce Hoult <bruce@hoult.org> wrote:
> Do you have any good estimates for how much of the execution time is
> typically spent in instruction decode?
>
> RISC-V qemu is twice as fast as ARM or Aarch64 qemu, so it's doing something
> right!
>
> (I suspect it's probably mostly the lack of needing to emulate condition
> codes)

The last time I tried to profile qemu (system mode, running the Go
bootstrap, I think), I didn't get very far because no jit-map and I
wasn't able to get frame pointers working, but as far as I got none of
the translate functions showed up.

Most time spent in translated code, trampolines for entering and
exiting translated code, TLB maintenance, and the code to choose which
basic block to run next.

Making the instruction decoder a bit slower is not likely to have much
effect (but do do before and after measurements to be sure).

Significant wins would come from reducing the number of switches
between translations (e.g. by translating larger units, all code on a
page at once, functions, traces), by making switches between
translations cheaper (e.g. with inline caches), or by reducing the
cost of access translation (e.g. two accesses relative to the same
base register in the same translation often hit the same virtual page
and can share translation effort, or more speculatively by using host
translation hardware.  (I am willing to discuss any of these further
OFF-LIST ONLY.)

-s
