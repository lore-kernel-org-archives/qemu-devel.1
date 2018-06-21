Received: from eggs.gnu.org ([2001:4830:134:3::10]:48709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVzza-0005r7-F7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVzzY-00061n-Qx
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:51:18 -0400
Date: Thu, 21 Jun 2018 15:51:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180621135108.GI5024@localhost.localdomain>
References: <20180614232119.31669-1-naravamudan@digitalocean.com>
	<20180615174729.20544-1-naravamudan@digitalocean.com>
	<1dbfeae9-6cae-179b-214b-61e3f96ac94c@redhat.com>
	<20180619201451.GA6337@breakout> <20180619223557.GA10696@breakout>
	<20180619225400.GA11164@breakout>
	<20180620095742.GB3946@localhost.localdomain>
	<20180620193452.GA25190@breakout> <20180621032614.GA8787@breakout>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621032614.GA8787@breakout>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] [RFC v2] aio: properly bubble
 up errors from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 21.06.2018 um 05:26 hat Nishanth Aravamudan geschrieben:
> On 20.06.2018 [12:34:52 -0700], Nishanth Aravamudan wrote:
> > On 20.06.2018 [11:57:42 +0200], Kevin Wolf wrote:
> > > Am 20.06.2018 um 00:54 hat Nishanth Aravamudan geschrieben:
> > > > On 19.06.2018 [15:35:57 -0700], Nishanth Aravamudan wrote:
> > > > > On 19.06.2018 [13:14:51 -0700], Nishanth Aravamudan wrote:
> > > > > > On 19.06.2018 [14:35:33 -0500], Eric Blake wrote:
> > > > > > > On 06/15/2018 12:47 PM, Nishanth Aravamudan via Qemu-devel wrote:
> > > > > 
> > > > > <snip>
> > > > > 
> > > > > > > >           } else if (s->use_linux_aio) {
> > > > > > > > +            int rc;
> > > > > > > > +            rc = aio_setup_linux_aio(bdrv_get_aio_context(bs));
> > > > > > > > +            if (rc != 0) {
> > > > > > > > +                error_report("Unable to use native AIO, falling back to "
> > > > > > > > +                             "thread pool.");
> > > > > > > 
> > > > > > > In general, error_report() should not output a trailing '.'.
> > > > > > 
> > > > > > Will fix.
> > > > > > 
> > > > > > > > +                s->use_linux_aio = 0;
> > > > > > > > +                return rc;
> > > > > > > 
> > > > > > > Wait - the message claims we are falling back, but the non-zero return code
> > > > > > > sounds like we are returning an error instead of falling back.  (My
> > > > > > > preference - if the user requested something and we can't do it, it's better
> > > > > > > to error than to fall back to something that does not match the user's
> > > > > > > request).
> > > > > > 
> > > > > > I think that makes sense, I hadn't tested this specific case (in my
> > > > > > reading of the code, it wasn't clear to me if raw_co_prw() could be
> > > > > > called before raw_aio_plug() had been called, but I think returning the
> > > > > > error code up should be handled correctly. What about the cases where
> > > > > > there is no error handling (the other two changes in the patch)?
> > > > > 
> > > > > While looking at doing these changes, I realized that I'm not quite sure
> > > > > what the right approach is here. My original rationale for returning
> > > > > non-zero was that AIO was requested but could not be completed. I
> > > > > haven't fully tracked back the calling paths, but I assumed it would get
> > > > > retried at the top level, and since we indicated to not use AIO on
> > > > > subsequent calls, it will succeed and use threads then (note, that I do
> > > > > now realize this means a mismatch between the qemu command-line and the
> > > > > in-use AIO model).
> > > > > 
> > > > > In practice, with my v2 patch, where I do return a non-zero error-code
> > > > > from this function, qemu does not exit (nor is any logging other than
> > > > > that I added emitted on the monitor). If I do not fallback, I imagine we
> > > > > would just continuously see this error message and IO might not actually
> > > > > every occur? Reworking all of the callpath to fail on non-zero returns
> > > > > from raw_co_prw() seems like a fair bit of work, but if that is what is
> > > > > being requested, I can try that (it will just take a while).
> > > > > Alternatively, I can produce a v3 quickly that does not bubble the
> > > > > actual errno all the way up (since it does seem like it is ignored
> > > > > anyways?).
> > > > 
> > > > Sorry for the noise, but I had one more thought. Would it be appropriate
> > > > to push the _setup() call up to when we parse the arguments about
> > > > aio=native? E.g., we already check there if cache=directsync is
> > > > specified and error out if not.
> > > 
> > > We already do this:
> > 
> > Right, I stated above it already is done, I simply meant adding a second
> > check here that we can obtain and setup the AIO context successfully.

Yes, sorry, I misread.

> > >      /* Currently Linux does AIO only for files opened with O_DIRECT */
> > >     if (s->use_linux_aio && !(s->open_flags & O_DIRECT)) {
> > >         error_setg(errp, "aio=native was specified, but it requires "
> > >                          "cache.direct=on, which was not specified.");
> > >         ret = -EINVAL;
> > >         goto fail;
> > >     }
> > > 
> > > laio_init() is about other types of errors. But anyway, yes, calling
> > > laio_init() already in .bdrv_open() is possible. Returning errors from
> > > .bdrv_open() is nice and easy and we should do it.
> > 
> > Ack.
> > 
> > > However, we may also need to call laio_init() again when switching to a
> > > different I/O thread after the image is already opened. This is what I
> > > meant when I commented on v1 that you should do this in the
> > > .bdrv_attach_aio_context callback. The problem here is that we can't
> > > return an error there and the guest is already using the image. In this
> > > case, logging an error and falling back to the thread pool seems to be
> > > the best option we have.
> > 
> > Is this is a request for new functionality? Just trying to understand,
> > because aiui, block/file-posix.c does not implement the
> > bdrv_attach_aio_context callback currently. Instead, aio_get_linux_aio()
> > is called from three places, raw_co_prw, raw_aio_plug and
> > raw_aio_unplug, which calls into laio_init() and
> > laio_attach_aio_context(). I can add the callback you suggest with
> > appropriate error handling (I suppose it would point to
> > laio_attach_aio_context, possibly with some modifications) and remove
> > the call from aio_get_linux_aio()? Just trying to understand the request
> > a bit better, as I don't see where exactly iothreads get switched and
> > how that is implemented currently (and thus where laio_init() would get
> > called again in the current code).

It's not new functionality, but moving things to a different place.

Our goal is that aio_get_linux_aio() never returns NULL in the I/O path
so that we don't have to duplicate the error handling everywhere. For
each AioContext, aio_get_linux_aio() can return NULL only the first
time. Once it successfully returned a LinuxAioState, it will never
return NULL again for the same AioContext.

You cover the QEMU main loop AioContext when you call
aio_get_linux_aio() in raw_open_common(). But whenever the AioContext is
changed, we can get NULL again on the next aio_get_linux_aio() call
because we don't know whether that AioContext already successfully
returned a LinuxAioState before.

If you call once it in .bdrv_attach_aio_context() and disable Linux AIO
if it fails, you have centralised all the error paths that you currently
need in all I/O paths.

> While I waited for a reply to this, I started coding on what I think was
> being asked for and have come to the conclusion that there are actually
> three bugs here :)
> 
> Test cases (with one disk attached to the VM):
> 
> 1) Set /proc/sys/fs/max-aio-nr to 0. Specify aio=native and qemu dies
> with a SIGSEGV.
>     - This case is understood and pushing the laio_init()-return code
>       check to the bdrv_open() path fixes this (and allows for the
>       failure to be communicated to the user).

