Received: from eggs.gnu.org ([2001:4830:134:3::10]:50178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co99Y-0003Rb-6f
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co99X-0006oz-AQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:39:48 -0400
References: <20170314171120.80741-1-vsementsov@virtuozzo.com>
	<20170315110351.GG4030@noname.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a68a30f-8765-ca91-572f-ed8d7083b202@redhat.com>
Date: Wed, 15 Mar 2017 14:39:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170315110351.GG4030@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blk: fix aio context loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com



On 15/03/2017 12:03, Kevin Wolf wrote:
> But we discussed this earlier, and while I'm not completely sure any
> more about the details, I seem to remeber that Paolo said something
> along the lines that AioContext is going away anyway and building the
> code for proper management would be wasted time.

AioContext is going to stay, but everybody will be able to send
operations to a BB/BDS from any AioContext.  The BDS AioContext will
only matter for network devices, since they have to attach the file
descriptor handlers somewhere.  For files it won't matter at all because
you can use multiple Linux AIO context or thread pools at the same time.

There should be a policy on which BB sets AioContext on the BDS (e.g.
only the device does it), but apart from that, it should not be an issue.

Paolo

> Stefan, Paolo, do you remember the details why we didn't even do a
> simple fix like the one below? I think there were some patches on the
> list, no?
> 
> Kevin
> 
>> ======
>> Also, on master branch I can't reproduce it as vm crashed earlier, without any
>> eject/change, on assert(s->ctx && s->dataplane_started) in
>> virtio_scsi_data_plane_handle_ctrl(). It looks like race with
>> virtio_scsi_dataplane_start(), and for test (to reproduce assert described above),
>> I've "fixed" it with just:
>>
>> @@ -63,6 +63,7 @@ static bool virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
>>  {
>>      VirtIOSCSI *s = VIRTIO_SCSI(vdev);
>>  
>> +    sleep(10);
>>      assert(s->ctx && s->dataplane_started);
>>      return virtio_scsi_handle_ctrl_vq(s, vq);
>>  }
>>
>> This race is not reproduced for me in our 2.6 based branch.
>>
>>  block/block-backend.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 5742c09c2c..6d5044228e 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -65,6 +65,8 @@ struct BlockBackend {
>>      bool allow_write_beyond_eof;
>>  
>>      NotifierList remove_bs_notifiers, insert_bs_notifiers;
>> +
>> +    AioContext *aio_context;
>>  };
>>  
>>  typedef struct BlockBackendAIOCB {
>> @@ -559,6 +561,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
>>      }
>>      bdrv_ref(bs);
>>  
>> +    if (blk->aio_context != NULL) {
>> +        bdrv_set_aio_context(bs, blk->aio_context);
>> +    }
>> +
>>      notifier_list_notify(&blk->insert_bs_notifiers, blk);
>>      if (blk->public.throttle_state) {
>>          throttle_timers_attach_aio_context(
>> @@ -1607,6 +1613,7 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
>>  {
>>      BlockDriverState *bs = blk_bs(blk);
>>  
>> +    blk->aio_context = new_context;
>>      if (bs) {
>>          if (blk->public.throttle_state) {
>>              throttle_timers_detach_aio_context(&blk->public.throttle_timers);
>> -- 
>> 2.11.1
>>
