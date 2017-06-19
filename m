Received: from eggs.gnu.org ([2001:4830:134:3::10]:37044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dMtuk-0000sv-EY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dMtuj-00049L-GA
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:28:10 -0400
References: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
	<20170619072727.GA6113@noname.redhat.com>
From: Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <6324ce25-8fa8-9204-d15b-32f20fb71e4b@gmail.com>
Date: Mon, 19 Jun 2017 18:27:21 +0800
MIME-Version: 1.0
In-Reply-To: <20170619072727.GA6113@noname.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Question] How can we confirm hot-plug disk
 succesfully?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

在 6/19/2017 3:27 PM, Kevin Wolf 写道:
> Am 18.06.2017 um 09:21 hat Xie Changlong geschrieben:
>> In device hot-remove scenario, if we don't probe acpiphp module on
>> the guest, 'device_del' will never emit DEVICE_DELETED event(because
>> guest will not write to __EJ0) . So we can confirm that hot-remove
>> failed. But IIUC, there is no event such as DEVICE_ADDED, so
>> 1) How can we confirm hotplug('device_add') successfully?
>> 2) It seems when hot-plug disk, we don't care acpiphp module status
>> on the guest, am I right?
>> 3) Why there is no DEVICE_ADDED like event?
> 
> device_add doesn't need guest cooperation, so it is immediately
> completed when the QMP command returns success.
> 

That's what i though too. But I have a question, if we don't proble 
acpiphp on the guest, and execute below commands:

Hot plug:
(qemu) drive_add 0 
file=/resource/changlox/test.raw,id=drive-virtio-disk1,if=none
(qemu) device_add virtio-blk-pci,drive=drive-virtio-disk1,id=virtio-disk1

Hot remove:
(qemu) device_del virtio-disk1
(qemu) drive_del drive-virtio-disk1
(qemu) qom-list /machine/peripheral
type (string)
virtio-disk1 (child<virtio-blk-pci>)
(qemu) info block
foo (#block122): suse1.qcow2 (qcow2)
     Cache mode:       writeback, direct
     Backing file:     suse.qcow2.orgin (chain depth: 1)

ide1-cd0: [not inserted]
     Removable device: not locked, tray closed

floppy0: [not inserted]
     Removable device: not locked, tray closed

sd0: [not inserted]
     Removable device: not locked, tray closed
(qemu) drive_add 0 
file=/resource/changlox/test.raw,id=drive-virtio-disk1,if=none
Duplicate ID 'drive-virtio-disk1' for drive

'info block' shows nothing, but we can't add drive who's id 
is'drive-virtio-disk1' too。 There is a more serious situation, we could 
*never* destory device memory with 'device_del', it's memory leak to me 
if the guest os never support hot-plug and the user don't know this 
information.



> Kevin
> 

-- 
Thanks
     -Xie
