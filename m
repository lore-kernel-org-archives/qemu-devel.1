Received: from eggs.gnu.org ([2001:4830:134:3::10]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1eOMzC-00028m-Lz
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1eOMzB-00063j-UA
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:15:06 -0500
References: <b630fe8c-6905-6743-d29d-ded450d5d10b@redhat.com>
	<20171211114129.GC3350@lemon>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <c57f063f-a95b-4a82-8b5e-a713ba61d734@redhat.com>
Date: Mon, 11 Dec 2017 13:14:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171211114129.GC3350@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU not honouring bootorder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org

On 12/11/2017 12:41 PM, Fam Zheng wrote:
> On Thu, 12/07 13:10, Michal Privoznik wrote:
>> Dear list,
>>
>> I've encountered the following problem. I have two disks:
>>
>>   /var/lib/libvirt/images/fedora.qcow2  (which contains OS)
>>   /dev/sde (iSCSI dummy disk just for testing)
>>
>> Now, when I configure QEMU to start with both of them, QEMU/Seabios
>> tries to boot from /dev/sde which fails obviously. Even setting
>> bootorder does not help. Here's my command line:
>>
>>   qemu-system-x86_64 \
>>   -boot menu=on,strict=on \
>>   -device lsi,id=scsi0,bus=pci.0 \
>>   -drive file=/var/lib/libvirt/images/fedora.qcow2,format=qcow2,if=none,id=drive-scsi0 \
>>   -device scsi-hd,bus=scsi0.0,drive=drive-scsi0,bootindex=1 \
>>   -drive file=/dev/sde,format=raw,if=none,id=drive-scsi1 \
>>   -device scsi-block,bus=scsi0.0,drive=drive-scsi1,bootindex=2
>>
>> It was found that if 'drive-scsi1' is scsi-hd instead of scsi-block
>> everything works as expected and I can boot my guest successfully.
> 
> Does it help if you add SCSI level ordering with "lun={0,1},channel=0,scsi-id=0"
> for both devices?

Setting lun helps. On the other hand, I had to change from LSI
controller to virtio-scsi as LSI doesn't support more than 1 LUNs.

Michal
