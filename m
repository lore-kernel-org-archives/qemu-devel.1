Received: from eggs.gnu.org ([209.51.188.92]:50393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggZ5m-00057c-0j
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggYy2-0001hy-5O
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggYkm-0002SN-PY
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:31:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-12-fli@suse.com>
Date: Mon, 07 Jan 2019 18:31:52 +0100
In-Reply-To: <20181225140449.15786-12-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:44 +0800")
Message-ID: <875zv0ml13.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 11/16] qemu_thread: supplement
 error handling for emulated_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, Gerd Hoffmann <kraxel@redhat.com>

Fei Li <fli@suse.com> writes:

> Utilize the existed errp to propagate the error and do the
> corresponding cleanup to replace the temporary &error_abort.
>
> Cc: Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  hw/usb/ccid-card-emulated.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index f8ff7ff4a3..9245b4fcad 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -32,7 +32,6 @@
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
>  #include "ccid.h"
> -#include "qapi/error.h"
>  
>  #define DPRINTF(card, lvl, fmt, ...) \
>  do {\
> @@ -544,11 +543,15 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>          error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
>          goto out2;
>      }
> -    /* TODO: let the further caller handle the error instead of abort() here */
> -    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
> -    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
> +    if (!qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
> +                            card, QEMU_THREAD_JOINABLE, errp)) {
> +        goto out2;
> +    }
> +    if (!qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
> +                            handle_apdu_thread, card,
> +                            QEMU_THREAD_JOINABLE, errp)) {
> +        goto out2;

You need to stop and join the first thread.

> +    }
>  
>  out2:
>      clean_event_notifier(card);
