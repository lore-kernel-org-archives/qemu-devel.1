Received: from eggs.gnu.org ([2001:4830:134:3::10]:56987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3XT-0005iG-Rq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3XT-0002p4-16
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:35:51 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:36471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC3XS-0002oy-Qq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:35:50 -0400
Received: by mail-ot0-x231.google.com with SMTP id p2-v6so2044038otf.3
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:35:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180227083919.12339-6-kraxel@redhat.com>
References: <20180227083919.12339-1-kraxel@redhat.com>
	<20180227083919.12339-6-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:35:29 +0100
Message-ID: <CAFEAcA_P+NMaJBSxTnOBjFWRyfgpxOk8Gbxvo6wr7rxbY0dxNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 5/5] usb-mtp: Advertise SendObjectInfo for
 write support
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

On 27 February 2018 at 08:39, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: Bandan Das <bsd@redhat.com>
>
> This patch implements a dummy ObjectInfo structure so that
> it's easy to typecast the incoming data. If the metadata is
> valid, write_pending is set. Also, the incoming filename
> is utf-16, so, instead of depending on external libraries, just
> implement a simple function to get the filename
>
> Signed-off-by: Bandan Das <bsd@redhat.com>
> Message-id: 20180223164829.29683-6-bsd@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 2 deletions(-)

Hi; Coverity points out a pointer use-after-NULL-check in this
code (CID1390592):

> +    case CMD_SEND_OBJECT_INFO:
> +        /* Return error if store is read-only */
> +        if (!FLAG_SET(s, MTP_FLAG_WRITABLE)) {
> +            usb_mtp_queue_result(s, RES_STORE_READ_ONLY,
> +                                 c->trans, 0, 0, 0, 0);
> +        } else if (c->argv[0] && (c->argv[0] != QEMU_STORAGE_ID)) {
> +            /* First parameter points to storage id or is 0 */
> +            usb_mtp_queue_result(s, RES_STORE_NOT_AVAILABLE, c->trans,
> +                                 0, 0, 0, 0);
> +        } else if (c->argv[1] && !c->argv[0]) {
> +            /* If second parameter is specified, first must also be specified */
> +            usb_mtp_queue_result(s, RES_DESTINATION_UNSUPPORTED, c->trans,
> +                                 0, 0, 0, 0);
> +        } else {
> +            uint32_t handle = c->argv[1];
> +            if (handle == 0xFFFFFFFF || handle == 0) {
> +                /* root object */
> +                o = QTAILQ_FIRST(&s->objects);
> +            } else {
> +                o = usb_mtp_object_lookup(s, handle);
> +            }
> +            if (o == NULL) {

Here we do a NULL check on 'o'...

> +                usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE, c->trans,
> +                                     0, 0, 0, 0);
> +            }
> +            if (o->format != FMT_ASSOCIATION) {

...but here we dereference 'o', which will crash if it is NULL.

> +                usb_mtp_queue_result(s, RES_INVALID_PARENT_OBJECT, c->trans,
> +                                     0, 0, 0, 0);
> +            }
> +        }
> +        if (o) {
> +            s->dataset.parent_handle = o->handle;
> +        }
> +        s->data_out = usb_mtp_data_alloc(c);
> +        return;

thanks
-- PMM
