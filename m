Received: from eggs.gnu.org ([2001:4830:134:3::10]:56044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cuzhx-0004Vd-4G
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cuzht-0002GJ-Rw
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cuzht-0002Ev-Je
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:59:33 -0400
Date: Mon, 3 Apr 2017 11:59:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403105912.GL2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170320131703.GN3792@redhat.com>
	<cf6a29f8-2dac-4246-8cd3-86790b52409b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf6a29f8-2dac-4246-8cd3-86790b52409b@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, Jani Kokkonen <jani.kokkonen@huawei.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On Tue, Mar 21, 2017 at 10:25:31AM +0100, Pradeep Jagadeesh wrote:
> 
> On 3/20/2017 2:17 PM, Daniel P. Berrange wrote:
> > On Mon, Mar 20, 2017 at 09:07:20AM -0400, Pradeep Jagadeesh wrote:
> > 
> > > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > > index 8819281..e4e3478 100644
> > > --- a/hmp-commands.hx
> > > +++ b/hmp-commands.hx
> > > @@ -1637,6 +1637,34 @@ ETEXI
> > >      },
> > > 
> > >  STEXI
> > > +@item 9p_passwd @var{device} @var{password}
> > > +@findex 9p_passwd
> > > +Set the encrypted device @var{device} password to @var{password}
> > > +ETEXI
> > > +
> > > +    {
> > > +        .name       = "fs9p_set_io_throttle",
> > > +        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
> > > +        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
> > > +        .help       = "change I/O throttle limits for a block drive",
> > > +        .cmd        = hmp_9pfs_set_io_throttle,
> > > +    },
> > > +
> > > +STEXI
> > > +@item fs9p_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
> > > +@findex 9pfs_set_io_throttle
> > > +Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
> > > +ETEXI
> > > +
> > > +    {
> > > +        .name       = "set_password",
> > > +        .args_type  = "protocol:s,password:s,connected:s?",
> > > +        .params     = "protocol password action-if-connected",
> > > +        .help       = "set spice/vnc password",
> > > +        .cmd        = hmp_set_password,
> > > +    },
> > > +
> > > +STEXI
> > 
> > This looks all mangled wrt password related stuff
> I did not understand the usage of the password.
> Do we really need password here?.
> I just followed how is it done in block devices.

This is all just wrong - remove all these password related stuff.

> > > +##
> > > +# @fs9p_set_io_throttle:
> > > +#
> > > +# Change I/O limits for a 9p/fsdev device.
> > > +#
> > > +# Since QEMU 2.9, I/0 limits can be enabled on each  fsdev(9pfs) device
> > 
> > Is this supposed to be generic for any fsdev impl, or specific to the
> > 9p impl only ? Without knowing more, I'd expect us to really be designing
> > something generic, and not tied to just the 9p impl. IOW,  having '9p' in
> > the name of the QAPI commands feels wrong - use of 'fsdev' feels like the
> > better naming. Same applies to the HMP commands.
> Yes its for the fsdev. But other than 9p when the fsdev is used?
> I will rename 9p to fsdev.

The point is that this is a public API which needs long term support. We
thus need to consider the possibility that we'll have other usage of the
fsdev framework in future that is not related to 9p, even though it does
not exist today.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
