Received: from eggs.gnu.org ([2001:4830:134:3::10]:46293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqUne-0007AT-Ah
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 21:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqUnd-0000Hz-Dm
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 21:15:26 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eqUnc-0000Ex-Vm
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 21:15:25 -0500
Received: by mail-lf0-x241.google.com with SMTP id l191so25223785lfe.1
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 18:15:24 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180215220540.6556-4-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
	<20180215220540.6556-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 26 Feb 2018 18:14:53 -0800
Message-ID: <CAKmqyKPBSkyUrkts8z9dM+0JxRN9cutc8xUy_qZuvgpkWYB58Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/11] sdcard: add a trace event for
 command responses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Feb 15, 2018 at 2:05 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c         | 27 ++++++++++++++++++++++++---
>  hw/sd/trace-events |  1 +
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 72e9b47e34..8f72cde534 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -153,6 +153,27 @@ static const char *sd_state_name(enum SDCardStates s=
tate)
>      return state_name[state];
>  }
>
> +static const char *sd_response_name(sd_rsp_type_t rsp)
> +{
> +    static const char *response_name[] =3D {
> +        [sd_r0]     =3D "RESP#0 (no response)",
> +        [sd_r1]     =3D "RESP#1 (normal cmd)",
> +        [sd_r2_i]   =3D "RESP#2 (CID reg)",
> +        [sd_r2_s]   =3D "RESP#2 (CSD reg)",
> +        [sd_r3]     =3D "RESP#3 (OCR reg)",
> +        [sd_r6]     =3D "RESP#6 (RCA)",
> +        [sd_r7]     =3D "RESP#7 (operating voltage)",
> +    };
> +    if (rsp =3D=3D sd_illegal) {
> +        return "ILLEGAL RESP";
> +    }
> +    if (rsp =3D=3D sd_r1b) {
> +        rsp =3D sd_r1;
> +    }
> +    assert(rsp <=3D ARRAY_SIZE(response_name));
> +    return response_name[rsp];
> +}
> +
>  static uint8_t sd_get_dat_lines(SDState *sd)
>  {
>      return sd->enable ? sd->dat_lines : 0;
> @@ -1596,10 +1617,12 @@ send_response:
>
>      case sd_r0:
>      case sd_illegal:
> -    default:
>          rsplen =3D 0;
>          break;
> +    default:
> +        g_assert_not_reached();
>      }
> +    trace_sdcard_response(sd_response_name(rtype), rsplen);
>
>      if (rtype !=3D sd_illegal) {
>          /* Clear the "clear on valid command" status bits now we've
> @@ -1616,8 +1639,6 @@ send_response:
>              DPRINTF(" %02x", response[i]);
>          }
>          DPRINTF(" state %d\n", sd->state);
> -    } else {
> -        DPRINTF("No response %d\n", sd->state);
>      }
>  #endif
>
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 75dac5a2cd..b2aa19ec0d 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -26,6 +26,7 @@ sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
>  # hw/sd/sd.c
>  sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD=
%d arg 0x%08x (state %s)"
>  sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
> +sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
>  sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size =
0x%x"
>  sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size=
 0x%x"
>
> --
> 2.16.1
>
>
