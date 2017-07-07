Received: from eggs.gnu.org ([2001:4830:134:3::10]:51169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTSwa-0001YY-FM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTSwQ-0008Vy-R6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTSwQ-0008Vg-IA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:05:02 -0400
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-4-git-send-email-thuth@redhat.com>
	<20170707145402.30187319@dhcp-192-215.str.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2e3bc24b-2244-1cb7-4276-73b1126d6973@redhat.com>
Date: Fri, 7 Jul 2017 15:04:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170707145402.30187319@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/8] pc-bios/s390-ccw: Move
 virtio-block related functions into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 07.07.2017 14:54, Cornelia Huck wrote:
> On Fri,  7 Jul 2017 12:26:59 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The netboot code is going to link against the code from virtio.c, too,
>> so we've got to move the virtio-block related code out of the way.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/Makefile     |   2 +-
>>  pc-bios/s390-ccw/main.c       |   2 +-
>>  pc-bios/s390-ccw/s390-ccw.h   |   2 +-
>>  pc-bios/s390-ccw/virtio-blk.c | 296 ++++++++++++++++++++++++++++++++++++++++++
>>  pc-bios/s390-ccw/virtio.c     | 273 +-------------------------------------
>>  pc-bios/s390-ccw/virtio.h     |   4 +
>>  6 files changed, 307 insertions(+), 272 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/virtio-blk.c
>>
> 
>> diff --git a/pc-bios/s390-ccw/virtio-blk.c b/pc-bios/s390-ccw/virtio-blk.c
>> new file mode 100644
>> index 0000000..6cb77bc
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/virtio-blk.c
>> @@ -0,0 +1,296 @@
>> +/*
>> + * Virtio driver bits
>> + *
>> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
> 
> The original code carries the same copyright notice, but there's a lot
> of IBM code in there. Just saying.

Then the IBM folks should maybe add their (c) statement to that file
first? Otherwise, I assume they simply do not care ;-)

[...]
>> +int virtio_read_many(ulong sector, void *load_addr, int sec_num)
>> +{
>> +    VDev *vdev = virtio_get_device();
>> +
>> +    switch (vdev->senseid.cu_model) {
>> +    case VIRTIO_ID_BLOCK:
>> +        return virtio_blk_read_many(vdev, sector, load_addr, sec_num);
>> +    case VIRTIO_ID_SCSI:
>> +        return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);
> 
> This is scsi, not blk. Should virtio_read_many() stay in virtio.c?

No, that does not work since virtio_scsi_read_many() is defined in
virtio-scsi.c which is not linked to the netboot code.

>> +    }
>> +    panic("\n! No readable IPL device !\n");
>> +    return -1;
>> +}
> (...)
>> +void virtio_assume_scsi(void)
>> +{
>> +    VDev *vdev = virtio_get_device();
>> +
>> +    switch (vdev->senseid.cu_model) {
>> +    case VIRTIO_ID_BLOCK:
>> +        vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
>> +        vdev->config.blk.blk_size = VIRTIO_SCSI_BLOCK_SIZE;
>> +        vdev->config.blk.physical_block_exp = 0;
>> +        vdev->blk_factor = 1;
>> +        break;
>> +    case VIRTIO_ID_SCSI:
>> +        vdev->scsi_block_size = VIRTIO_SCSI_BLOCK_SIZE;
> 
> More scsi. Maybe the file just needs a different name :)

Do you have a better suggestion?

 Thomas
