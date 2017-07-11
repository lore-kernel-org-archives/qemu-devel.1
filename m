Received: from eggs.gnu.org ([2001:4830:134:3::10]:46170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUrc1-0007ii-IU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUrbx-0001bA-Mu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:37:45 -0400
Date: Tue, 11 Jul 2017 11:37:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711093734.GF4335@noname.str.redhat.com>
References: <1499687125-22948-1-git-send-email-kwolf@redhat.com>
	<CAFEAcA_2dB3rN6mJcwrxShPaEO8dEzoNU27dTkWC3jjnjRPC6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_2dB3rN6mJcwrxShPaEO8dEzoNU27dTkWC3jjnjRPC6g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] commit: Add NULL check for overlay_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable@nongnu.org

Am 10.07.2017 um 14:09 hat Peter Maydell geschrieben:
> On 10 July 2017 at 12:45, Kevin Wolf <kwolf@redhat.com> wrote:
> > I can't see how overlay_bs could become NULL with the current code, but
> > other code in this function already checks it and we can make Coverity
> > happy with this check, so let's add it.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/commit.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/commit.c b/block/commit.c
> > index 774a8a5..50e7950 100644
> > --- a/block/commit.c
> > +++ b/block/commit.c
> > @@ -90,7 +90,9 @@ static void commit_complete(BlockJob *job, void *opaque)
> >
> >      /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
> >      bdrv_ref(top);
> > -    bdrv_ref(overlay_bs);
> > +    if (overlay_bs) {
> > +        bdrv_ref(overlay_bs);
> > +    }
> >
> >      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
> >       * the normal backing chain can be restored. */
> 
> Commit 19ebd13ed45ad5d5f2 which added the bdrv_ref() call
> was cc qemu-stable; should we cc this fix too, or are you
> happy that it's definitely not actually triggerable in stable?

Okay, I'll add the CC, better safe than sorry.

Kevin
