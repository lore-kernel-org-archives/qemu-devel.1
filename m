Received: from eggs.gnu.org ([2001:4830:134:3::10]:55243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3Qg-0001B8-Ln
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3Qf-0008Le-PV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:28:50 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:34647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC3Qf-0008La-J1
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:28:49 -0400
Received: by mail-ot0-x231.google.com with SMTP id i5-v6so2021349oth.1
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:28:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180227083919.12339-6-kraxel@redhat.com>
References: <20180227083919.12339-1-kraxel@redhat.com>
	<20180227083919.12339-6-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:28:28 +0100
Message-ID: <CAFEAcA8yrYiLynXgvKuG3o=R-5YMt9U-=ec8ODUpqX==qE-9KQ@mail.gmail.com>
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

> +static void usb_mtp_write_metadata(MTPState *s)

Hi; Coverity points out a missing error check in this function
(CID 1390578):

> +{
> +    MTPData *d = s->data_out;
> +    ObjectInfo *dataset = (ObjectInfo *)d->data;
> +    char *filename = g_new0(char, dataset->length);
> +    MTPObject *o;
> +    MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);

usb_mtp_object_lookup() can return NULL, but we do not check it...

> +    uint32_t next_handle = s->next_handle;
> +
> +    assert(!s->write_pending);
> +
> +    utf16_to_str(dataset->length, dataset->filename, filename);
> +
> +    o = usb_mtp_object_lookup_name(p, filename, dataset->length);

...and if p is NULL here then we will crash in usb_mtp_object_lookup_name().

> +    if (o != NULL) {
> +        next_handle = o->handle;
> +    }
> +
> +    s->dataset.filename = filename;
> +    s->dataset.format = dataset->format;
> +    s->dataset.size = dataset->size;
> +    s->dataset.filename = filename;
> +    s->write_pending = true;
> +
> +    if (s->dataset.format == FMT_ASSOCIATION) {
> +        usb_mtp_write_data(s);
> +        /* next_handle will be allocated to the newly created dir */
> +        if (d->fd == -1) {
> +            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
> +                                 0, 0, 0, 0);
> +            return;
> +        }
> +        d->fd = -1;
> +    }
> +
> +    usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
> +                         s->dataset.parent_handle, next_handle);
> +}
> +

thanks
-- PMM
