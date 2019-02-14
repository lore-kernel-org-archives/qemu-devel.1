Received: from eggs.gnu.org ([209.51.188.92]:50768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guM7p-0002SV-Bu
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guM7l-0006Hs-MG
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:52:43 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:43549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guM7g-00066G-Ah
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:52:40 -0500
Received: by mail-ot1-x330.google.com with SMTP id n71so12260814ota.10
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20190130073426.11525-1-kraxel@redhat.com>
	<20190130073426.11525-8-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-8-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 18:52:21 +0000
Message-ID: <CAFEAcA-hgtFq-LHY=73+PtQKp2J-b6LdG73+Ag_uPtwF9Z4iYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 7/8] usb-mtp: breakup MTP write into smaller
 chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 30 Jan 2019 at 07:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Bandan Das <bsd@redhat.com>
>
> For every MTP_WRITE_BUF_SZ copied, this patch writes it to file before
> getting the next block of data. The file is kept opened for the
> duration of the operation but the sanity checks on the write operation
> are performed only once when the write operation starts. Additionally,
> we also update the file size in the object metadata once the file has
> completely been written.
>
> Suggested-by: Gerd Hoffman <kraxel@redhat.com>
> Signed-off-by: Bandan Das <bsd@redhat.com>
> Message-id: 20190129131908.27924-3-bsd@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Hi; Coverity has spotted a couple of issues with this patch:


> +static void usb_mtp_update_object(MTPObject *parent, char *name)
> +{
> +    MTPObject *o =
> +        usb_mtp_object_lookup_name(parent, name, strlen(name));
> +
> +    if (o) {
> +        lstat(o->path, &o->stat);

CID 1398651: We don't check the return value of this lstat() for failure.

> +    }
> +}
> +
>  static void usb_mtp_write_data(MTPState *s)
>  {
>      MTPData *d = s->data_out;

[...]

> +    case WRITE_CONTINUE:
> +    case WRITE_END:
> +        rc = write_retry(d->fd, d->data, d->data_offset,
> +                         d->offset - d->data_offset);
> +        if (rc != d->data_offset) {
>              usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
>                                   0, 0, 0, 0);
>              goto done;
> +        }
> +        if (d->write_status != WRITE_END) {
> +            return;

CID 1398642: This early-return case in usb_mtp_write_data() returns
from the function without doing any of the cleanup (closing file,
freeing data, etc). Possibly it should be "goto done;" instead ?
The specific thing Coverity complains about is the memory pointed
to by "path".

thanks
-- PMM
