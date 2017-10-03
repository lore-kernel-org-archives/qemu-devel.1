Received: from eggs.gnu.org ([2001:4830:134:3::10]:43989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMBt-0005jE-Uz
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMBp-0000cj-V2
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:20:49 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:52391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzMBp-0000c0-QF
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:20:45 -0400
Received: by mail-ua0-f179.google.com with SMTP id i35so2408774uah.9
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 05:20:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642395256.3900.7797961982959292389.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642395256.3900.7797961982959292389.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 14:20:44 +0200
Message-ID: <CABdb73622pU09nem99V8_DihiCEPRH0NH7OKJzsVpdiFOEJiWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 19/43] windbg: implemented
 windbg_process_control_packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Sep 26, 2017 at 1:05 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  windbgstub.c |   26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/windbgstub.c b/windbgstub.c
> index 3a13d22349..b8053102dd 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -126,7 +126,31 @@ static void windbg_process_data_packet(ParsingContext *ctx)
>  {}
>
>  static void windbg_process_control_packet(ParsingContext *ctx)
> -{}
> +{
> +    switch (ctx->packet.PacketType) {
> +    case PACKET_TYPE_KD_ACKNOWLEDGE:
> +        break;
> +
> +    case PACKET_TYPE_KD_RESET:
> +    {
> +        SizedBuf buf = kd_gen_load_symbols_sc(qemu_get_cpu(0));
> +
> +        windbg_send_data_packet(buf.data, buf.size,
> +                                PACKET_TYPE_KD_STATE_CHANGE64);
> +        windbg_send_control_packet(ctx->packet.PacketType);
> +        windbg_state->ctrl_packet_id = INITIAL_PACKET_ID;
> +        SBUF_FREE(buf);
> +        break;
> +    }
> +    default:
> +        WINDBG_ERROR("Catched unsupported control packet 0x%x",

"caught" instead of "catched", same in patches 20 and 21.

> +                     ctx->packet.PacketType);
> +
> +        windbg_state->ctrl_packet_id = 0;
> +        windbg_send_control_packet(PACKET_TYPE_KD_RESEND);
> +        break;
> +    }
> +}
>
>  static void windbg_ctx_handler(ParsingContext *ctx)
>  {
>
