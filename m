Received: from eggs.gnu.org ([2001:4830:134:3::10]:38487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1d1bOi-0000An-BP
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1d1bOe-00023U-6K
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:27:04 -0400
Received: from mail1.windriver.com ([147.11.146.13]:43692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1d1bOd-00023G-TJ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:27:00 -0400
Message-ID: <58FA32CC.2060104@windriver.com>
Date: Fri, 21 Apr 2017 10:26:52 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <58F92229.1080402@windriver.com>
	<a09762ce-092f-6fb1-6cc3-08a94a3c3dd1@redhat.com>
In-Reply-To: <a09762ce-092f-6fb1-6cc3-08a94a3c3dd1@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] question about block size and virtual disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 04/20/2017 03:21 PM, Eric Blake wrote:
> On 04/20/2017 04:03 PM, Chris Friesen wrote:

>> Also, does the 4KB block size get "passed-through" to the guest somehow
>> so that the guest knows it needs to use 4KB blocks, or does that need to
>> be explicitly specified via virtio-blk-pci.logical_block_size and/or
>> virtio-blk-pci.physical_block_size parameters?  (Assuming I'm using
>> virtio-blk-pci.)
>
> Again, qemu should be passing the advertisement of host properties down
> to the guest insofar as possible (so a good guest will see that the
> hardware is 4k only and will not try to make 512-byte requests), but at
> the same time, qemu should handle guests that are so old that they are
> blissfully unaware of the hardware advertisements and send 512-byte
> requests anyway.  Of course, such guests are penalized with
> read-modify-write delays when submitting 512-byte IO.  But explicitly
> stating available parameters is always the wisest course of action, if
> you don't want to rely on defaults changing underneath you.

I did an experiment with qemu-kvm-ev-2.6.0-28.el7_3.6.1, using -drive 
cache=none,aio=native and an LVM volume as the storage.

The guest saw the logical/physical block size as 512B, even though on the host 
both were 4KB.

Unless something is being lost in the LVM layer (which is possible) it appears 
that qemu defaults to 512B block size unless explicitly told otherwise.

Chris
