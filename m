Received: from eggs.gnu.org ([2001:4830:134:3::10]:45083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJfFd-00020s-Ul
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJfFa-0004Hy-Rx
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:44:37 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:47081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJfFa-0004Ho-Mq
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:44:34 -0500
Received: by mail-vk0-f47.google.com with SMTP id 138so117150vko.13
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 04:44:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127349122.6888.9523124333246477608.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127349122.6888.9523124333246477608.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 28 Nov 2017 13:44:33 +0100
Message-ID: <CABdb737B1Ldxr0KPtnrLAJpLgC9=BgE-qQ8a3BeL7DM=ydR9ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 45/45] windbg: implemented
 kd_api_get_context_ex and kd_api_set_context_ex
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

On Tue, Nov 21, 2017 at 3:11 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
[...]
> diff --git a/windbgstub.c b/windbgstub.c
> index 36372c0ea5..3bcf6a8cbb 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -224,6 +224,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
>          kd_api_query_memory(cpu, &ctx->data);
>          break;
>
> +    case DbgKdGetContextExApi:
> +        kd_api_get_context_ex(cpu, &ctx->data);
> +        break;
> +
> +    case DbgKdSetContextExApi:
> +        kd_api_set_context_ex(cpu, &ctx->data);
> +        break;
> +
>      default:
>          kd_api_unsupported(cpu, &ctx->data);
>          break;
> @@ -262,12 +270,12 @@ static void windbg_process_control_packet(ParsingContext *ctx)
>
>      case PACKET_TYPE_KD_RESET:
>      {
> -        SizedBuf buf = kd_gen_load_symbols_sc(qemu_get_cpu(0));
> +        windbg_send_control_packet(ctx->packet.PacketType);
> +        windbg_state->ctrl_packet_id = INITIAL_PACKET_ID;

You didn't mention it in the cover email so I'd like to be sure. This
is what fixed the initial handshake so it works without -b now, is
that correct? Thanks!

> +        SizedBuf buf = kd_gen_load_symbols_sc(qemu_get_cpu(0));
>          windbg_send_data_packet(buf.data, buf.size,
>                                  PACKET_TYPE_KD_STATE_CHANGE64);
> -        windbg_send_control_packet(ctx->packet.PacketType);
> -        windbg_state->ctrl_packet_id = INITIAL_PACKET_ID;
>          SBUF_FREE(buf);
>          break;
>      }
>
