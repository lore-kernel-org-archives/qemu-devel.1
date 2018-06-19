Received: from eggs.gnu.org ([2001:4830:134:3::10]:45412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fVPVl-00050M-Mu
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fVPVi-0002FK-Jg
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:54:05 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:42920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fVPVi-0002Eb-Cc
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:54:02 -0400
Received: by mail-pg0-x242.google.com with SMTP id c10-v6so526471pgu.9
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 15:54:02 -0700 (PDT)
Date: Tue, 19 Jun 2018 15:54:00 -0700
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Message-ID: <20180619225400.GA11164@breakout>
References: <20180614232119.31669-1-naravamudan@digitalocean.com>
	<20180615174729.20544-1-naravamudan@digitalocean.com>
	<1dbfeae9-6cae-179b-214b-61e3f96ac94c@redhat.com>
	<20180619201451.GA6337@breakout> <20180619223557.GA10696@breakout>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619223557.GA10696@breakout>
Subject: Re: [Qemu-devel] [PATCH] [RFC v2] aio: properly bubble up errors
 from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 19.06.2018 [15:35:57 -0700], Nishanth Aravamudan wrote:
> On 19.06.2018 [13:14:51 -0700], Nishanth Aravamudan wrote:
> > On 19.06.2018 [14:35:33 -0500], Eric Blake wrote:
> > > On 06/15/2018 12:47 PM, Nishanth Aravamudan via Qemu-devel wrote:
> 
> <snip>
> 
> > > >           } else if (s->use_linux_aio) {
> > > > +            int rc;
> > > > +            rc = aio_setup_linux_aio(bdrv_get_aio_context(bs));
> > > > +            if (rc != 0) {
> > > > +                error_report("Unable to use native AIO, falling back to "
> > > > +                             "thread pool.");
> > > 
> > > In general, error_report() should not output a trailing '.'.
> > 
> > Will fix.
> > 
> > > > +                s->use_linux_aio = 0;
> > > > +                return rc;
> > > 
> > > Wait - the message claims we are falling back, but the non-zero return code
> > > sounds like we are returning an error instead of falling back.  (My
> > > preference - if the user requested something and we can't do it, it's better
> > > to error than to fall back to something that does not match the user's
> > > request).
> > 
> > I think that makes sense, I hadn't tested this specific case (in my
> > reading of the code, it wasn't clear to me if raw_co_prw() could be
> > called before raw_aio_plug() had been called, but I think returning the
> > error code up should be handled correctly. What about the cases where
> > there is no error handling (the other two changes in the patch)?
> 
> While looking at doing these changes, I realized that I'm not quite sure
> what the right approach is here. My original rationale for returning
> non-zero was that AIO was requested but could not be completed. I
> haven't fully tracked back the calling paths, but I assumed it would get
> retried at the top level, and since we indicated to not use AIO on
> subsequent calls, it will succeed and use threads then (note, that I do
> now realize this means a mismatch between the qemu command-line and the
> in-use AIO model).
> 
> In practice, with my v2 patch, where I do return a non-zero error-code
> from this function, qemu does not exit (nor is any logging other than
> that I added emitted on the monitor). If I do not fallback, I imagine we
> would just continuously see this error message and IO might not actually
> every occur? Reworking all of the callpath to fail on non-zero returns
> from raw_co_prw() seems like a fair bit of work, but if that is what is
> being requested, I can try that (it will just take a while).
> Alternatively, I can produce a v3 quickly that does not bubble the
> actual errno all the way up (since it does seem like it is ignored
> anyways?).

Sorry for the noise, but I had one more thought. Would it be appropriate
to push the _setup() call up to when we parse the arguments about
aio=native? E.g., we already check there if cache=directsync is
specified and error out if not. We could, in theory, also call
laio_init() there (via the new function) and error out to the CLI if
that fails. Then the runtime paths would simply be able to use the
context that was setup earlier? I would need to verify the
laio_cleanup() happens correctly still.

Thanks,
Nish
