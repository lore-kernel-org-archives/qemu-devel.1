Received: from eggs.gnu.org ([2001:4830:134:3::10]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ctrUn-0007wE-Vv
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ctrUi-0008IH-Ls
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:01:22 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:33124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1ctrUi-0008HQ-Fu
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:01:16 -0400
Received: by mail-it0-x241.google.com with SMTP id w11so1375320itb.0
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 01:01:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170331090731.27b10c0c@bahia.lab.toulouse-stg.fr.ibm.com>
References: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
	<c65ce78e-9a33-ee17-0a49-2a28390060f0@redhat.com>
	<20170330174608.0ed57618@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAKXe6SKEbvxLWiCjSo7AYzAQmzdEGOeeYL47BYkcFPGx8VA20g@mail.gmail.com>
	<20170331090731.27b10c0c@bahia.lab.toulouse-stg.fr.ibm.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 31 Mar 2017 16:01:15 +0800
Message-ID: <CAKXe6SJhBAjRm_BWQEombeApxbdvVdNnpEc53SfFwWDPT1bQGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9?] 9pfs: fix migration_block leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>

2017-03-31 15:07 GMT+08:00 Greg Kurz <groug@kaod.org>:

> On Fri, 31 Mar 2017 09:26:35 +0800
> Li Qiang <liq3ea@gmail.com> wrote:
>
> > Hello,
> >
> > 2017-03-30 23:46 GMT+08:00 Greg Kurz <groug@kaod.org>:
> >
> > > On Thu, 30 Mar 2017 08:25:25 -0500
> > > Eric Blake <eblake@redhat.com> wrote:
> > >
> > > > On 03/30/2017 07:27 AM, Li Qiang wrote:
> > > > > The guest can leave the pdu->s->migration_blocker exists by attach
> > > >
> > > > s/exists/in place/
> > > > s/attach/attaching/
> > > >
> > >
> >
> > Eric,
> > Thanks for pointing my mistakes!
> >
> >
> > > > > but not remove a fid. Then if we hot unplug the 9pfs device, the
> > > >
> > >
> > > In theory you're right, but the current 9p client in linux won't let
> you
> > > hot
> > > unplug the device unless you unmount the 9p share first, hence freeing
> the
> > > blocker.
> > >
> > >
> > I think we should consider every possible situation.
> >
> >
> > > > s/remove/removing/
> > > >
> > > > > v9fs_reset() just free the fids, but not free the
> migration_blocker.
> > > > > This will leak a memory leak. This patch avoid this.
> > >
> > > I had a similar issue sitting my TODO list for quite a time: the
> blocker
> > > survives a system_reset. It doesn't cause a memory leak but it prevents
> > > migration until the guest mounts/unmounts the 9p share again.
> > >
> > > This boils down to virtfs_reset() calling free_fid() instead of
> put_fid()
> > > IIRC.
> > >
> > > >
> > > > s/leak a/cause a/
> > > > s/avoid/avoids/
> > > >
> > > > >
> > > > > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > > > > ---
> > > > >  hw/9pfs/9p.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > >
> > > > Probably worth including in 2.9 as a bug fix.
> > > >
> > > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > > >
> > > > >
> > > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > > index 48babce..b55c02d 100644
> > > > > --- a/hw/9pfs/9p.c
> > > > > +++ b/hw/9pfs/9p.c
> > > > > @@ -548,6 +548,12 @@ static void coroutine_fn virtfs_reset(V9fsPDU
> > > *pdu)
> > > > >              free_fid(pdu, fidp);
> > > > >          }
> > > > >      }
> > > > > +
> > > > > +    if (pdu->s->migration_blocker) {
> > > > > +        migrate_del_blocker(pdu->s->migration_blocker);
> > > > > +        error_free(pdu->s->migration_blocker);
> > > > > +        pdu->s->migration_blocker = NULL;
> > > > > +    }
> > >
> > > I'd prefer to drain all PDUs in virtfs_reset() and have the loop above
> > > to call put_fid() instead of free_fid(). If this isn't doable for 2.9,
> > > I'll apply this patch with a comment.
> > >
> > >
> > Yes, I have considered to use put_fid() to fix this. But I'm not sure the
> > 'fidp->ref' is  at most 1 in virtfs_reset() function(I think it is).
> >
>
> And indeed, if the fid is involved in an I/O then its ref will be != 0.
>
> > IIUC I think omit the 'else' branch, and call put_fid() directly like
> this.
> >
>
> This won't work: we must ensure that fidp->ref reaches zero (ie, drain
> all PDUs), then we can fidp->ref++ (ie, get a ref on the fid) and call
> put_fid(), which will drop the last ref of the fid and clear the blocker
> if this is the root fid.
>
>
Right, but how can we ensure we have drained all PDUs? Any idea?

Thanks.



> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 48babce..ae97e79 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -544,9 +544,8 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
> >
> >          if (fidp->ref) {
> >              fidp->clunked = 1;
> > -        } else {
> > -            free_fid(pdu, fidp);
> >          }
> > +        put_fid(pdu, fidp);
> >      }
> >  }
> >
> >
> > If you agree, I will send a formal patch.
> >
> >
> >
> > > > >  }
> > > > >
> > > > >  #define P9_QID_TYPE_DIR         0x80
> > > > >
> > > >
> > >
> > >
>
>
