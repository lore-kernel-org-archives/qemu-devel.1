Received: from eggs.gnu.org ([2001:4830:134:3::10]:49664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLXx3-0004qx-U3
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLXx3-0004fF-1V
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:53:30 -0400
References: <CAGtobs_PEYmSyPwbYG-6oNp9PxwQ52xHaFuXh59ELWcrAm6LSA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <340670a5-c9f3-ccf0-6af2-1bc1dc471866@redhat.com>
Date: Wed, 23 May 2018 13:53:23 -0400
MIME-Version: 1.0
In-Reply-To: <CAGtobs_PEYmSyPwbYG-6oNp9PxwQ52xHaFuXh59ELWcrAm6LSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AIO error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>



On 05/22/2018 06:01 PM, Nishanth Aravamudan via Qemu-devel wrote:
> Hi!
> 

Hi! CCing qemu-block@nongnu.org;

> I'm tracking an error case in the native AIO path, and was wondering if
> there was a latent (albeit possibly hard to hit) bug. Specifically
> util/async.c::aio_get_linux_aio:
> 
> #ifdef CONFIG_LINUX_AIO
> LinuxAioState *aio_get_linux_aio(AioContext *ctx)
> {
>     if (!ctx->linux_aio) {
>         ctx->linux_aio = laio_init();
>         laio_attach_aio_context(ctx->linux_aio, ctx);
>     }
>     return ctx->linux_aio;
> }
> #endif
> 
> laio_init() can in certain conditions return NULL, but that's not checked
> here and then the NULL result is passed directly into
> laio_attach_aio_context, which dereferences it without checking that the
> pointer is valid.
> 

Looks like a good old-fashioned bug to me:

``
    if (event_notifier_init(&s->e, false) < 0) {
        goto out_free_state;
    }

    if (io_setup(MAX_EVENTS, &s->ctx) != 0) {
        goto out_close_efd;
    }

...

out_close_efd:
    event_notifier_cleanup(&s->e);
out_free_state:
    g_free(s);
    return NULL;
``

event_notifier_init looks like it is... usually(?) going to return
-errno on error, and the man page for io_setup suggests that the libaio
wrapper for io_setup is supposed to return -errno if it fails; we could
probably hold onto that error code.

We probably ought to forward those error codes up to the caller; maybe:

int laio_init(LinuxAioState **linux_aio);

> I'm not sure what is appropriate if laio_init() returns NULL, returning
> NULL back to the caller of aio_get_linux_aio() has its own issues, because
> those callers don't seem to check its return value either.
> 

If laio_init can return NULL,  aio_get_linux_aio needs to check for that.

Then callers of that ought to be amended to return some kind of error:

raw_co_prw can return whatever laio_init returned as an error code.
raw_aio_plug doesn't have a way to communicate errors, yet...
raw_aio_unplug doesn't have an error reporting mechanism either.

Those last two are defined here:

    .bdrv_io_plug = raw_aio_plug,
    .bdrv_io_unplug = raw_aio_unplug,

but it looks like bdrv_io_un|plug doesn't return errors either.

bdrv_io_plug is called by both blk_io_plug and itself, but has no other
callers.

blk_io_plug is called in two places:

virtio_scsi_handle_cmd_req_prepare, which can report -errno error codes
(so we can amend blk_io_plug and bdrv_io_plug to just bubble up errors), and

virtio_blk_handle_vq -- which doesn't appear to be capable of handling
an error, just indicating "progress".

unplug has three usages, one in virtio-blk and two in virtio-scsi, all
of which only appear to check for "progress" and don't seem to have
explicit error reporting.

Probably unplug can't actually fail like this though -- I'm assuming by
the name that it must occur after a call to plug and that will have
memoized the call to aio_get_linux_aio by then.

So... probably what we need to do here is take a look at the virtio-blk
usage of plug and do error-plumbing as necessary.

Wanna send a patch?

--js

> Thanks in advance!
> -Nish
> 
