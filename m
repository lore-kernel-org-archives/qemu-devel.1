Received: from eggs.gnu.org ([2001:4830:134:3::10]:51941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYN1K-0002v0-2w
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYN1G-0008Gq-5Q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dYN1F-0008Fc-Si
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:46:18 -0400
Date: Fri, 21 Jul 2017 09:46:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170721014611.GL11032@lemon>
References: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
	<1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
	<edae6aa7-34ef-a3a8-94e0-175f05728345@redhat.com>
	<DM2PR21MB0060A68EDF44A9FC4B018C909EA10@DM2PR21MB0060.namprd21.prod.outlook.com>
	<20170720065324.GH11032@lemon>
	<DM2PR21MB00604522F0A851502DF8B4FD9EA70@DM2PR21MB0060.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM2PR21MB00604522F0A851502DF8B4FD9EA70@DM2PR21MB0060.namprd21.prod.outlook.com>
Subject: Re: [Qemu-devel] Disable image locking for snapshot drive?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, 07/20 21:49, Andrew Baumann via Qemu-devel wrote:
> > From: Fam Zheng [mailto:famz@redhat.com]
> > Sent: Wednesday, 19 July 2017 23:53
> > 
> > On Tue, 07/18 16:19, Andrew Baumann wrote:
> > > > From: Eric Blake [mailto:eblake@redhat.com]
> > > > Sent: Tuesday, 18 July 2017 8:07
> > > > On 07/17/2017 07:33 PM, John Snow wrote:
> > > > > On 07/17/2017 07:30 PM, Andrew Baumann via Qemu-devel wrote:
> > > > >> I'm running a recent Linux build of qemu on Windows Subsystem for
> > Linux
> > > > (WSL) which doesn't appear to implement file locking:
> > > > >>
> > > > >> $ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,id=hd0 -
> > device
> > > > virtio-blk-pci,drive=hd0
> > > > >> qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to
> > > > unlock byte 100
> > > >
> > > > Does WSL implement fcntl(F_SETLK) but not fcntl(F_OFD_SETLK)?
> > >
> > > Yes, this appears to be the case (there's also one report that it's broken):
> > > https://github.com/Microsoft/BashOnWindows/issues/1927
> > 
> > What does fcntl(F_OFD_SETLK) return? If it is -ENOTSUP, we can probably
> > detect
> > that and disable locking. Can you try the patch pasted in the end?
> 
> It returns -EINVAL. Your patch works, if I change the error code. Maybe
> testing for either ENOTSUP or EINVAL, and only allowing the fallback if the
> user didn't force locking on, would be a reasonable compromise?

I'm less comfortable with treating -EINVAL as "not supported".

A better fallback simply disabling is probably F_SETLK. Anyway I think a message
to stderr should be printed like the "#ifndef F_OFD_SETLK" case.

I'll work on a formal patch which does that.

Thanks,
Fam

> 
> Cheers,
> Andrew
> 
> > ---
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index cfbb236f6f..0be5bbbd53 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -493,6 +493,12 @@ static int raw_open_common(BlockDriverState *bs,
> > QDict *options,
> >      }
> >      s->fd = fd;
> > 
> > +    if (s->use_lock) {
> > +        int ret0 = qemu_unlock_fd(fd, 0, 0);
> > +        if (ret0 == -ENOTSUP) {
> > +            s->use_lock = false;
> > +        }
> > +    }
> >      s->lock_fd = -1;
> >      if (s->use_lock) {
> >          fd = qemu_open(filename, s->open_flags);
> 
