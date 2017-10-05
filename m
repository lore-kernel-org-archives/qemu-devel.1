Received: from eggs.gnu.org ([2001:4830:134:3::10]:44177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0B3f-0004DK-Jn
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0B3Z-00012f-L0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:39:43 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:47872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0B3Z-00011e-Dn
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:39:37 -0400
Received: by mail-qt0-x232.google.com with SMTP id z50so22160881qtj.4
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:39:37 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-15-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <562a5db1-ab3b-1d77-eb8e-69af276bcac3@linaro.org>
Date: Thu, 5 Oct 2017 14:39:33 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-15-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/20] target/arm: Implement security
 attribute lookups for memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/22/2017 11:00 AM, Peter Maydell wrote:
> Implement the security attribute lookups for memory accesses
> in the get_phys_addr() functions, causing these to generate
> various kinds of SecureFault for bad accesses.
> 
> The major subtlety in this code relates to handling of the
> case when the security attributes the SAU assigns to the
> address don't match the current security state of the CPU.
> 
> In the ARM ARM pseudocode for validating instruction
> accesses, the security attributes of the address determine
> whether the Secure or NonSecure MPU state is used. At face
> value, handling this would require us to encode the relevant
> bits of state into mmu_idx for both S and NS at once, which
> would result in our needing 16 mmu indexes. Fortunately we
> don't actually need to do this because a mismatch between
> address attributes and CPU state means either:
>  * some kind of fault (usually a SecureFault, but in theory
>    perhaps a UserFault for unaligned access to Device memory)
>  * execution of the SG instruction in NS state from a
>    Secure & NonSecure code region
> 
> The purpose of SG is simply to flip the CPU into Secure
> state, so we can handle it by emulating execution of that
> instruction directly in arm_v7m_cpu_do_interrupt(), which
> means we can treat all the mismatch cases as "throw an
> exception" and we don't need to encode the state of the
> other MPU bank into our mmu_idx values.
> 
> This commit doesn't include the actual emulation of SG;
> it also doesn't include implementation of the IDAU, which
> is a per-board way to specify hard-coded memory attributes
> for addresses, which override the CPU-internal SAU if they
> specify a more secure setting than the SAU is programmed to.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h |  15 ++++
>  target/arm/helper.c    | 182 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 195 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
