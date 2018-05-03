Received: from eggs.gnu.org ([2001:4830:134:3::10]:51949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEDgv-0001gy-7g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEDgu-0007HX-8B
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:50:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180423084518.2426-1-armbru@redhat.com>
	<20180423130219.GD6630@localhost.localdomain>
	<87d0ydorv6.fsf@dusky.pond.sub.org>
	<20180503122642.GB6140@localhost.localdomain>
Date: Thu, 03 May 2018 14:50:25 +0200
In-Reply-To: <20180503122642.GB6140@localhost.localdomain> (Kevin Wolf's
	message of "Thu, 3 May 2018 14:26:42 +0200")
Message-ID: <87muxgoqcu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] cpus: Fix event order on resume of stopped
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 03.05.2018 um 14:17 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 23.04.2018 um 10:45 hat Markus Armbruster geschrieben:
>> >> When resume of a stopped guest immediately runs into block device
>> >> errors, the BLOCK_IO_ERROR event is sent before the RESUME event.
>> >> 
>> >> Reproducer:
>> >> 
>> >> 1. Create a scratch image
>> >>    $ dd if=/dev/zero of=scratch.img bs=1M count=100
>> >> 
>> >>    Size doesn't actually matter.
>> >> 
>> >> 2. Prepare blkdebug configuration:
>> >> 
>> >>    $ cat >blkdebug.conf <<EOF
>> >>    [inject-error]
>> >>    event = "write_aio"
>> >>    errno = "5"
>> >>    EOF
>> >> 
>> >>    Note that errno 5 is EIO.
>> >> 
>> >> 3. Run a guest with an additional scratch disk, i.e. with additional
>> >>    arguments
>> >>    -drive if=none,id=scratch-drive,format=raw,werror=stop,file=blkdebug:blkdebug.conf:scratch.img
>> >>    -device virtio-blk-pci,id=scratch,drive=scratch-drive
>> >> 
>> >>    The blkdebug part makes all writes to the scratch drive fail with
>> >>    EIO.  The werror=stop pauses the guest on write errors.
>> >> 
>> >> 4. Connect to the QMP socket e.g. like this:
>> >>    $ socat UNIX:/your/qmp/socket READLINE,history=$HOME/.qmp_history,prompt='QMP> '
>> >> 
>> >>    Issue QMP command 'qmp_capabilities':
>> >>    QMP> { "execute": "qmp_capabilities" }
>> >> 
>> >> 5. Boot the guest.
>> >> 
>> >> 6. In the guest, write to the scratch disk, e.g. like this:
>> >> 
>> >>    # dd if=/dev/zero of=/dev/vdb count=1
>> >> 
>> >>    Do double-check the device specified with of= is actually the
>> >>    scratch device!
>> >> 
>> >> 7. Issue QMP command 'cont':
>> >>    QMP> { "execute": "cont" }
>> >> 
>> >> After step 6, I get a BLOCK_IO_ERROR event followed by a STOP event.  Good.
>> >> 
>> >> After step 7, I get BLOCK_IO_ERROR, then RESUME, then STOP.  Not so
>> >> good; I'd expect RESUME, then BLOCK_IO_ERROR, then STOP.
>> >
>> > Do you want to rephrase this in the form of a script for qemu-iotests?
>> >
>> > I suppose the 'dd' line can be replaced by a 'qemu-io' monitor command.
>> 
>> Uh, can it?  With qemu-io, the write doesn't stop the guest, because it
>> bypasses the device model, and thus blk_error_action().  I'm not aware
>> of ways to make qemu-iotests write via a device model.  I'm afraid we
>> need a full-fledged qtest.  Better ideas?
>
> I'm afraid you're right. :-(
>
> Did I ever mention that I don't really like having the werror logic in
> the devices?

Only a few times :)

There's an explanation next to blk_error_action():

/* This is done by device models because, while the block layer knows
 * about the error, it does not know whether an operation comes from
 * the device or the block layer (from a job, for example).
 */
