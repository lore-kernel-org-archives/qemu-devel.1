Received: from eggs.gnu.org ([2001:4830:134:3::10]:54760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gM6kO-0008BR-EK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 02:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gM6kN-0001s0-F7
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 02:35:00 -0500
References: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
	<ad9227ab-bcce-1703-e6aa-a7b14907868b@redhat.com>
	<e9a68107-ccde-337d-25f2-5636c8a89f19@amazon.com>
	<156d16ca-1e89-1b00-cba4-bfcfc100f9c4@redhat.com>
	<48544a04-a8f7-dec5-ecc0-b5c0ed5156a4@oracle.com>
	<52326245-8ee7-2d6e-4e22-56b9cc7cd04f@amazon.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <297a9736-29fe-4ae4-43bb-a0188636b703@oracle.com>
Date: Mon, 12 Nov 2018 15:36:34 +0800
MIME-Version: 1.0
In-Reply-To: <52326245-8ee7-2d6e-4e22-56b9cc7cd04f@amazon.com>
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
To: Marc Olson <marcolso@amazon.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>



On 11/12/2018 03:13 PM, Marc Olson via Qemu-devel wrote:
> On 11/3/18 10:24 AM, Dongli Zhang wrote:
>> Hi all,
>>
>> I tried with the patch at:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00394.html
>>
>> The patch is applied to qemu-3.0.0.
>>
>>
>> Below configuration is used to test the feature for guest VM nvme.
>>
>> # qemu-system-x86_64 \
>> -smp 4 -m 2000M -enable-kvm -vnc :0 -monitor stdio \
>> -net nic -net user,hostfwd=tcp::5022-:22 \
>> -drive file=virtio-disk.img,format=raw,if=none,id=disk0 \
>> -device virtio-blk-pci,drive=disk0,id=disk0-dev,num-queues=2,iothread=io1 \
>> -object iothread,id=io1 \
>> -device nvme,drive=nvme1,serial=deadbeaf1 \
>> -drive file=blkdebug:blkdebug.config:nvme.img,if=none,id=nvme1
>>
>> # cat blkdebug.config
>> [delay]
>> event = "write_aio"
>> latency = "9999999999"
>> sector = "40960"
>>
>>
>> The 'write' latency of sector=40960 is set to a very large value. When the I/O
>> is stalled in guest due to that sector=40960 is accessed, I do see below
>> messages in guest log:
>>
>> [   80.807755] nvme nvme0: I/O 11 QID 2 timeout, aborting
>> [   80.808095] nvme nvme0: Abort status: 0x4001
>>
>>
>> However, then nothing happens further. nvme I/O hangs in guest. I am not able to
>> kill the qemu process with Ctrl+C. Both vnc and qemu user net do not work. I
>> need to kill qemu with "kill -9"
>>
>>
>> The same result for virtio-scsi and qemu is stuck as well.
> While I didn't try virtio-scsi, I wasn't able to reproduce this behavior using
> nvme on Ubuntu 18.04 (4.15). What image and kernel version are you trying against?

Would you like to reproduce the "aborting" message or the qemu hang?

guest image: ubuntu 16.04
guest kernel: mainline linux kernel (and default kernel in ubuntu 16.04)
qemu: qemu-3.0.0 (with the blkdebug delay patch)

Would you be able to see the nvme abort (which is indeed not supported by qemu)
message in guest kernel?

Once I see that message, I would not be able to kill the qemu-system-x86_64
command line with Ctrl+C.

Dongli Zhang
