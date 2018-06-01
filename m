Received: from eggs.gnu.org ([2001:4830:134:3::10]:41341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOkzM-0006Py-Bw
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOkzG-0004Zi-Lp
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:25:08 -0400
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<20180601133202.GS8687@stefanha-x1.localdomain>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <84ff808f-2856-808e-0a42-a1b5e0d3c64b@tuxera.com>
Date: Fri, 1 Jun 2018 17:24:53 +0300
MIME-Version: 1.0
In-Reply-To: <20180601133202.GS8687@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>

On 06/01/2018 04:32 PM, Stefan Hajnoczi wrote:
> On Fri, Jun 01, 2018 at 12:17:19AM +0300, Ari Sundholm wrote:
>> From: Aapo Vienamo <aapo@tuxera.com>
> 
> Thanks for the patch!
> 
>> Implements a block device write logging system, similar to Linux kernel
>> device mapper dm-log-writes. The write operations that are performed
>> on a block device are logged to a file or another block device. The
>> write log format is identical to the dm-log-writes format. Currently,
>> log markers are not supported.
>>
>> This functionality can be used for fail-safe and fs consistency
>> testing. By implementing it in qemu, tests utilizing write logs can be
>> be used to test non-Linux drivers and older kernels.
> 
> This patch doesn't implement the same semantics as dm-log-writes, where
> only completed writes are logged to make fs consistency testing easier.
> If you intend to use it for this purpose, shouldn't it act the same way
> as dm-log-writes?
> 

I am not quite sure what you mean. I am not the original author of this 
proposed feature, but to me (admittedly with little experience of qemu 
internals), it looks like the driver accurately logs the writes and 
flushes performed on the guest block device. It intentionally does not 
concern itself with when the write actually hits the physical host block 
device or file, as we're interested in the direct interactions between a 
filesystem driver and the guest block device. The write hitting the 
various levels of the host-side caches and devices is left up to the 
caching mode. But perhaps there's something obvious I'm not seeing?

Speaking of the caching mode, I now realized that the log superblock is 
probably never written out when cache=unsafe is set, which will need fixing.

>> The implementation is based on the blkverify and blkdebug block drivers.
> 
> This functionality overlaps with existing block drivers.  In the
> long-term people want to observe I/O requests in various ways beyond
> what the dm-log-writes offers.  Therefore I'd like to suggest a
> different approach that extends the quorum driver instead:
> 
> Add a read-pattern=first parameter to the block/quorum.c driver so it
> only reads from the first child.  QEMU can be launched with quorum and
> NBD so that writes and flushes are mirrored to the external NBD server.
> 
> Any file format or online analysis can be implemented in the NBD server.
> There are a number of NBD plugins here:
> https://github.com/libguestfs/nbdkit
> 
> I think sending the writes and flushes over NBD is more flexible.
> 

That sounds interesting! I will look into this possibility.

Thanks,
Ari Sundholm
ari@tuxera.com
