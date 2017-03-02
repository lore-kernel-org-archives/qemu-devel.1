Received: from eggs.gnu.org ([2001:4830:134:3::10]:60908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjSiG-0001Qa-Qj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjSiB-0000Jz-T6
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:32:16 -0500
References: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
	<20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b12c69aa-67ee-ffbc-cd89-716c24889167@redhat.com>
Date: Thu, 2 Mar 2017 16:32:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org



On 02/03/2017 15:49, Cornelia Huck wrote:
> On Thu,  2 Mar 2017 14:04:22 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
>> index 5556f0e..13dd14d 100644
>> --- a/hw/block/dataplane/virtio-blk.c
>> +++ b/hw/block/dataplane/virtio-blk.c
>> @@ -258,9 +258,16 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
>>          virtio_queue_aio_set_host_notifier_handler(vq, s->ctx, NULL);
>>      }
>>
>> -    /* Drain and switch bs back to the QEMU main loop */
>> +    /* Drain and switch bs back to the QEMU main loop. After drain, the
>> +     * device will not submit (nor comple) any requests until dataplane
> 
> s/comple/complete/
> 
>> +     * starts again.
>> +     */
>>      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
>>
>> +    /* Notify guest before the guest notifiers get cleaned up */
>> +    qemu_bh_cancel(s->bh);
>> +    notify_guest_bh(s);
>> +
> 
> Hm... does virtio-scsi dataplane need a similar treatment? Or am I
> missing something?

No, the BH optimization is specific to virtio-blk.  Thanks for the patch
Halil!

Paolo

>>      aio_context_release(s->ctx);
>>
>>      for (i = 0; i < nvqs; i++) {
> 
