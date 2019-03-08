Received: from eggs.gnu.org ([209.51.188.92]:34949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Iww-00052C-3n
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Iwv-0006D0-En
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:06:22 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:38265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2Iwv-0006CX-8y
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:06:21 -0500
Received: by mail-ot1-x32c.google.com with SMTP id m1so17966436otf.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 09:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
In-Reply-To: <20190307095441.31921-4-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 17:06:08 +0000
Message-ID: <CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 3/4] usb-mtp: prevent null dereference while
 deleting objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>

On Thu, 7 Mar 2019 at 09:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Bandan Das <bsd@redhat.com>
>
> Spotted by Coverity: CID 1399144
>
> Signed-off-by: Bandan Das <bsd@redhat.com>
> Message-id: 20190306210409.14842-4-bsd@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 1f22284949df..06e376bcd211 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1177,9 +1177,7 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
>              usb_mtp_object_free_one(s, o);
>              success = true;
>          }
> -    }
> -
> -    if (o->format == FMT_ASSOCIATION) {
> +    } else if (o->format == FMT_ASSOCIATION) {
>          if (rmdir(o->path)) {
>              partial_delete = true;
>          } else {
> --

Hi; following this change Coverity now complains (CID 1399414)
about dead code later in the file:

In this set of if/else clauses, either we
set partial_delete to true, or we set success to
true, but never both:

    if (o->format == FMT_UNDEFINED_OBJECT) {
        if (remove(o->path)) {
            partial_delete = true;
        } else {
            usb_mtp_object_free_one(s, o);
            success = true;
        }
    } else if (o->format == FMT_ASSOCIATION) {
        if (rmdir(o->path)) {
            partial_delete = true;
        } else {
            usb_mtp_object_free_one(s, o);
            success = true;
        }
    }

and so here:

    if (success && partial_delete) {
        return PARTIAL_DELETE;
    }

the condition can never be true and the code inside
the if () {} is dead.

When is the routine intended to return the PARTIAL_DELETE
return value ?

thanks
-- PMM
