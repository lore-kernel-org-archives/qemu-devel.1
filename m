Received: from eggs.gnu.org ([209.51.188.92]:58717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Pu-0005JG-OE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Pu-0001XE-2x
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:40:42 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190114133553.GE7038@stefanha-x1.localdomain>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
	<20190114133553.GE7038@stefanha-x1.localdomain>
Date: Mon, 14 Jan 2019 15:40:39 +0100
Message-ID: <w51won7480o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 14 Jan 2019 02:35:53 PM CET, Stefan Hajnoczi wrote:
> On Fri, Jan 11, 2019 at 03:14:08PM +0100, Alberto Garcia wrote:
>> On Fri 11 Jan 2019 02:24:16 PM CET, Kevin Wolf wrote:
>> >> >> The following QMP command leads to a crash when iothreads are used:
>> >> >>
>> >> >>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }
>> >> >
>> >> > How did you reproduce this? Do you have a test case?
>> >> 
>> >> Ok, I finally reproduced it, the patch looks good to me.
>> >
>> > Can it be turned into a qemu-iotests case or is it too complicated for
>> > that?
>> 
>> I can reproduce the problem reliably with this:
>> 
>> { "execute": "qmp_capabilities" }
>> { "execute": "blockdev-add",
>>   "arguments": {"driver": "null-co", "node-name": "hd0"}}
>> { "execute": "object-add",
>>   "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>> { "execute": "device_add",
>>   "arguments": {"id": "scsi0", "driver": "virtio-scsi-pci",
>>                 "iothread": "iothread0"}}
>> { "execute": "device_add",
>>   "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
>> { "execute": "block_set_io_throttle",
>>   "arguments": {"id": "scsi-hd0", "bps": 0, "bps_rd": 0, "bps_wr": 0,
>>                 "iops": 1000, "iops_rd": 0, "iops_wr": 0}}
>> { "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>> 
>> But this doesn't crash if I put it in an iotest.
>
> I've been able to reproduce this in an iotest, please see v2 of this
> series.

That iotest doesn't crash for me :-?

Berto
