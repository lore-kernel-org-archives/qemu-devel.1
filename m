Received: from eggs.gnu.org ([2001:4830:134:3::10]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dsNBb-0006Uu-2H
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dsNBY-0005zS-0o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:59:39 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:45703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dsNBX-0005ya-QO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:59:35 -0400
Received: by mail-wr0-f176.google.com with SMTP id m18so4138967wrm.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 22:59:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721152129.GJ18014@stefanha-x1.localdomain>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170721152129.GJ18014@stefanha-x1.localdomain>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 14 Sep 2017 07:59:33 +0200
Message-ID: <CABdb734wXQXK_GYViPQFWhjV9XVeAGZ_2MSjqi4S79-aeTnNqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/9] virtio: enhance virtio_error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

On Fri, Jul 21, 2017 at 5:21 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 17, 2017 at 10:11:43AM +0200, Ladi Prosek wrote:
>> Output like "Virtqueue size exceeded" is not much useful in identifying the
>> culprit. This series beefs up virtio_error to print the virtio device name
>> and id, and introduces virtqueue_error which additionally includes the index
>> of the virtqueue where the error occured.
>>
>> Patches 1 to 3 lay the groundwork, patches 4 to 8 convert virtio devices to
>> use virtqueue_error instead of virtio_error. Patch 9 adds virtio_error and
>> virtqueue_error to the list of error funcs in checkpatch.pl.
>>
>> v1->v2:
>> * Modified virtio_error and added virtqueue_error (Stefan)
>> * Now also printing device id (Stefan)
>> * Went over all virtio_error call sites and converted them to virtqueue_error
>>   as appropriate; added virtio device maintainers to cc
>>
>> v2->v3:
>> * Removed patch 1 (Stefan, Markus)
>> * Split patch 3 into 2 (adds virtqueue_error) and 3 (makes virtio.c call it)
>>   (Cornelia)
>> * Added patch 9 to modify $qemu_error_funcs in checkpatch.pl (Greg)
>> * s/includes queue index/includes the queue index/ in patch 3-9 commit
>>   messages (Cornelia)
>> * Fixed virtio_get_device_id to return empty string instead of NULL if the
>>   device doesn't have an id (Stefan)
>> * Simplified the change in virtio-crypto.c to use vcrypto->ctrl_vq instead
>>   of propagating the vq pointer in function arguments (Cornelia, Gonglei)
>>
>> Ladi Prosek (9):
>>   virtio: enhance virtio_error messages
>>   virtio: introduce virtqueue_error
>>   virtio: use virtqueue_error for errors with queue context
>>   virtio-9p: use virtqueue_error for errors with queue context
>>   virtio-blk: use virtqueue_error for errors with queue context
>>   virtio-net: use virtqueue_error for errors with queue context
>>   virtio-scsi: use virtqueue_error for errors with queue context
>>   virtio-crypto: use virtqueue_error for errors with queue context
>>   checkpatch: add virtio_error and virtqueue_error to error funcs
>>
>>  hw/9pfs/virtio-9p-device.c |  37 ++++++--------
>>  hw/block/virtio-blk.c      |   6 +--
>>  hw/net/virtio-net.c        |  24 ++++-----
>>  hw/scsi/virtio-scsi.c      |   2 +-
>>  hw/virtio/virtio-crypto.c  |  49 ++++++++++---------
>>  hw/virtio/virtio.c         | 119 +++++++++++++++++++++++++++++++--------------
>>  include/hw/virtio/virtio.h |   1 +
>>  scripts/checkpatch.pl      |   4 +-
>>  8 files changed, 143 insertions(+), 99 deletions(-)
>
> Looks good.  QEMU is currently in freeze for the 2.10 release.  You may
> need to resend so Michael Tsirkin can merge it after the release, or if
> he maintainers a -next branch he could merge it right away.

Should I resend the series, Michael?

Thanks,
Ladi
