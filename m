Received: from eggs.gnu.org ([2001:4830:134:3::10]:49227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1eY-0006B9-PB
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1eY-0008Df-5N
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:41:50 -0500
MIME-Version: 1.0
In-Reply-To: <1513183941-24300-3-git-send-email-peter.maydell@linaro.org>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
	<1513183941-24300-3-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jan 2018 13:41:16 -0800
Message-ID: <CAKmqyKNjCtKYOP5cnOE5ZiZ_d6_Gg7Vb9ey7=OE-icgK-FdJ=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/intc/arm_gic: reserved register
 addresses are RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Patch Tracking <patches@linaro.org>

On Wed, Dec 13, 2017 at 8:52 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The GICv2 specification says that reserved register addresses
> must RAZ/WI; now that we implement external abort handling
> for Arm CPUs this means we must return MEMTX_OK rather than
> MEMTX_ERROR, to avoid generating a spurious guest data abort.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Looks good to me.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair


> ---
>  hw/intc/arm_gic.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 5a0e2a3..d701e49 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1261,7 +1261,8 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "gic_cpu_read: Bad offset %x\n", (int)offset);
> -        return MEMTX_ERROR;
> +        *data = 0;
> +        break;
>      }
>      return MEMTX_OK;
>  }
> @@ -1329,7 +1330,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "gic_cpu_write: Bad offset %x\n", (int)offset);
> -        return MEMTX_ERROR;
> +        return MEMTX_OK;
>      }
>      gic_update(s);
>      return MEMTX_OK;
> --
> 2.7.4
>
>
