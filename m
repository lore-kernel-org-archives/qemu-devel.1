Received: from eggs.gnu.org ([2001:4830:134:3::10]:44504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1SDu-0005RT-TO
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1SDr-00060N-RF
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:43:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1f1SDr-00060E-LU
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:43:47 -0400
References: <20180328192800.7138-1-maxime.coquelin@redhat.com>
	<20180328192800.7138-2-maxime.coquelin@redhat.com>
	<FF7FC980937D6342B9D289F5F3C7C2625B6255A0@SHSMSX103.ccr.corp.intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <5ebd5f1c-7845-c136-d93b-c288c9b5d9d0@redhat.com>
Date: Thu, 29 Mar 2018 09:43:34 +0200
MIME-Version: 1.0
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B6255A0@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vhost-user-blk: set config ops
 before vhost-user init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 03/29/2018 02:53 AM, Liu, Changpeng wrote:
> 
> 
>> -----Original Message-----
>> From: Maxime Coquelin [mailto:maxime.coquelin@redhat.com]
>> Sent: Thursday, March 29, 2018 3:28 AM
>> To: mst@redhat.com; Liu, Changpeng <changpeng.liu@intel.com>;
>> marcandre.lureau@redhat.com; qemu-devel@nongnu.org
>> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
>> Subject: [PATCH v2 1/2] vhost-user-blk: set config ops before vhost-user init
>>
>> As soon as vhost-user init is done, the backend may send
>> VHOST_USER_SLAVE_CONFIG_CHANGE_MSG, so let's set the
>> notification callback before it.
>>
>> Also, it will be used to know whether the device supports
>> the config feature to advertize it or not.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>   hw/block/vhost-user-blk.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index f840f07dfe..262baca432 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -259,6 +259,8 @@ static void vhost_user_blk_device_realize(DeviceState
>> *dev, Error **errp)
>>       s->dev.vq_index = 0;
>>       s->dev.backend_features = 0;
>>
>> +    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> Please also remove the line "assert(hdev->vhost_ops);" in function vhost_dev_set_config_notifier at vhost.c file.

Oh right, posting v3 removing this.

Thanks,
Maxime
>> +
>>       ret = vhost_dev_init(&s->dev, &s->chardev, VHOST_BACKEND_TYPE_USER, 0);
>>       if (ret < 0) {
>>           error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
>> @@ -277,8 +279,6 @@ static void vhost_user_blk_device_realize(DeviceState
>> *dev, Error **errp)
>>           s->blkcfg.num_queues = s->num_queues;
>>       }
>>
>> -    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>> -
>>       return;
>>
>>   vhost_err:
>> --
>> 2.14.3
> 
