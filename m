Received: from eggs.gnu.org ([2001:4830:134:3::10]:37922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxRQ-00015E-Di
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxRP-0007jM-I5
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:52:40 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-5-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3452cd65-6045-b93d-47cc-879174660849@twiddle.net>
Date: Mon, 5 Dec 2016 09:52:35 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-5-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/13] target-ppc: implement lxvll
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
> +void helper_lxvll(CPUPPCState *env, target_ulong addr,
> +                  target_ulong xt_num, target_ulong rb)
> +{
> +    ppc_vsr_t xt;
> +
> +    getVSR(xt_num, &xt, env);
> +    if (unlikely((rb & 0xFF) == 0)) {
> +        xt.s128 = int128_make128(0, 0);

Nit: int128_zero.

> +    } else {
> +        target_ulong end = ((rb & 0xFF) * 8) - 1;
> +        if (msr_le) {
> +            xt.u64[LO_IDX] = cpu_ldq_data_ra(env, addr, GETPC());
> +            addr = addr_add(env, addr, 8);
> +            xt.u64[HI_IDX] = cpu_ldq_data_ra(env, addr, GETPC());
> +            xt.s128 = int128_and(xt.s128, mask_u128(127 - end, 127));

The ISA document says that this is a sequence of byte operations.  Which means
that END < 127 will not access bytes outside of the length.  Which means that
your code will trigger SIGSEGV near page boundaries when real hardware won't.

I also don't see how this does the right thing for little-endian.


r~
