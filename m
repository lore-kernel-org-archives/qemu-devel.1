Received: from eggs.gnu.org ([2001:4830:134:3::10]:52756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0S9E-00028f-1r
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0S9C-0008QT-QQ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:22:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170412091819.GB4955@noname.str.redhat.com> (Kevin Wolf's
	message of "Wed, 12 Apr 2017 11:18:19 +0200")
References: <20170412091819.GB4955@noname.str.redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 14:22:03 +0200
Message-ID: <878tmxj47o.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] migrate -b problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com, dgilbert@redhat.com

Kevin Wolf <kwolf@redhat.com> wrote:
> Hi all,

Hi

> after getting assertion failure reports for block migration in the last
> minute, we just hacked around it by commenting out op blocker assertions
> for the 2.9 release, but now we need to see how to fix things properly.
> Luckily, get_maintainer.pl doesn't report me, but only you. :-)

migration/block.c  is a classic.  Anyone that touches it last is the
maintainer.


> The main problem I see with the block migration code (on the
> destination) is that it abuses the BlockBackend that belongs to the
> guest device to make its own writes to the image file. If the guest
> isn't allowed to write to the image (which it now isn't during incoming
> migration since it would conflict with the newer style of block
> migration using an NBD server), writing to this BlockBackend doesn't
> work any more.
>
> So what should really happen is that incoming block migration creates
> its own BlockBackend for writing to the image. Now we don't want to do
> this anew for every incoming block, but ideally we'd just create all
> necessary BlockBackends upfront and then keep using them throughout the
> whole migration. Is there a way to get some setup/teardown callbacks
> at the start/end of the migration that could initialise and free such
> global data?

Two answers:

- Easy one (for me).  look at how spice/qxl use migration notifiers (no,
  it is not pretty, but its what is already done).

- More difficult
  I am trying to get an easier to use way migration notifiers.  What we
  need is to be able to schedule:
     - when we start a migration
        * this thing that you need
     - when we finish a migration (either complete, error or cancel)
        * basically to do a free
        * or spice to handle the screen seamlesly to the new client
     - when we are about to start last stage of migration
        * so devices can write things to memory
          Look at new arm GIC (or PIC) or whatever on the list

And probably something more that I haven't yet think about.

> The other problem with block migration is that is uses a BlockBackend
> name to identify which device is migrated. However, there can be images
> that are not attached to any BlockBackend, or if it is, the BlockBackend
> might be anonymous, so this doesn't work. I suppose changing the field
> to "device name if available, node-name otherwise" would solve this.

That is above my knowledge.

Later, Juan.
