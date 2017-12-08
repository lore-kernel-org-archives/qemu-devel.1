Received: from eggs.gnu.org ([2001:4830:134:3::10]:50954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eNRlq-00062i-Bf
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 18:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eNRlp-0001K1-0i
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 18:09:30 -0500
Date: Fri, 8 Dec 2017 18:09:20 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171208230920.GA11462@flamenco>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
	<1507824216-29058-9-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507824216-29058-9-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PULL 08/13] target/arm: Pull Thumb insn word
 loads up to top level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org

On Thu, Oct 12, 2017 at 17:03:31 +0100, Peter Maydell wrote:
> Refactor the Thumb decode to do the loads of the instruction words at
> the top level rather than only loading the second half of a 32-bit
> Thumb insn in the middle of the decode.
> 
> This is simple apart from the awkward case of Thumb1, where the
> BL/BLX prefix and suffix instructions live in what in Thumb2 is the
> 32-bit insn space.  To handle these we decode enough to identify
> whether we're looking at a prefix/suffix that we handle as a 16 bit
> insn, or a prefix that we're going to merge with the following suffix
> to consider as a 32 bit insn.  The translation of the 16 bit cases
> then moves from disas_thumb2_insn() to disas_thumb_insn().
> 
> The refactoring has the benefit that we don't need to pass the
> CPUARMState* down into the decoder code any more, but the major
> reason for doing this is that some Thumb instructions must be always
> unconditional regardless of the IT state bits, so we need to know the
> whole insn before we emit the "skip this insn if the IT bits and cond
> state tell us to" code.  (The always unconditional insns are BKPT,
> HLT and SG; the last of these is 32 bits.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 1507556919-24992-7-git-send-email-peter.maydell@linaro.org

This commit breaks the debian-arm boot test (see [1]), boot dies at:

> random: systemd urandom read with 4 bits of entropy available
> systemd[1]: Caught <SEGV>, core dump failed.
> systemd[1]: Freezing execution.

Sorry I noticed this so late (-rc4), for a while I thought my development
was causing this and didn't pay much attention to it. However, just realised
the problem is present on master. Bisect log below.

Thanks,

		Emilio

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04085.html

$ git bisect log
git bisect start
# bad: [2babfe0c9241c239272a03fec785165a50e8288c] Update version for v2.11.0-rc4 release
git bisect bad 2babfe0c9241c239272a03fec785165a50e8288c
# good: [1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec] Update version for v2.10.0 release
git bisect good 1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec
# good: [62a2554ec2630896d1299e1a282a64c7f3b00da0] 390x/css: introduce maximum data address checking
git bisect good 62a2554ec2630896d1299e1a282a64c7f3b00da0
# bad: [f51f315a676ec913a55ac27be4ef857f9f7ddc5c] translate-all: use qemu_protect_rwx/none helpers
git bisect bad f51f315a676ec913a55ac27be4ef857f9f7ddc5c
# bad: [9f99c85c4a364f8de8134eb53b0cc1b84ded4b3f] Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging
git bisect bad 9f99c85c4a364f8de8134eb53b0cc1b84ded4b3f
# good: [3637cf58f9441ad277fd70299a29d0e39b32c96c] util: move qemu_real_host_page_size/mask to osdep.h
git bisect good 3637cf58f9441ad277fd70299a29d0e39b32c96c
# bad: [b81b948ecc8659d78066f374c787ed12379d21dd] virtio/pci/migration: Convert to VMState
git bisect bad b81b948ecc8659d78066f374c787ed12379d21dd
# good: [43851b5bd48d952561610d0d6d6c314c97eff543] iotests: Set up Python logging
git bisect good 43851b5bd48d952561610d0d6d6c314c97eff543
# bad: [76eff04d166b8fe747adbe82de8b7e060e668ff9] target/arm: Implement SG instruction corner cases
git bisect bad 76eff04d166b8fe747adbe82de8b7e060e668ff9
# good: [b9f587d62cebed427206539750ebf59bde4df422] target/arm: Add M profile secure MMU index values to get_a32_user_mem_index()
git bisect good b9f587d62cebed427206539750ebf59bde4df422
# good: [6b8acf256df09c8a8dd7dcaa79b06eaff4ad63f7] target-arm: Don't check for "Thumb2 or M profile" for not-Thumb1
git bisect good 6b8acf256df09c8a8dd7dcaa79b06eaff4ad63f7
# bad: [5b8d7289e9e92a0d7bcecb93cd189e245fef10cd] target-arm: Simplify insn_crosses_page()
git bisect bad 5b8d7289e9e92a0d7bcecb93cd189e245fef10cd
# bad: [296e5a0a6c393553079a641c50521ae33ff89324] target/arm: Pull Thumb insn word loads up to top level
git bisect bad 296e5a0a6c393553079a641c50521ae33ff89324
# first bad commit: [296e5a0a6c393553079a641c50521ae33ff89324] target/arm: Pull Thumb insn word loads up to top level
