Received: from eggs.gnu.org ([2001:4830:134:3::10]:56011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpYfX-0001J7-Gz
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpYfS-0002Xl-NO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:38:55 -0400
Date: Wed, 6 Sep 2017 13:38:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906113845.GE3753@dhcp-200-186.str.redhat.com>
References: <20170906085006.26983-1-rjones@redhat.com>
	<20170906101905.GD3753@dhcp-200-186.str.redhat.com>
	<20170906104451.GM20914@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906104451.GM20914@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] qemu-options: Document the -drive
 locking parameter.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, famz@redhat.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru

Am 06.09.2017 um 12:44 hat Richard W.M. Jones geschrieben:
> On Wed, Sep 06, 2017 at 12:19:05PM +0200, Kevin Wolf wrote:
> > Am 06.09.2017 um 10:50 hat Richard W.M. Jones geschrieben:
> > > Commit 16b48d5d66d2 ("file-posix: Add 'locking' option") added this
> > > option, but as it was not documented in the -help output it was not
> > > easily possible to tell if a particular qemu binary supports it.
> > > 
> > > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > > ---
> > >  qemu-options.hx | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 9f6e2adfff..f8f95eb498 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -796,7 +796,7 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
> > >      "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
> > >      "       [,serial=s][,addr=A][,rerror=ignore|stop|report]\n"
> > >      "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
> > > -    "       [,readonly=on|off][,copy-on-read=on|off]\n"
> > > +    "       [,readonly=on|off][,copy-on-read=on|off][,locking=off|auto|on]\n"
> > >      "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
> > >      "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
> > >      "       [[,iops=i]|[[,iops_rd=r][,iops_wr=w]]]\n"
> > 
> > 'locking' is a driver-specific option and not universally available for
> > all images, so it shouldn't be included here.
> 
> Indeed this patch is wrong, please ignore it.
> 
> However I couldn't work out the incantation to disable locking for a
> qcow2 overlay backed by a file which is locked by another qemu
> process:
> 
>   ...
>       -drive file=/home/rjones/d/libguestfs/tmp/libguestfsSOXEiU/overlay1,cache=unsafe,format=qcow2,file.locking=off,id=hd0,if=none \
>       -device scsi-hd,drive=hd0 \
>   ...
>   qemu-system-x86_64: -device scsi-hd,drive=hd0: Failed to get shared "write" lock
>   Is another process using the image?
>   ...

This command line fragment looks correct to me. For me, it seems to
work. I'm starting a first qemu in the background with default locking
options:

    $ x86_64-softmmu/qemu-system-x86_64 -hda /tmp/test.qcow2

And then starting a second one with a command line resembling yours:

    $ x86_64-softmmu/qemu-system-x86_64 -device virtio-scsi \
      -drive file=/tmp/test.qcow2,cache=unsafe,format=qcow2,file.locking=off,id=hd0,if=none \
      -device scsi-hd,drive=hd0

This works for me. If I set file.locking=auto, it fails as expected, so
it's not that the locking isn't working for me at all.

> I'm guessing I need another level of indirection to get to the backing
> file, but file.file.locking=off did not work either.

No, that would be too much. Without a prefix you configure the qcow2
layer, with the 'file.' prefix you configure the file-posix one. There
is no further nested node.

> I think the error message there is wrong as well since it doesn't
> refer to the right command line option nor tell you which file is
> locked.

This is interesting, I do get -drive in my error message with
locking=auto.

I could see how your message makes sense with -blockdev because I think
then the image file is really only locked as soon as it is used (and
only with the permissions that that user requires), so -device would in
fact be where it happens and the error message would reflect that. But
with -drive, we already request some permissions while opening the
image, so I would definitely expect -drive in your error message.

Kevin
