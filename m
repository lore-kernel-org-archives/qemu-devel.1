Received: from eggs.gnu.org ([208.118.235.92]:36224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf7mF-00004x-3i
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf7mC-0007Ke-1h
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:31:30 -0500
References: <20181218063911.2112-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <76c13216-a9a1-4d5f-f74c-cc654e2390c7@ilande.co.uk>
Date: Thu, 3 Jan 2019 18:31:09 +0000
MIME-Version: 1.0
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 18/12/2018 06:38, Richard Henderson wrote:

> This implements some of the things that I talked about with Mark
> this morning / yesterday.  In particular:
> 
> (0) Implement expanders for nand, nor, eqv logical operations.
> 
> (1) Implement saturating arithmetic for the tcg backend.
> 
>     While I had expanders for these, they always went to helpers.
>     It's easy enough to expand byte and half-word operations for x86.
>     Beyond that, 32 and 64-bit operations can be expanded with integers.
> 
> (2) Implement minmax arithmetic for the tcg backend.
> 
>     While I had integral minmax operations, I had not yet added
>     any vector expanders for this.  (The integral stuff came in
>     for atomic minmax.)
> 
> (3) Trivial conversions to minmax for target/arm.
> 
> (4) Patches 11-18 are identical to Mark's.
> 
> (5) Patches 19-25 implement splat and logicals for VMX and VSX.
> 
>     VSX is no more difficult than VMX for these.  It does seem to be
>     just about everything that we can do for VSX at the momement.
> 
> (6) Patches 26-33 implement saturating arithmetic for VMX.
> 
> (7) Patch 34 implements minmax arithmetic for VMX.
> 
> I've tested the new operations via aarch64 guest, as that's the set
> of risu test cases I've got handy.  The rest is untested so far.

I've taken my previous PPC patchsets below:

[PATCH v5 0/9] target/ppc: prepare for conversion to TCG vector operations
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00063.html

[PATCH v2 0/8] target/ppc: remove various endian hacks from int_helper.c
https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06149.html

and then rebased this patchset on top of them (including a squash of the vsplt fix
posted earlier today at
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00287.html) and pushed the
result to https://github.com/mcayland/qemu/tree/ppc-altivec-v5.5-rth.

Fixing the vsplt instruction now gives a readable display in my MacOS tests, but I'm
still seeing "shadows" such as https://www.ilande.co.uk/tmp/qemu/badapple4.png which
I've bisected down to:


commit 71f229eb331e979971a0a79e5a2fcdfb9380bd06
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Dec 17 22:39:10 2018 -0800

    target/ppc: convert vadd*s and vsub*s to vector operations

    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


So looks like there's something still not quite right with the saturation flag/vector
saturation implementation.


ATB,

Mark.
