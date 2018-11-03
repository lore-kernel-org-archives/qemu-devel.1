Received: from eggs.gnu.org ([2001:4830:134:3::10]:42103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gIzfM-0002UW-8E
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 13:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gIzfL-0005mX-7E
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 13:24:56 -0400
References: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
	<ad9227ab-bcce-1703-e6aa-a7b14907868b@redhat.com>
	<e9a68107-ccde-337d-25f2-5636c8a89f19@amazon.com>
	<156d16ca-1e89-1b00-cba4-bfcfc100f9c4@redhat.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <48544a04-a8f7-dec5-ecc0-b5c0ed5156a4@oracle.com>
Date: Sun, 4 Nov 2018 01:24:38 +0800
MIME-Version: 1.0
In-Reply-To: <156d16ca-1e89-1b00-cba4-bfcfc100f9c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to emulate block I/O timeout on qemu side?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Marc Olson <marcolso@amazon.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

Hi all,

I tried with the patch at:

https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00394.html

The patch is applied to qemu-3.0.0.


Below configuration is used to test the feature for guest VM nvme.

# qemu-system-x86_64 \
-smp 4 -m 2000M -enable-kvm -vnc :0 -monitor stdio \
-net nic -net user,hostfwd=tcp::5022-:22 \
-drive file=virtio-disk.img,format=raw,if=none,id=disk0 \
-device virtio-blk-pci,drive=disk0,id=disk0-dev,num-queues=2,iothread=io1 \
-object iothread,id=io1 \
-device nvme,drive=nvme1,serial=deadbeaf1 \
-drive file=blkdebug:blkdebug.config:nvme.img,if=none,id=nvme1

# cat blkdebug.config
[delay]
event = "write_aio"
latency = "9999999999"
sector = "40960"


The 'write' latency of sector=40960 is set to a very large value. When the I/O
is stalled in guest due to that sector=40960 is accessed, I do see below
messages in guest log:

[   80.807755] nvme nvme0: I/O 11 QID 2 timeout, aborting
[   80.808095] nvme nvme0: Abort status: 0x4001


However, then nothing happens further. nvme I/O hangs in guest. I am not able to
kill the qemu process with Ctrl+C. Both vnc and qemu user net do not work. I
need to kill qemu with "kill -9"


The same result for virtio-scsi and qemu is stuck as well.


About blkdebug, I can only trigger the error by the config file. Is there a way
to inject error or latency via qemu monior? For instance, I would like to inject
error not for a specific sector or state, but for the entire disk when I input
some command via qemu monitor.

Dongli Zhang


On 11/03/2018 02:17 AM, John Snow wrote:
> 
> 
> On 11/02/2018 01:55 PM, Marc Olson wrote:
>> On 11/2/18 10:49 AM, John Snow wrote:
>>> On 11/02/2018 04:11 AM, Dongli Zhang wrote:
>>>> Hi,
>>>>
>>>> Is there any way to emulate I/O timeout on qemu side (not fault
>>>> injection in VM
>>>> kernel) without modifying qemu source code?
>>>>
>>>> For instance, I would like to observe/study/debug the I/O timeout
>>>> handling of
>>>> nvme, scsi, virtio-blk (not supported) of VM kernel.
>>>>
>>>> Is there a way to trigger this on purpose on qemu side?
>>>>
>>>> Thank you very much!
>>>>
>>>> Dongli Zhang
>>>>
>>> I don't think the blkdebug driver supports arbitrary delays right now.
>>> Maybe we could augment it to do so?
>>>
>>> (I thought someone already had, but maybe it wasn't merged?)
>>>
>>> Aha, here:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05297.html
>>> V2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00394.html
>>>
>>> Let's work from there.
>>
>> I've got updates to that patch series that fell on the floor due to
>> other competing things. I'll get some screen time this weekend to work
>> on them and submit v3.
>>
>> /marc
>>
> 
> Great! Please CC the usual maintainers, but also include me.
> 
> In the meantime, Dongli Zhang, why don't you try the v2 patch and see if
> that helps you out for your use case? Report back if it works for you or
> not.
> 
> --js
> 
