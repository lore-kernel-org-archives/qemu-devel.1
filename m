Received: from eggs.gnu.org ([2001:4830:134:3::10]:47312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFD8F-0002VT-Mw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFD8C-0004BW-JK
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:54:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFD8B-00044n-VH
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 00:54:32 -0500
Message-ID: <5A0D27D8.6050506@huawei.com>
Date: Thu, 16 Nov 2017 13:53:28 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
In-Reply-To: <CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Question] why need to start all queues in
 vhost_net_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc: "Longpeng(Mike)" <longpeng.mike@gmail.com>, qemu-devel@nongnu.org, arei.gonglei@huawei.com, king.wang@huawei.com, weidong.huang@huawei.com, stefanha@redhat.com

Hi Jason & Michael,

Do you have any idea about this problem ?

-- 
Regards,
Longpeng(Mike)

On 2017/11/15 23:54, Longpeng(Mike) wrote:

> 2017-11-15 23:05 GMT+08:00 Jason Wang <jasowang@redhat.com>:
>>
>>
>> On 2017年11月15日 22:55, Longpeng(Mike) wrote:
>>>
>>> Hi guys,
>>>
>>> We got a BUG report from our testers yesterday, the testing scenario was
>>> migrating a VM (Windows guest, *4 vcpus*, 4GB, vhost-user net: *7
>>> queues*).
>>>
>>> We found the cause reason, and we'll report the BUG or send a fix patch
>>> to upstream if necessary( we haven't test the upstream yet, sorry... ).
>>
>>
>> Could you explain this a little bit more?
>>
>>>
>>> We want to know why the vhost_net_start() must start *total queues* ( in
>>> our
>>> VM there're 7 queues ) but not *the queues that current used* ( in our VM,
>>> guest
>>> only uses the first 4 queues because it's limited by the number of vcpus)
>>> ?
>>>
>>> Looking forward to your help, thx :)
>>
>>
>> Since the codes have been there for years and works well for kernel
>> datapath. You should really explain what's wrong.
>>
> 
> OK. :)
> 
> In our scenario,  the Windows's virtio-net driver only use the first 4
> queues and it
> *only set desc/avail/used table for the first 4 queues*, so in QEMU
> the desc/avail/
> used of the last 3 queues are ZERO,  but unfortunately...
> '''
> vhost_net_start
>   for (i = 0; i < total_queues; i++)
>     vhost_net_start_one
>       vhost_dev_start
>         vhost_virtqueue_start
> '''
> In vhost_virtqueue_start(), it will calculate the HVA of
> desc/avail/used table, so for last
> 3 queues, it will use ZERO as the GPA to calculate the HVA, and then
> send the results
> to the user-mode backend ( we use *vhost-user* ) by vhost_virtqueue_set_addr().
> 
> When the EVS get these address, it will update a *idx* which will be
> treated as  vq's
> last_avail_idx when virtio-net stop ( pls see vhost_virtqueue_stop() ).
> 
> So we get the following result after virtio-net stop:
>   the desc/avail/used of the last 3 queues's vqs are all ZERO, but these vqs's
>   last_avail_idx is NOT ZERO.
> 
> At last, virtio_load() reports an error:
> '''
>   if (!vdev->vq[i].vring.desc && vdev->vq[i].last_avail_idx) { // <--
> will be TRUE
>       error_report("VQ %d address 0x0 "
>                          "inconsistent with Host index 0x%x",
>                          i, vdev->vq[i].last_avail_idx);
>             return -1;
>    }
> '''
> 
> BTW, the problem won't appear if use Linux guest, because the Linux virtio-net
> driver will set all 7 queues's desc/avail/used tables. And the problem
> won't appear
> if the VM use vhost-net, because vhost-net won't update *idx* in SET_ADDR ioctl.
> 
> Sorry for my pool English, Maybe I could describe the problem in Chinese for you
> in private if necessary.
> 
> 
>> Thanks
> 
> 


-- 
Regards,
Longpeng(Mike)
