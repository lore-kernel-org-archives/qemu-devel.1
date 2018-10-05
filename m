Received: from eggs.gnu.org ([2001:4830:134:3::10]:43705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8Ps9-0000a2-Rr
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8Pry-0000n1-PW
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:10:25 -0400
Date: Fri, 5 Oct 2018 15:10:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181005131001.GA4606@localhost.localdomain>
References: <20181001171901.11004-1-kwolf@redhat.com>
	<20181001171901.11004-9-kwolf@redhat.com>
	<CAFEAcA95awvCWT8FA-qfcpYiovpmprSFeA5yxa1BbhZX12BbeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA95awvCWT8FA-qfcpYiovpmprSFeA5yxa1BbhZX12BbeA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 08/23] file-posix: Forbid trying to change
 unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 05.10.2018 um 14:55 hat Peter Maydell geschrieben:
> On 1 October 2018 at 18:18, Kevin Wolf <kwolf@redhat.com> wrote:
> > From: Alberto Garcia <berto@igalia.com>
> >
> > The file-posix code is used for the "file", "host_device" and
> > "host_cdrom" drivers, and it allows reopening images. However the only
> > option that is actually processed is "x-check-cache-dropped", and
> > changes in all other options (e.g. "filename") are silently ignored:
> >
> >    (qemu) qemu-io virtio0 "reopen -o file.filename=no-such-file"
> >
> > While we could allow changing some of the other options, let's keep
> > things as they are for now but return an error if the user tries to
> > change any of them.
> >
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/file-posix.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index bc5e54560a..2da3a76355 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -849,8 +849,13 @@ static int raw_reopen_prepare(BDRVReopenState *state,
> >          goto out;
> >      }
> >
> > -    rs->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
> > -                                                false);
> > +    rs->check_cache_dropped =
> > +        qemu_opt_get_bool_del(opts, "x-check-cache-dropped", false);
> > +
> > +    /* This driver's reopen function doesn't currently allow changing
> > +     * other options, so let's put them back in the original QDict and
> > +     * bdrv_reopen_prepare() will detect changes and complain. */
> > +    qemu_opts_to_qdict(opts, state->options);
> 
> Hi. Coverity is suspicious about this call to qemu_opts_to_qdict()
> because it returns a value which this callsite is ignoring but
> almost all others don't ignore (CID 1395991). Is it correct?
> 
> (It also doesn't like the call in block.c: CID 1395989.)

I think this is a false positive. qemu_opts_to_qdict() returns the dict
it was given, except if NULL was given, then it returns a newly
allocated one.

Kevin
