Received: from eggs.gnu.org ([209.51.188.92]:56991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guieH-000093-NQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guieF-0006YA-Qn
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:55:45 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guieE-0006Vn-GI
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:55:42 -0500
Received: by mail-ot1-x32d.google.com with SMTP id n8so18247481otl.6
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 10:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20190130073426.11525-1-kraxel@redhat.com>
	<20190130073426.11525-8-kraxel@redhat.com>
	<CAFEAcA-hgtFq-LHY=73+PtQKp2J-b6LdG73+Ag_uPtwF9Z4iYg@mail.gmail.com>
	<jpgef886gbk.fsf@linux.bootlegged.copy>
In-Reply-To: <jpgef886gbk.fsf@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Feb 2019 18:55:29 +0000
Message-ID: <CAFEAcA8Q_73RQZOwqJSVA8AaY2D82n4Tb66gvdWP90mdroJs6Q@mail.gmail.com>
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
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 15 Feb 2019 at 18:45, Bandan Das <bsd@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > CID 1398642: This early-return case in usb_mtp_write_data() returns
> > from the function without doing any of the cleanup (closing file,
> > freeing data, etc). Possibly it should be "goto done;" instead ?
> > The specific thing Coverity complains about is the memory pointed
> > to by "path".
> >
>
> I believe this is a false positive, there's still more data incoming
> and we have successfully written the data we got this time, so we return
> without freeing up any of the structures. I will add a comment here.

Looking at the code I think Coverity is correct about the 'path'
string. We allocate this with
            path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
and then use it in a mkdir() and an open() call, and never
save the pointer anywhere. But we only g_free() it in the
exit paths that go through "free:".

One simple fix to this would be to narrow the scope of 'path',
so we deal with it only inside the if():

        if (s->dataset.filename) {
            char *path = g_strdup_printf("%s/%s", parent->path,
s->dataset.filename);
            if (s->dataset.format == FMT_ASSOCIATION) {
                d->fd = mkdir(path, mask);
                g_free(path);
                goto free;
            }
            d->fd = open(path, O_CREAT | O_WRONLY |
                         O_CLOEXEC | O_NOFOLLOW, mask);
            g_free(path);
            if (d->fd == -1) {
                usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                     0, 0, 0, 0);
                goto done;
            }
            [...]

and then drop the g_free(path) from the end of the function.


While I'm looking at this, that call to mkdir() looks bogus:
                d->fd = mkdir(path, mask);
mkdir() does not return a file descriptor, it returns a
0-or-negative status code (which we are not checking),
so storing its result into d->fd looks very weird. If
we ever do try to treat d->fd as an fd later on then we
will end up operating on stdin, which is going to have
very confusing effects.


If the MTPState* is kept around and reused, should the
cleanup code that does close(d->fd) also set d->fd to -1,
so that we know that the fd has been closed and don't
later try to close it twice or otherwise use it ?

thanks
-- PMM
