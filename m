Received: from eggs.gnu.org ([2001:4830:134:3::10]:50227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1feBtA-0004gG-RI
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 00:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1feBt5-0002GE-FD
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 00:10:32 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hejianet@gmail.com>) id 1feBt5-0002Ej-7a
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 00:10:27 -0400
Received: by mail-pf0-x242.google.com with SMTP id v15-v6so3657207pff.5
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 21:10:27 -0700 (PDT)
References: <1531490645-10989-1-git-send-email-yury-kotov@yandex-team.ru>
	<20180713191451-mutt-send-email-mst@kernel.org>
From: Jia He <hejianet@gmail.com>
Message-ID: <dca98882-8432-fc8e-0c16-64c238776518@gmail.com>
Date: Sat, 14 Jul 2018 12:09:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180713191451-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: fix invalid downcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, wrfsh@yandex-team.ru



On 7/14/2018 12:15 AM, Michael S. Tsirkin Wrote:
> On Fri, Jul 13, 2018 at 05:04:05PM +0300, Yury Kotov wrote:
>> virtio_queue_get_desc_addr returns 64-bit hwaddr while int is usually 32-bit.
>> If returned hwaddr is not equal to 0 but least-significant 32 bits are
>> equal to 0 then this code will not actually stop running queue.
>>
>> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> 
> So IIUC
> 
> Fixes: fb20fbb764aa1 ("vhost: avoid to start/stop virtqueue which is not ready")

> And 
> Cc: qemu-stable@nongnu.org
> 
>> ---
>>  hw/virtio/vhost.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index b129cb9..7edeee7 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1071,10 +1071,8 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
>>          .index = vhost_vq_index,
>>      };
>>      int r;
>> -    int a;
>>  
>> -    a = virtio_queue_get_desc_addr(vdev, idx);
>> -    if (a == 0) {
>> +    if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
>>          /* Don't stop the virtqueue which might have not been started */
>>          return;
>>      }
>> -- 
>> 2.7.4
> 
yes, it is a bug introduced by fb20fbb764aa1
Acked-by: Jia He <hejianet@gmail.com>
-- 
Cheers,
Jia
