Received: from eggs.gnu.org ([209.51.188.92]:33121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghyW7-0000IU-AL
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghyW6-0000pD-3C
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:14:39 -0500
Date: Fri, 11 Jan 2019 16:14:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111151426.GM5010@dhcp-200-186.str.redhat.com>
References: <cover.1547132561.git.berto@igalia.com>
	<42c8dab1efbcd608a09a1d84468fc498b612bfa1.1547132561.git.berto@igalia.com>
	<20190111150213.GK5010@dhcp-200-186.str.redhat.com>
	<w51muo7qlo4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51muo7qlo4.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] block: Acquire the AioContext in
 scsi_*_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 11.01.2019 um 16:05 hat Alberto Garcia geschrieben:
> On Fri 11 Jan 2019 04:02:13 PM CET, Kevin Wolf wrote:
> >> @@ -2568,7 +2579,10 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
> >>      }
> >>  
> >>      /* check we are using a driver managing SG_IO (version 3 and after) */
> >> +    ctx = blk_get_aio_context(s->qdev.conf.blk);
> >> +    aio_context_acquire(ctx);
> >>      rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
> >> +    aio_context_release(ctx);
> >>      if (rc < 0) {
> >>          error_setg_errno(errp, -rc, "cannot get SG_IO version number");
> >>          if (rc != -EPERM) {
> >
> > This is probably not enough. get_device_type() and
> > scsi_generic_read_device_inquiry() below issue more ioctls (but we
> > need to be careful not to include the scsi_realize() call in the
> > locked section if you take the lock again there).
> 
> Hmmm, another alternative is not to take the lock in scsi_realize() and
> take it instead in all the functions that call it (it's 4 or 5).

We touch most of them anyway, so I think it is an option.

Kevin
