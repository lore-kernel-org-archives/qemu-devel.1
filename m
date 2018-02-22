Received: from eggs.gnu.org ([2001:4830:134:3::10]:39983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopFa-0006Pf-2Y
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopFY-0002Aj-W0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:41:22 -0500
Date: Thu, 22 Feb 2018 11:40:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180222114053.GE9323@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
	<7c23f28d-ee14-c504-ae13-04414c4b032e@redhat.com>
	<20180222105755.GB4147@localhost.localdomain>
	<37efa6ac-8e36-9c96-84ef-a8639ba64937@kamp.de>
	<20180222113204.GC4147@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222113204.GC4147@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Thu, Feb 22, 2018 at 12:32:04PM +0100, Kevin Wolf wrote:
> Am 22.02.2018 um 12:01 hat Peter Lieven geschrieben:
> > Am 22.02.2018 um 11:57 schrieb Kevin Wolf:
> > > Am 20.02.2018 um 22:54 hat Paolo Bonzini geschrieben:
> > >> On 20/02/2018 18:04, Peter Lieven wrote:
> > >>> Hi,
> > >>>
> > >>> I remember we discussed a long time ago to limit the stack usage of all
> > >>> functions that are executed in a coroutine
> > >>> context to a very low value to be able to safely limit the coroutine
> > >>> stack size as well.
> > >> IIRC the only issue was that hw/ide/atapi.c has mutual recursion between
> > >> ide_atapi_cmd_reply_end -> ide_transfer_start -> ahci_start_transfer ->
> > >> ide_atapi_cmd_reply_end.
> > >>
> > >> But perhaps it's not an issue, somebody needs to audit the code.
> > > I think John intended to get rid of the recursion sometime, but I doubt
> > > he has had the time so far.
> > 
> > Apart from this is is possible to define special cflags in the
> > Makefile.objs just for a subdirectory? I have patches ready to make
> > the block layer files and other coroutine users compile with
> > -Wstack-size=2048. But I do not want to specify each file separately.
> 
> Our Makefiles have lines like this:
> 
>     iscsi.o-cflags     := $(LIBISCSI_CFLAGS)
> 
> I don't think there is a direct mechanism to apply cflags to a whole
> directory or just to block-obj-y/block-obj-m, but just looping over them
> could work. I'm not a Makefile expert at all, but after some toying with
> a simple example, something like this might work:
> 
>     $(foreach x,$(block-obj-y),$(eval $x-cflags += -Wstack-size=2048))

You'll need it for anything block layer depends on too - so that's much
of util/, crypto/ and io/ directories at least.

So perhaps it would be shorter if we do the opposite - set -Wstack-size=2048
globally for everything in QEMU, and then override -Wstack-size=$BIGGER
for the (hopefully) few sources that have a larger stack need ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
