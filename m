Received: from eggs.gnu.org ([2001:4830:134:3::10]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTO7-0002XZ-Dq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTNz-0004Li-BX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:56:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDTNz-0004LC-09
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:56:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so37122196wrt.10
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:56:10 -0700 (PDT)
References: <1539946236-18028-1-git-send-email-liq3ea@gmail.com>
	<1539946236-18028-3-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fbc29b1b-1cb7-afdf-e6e5-baf5487fdcf3@redhat.com>
Date: Fri, 19 Oct 2018 13:56:08 +0200
MIME-Version: 1.0
In-Reply-To: <1539946236-18028-3-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw: ccid-card-emulated: cleanup
 resource when realize in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, kraxel@redhat.com
Cc: liq3ea@163.com, qemu-devel@nongnu.org

On 19/10/2018 12:50, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/usb/ccid-card-emulated.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index b356edb..25976ed 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -499,7 +499,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>      card->reader = NULL;
>      card->quit_apdu_thread = 0;
>      if (init_event_notifier(card, errp) < 0) {
> -        return;
> +        goto out1;
>      }
>  
>      card->backend = 0;
> @@ -513,7 +513,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>          for (ptable = backend_enum_table; ptable->name != NULL; ++ptable) {
>              error_append_hint(errp, "%s\n", ptable->name);
>          }
> -        return;
> +        goto out2;
>      }
>  
>      /* TODO: a passthru backened that works on local machine. third card type?*/
> @@ -523,31 +523,39 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>          } else {
>              error_setg(errp, "%s: you must provide all three certs for"
>                         " certificates backend", TYPE_EMULATED_CCID);
> -            return;
> +            goto out2;
>          }
>      } else {
>          if (card->backend != BACKEND_NSS_EMULATED) {
>              error_setg(errp, "%s: bad backend specified. The options are:%s"
>                         " (default), %s.", TYPE_EMULATED_CCID,
>                         BACKEND_NSS_EMULATED_NAME, BACKEND_CERTIFICATES_NAME);
> -            return;
> +            goto out2;
>          }
>          if (card->cert1 != NULL || card->cert2 != NULL || card->cert3 != NULL) {
>              error_setg(errp, "%s: unexpected cert parameters to nss emulated "
>                         "backend", TYPE_EMULATED_CCID);
> -            return;
> +            goto out2;
>          }
>          /* default to mirroring the local hardware readers */
>          ret = wrap_vcard_emul_init(NULL);
>      }
>      if (ret != VCARD_EMUL_OK) {
>          error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
> -        return;
> +        goto out2;
>      }
>      qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
>                         card, QEMU_THREAD_JOINABLE);
>      qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
>                         card, QEMU_THREAD_JOINABLE);
> +
> +out2:

You might call this 'cleanup' ...

> +    clean_event_notifier(card);
> +out1:

... and this one 'out'.

> +    qemu_cond_destroy(&card->handle_apdu_cond);
> +    qemu_mutex_destroy(&card->handle_apdu_mutex);
> +    qemu_mutex_destroy(&card->vreader_mutex);
> +    qemu_mutex_destroy(&card->event_list_mutex);
>  }
>  
>  static void emulated_unrealize(CCIDCardState *base, Error **errp)
> 
