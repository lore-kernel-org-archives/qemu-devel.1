Received: from eggs.gnu.org ([2001:4830:134:3::10]:51446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEDe5-0000Lf-27
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEDe4-0005y5-Ap
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:47:37 -0400
References: <20180423084518.2426-1-armbru@redhat.com>
	<20180423130219.GD6630@localhost.localdomain>
	<87d0ydorv6.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29e37e65-ba08-4464-79cf-2238bc74e9e8@redhat.com>
Date: Thu, 3 May 2018 14:47:25 +0200
MIME-Version: 1.0
In-Reply-To: <87d0ydorv6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 03/05/2018 14:17, Markus Armbruster wrote:
>>> 4. Connect to the QMP socket e.g. like this:
>>>    $ socat UNIX:/your/qmp/socket READLINE,history=$HOME/.qmp_history,prompt='QMP> '
>>>
>>>    Issue QMP command 'qmp_capabilities':
>>>    QMP> { "execute": "qmp_capabilities" }
>>>
>>> 5. Boot the guest.
>>>
>>> 6. In the guest, write to the scratch disk, e.g. like this:
>>>
>>>    # dd if=/dev/zero of=/dev/vdb count=1
>>>
>>>    Do double-check the device specified with of= is actually the
>>>    scratch device!
>>>
>>> 7. Issue QMP command 'cont':
>>>    QMP> { "execute": "cont" }
>>>
>>> After step 6, I get a BLOCK_IO_ERROR event followed by a STOP event.  Good.
>>>
>>> After step 7, I get BLOCK_IO_ERROR, then RESUME, then STOP.  Not so
>>> good; I'd expect RESUME, then BLOCK_IO_ERROR, then STOP.
>> Do you want to rephrase this in the form of a script for qemu-iotests?
>>
>> I suppose the 'dd' line can be replaced by a 'qemu-io' monitor command.
> Uh, can it?  With qemu-io, the write doesn't stop the guest, because it
> bypasses the device model, and thus blk_error_action().  I'm not aware
> of ways to make qemu-iotests write via a device model.  I'm afraid we
> need a full-fledged qtest.  Better ideas?

Yeah, using virtio-blk-test sounds like a good idea.

Paolo
