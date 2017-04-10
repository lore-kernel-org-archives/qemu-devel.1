Received: from eggs.gnu.org ([2001:4830:134:3::10]:50758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYhE-0006L1-CB
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYhD-0007qf-AF
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:45:28 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxYhD-0007qO-3n
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:45:27 -0400
Received: by mail-wm0-x22c.google.com with SMTP id u2so36367014wmu.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:45:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <07368f466735c951eaf53605582085cc7c5feb9b.1491349058.git.alistair.francis@xilinx.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<07368f466735c951eaf53605582085cc7c5feb9b.1491349058.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 13:45:05 +0100
Message-ID: <CAFEAcA-XHSQcNcWmUkV4b0oK=TZFZ2Q+nr53p7tF0+hTZ5UzpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 4/5] cadence_gem: Make the revision a
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 5 April 2017 at 00:40, Alistair Francis <alistair.francis@xilinx.com> wrote:
> Expose the Cadence GEM revision as a property.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  hw/net/cadence_gem.c         | 6 +++++-
>  include/hw/net/cadence_gem.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index b9eaed4..7047e02 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -300,6 +300,8 @@
>  #define DESC_1_RX_SOF 0x00004000
>  #define DESC_1_RX_EOF 0x00008000
>
> +#define GEM_MODID_VALUE 0x00020118
> +
>  static inline unsigned tx_desc_get_buffer(unsigned *desc)
>  {
>      return desc[0];
> @@ -1213,7 +1215,7 @@ static void gem_reset(DeviceState *d)
>      s->regs[GEM_TXPAUSE] = 0x0000ffff;
>      s->regs[GEM_TXPARTIALSF] = 0x000003ff;
>      s->regs[GEM_RXPARTIALSF] = 0x000003ff;
> -    s->regs[GEM_MODID] = 0x00020118;
> +    s->regs[GEM_MODID] = s->revision;
>      s->regs[GEM_DESCONF] = 0x02500111;
>      s->regs[GEM_DESCONF2] = 0x2ab13fff;
>      s->regs[GEM_DESCONF5] = 0x002f2145;
> @@ -1512,6 +1514,8 @@ static const VMStateDescription vmstate_cadence_gem = {
>
>  static Property gem_properties[] = {
>      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
> +    DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
> +                       GEM_MODID_VALUE),
>      DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
>                        num_priority_queues, 1),
>      DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
> index c469ffe..35de622 100644
> --- a/include/hw/net/cadence_gem.h
> +++ b/include/hw/net/cadence_gem.h
> @@ -50,6 +50,7 @@ typedef struct CadenceGEMState {
>      uint8_t num_priority_queues;
>      uint8_t num_type1_screeners;
>      uint8_t num_type2_screeners;
> +    uint32_t revision;
>
>      /* GEM registers backing store */
>      uint32_t regs[CADENCE_GEM_MAXREG];
> --
> 2.9.3
>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
