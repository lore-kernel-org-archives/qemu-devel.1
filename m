Received: from eggs.gnu.org ([2001:4830:134:3::10]:52492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjxC-0000YC-L9
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjx5-0000n2-0B
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:49:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEjx4-0000VZ-Ok
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:49:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id w186-v6so778834wmf.0
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:49:18 -0700 (PDT)
References: <20181012090752.31891-1-yuchenlin@synology.com>
	<d8051b2fc349d58dcd98cd383ae6bf32@synology.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75b2d7f3-88d3-b79c-e808-c21dcf661174@redhat.com>
Date: Tue, 23 Oct 2018 01:49:16 +0200
MIME-Version: 1.0
In-Reply-To: <d8051b2fc349d58dcd98cd383ae6bf32@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vhost-scsi: prevent using uninitialized vqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <yuchenlin@synology.com>
Cc: Forrest Liu <forrestl@synology.com>, qemu-devel@nongnu.org, mst@redhat.com, qemu-stable@nongnu.org

On 22/10/18 4:17, yuchenlin via Qemu-devel wrote:
> Ping?
> 
> On 2018-10-12 17:07, yuchenlin@synology.com wrote:
>> From: yuchenlin <yuchenlin@synology.com>
>>
>> There are 3 virtqueues (ctrl, event and cmd) for virtio scsi device,
>> but seabios will only set the physical address for the 3rd one (cmd).
>> Then in vhost_virtqueue_start(), virtio_queue_get_desc_addr()
>> will be 0 for ctrl and event vq.
>>
>> In this case, ctrl and event vq are not initialized.
>> vhost_verify_ring_mappings may use uninitialized vhost_virtqueue
>> such that vhost_verify_ring_part_mapping returns ENOMEM.
>>
>> When encountered this problem, we got the following logs:
>>
>>     qemu-system-x86_64: Unable to map available ring for ring 0
>>     qemu-system-x86_64: Verify ring failure on region 0
>>
>> Signed-off-by: Forrest Liu <forrestl@synology.com>
>> Signed-off-by: yuchenlin <yuchenlin@synology.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> ---
>>  hw/scsi/vhost-scsi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index becf550085..7f21b4f9d6 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -183,7 +183,7 @@ static void vhost_scsi_realize(DeviceState *dev,
>> Error **errp)
>>      }
>>
>>      vsc->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
>> -    vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
>> +    vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
>>      vsc->dev.vq_index = 0;
>>      vsc->dev.backend_features = 0;
> 
> 
