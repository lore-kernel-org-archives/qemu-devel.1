Received: from eggs.gnu.org ([209.51.188.92]:47408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cej-0004lA-HE
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2ceh-00030y-LF
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:08:52 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:45471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2ceg-0002xD-JS
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:08:51 -0500
Received: by mail-oi1-x22b.google.com with SMTP id t82so327678oie.12
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 06:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	<jpg36nxf8ta.fsf@linux.bootlegged.copy>
In-Reply-To: <jpg36nxf8ta.fsf@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 14:08:36 +0000
Message-ID: <CAFEAcA-AJYJZxRfcFz0mV6uF9jy4g+heL-Y-DR_nbNVS=AwoqA@mail.gmail.com>
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
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 8 Mar 2019 at 19:46, Bandan Das <bsd@redhat.com> wrote:
> This is very broken! I think something like this should work:
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 06e376bcd2..87a4bfb415 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1138,8 +1138,8 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
>  /* Return correct return code for a delete event */
>  enum {
>      ALL_DELETE,
> -    PARTIAL_DELETE,
>      READ_ONLY,
> +    PARTIAL_DELETE,
>  };

This is defining these values as an incrementing series...


>      if (o->format == FMT_UNDEFINED_OBJECT) {
>          if (remove(o->path)) {
> -            partial_delete = true;
> +            ret |= READ_ONLY;
>          } else {
>              usb_mtp_object_free_one(s, o);
> -            success = true;
> +            ret |= ALL_DELETE;

...but here we're using them as bits which we OR together.
In particular ALL_DELETE is 0, so ORing it in will
do nothing.

thanks
-- PMM
