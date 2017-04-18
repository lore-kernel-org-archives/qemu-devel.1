Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0OEz-0002zj-MJ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0OEw-0003pz-Gj
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:12:01 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d0OEw-0003pq-AN
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:11:58 -0400
Received: by mail-wr0-x243.google.com with SMTP id l44so23539198wrc.2
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 01:11:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
	<b1be5af9a1d304f55847efeab706e88e3b9b1afa.1492384862.git.shorne@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5447c3cd-4b64-3b71-fd77-33a29f225104@twiddle.net>
Date: Tue, 18 Apr 2017 01:11:53 -0700
MIME-Version: 1.0
In-Reply-To: <b1be5af9a1d304f55847efeab706e88e3b9b1afa.1492384862.git.shorne@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/openrisc: implement shadow
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> Shadow registers are part of the openrisc spec along with sr[cid], as
> part of the fast context switching feature.  When exceptions occur,
> instead of having to save registers to the stack if enabled the CID will
> increment and a new set of registers will be available.
>
> This patch only implements shadow registers which can be used as extra
> scratch registers via the mfspr and mtspr if required.  This is
> implemented in a way where it would be easy to add on the fast context
> switching, currently cid is hardcoded to 0.

I'm not especially keen on this half-conversion.
If CID cannot be changed, then

> -    target_ulong gpr[32];     /* General registers */
> +    target_ulong shadow_gpr[16][32]; /* Shadow registers */
> +    target_ulong * gpr;       /* General registers (backed by shadow) */

this pointer should not be necessary.  Just use a union, or even just

     target_ulong gpr[32];
     target_ulong shadow_gpr[15][32];

for now.

Alternately, add accessor functions that take the whole ENV (which would be 
able to read CID, when needed).  C.f.

     uint64_t cpu_alpha_load_gr(CPUAlphaState *env, unsigned reg);
     void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val);

If/when CID can be changed, then we can talk about various ways
that this can be modeled within TCG.


r~