Right.

> 2) Set /proc/sys/fs/max-aio-nr to 128. Specify aio=native and some
> number of IOThreads. Over qmp issue a x-blockdev-set-iothread command to
> move the block device node to one of the IOThreads. qemu eventually dies
> with a SIGSEGV.
>     - I am fairly sure this is the case you described above, and is
>       fixed by re-implementing the bdrv_{attach,detach}_aio_context
>       callbacks. I have a patch that does this and successfully tested
>       the SEGV is avoided.
> 
> 3) Set /proc/sys/fs/max-aio-nr to 512 (I think 256 would be sufficient,
> though). Specify aio=native and some number of IOThreads. Over qmp issue
> a x-blockdev-set-iothread command to move the block device node to one
> of the IOThreads. Shutdown the guest normally. qemu dies with a SIGABRT.
>     - This appears to be because there is a mismatch in
>       aio_context_{acquire,release} calls (this is my hypothesis right
>       now). The abort comes from bdrv_flush -> aio_context_release and
>       an EPERM from qemu_mutex_unlock_impl() which I believe is just
>       reflecting an EPERM from pthread_mutex_unlock? My theory is that
>       the main qemu thread acquired the aio mutex but then the IOThread
>       released it? I will try and trace the mutexes tomorrow, but I
>       still don't have a fix for this case.

x-blockdev-set-iothread is not the proper way to achieve what you want.
You can only correctly use it with images that are not attached to any
guest device. If you move a block node to a different I/O thread (and
therefore AioContext) under the feet of the guest device, crashes aren't
completely unexpected.

The proper way to test this would be -device virtio-blk,iothread=...
In this case, the raw BlockDriverState is first created in the main
AioContext, but when the virtio-blk device is initialised, it moves it
to the specified I/O thread.

Kevin
