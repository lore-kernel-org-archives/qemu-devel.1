Received: from eggs.gnu.org ([2001:4830:134:3::10]:59435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTZ2m-0003eA-QL
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTZ2l-00073d-Sh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:40:32 -0400
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-8-peter.maydell@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a7777026-e81c-45c7-3920-66f4b7146b41@redhat.com>
Date: Thu, 14 Jun 2018 22:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180604152941.20374-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/13] hw/misc/tz-mpc.c: Implement
 correct blocked-access behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi Peter,
On 06/04/2018 05:29 PM, Peter Maydell wrote:
> The MPC is guest-configurable for whether blocked accesses:
>  * should be RAZ/WI or cause a bus error
>  * should generate an interrupt or not
> 
> Implement this behaviour in the blocked-access handlers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/tz-mpc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
> index 9db55e23daf..704bb3fb44d 100644
> --- a/hw/misc/tz-mpc.c
> +++ b/hw/misc/tz-mpc.c
> @@ -43,6 +43,9 @@ REG32(INT_EN, 0x28)
>      FIELD(INT_EN, IRQ, 0, 1)
>  REG32(INT_INFO1, 0x2c)
>  REG32(INT_INFO2, 0x30)
> +    FIELD(INT_INFO2, HMASTER, 0, 16)
> +    FIELD(INT_INFO2, HNONSEC, 16, 1)
> +    FIELD(INT_INFO2, CFG_NS, 17, 1)
>  REG32(INT_SET, 0x34)
>      FIELD(INT_SET, IRQ, 0, 1)
>  REG32(PIDR4, 0xfd0)
> @@ -266,6 +269,45 @@ static const MemoryRegionOps tz_mpc_reg_ops = {
>      .impl.max_access_size = 4,
>  };
>  
> +static inline bool tz_mpc_cfg_ns(TZMPC *s, hwaddr addr)
> +{
> +    /* Return the cfg_ns bit from the LUT for the specified address */
> +    hwaddr blknum = addr / s->blocksize;
> +    hwaddr blkword = blknum / 32;
> +    uint32_t blkbit = 1U << (blknum % 32);
> +
> +    /* This would imply the address was larger than the size we
> +     * defined this memory region to be, so it can't happen.
> +     */
> +    assert(blkword < s->blk_max);
> +    return s->blk_lut[blkword] & blkbit;
> +}
> +
> +static MemTxResult tz_mpc_handle_block(TZMPC *s, hwaddr addr, MemTxAttrs attrs)
> +{
> +    /* Handle a blocked transaction: raise IRQ, capture info, etc */
> +    if (!s->int_stat) {
> +        /* First blocked transfer: capture information into INT_INFO1 and
> +         * INT_INFO2. Subsequent transfers are still blocked but don't
> +         * capture information until the guest clears the interrupt.
> +         */
> +
> +        s->int_info1 = addr;
> +        s->int_info2 = 0;
> +        s->int_info2 = FIELD_DP32(s->int_info2, INT_INFO2, HMASTER,
> +                                  attrs.requester_id & 0xffff);
> +        s->int_info2 = FIELD_DP32(s->int_info2, INT_INFO2, HNONSEC,
> +                                  ~attrs.secure);
> +        s->int_info2 = FIELD_DP32(s->int_info2, INT_INFO2, CFG_NS,
> +                                  tz_mpc_cfg_ns(s, addr));
> +        s->int_stat |= R_INT_STAT_IRQ_MASK;
> +        tz_mpc_irq_update(s);
> +    }
> +
> +    /* Generate bus error if desired; otherwise RAZ/WI */
> +    return (s->ctrl & R_CTRL_SEC_RESP_MASK) ? MEMTX_ERROR : MEMTX_OK;
> +}
> +
>  /* Accesses only reach these read and write functions if the MPC is
>   * blocking them; non-blocked accesses go directly to the downstream
>   * memory region without passing through this code.
> @@ -274,19 +316,23 @@ static MemTxResult tz_mpc_mem_blocked_read(void *opaque, hwaddr addr,
>                                             uint64_t *pdata,
>                                             unsigned size, MemTxAttrs attrs)
>  {
> +    TZMPC *s = TZ_MPC(opaque);
> +
>      trace_tz_mpc_mem_blocked_read(addr, size, attrs.secure);
>  
>      *pdata = 0;
> -    return MEMTX_OK;
> +    return tz_mpc_handle_block(s, addr, attrs);
>  }
>  
>  static MemTxResult tz_mpc_mem_blocked_write(void *opaque, hwaddr addr,
>                                              uint64_t value,
>                                              unsigned size, MemTxAttrs attrs)
>  {
> +    TZMPC *s = TZ_MPC(opaque);
> +
>      trace_tz_mpc_mem_blocked_write(addr, value, size, attrs.secure);
>  
> -    return MEMTX_OK;
> +    return tz_mpc_handle_block(s, addr, attrs);
>  }
>  
>  static const MemoryRegionOps tz_mpc_mem_blocked_ops = {
> 

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
