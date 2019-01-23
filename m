Received: from eggs.gnu.org ([209.51.188.92]:59827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gmQxv-0008Nd-Mw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gmQxu-0007w5-DO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:25:47 -0500
Date: Wed, 23 Jan 2019 22:25:29 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190123222529.GF12500@redhat.com>
References: <20190123211953.28578-1-eblake@redhat.com>
	<20190123215521.GD12500@redhat.com>
	<5bd946ae-0f88-375b-072f-40b0aa850ab2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd946ae-0f88-375b-072f-40b0aa850ab2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Deprecate qemu-nbd --partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, qemu-block@nongnu.org, thuth@redhat.com, "reviewer:Incompatible changes" <libvir-list@redhat.com>

On Wed, Jan 23, 2019 at 04:18:16PM -0600, Eric Blake wrote:
> On 1/23/19 3:55 PM, Richard W.M. Jones wrote:
> > On Wed, Jan 23, 2019 at 03:19:53PM -0600, Eric Blake wrote:
> >> The existing qemu-nbd --partition code claims to handle logical
> >> partitions up to 8, since its introduction in 2008 (commit 7a5ca86).
> >> However, the implementation is bogus (actual MBR logical partitions
> >> form a sort of linked list, with one partition per extended table
> >> entry, rather than four logical partitions in a single extended
> >> table), making the code unlikely to work for anything beyond -P5 on
> >> actual guest images. What's more, the code does not support GPT
> >> partitions, which are becoming more popular, and maintaining device
> >> subsetting in both NBD and the raw device is unnecessary maintenance
> >> burden.  And nbdkit has just added code to properly handle an
> >> arbitrary number of MBR partitions, along with its existing code
> >> for handling GPT partitions.
> >>
> >> Note that obtaining the offsets of a partition can be learned by
> >> using 'qemu-nbd -c /dev/nbd0 file.qcow2 && sfdisk --dump /dev/nbd0',
> >> but by the time you've done that, you might as well just mount
> >> /dev/nbd0p1 that the kernel creates for you.
> >>
> >> Start the clock on the deprecation cycle, with an example of how
> >> to write device subsetting without using -P.
> >>
> 
> >> +For example, if partition 1 is 100MiB starting at 1MiB, the old command
> >> +
> >> +@example{qemu-nbd -P 1 -f qcow2 file.qcow2}
> >> +
> >> +can be rewritten as:
> >> +
> >> +@example{qemu-nbd --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.backing.driver=file,file.backing.filename=file.qcow2}
> >> +
> >> +Alternatively, the @code{nbdkit} project provides a more powerful
> >> +partition filter on top of its nbd plugin, which can be used to select
> >> +an arbitrary MBR or GPT partition on top of any other full-image NBD
> >> +export.
> > 
> > You might want to add the actual command here.
> 
> Good idea - as long as we are deprecating something, telling the user
> how to get the same functionality (in this case, user-space partition
> detection, without involving /dev/nbd) is worth the extra effort.
> 
> >  Unfortunately nbdkit
> > cannot read qcow2 files meaning (as you note already) that you have to
> > forward the connection through the nbdkit-nbd-plugin to qemu-nbd.
> > This worked for me:
> > 
> >   qemu-nbd -t -k /tmp/sock -f qcow2 file.qcow2 &
> >   nbdkit -f --filter=partition nbd socket=/tmp/sock partition=1 &
> 
> Is the -f necessary? Otherwise, yes, this looks reasonable.  I'll add it
> for v2.

It's not necessary, but it makes nbdkit behave the same way with
respect to remaining in the foreground as qemu-nbd.

Rich.

> > If you drop the requirement to demonstrate this with qcow2 then the
> > command would be just this:
> > 
> >   nbdkit --filter=partition file disk.raw partition=1
> > 
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 




-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
