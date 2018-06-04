Received: from eggs.gnu.org ([2001:4830:134:3::10]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fPoKA-0001Wi-Gx
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fPoK9-0005eP-6k
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:10:58 -0400
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<20180601133202.GS8687@stefanha-x1.localdomain>
	<84ff808f-2856-808e-0a42-a1b5e0d3c64b@tuxera.com>
	<20180604095133.GE13674@stefanha-x1.localdomain>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <9bd3376a-f7b3-5f51-7fe0-79888898da7f@tuxera.com>
Date: Mon, 4 Jun 2018 15:10:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180604095133.GE13674@stefanha-x1.localdomain>
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

On 06/04/2018 12:51 PM, Stefan Hajnoczi wrote:
> On Fri, Jun 01, 2018 at 05:24:53PM +0300, Ari Sundholm wrote:
>> On 06/01/2018 04:32 PM, Stefan Hajnoczi wrote:
>>> On Fri, Jun 01, 2018 at 12:17:19AM +0300, Ari Sundholm wrote:
>>>> From: Aapo Vienamo <aapo@tuxera.com>
>>>
>>> Thanks for the patch!
>>>
>>>> Implements a block device write logging system, similar to Linux kernel
>>>> device mapper dm-log-writes. The write operations that are performed
>>>> on a block device are logged to a file or another block device. The
>>>> write log format is identical to the dm-log-writes format. Currently,
>>>> log markers are not supported.
>>>>
>>>> This functionality can be used for fail-safe and fs consistency
>>>> testing. By implementing it in qemu, tests utilizing write logs can be
>>>> be used to test non-Linux drivers and older kernels.
>>>
>>> This patch doesn't implement the same semantics as dm-log-writes, where
>>> only completed writes are logged to make fs consistency testing easier.
>>> If you intend to use it for this purpose, shouldn't it act the same way
>>> as dm-log-writes?
>>>
>>
>> I am not quite sure what you mean. I am not the original author of this
>> proposed feature, but to me (admittedly with little experience of qemu
>> internals), it looks like the driver accurately logs the writes and flushes
>> performed on the guest block device. It intentionally does not concern
>> itself with when the write actually hits the physical host block device or
>> file, as we're interested in the direct interactions between a filesystem
>> driver and the guest block device. The write hitting the various levels of
>> the host-side caches and devices is left up to the caching mode. But perhaps
>> there's something obvious I'm not seeing?
> 
> Linux dm-log-writes is specific about when logging happens:
> 
>   * We log writes only after they have been flushed, this makes the log describe
>   * close to the order in which the data hits the actual disk, not its cache.  So
>   * for example the following sequence (W means write, C means complete)
>   *
>   * Wa,Wb,Wc,Cc,Ca,FLUSH,FUAd,Cb,CFLUSH,CFUAd
>   *
>   * Would result in the log looking like this:
>   *
>   * c,a,flush,fuad,b,<other writes>,<next flush>
>   *
>   * This is meant to help expose problems where file systems do not properly wait
>   * on data being written before invoking a FLUSH.  FUA bypasses cache so once it
>   * completes it is added to the log as it should be on disk.
> 
> This patch implements the same on-disk format but the semantics are
> different since it doesn't wait for a flush.
> 
> If I use dm-log-writes on a linear device-mapper target inside the guest
> or on the host, then I would have expected the same output as QEMU's
> dm-log-writes, but I think this is not the case.
> 
> It's worth at least documenting this quirk.

Oh, now I see what you mean.

I was under the impression that when we do the logging at the level it 
is done now, we see the actual writes to the guest block device to 
completion, as far as the guest is concerned (being safely in the host's 
page cache is enough for this). Is this understanding incorrect?

Regarding the issue of waiting for flushes, as it is now, the driver 
only updates the superblock of the log on flush, and everything in the 
log file/device beyond the limits set by the values in the superblock is 
typically ignored as garbage by tools handling dm-log-writes logs. (I 
wonder if dm-log-writes actually works similarly by exploiting this 
fact?) QEMU does a flush on shutdown, though, so, with how the code 
works, all writes will have hit the disk and been logged, unless QEMU 
has crashed or cache=unsafe is on (have to figure out what to do about 
that last bit!).

I guess this at least requires documenting, regardless of whether the 
behavior is correct or not. Thank you for bringing this up!

Thanks,
Ari Sundholm
ari@tuxera.com

> 
> Stefan
> 
