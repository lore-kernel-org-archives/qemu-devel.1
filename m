Received: from eggs.gnu.org ([209.51.188.92]:33150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1guj42-0004yP-Ls
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1guj40-00027G-Qp
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:22:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1guj3z-00025g-JX
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:22:20 -0500
From: Bandan Das <bsd@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
	<20190130073426.11525-8-kraxel@redhat.com>
	<CAFEAcA-hgtFq-LHY=73+PtQKp2J-b6LdG73+Ag_uPtwF9Z4iYg@mail.gmail.com>
	<jpgef886gbk.fsf@linux.bootlegged.copy>
	<CAFEAcA8Q_73RQZOwqJSVA8AaY2D82n4Tb66gvdWP90mdroJs6Q@mail.gmail.com>
Date: Fri, 15 Feb 2019 14:22:12 -0500
In-Reply-To: <CAFEAcA8Q_73RQZOwqJSVA8AaY2D82n4Tb66gvdWP90mdroJs6Q@mail.gmail.com>
	(Peter Maydell's message of "Fri, 15 Feb 2019 18:55:29 +0000")
Message-ID: <jpgva1k3li3.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 15 Feb 2019 at 18:45, Bandan Das <bsd@redhat.com> wrote:
>>
...
>> I believe this is a false positive, there's still more data incoming
>> and we have successfully written the data we got this time, so we return
>> without freeing up any of the structures. I will add a comment here.
>
> Looking at the code I think Coverity is correct about the 'path'
> string. We allocate this with
>             path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
> and then use it in a mkdir() and an open() call, and never
> save the pointer anywhere. But we only g_free() it in the
> exit paths that go through "free:".
>
Thanks for the catch! Indeed, it's not being saved anywhere. I assumed
without looking it's d->path but we don't need path anywhere else, so I guess
your solution below is fair.

> One simple fix to this would be to narrow the scope of 'path',
> so we deal with it only inside the if():
>
>         if (s->dataset.filename) {
>             char *path = g_strdup_printf("%s/%s", parent->path,
> s->dataset.filename);
>             if (s->dataset.format == FMT_ASSOCIATION) {
>                 d->fd = mkdir(path, mask);
>                 g_free(path);
>                 goto free;
>             }
>             d->fd = open(path, O_CREAT | O_WRONLY |
>                          O_CLOEXEC | O_NOFOLLOW, mask);
>             g_free(path);
>             if (d->fd == -1) {
>                 usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
>                                      0, 0, 0, 0);
>                 goto done;
>             }
>             [...]
>
> and then drop the g_free(path) from the end of the function.
>
>
> While I'm looking at this, that call to mkdir() looks bogus:
>                 d->fd = mkdir(path, mask);
> mkdir() does not return a file descriptor, it returns a
> 0-or-negative status code (which we are not checking),
> so storing its result into d->fd looks very weird. If
> we ever do try to treat d->fd as an fd later on then we
> will end up operating on stdin, which is going to have
> very confusing effects.
>
Agreed, this is incorrect and confusing. I will add a test
for mkdir. I will post a patch for this as well as set
d->fd to -1. Thanks for taking a look.

Bandan

>
> If the MTPState* is kept around and reused, should the
> cleanup code that does close(d->fd) also set d->fd to -1,
> so that we know that the fd has been closed and don't
> later try to close it twice or otherwise use it ?
>
> thanks
> -- PMM
