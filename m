Received: from eggs.gnu.org ([2001:4830:134:3::10]:50121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjian161@huawei.com>) id 1gYsk7-00062M-T5
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjian161@huawei.com>) id 1gYscf-0007aH-62
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:07:50 -0500
References: <2121490c-6d17-bb39-eebe-1be4553f8c14@huawei.com>
	<20181214152051-mutt-send-email-mst@kernel.org>
From: wangjian <wangjian161@huawei.com>
Message-ID: <1f59dc9b-7127-248c-bc8e-00bb86453629@huawei.com>
Date: Mon, 17 Dec 2018 21:07:19 +0800
MIME-Version: 1.0
In-Reply-To: <20181214152051-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qemu: avoid memory leak while remove disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com

ok, I will send the patch by git send-email.

On 12/15/2018 4:22 AM, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 09:53:06AM +0800, wangjian wrote:
>> Memset vhost_dev to zero in the vhost_dev_cleanup function.
>> This causes dev.vqs to be NULL, so that
>> vqs does not free up space when calling the g_free function.
>> This will result in a memory leak. But you can't release vqs
>> directly in the vhost_dev_cleanup function, because vhost_net
>> will also call this function, and vhost_net's vqs is assigned by array.
>> In order to solve this problem, we first save the pointer of vqs,
>> and release the space of vqs after vhost_dev_cleanup is called.
>>
>> Signed-off-by: Jian Wang <wangjian161@huawei.com>
> The patch does not seem to apply.
> I suspect it was corrupted by your mailer, judging by
> the fact that you also sent the patch in HTML format.
>
> Can you please fix and repost?
> Thanks!
>
>
>> ---
>>   hw/block/vhost-user-blk.c | 7 +++++--
>>   hw/scsi/vhost-scsi.c      | 3 ++-
>>   hw/scsi/vhost-user-scsi.c | 3 ++-
>>   3 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 1451940..c3af28f 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -250,6 +250,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VHostUserBlk *s = VHOST_USER_BLK(vdev);
>>       VhostUserState *user;
>> +    struct vhost_virtqueue *vqs = NULL;
>>       int i, ret;
>>
>>       if (!s->chardev.chr) {
>> @@ -288,6 +289,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>       s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
>>       s->dev.vq_index = 0;
>>       s->dev.backend_features = 0;
>> +    vqs = s->dev.vqs;
>>
>>       vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>>
>> @@ -314,7 +316,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>   vhost_err:
>>       vhost_dev_cleanup(&s->dev);
>>   virtio_err:
>> -    g_free(s->dev.vqs);
>> +    g_free(vqs);
>>       virtio_cleanup(vdev);
>>
>>       vhost_user_cleanup(user);
>> @@ -326,10 +328,11 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VHostUserBlk *s = VHOST_USER_BLK(dev);
>> +    struct vhost_virtqueue *vqs = s->dev.vqs;
>>
>>       vhost_user_blk_set_status(vdev, 0);
>>       vhost_dev_cleanup(&s->dev);
>> -    g_free(s->dev.vqs);
>> +    g_free(vqs);
>>       virtio_cleanup(vdev);
>>
>>       if (s->vhost_user) {
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 7f21b4f..61e2e57 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -215,6 +215,7 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
>> +    struct vhost_virtqueue *vqs = vsc->dev.vqs;
>>
>>       migrate_del_blocker(vsc->migration_blocker);
>>       error_free(vsc->migration_blocker);
>> @@ -223,7 +224,7 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
>>       vhost_scsi_set_status(vdev, 0);
>>
>>       vhost_dev_cleanup(&vsc->dev);
>> -    g_free(vsc->dev.vqs);
>> +    g_free(vqs);
>>
>>       virtio_scsi_common_unrealize(dev, errp);
>>   }
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index 2e1ba4a..6728878 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -121,12 +121,13 @@ static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VHostUserSCSI *s = VHOST_USER_SCSI(dev);
>>       VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>> +    struct vhost_virtqueue *vqs = vsc->dev.vqs;
>>
>>       /* This will stop the vhost backend. */
>>       vhost_user_scsi_set_status(vdev, 0);
>>
>>       vhost_dev_cleanup(&vsc->dev);
>> -    g_free(vsc->dev.vqs);
>> +    g_free(vqs);
>>
>>       virtio_scsi_common_unrealize(dev, errp);
>>
>> --
>> 1.8.3.1
>>
> .
>
