Received: from eggs.gnu.org ([2001:4830:134:3::10]:44478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eNd0J-0000Wp-Fs
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 06:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eNd0G-0001Gw-9C
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 06:09:11 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8312ac9e-207b-87a8-3b4b-c7c3f70c0ead@redhat.com>
References: <20171207170834.15843-1-berto@igalia.com>
	<83722fb4-2458-fc9c-ddfe-6b7e7b65ca46@redhat.com>
	<w51609ijpsb.fsf@maestria.local.igalia.com>
	<8312ac9e-207b-87a8-3b4b-c7c3f70c0ead@redhat.com>
Date: Sat, 09 Dec 2017 12:08:30 +0100
Message-ID: <w51374krwep.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Tweak 030 in order
 to trigger a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 08 Dec 2017 08:13:48 PM CET, John Snow <jsnow@redhat.com> wrote:

>>>>              qemu_io('-f', iotests.imgfmt,
>>>> -                    '-c', 'write -P %d %d %d' % (i, i*1024*1024, num_kb * 1024),
>>>> +                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),
>>>
>>> I guess changing from a variable to a fixed 0xff pattern doesn't
>>> make a difference?
>> 
>> I noticed that with the previous code we would write zeroes to the
>> first image (i == 0), and with that I can't reproduce the bug. I
>> assume that block-stream doesn't copy the data in that case. Changing
>> it to anything != 0 solves the problem.
>
> I think I ran into a similar problem with an AHCI test once.

It's this bit from bdrv_co_do_copy_on_readv() (which is the way
block-stream is implemented):

    if (drv->bdrv_co_pwrite_zeroes &&
        buffer_is_zero(bounce_buffer, pnum)) {
        /* FIXME: Should we (perhaps conditionally) be setting
         * BDRV_REQ_MAY_UNMAP, if it will allow for a sparser copy
         * that still correctly reads as zero? */
        ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, pnum, 0);
    } else {
        /* This does not change the data on the disk, it is not
         * necessary to flush even in cache=writethrough mode.
         */
        ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
                                  &local_qiov, 0);
    }

Berto
