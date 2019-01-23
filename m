Received: from eggs.gnu.org ([209.51.188.92]:46347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmLCs-00044Z-7o
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmLCp-0007Gn-P8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:16:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b3e3cb90-32a6-77b0-1c5b-8281181c8ae8@redhat.com>
References: <cover.1548171741.git.berto@igalia.com>
	<6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
	<735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
	<w518szbmmw9.fsf@maestria.local.igalia.com>
	<b3e3cb90-32a6-77b0-1c5b-8281181c8ae8@redhat.com>
Date: Wed, 23 Jan 2019 17:16:42 +0100
Message-ID: <w5136pjmjrp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio-scsi: Forbid devices with
 different iothreads sharing a blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 23 Jan 2019 04:47:30 PM CET, Paolo Bonzini wrote:
>> You mean a common function with the code below?
>> 
>>>> +        ctx = blk_get_aio_context(sd->conf.blk);
>>>> +        if (ctx != s->ctx && ctx != qemu_get_aio_context()) {
>>>> +            error_setg(errp, "Cannot attach a blockdev that is using "
>>>> +                       "a different iothread");
>>>> +            return;
>>>> +        }
>> 
>> Who else would be the user?
>
> If it isn't, probably virtio-blk should be using too.

I agree, but that's the problem that I mentioned on the cover letter.

In the virtio-blk case I don't know how to tell that the block device is
using a different iothread during device_add, because the iothread is
not set during realize() but by virtio_blk_data_plane_start() that
happens only when I reboot the guest.

Berto
