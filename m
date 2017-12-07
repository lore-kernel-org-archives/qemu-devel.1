Received: from eggs.gnu.org ([2001:4830:134:3::10]:32924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eN1w4-0000BF-6B
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eN1vz-00029j-9c
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:34:20 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <83722fb4-2458-fc9c-ddfe-6b7e7b65ca46@redhat.com>
References: <20171207170834.15843-1-berto@igalia.com>
	<83722fb4-2458-fc9c-ddfe-6b7e7b65ca46@redhat.com>
Date: Thu, 07 Dec 2017 20:34:12 +0100
Message-ID: <w51609ijpsb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] iotests: Tweak 030 in order to trigger a
 race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 07 Dec 2017 08:16:41 PM CET, Eric Blake wrote:
>>              qemu_io('-f', iotests.imgfmt,
>> -                    '-c', 'write -P %d %d %d' % (i, i*1024*1024, num_kb * 1024),
>> +                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),
>
> I guess changing from a variable to a fixed 0xff pattern doesn't make
> a difference?

I noticed that with the previous code we would write zeroes to the first
image (i == 0), and with that I can't reproduce the bug. I assume that
block-stream doesn't copy the data in that case. Changing it to anything
!= 0 solves the problem.

And answering your question, it doesn't really matter if we write the
same value in all places, we only check the output of 'qemu-io -c map'.
Plus the areas don't even overlap.

Berto
