Received: from eggs.gnu.org ([2001:4830:134:3::10]:36619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVfbi-0001TS-8o
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVfbf-0006QU-N5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:00:46 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVfbf-0006QE-Hi
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:00:43 -0400
Received: by mail-ua0-f177.google.com with SMTP id g13so16614499uaj.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:00:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713163620.48c6a93c@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713163620.48c6a93c@bahia.lab.toulouse-stg.fr.ibm.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 17:00:42 +0200
Message-ID: <CABdb736of+LSqEQuV15=i-f1rEwBPz0P71Jty5ZZsBc=5nf5uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/8] virtio: enhance virtio_error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jul 13, 2017 at 4:36 PM, Greg Kurz <groug@kaod.org> wrote:
> On Thu, 13 Jul 2017 13:02:29 +0200
> Ladi Prosek <lprosek@redhat.com> wrote:
>
>> Output like "Virtqueue size exceeded" is not much useful in identifying the
>> culprit. This series beefs up virtio_error to print the virtio device name
>> and id, and introduces virtqueue_error which additionally includes the index
>> of the virtqueue where the error occured.
>>
>> Patches 1 to 3 lay the groundwork, patches 4 to 8 convert virtio devices to
>> use virtqueue_error instead of virtio_error.
>>
>> v1->v2:
>> * Modified virtio_error and added virtqueue_error (Stefan)
>> * Now also printing device id (Stefan)
>> * Went over all virtio_error call sites and converted them to virtqueue_error
>>   as appropriate; added virtio device maintainers to cc
>>
>> Ladi Prosek (8):
>>   qemu-error: introduce error_report_nolf
>>   virtio: enhance virtio_error messages
>>   virtio: introduce virtqueue_error
>>   virtio-9p: use virtqueue_error for errors with queue context
>>   virtio-blk: use virtqueue_error for errors with queue context
>>   virtio-net: use virtqueue_error for errors with queue context
>>   virtio-scsi: use virtqueue_error for errors with queue context
>>   virtio-crypto: use virtqueue_error for errors with queue context
>>
>
> While here, maybe you can add all the virtio_error related functions to the
> $qemu_error_funcs variable in scripts/checkpatch.pl ?

Will do, thanks!

> Cheers,
>
> --
> Greg
>
>>  hw/9pfs/virtio-9p-device.c  |  37 ++++++--------
>>  hw/block/virtio-blk.c       |   6 +--
>>  hw/net/virtio-net.c         |  24 ++++-----
>>  hw/scsi/virtio-scsi.c       |   2 +-
>>  hw/virtio/virtio-crypto.c   |  56 ++++++++++-----------
>>  hw/virtio/virtio.c          | 116 ++++++++++++++++++++++++++++++--------------
>>  include/hw/virtio/virtio.h  |   1 +
>>  include/qemu/error-report.h |   3 +-
>>  util/qemu-error.c           |  32 +++++++++---
>>  9 files changed, 169 insertions(+), 108 deletions(-)
>>
>
