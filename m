Received: from eggs.gnu.org ([2001:4830:134:3::10]:50617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZC0m-0003rY-1T
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZC0k-0001IK-VA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:49:59 -0500
References: <20181218063911.2112-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
Date: Tue, 18 Dec 2018 09:49:41 +0000
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

Thank you for working on this! I've just given this patchset a spin on my test images
and here's what I found:


- The version of my target/ppc patchset you've used is the one that I posted to the
mailing list which doesn't have the GEN_FLOAT macro fixes, removal of the uint64_t *
cast that you requested, and additional SoBs

I've taken this patchset, replaced my patches with the latest versions, and repushed
to github at https://github.com/mcayland/qemu/tree/ppc-altivec-rth.


- This patchset introduces visual artefacts on-screen for both OS X and OS 9

A quick bisection suggests that there could be 2 separate issues related to the
implementation of splat:

Patch "target/ppc: convert vspltis[bhw] to use vector operations" causes a black
border to appear around the OS X splash screen
(https://www.ilande.co.uk/tmp/qemu/badapple1.png) which may suggest an
overflow/alignment issue.

Following on from this, the next patch "target/ppc: convert vsplt[bhw] to use vector
operations" causes corruption of the OS X splash screen
(https://www.ilande.co.uk/tmp/qemu/badapple2.png) in a way that suggests there may be
an endian issue.


Having said that, the results look really promising, and I don't think it will take
too long to resolve any outstanding issues. I will be around on IRC later today if
that helps too.


ATB,

Mark.
