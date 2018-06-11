Received: from eggs.gnu.org ([2001:4830:134:3::10]:50737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fSLrr-0007vV-BX
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fSLrn-00043R-66
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:24:15 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180611122006.GE15038@localhost.localdomain>
References: <w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
	<b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
	<w51h8nqcijb.fsf@maestria.local.igalia.com>
	<aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
	<20180503122241.GA6140@localhost.localdomain>
	<w51zi0e6apc.fsf@maestria.local.igalia.com>
	<20180611122006.GE15038@localhost.localdomain>
Date: Mon, 11 Jun 2018 14:23:31 +0200
Message-ID: <w51tvq9zf3w.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon 11 Jun 2018 02:20:06 PM CEST, Kevin Wolf wrote:
> Am 01.06.2018 um 12:51 hat Alberto Garcia geschrieben:
>> On Thu 03 May 2018 02:22:41 PM CEST, Kevin Wolf wrote:
>> >> > Were the (more or less) exact requirements of QMP blockdev-reopen
>> >> > discussed? How is it different from qemu-io's "reopen" command?
>> >> > What are the options that you can and can not change?
>> >> 
>> >> I can't quite remember, I'm afraid.  I think it was supposed to be
>> >> pretty much qemu-io's reopen (so just bdrv_reopen()).  I suppose you
>> >> cannot change the driver (obviously) or probably the node name, because
>> >> either would result in the node being replaced by a completely new one.
>> >> 
>> >> Other than that, it probably depends on what the block driver supports,
>> >> but ideally you should be able to change everything.
>> >
>> > Honestly the design of bdrv_reopen() is quite broken because of the
>> > way it tries to maintain old options if they aren't specified, and
>> > guesses what you might mean when you add flags to the mix. The exact
>> > semantics are quite complicated and I'd rather avoid them in a stable
>> > API.
>> >
>> > A clean QMP command would probably apply the same defaults as
>> > blockdev-add, so you just get to specify the full options again.
>> 
>> I have a prototype of this working and almost ready to be published, but
>> there's a tricky thing with this part:
>> 
>> If we want blockdev-reopen to apply the defaults for all options except
>> from the ones expliclity specified by the user, then it means that we
>> need to check not just the options that are present, but also the ones
>> that are omitted.
>> 
>> For example:
>> 
>>    { "execute": "blockdev-add",
>>      "arguments": { "driver": "null-aio",
>>                     "node-name": "root",
>>                     "size": 1024 }
>> 
>> This adds a null-aio block device with the "size" option set to 1024
>> (the default is 1 << 30).
>> 
>> null_reopen_prepare() allows reopening that block device, but it does
>> not allow changing any of its options. Attempting to change the value of
>> "size" is detected by the loop that checks unhandled options at the end
>> of bdrv_reopen_prepare() and returns "Cannot change the option 'size'".
>> 
>> So far, so good. We have this generic check for all options that works
>> with all drivers, so as long as we only specify options that we know
>> that can be changed, everything is fine.
>> 
>> However if we want blockdev-reopen to apply the default values for all
>> omitted options, then omitting "size" would be equivalent to setting it
>> to its default value (1 << 30). And if "size" cannot be changed then
>> QEMU should complain unless we explicitly set "size" to 1024 again on
>> reopen.
>> 
>> This complicates things a bit, because we would go from "the options
>> that can't be changed are the ones that are not handled by each driver's
>> _prepare() function" to "options that are absent can also produce an
>> error".
>
> To be honest, I think this is fine. If the user can specify the size
> once (in blockdev-add), they can do it again (in blockdev-reopen).
>
> We just need to make sure that we don't break existing bdrv_reopen*()
> calls that come from places other than the monitor.

Good. I have the first revision of the series almost ready, expect it
this week.

Berto
