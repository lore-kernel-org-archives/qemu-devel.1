Received: from eggs.gnu.org ([209.51.188.92]:33642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1guU0x-000601-7o
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1guU0w-00018i-C3
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:18:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2177 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1guU0w-00015e-0d
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:18:10 -0500
References: <20190214122700.18572-1-zhengxiang9@huawei.com>
	<ec12aeeb-a480-f07d-c75e-6d6acf0359fa@redhat.com>
From: Zheng Xiang <zhengxiang9@huawei.com>
Message-ID: <fa2d4323-035e-5514-e201-5ce8162bf8ca@huawei.com>
Date: Fri, 15 Feb 2019 11:17:38 +0800
MIME-Version: 1.0
In-Reply-To: <ec12aeeb-a480-f07d-c75e-6d6acf0359fa@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-cd: Fix crash after remote cdrom
 detached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, wanghaibin.wang@huawei.com, lizhengui@huawei.com

Hi Paolo,

On 2019/2/15 2:07, Paolo Bonzini wrote:
> On 14/02/19 13:27, Xiang Zheng wrote:
>> There is a small window between the twice blk_is_available in
>> scsi_disk_emulate_command which would cause crash due to the later
>> assertion if the remote cdrom is detached in this window.
>>
>> So this patch replaces assertions with return to avoid qemu crash.
>>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>> The qemu error log shows:
>>
>> qemu-system-aarch64: /home/qemu/hw/scsi/scsi-disk.c:1896: scsi_disk_emulate_command: Assertion `blk_is_available(s->qdev.conf.blk)' failed.
>> 2019-02-15 04:35:18.592: shutting down, reason=crashed
> 
> Is this with virtio-scsi-dataplane?
> 

No, the QEMU commandline about scsi is bellow:
	-device virtio-scsi-pci,id=scsi0,bus=pci.4,addr=0x0 \
	-drive file=/mnt/zhengxiang/guestos.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0,cache=none,aio=native \
	-device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 \
	-drive file=/home/tmp.iso,format=raw,if=none,id=drive-scsi0-0-0-1,readonly=on,cache=none,aio=threads \
	-device scsi-cd,bus=scsi0.0,channel=0,scsi-id=0,lun=1,drive=drive-scsi0-0-0-1,id=scsi0-0-0-1

This problem can be reproduced by detaching and attaching remote cdrom repeatly.

-- 

Thanks,
Xiang
