Received: from eggs.gnu.org ([209.51.188.92]:39396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpYVN-0001O9-4W
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpYVG-0004Il-36
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:05:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpYVF-0004Ib-UF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:05:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-7-lifei1214@126.com>
Date: Fri, 01 Feb 2019 14:04:59 +0100
In-Reply-To: <20190201051806.53183-7-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:18:01 +0800")
Message-ID: <87bm3v7j7o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 06/11] qemu_thread: supplement
 error handling for emulated_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> Utilize the existed errp to propagate the error and do the
> corresponding cleanup to replace the temporary &error_abort.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  hw/usb/ccid-card-emulated.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index 0b170f6328..19b4b9a8fa 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -544,11 +544,16 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>          error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
>          goto out2;
>      }
> -    /* TODO: let the further caller handle the error instead of abort() here */
> -    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
> -    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
> +    if (qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
> +                           card, QEMU_THREAD_JOINABLE, errp) < 0) {
> +        goto out2;
> +    }
> +    if (qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
> +                           handle_apdu_thread, card,
> +                           QEMU_THREAD_JOINABLE, errp) < 0) {
> +        qemu_thread_join(&card->event_thread_id);

What makes event_thread terminate here?

I'm asking because if it doesn't, the join will hang.

> +        goto out2;
> +    }
>  
>      return;
