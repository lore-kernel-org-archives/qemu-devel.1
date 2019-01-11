Received: from eggs.gnu.org ([209.51.188.92]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghxdi-0005cg-8G
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghxZc-0000jI-Ry
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:14:13 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190111132416.GI5010@dhcp-200-186.str.redhat.com>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
Date: Fri, 11 Jan 2019 15:14:08 +0100
Message-ID: <w51pnt3qo27.fsf@maestria.local.igalia.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 11 Jan 2019 02:24:16 PM CET, Kevin Wolf wrote:
>> >> The following QMP command leads to a crash when iothreads are used:
>> >>
>> >>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }
>> >
>> > How did you reproduce this? Do you have a test case?
>> 
>> Ok, I finally reproduced it, the patch looks good to me.
>
> Can it be turned into a qemu-iotests case or is it too complicated for
> that?

I can reproduce the problem reliably with this:

{ "execute": "qmp_capabilities" }
{ "execute": "blockdev-add",
  "arguments": {"driver": "null-co", "node-name": "hd0"}}
{ "execute": "object-add",
  "arguments": {"qom-type": "iothread", "id": "iothread0"}}
{ "execute": "device_add",
  "arguments": {"id": "scsi0", "driver": "virtio-scsi-pci",
                "iothread": "iothread0"}}
{ "execute": "device_add",
  "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
{ "execute": "block_set_io_throttle",
  "arguments": {"id": "scsi-hd0", "bps": 0, "bps_rd": 0, "bps_wr": 0,
                "iops": 1000, "iops_rd": 0, "iops_wr": 0}}
{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}

But this doesn't crash if I put it in an iotest.

Berto
