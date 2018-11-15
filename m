Received: from eggs.gnu.org ([2001:4830:134:3::10]:51955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNEo2-00034r-Hb
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNEnt-0005Jp-Rm
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:23:20 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:34503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNEns-0005Ip-Uw
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:23:17 -0500
Received: by mail-ot1-x32f.google.com with SMTP id t5so17628766otk.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 02:23:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108121646.26173-2-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
	<20181108121646.26173-2-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 10:22:55 +0000
Message-ID: <CAFEAcA9XbnnpTKDJQMHqxfChBaKp5j71gsxUYOCo2SQXkOZ9DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 01/22] target/ppc: add external PID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>, Laurent Vivier <lvivier@redhat.com>, Roman Kapl <rka@sysgo.com>

On 8 November 2018 at 12:16, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: Roman Kapl <rka@sysgo.com>
>
> External PID is a mechanism present on BookE 2.06 that enables application to
> store/load data from different address spaces. There are special version of some
> instructions, which operate on alternate address space, which is specified in
> the EPLC/EPSC regiser.
>
> This implementation uses two additional MMU modes (mmu_idx) to provide the
> address space for the load and store instructions. The QEMU TLB fill code was
> modified to recognize these MMU modes and use the values in EPLC/EPSC to find
> the proper entry in he PPC TLB. These two QEMU TLBs are also flushed on each
> write to EPLC/EPSC.
>
> Following instructions are implemented: dcbfep dcbstep dcbtep dcbtstep dcbzep
> dcbzlep icbiep lbepx ldepx lfdepx lhepx lwepx stbepx stdepx stfdepx sthepx
> stwepx.
>
> Following vector instructions are not: evlddepx evstddepx lvepx lvepxl stvepx
> stvepxl.

Hi; Coverity reports an issue (CID1396864) with this function:

> +/* dcbfep (external PID dcbf) */
> +static void gen_dcbfep(DisasContext *ctx)
> +{
> +    /* XXX: specification says this is treated as a load by the MMU */
> +    TCGv t0;
> +    CHK_SV;
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    t0 = tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
> +    tcg_temp_free(t0);
> +}

It says that the gen_set_access_type() call is unreachable. I think
this is a false positive (the code is unreachable, but only if
CONFIG_USER_ONLY is defined). On the other hand, all the other
similar gen_* functions in this file that use CHK_SV seem to have
a pattern of

#if defined(CONFIG_USER_ONLY)
    GEN_PRIV;
#else
    TCGv t0;
    CHK_SV;
    [etc]
#endif

so maybe we should do that here too for consistency?

thanks
-- PMM
