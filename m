Received: from eggs.gnu.org ([2001:4830:134:3::10]:56036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtdD-0006Kq-Ek
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtdC-0003z0-FX
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:26:51 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:37547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwtdC-0003yX-B6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:26:50 -0400
Received: by mail-it0-x242.google.com with SMTP id v140so1369943ita.4
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:26:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642388560.3900.1889412060549174598.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642388560.3900.1889412060549174598.stgit@Misha-PC.lan02.inno>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Sep 2017 10:26:19 -0700
Message-ID: <CAKmqyKPuMtTXJ8Amq_ib31PFw4C2onA06rArd4QO0zwNiF3enA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/43] windbg: added chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, den@openvz.org

On Tue, Sep 26, 2017 at 4:04 AM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Added chardev for listening to windbg. Target device is a parameter in the '-windbg' option.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  windbgstub.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/windbgstub.c b/windbgstub.c
> index 60a380c213..378d1b911f 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "chardev/char.h"
>  #include "chardev/char-fe.h"
>  #include "exec/windbgstub.h"
> @@ -18,12 +19,26 @@
>  typedef struct WindbgState {
>      bool is_loaded;
>
> +    CharBackend chr;
> +
>      uint32_t ctrl_packet_id;
>      uint32_t data_packet_id;
>  } WindbgState;
>
>  static WindbgState *windbg_state;
>
> +static int windbg_chr_can_receive(void *opaque)
> +{
> +    return PACKET_MAX_SIZE;
> +}
> +
> +static void windbg_chr_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    if (windbg_state->is_loaded) {
> +        /* T0D0: parse data */
> +    }
> +}
> +
>  static void windbg_exit(void)
>  {
>      g_free(windbg_state);
> @@ -31,6 +46,8 @@ static void windbg_exit(void)
>
>  int windbg_server_start(const char *device)
>  {
> +    Chardev *chr = NULL;
> +
>      if (windbg_state) {
>          WINDBG_ERROR("Multiple instances are not supported");
>          exit(1);
> @@ -40,6 +57,15 @@ int windbg_server_start(const char *device)
>      windbg_state->ctrl_packet_id = RESET_PACKET_ID;
>      windbg_state->data_packet_id = INITIAL_PACKET_ID;
>
> +    chr = qemu_chr_new_noreplay(WINDBG, device);
> +    if (!chr) {
> +        return -1;
> +    }
> +
> +    qemu_chr_fe_init(&windbg_state->chr, chr, &error_abort);
> +    qemu_chr_fe_set_handlers(&windbg_state->chr, windbg_chr_can_receive,
> +                             windbg_chr_receive, NULL, NULL, NULL, NULL, true);
> +
>      atexit(windbg_exit);
>      return 0;
>  }
>
>
