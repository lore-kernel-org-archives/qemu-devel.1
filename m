Received: from eggs.gnu.org ([2001:4830:134:3::10]:53288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtUw-0003g9-M2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtUv-0006xp-Lq
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:18:18 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwtUv-0006xS-HV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:18:17 -0400
Received: by mail-it0-x243.google.com with SMTP id o200so5066172itg.1
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:18:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642388004.3900.5767850617613782105.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642388004.3900.5767850617613782105.stgit@Misha-PC.lan02.inno>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Sep 2017 10:17:46 -0700
Message-ID: <CAKmqyKNuoesi8NTPNfzM=dt+vciXEH1a9L+4iZuSkzpa0hHjRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/43] windbg: added WindbgState
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
> Added definition of the WindbgState struct and its initialization.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  windbgstub.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/windbgstub.c b/windbgstub.c
> index 3830446988..60a380c213 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -10,10 +10,36 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
>  #include "exec/windbgstub.h"
>  #include "exec/windbgstub-utils.h"
>
> +typedef struct WindbgState {
> +    bool is_loaded;
> +
> +    uint32_t ctrl_packet_id;
> +    uint32_t data_packet_id;
> +} WindbgState;
> +
> +static WindbgState *windbg_state;
> +
> +static void windbg_exit(void)
> +{
> +    g_free(windbg_state);
> +}
> +
>  int windbg_server_start(const char *device)
>  {
> +    if (windbg_state) {
> +        WINDBG_ERROR("Multiple instances are not supported");

Use error_report() to report errors.

Thanks,
Alistair

> +        exit(1);
> +    }
> +
> +    windbg_state = g_new0(WindbgState, 1);
> +    windbg_state->ctrl_packet_id = RESET_PACKET_ID;
> +    windbg_state->data_packet_id = INITIAL_PACKET_ID;
> +
> +    atexit(windbg_exit);

I don't think you need this.

Thanks,
Alistair

>      return 0;
>  }
>
>
