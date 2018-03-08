Received: from eggs.gnu.org ([2001:4830:134:3::10]:37588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etyCE-00043C-KU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etyCD-0007v2-N1
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:15:10 -0500
References: <20180307144205.20619-1-stefanha@redhat.com>
	<20180308180130-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <351bb0cc-59de-148f-8dfb-a6223fd9ee98@redhat.com>
Date: Thu, 8 Mar 2018 17:14:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180308180130-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 08/03/2018 17:01, Michael S. Tsirkin wrote:
> On Wed, Mar 07, 2018 at 02:42:01PM +0000, Stefan Hajnoczi wrote:
>> v3:
>>  * Rebase on qemu.git/master after AIO_WAIT_WHILE() was merged [Fam]
>> v2:
>>  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeventfd
>>    from a BH in the IOThread [Fam]
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> who is merging this?

Probably Stefan himself?  Just in case, for 4/4:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

>> There are several race conditions in virtio-blk/virtio-scsi dataplane code.
>> This patch series addresses them, see the commit description for details on the
>> individual cases.
>>
>> Stefan Hajnoczi (4):
>>   block: add aio_wait_bh_oneshot()
>>   virtio-blk: fix race between .ioeventfd_stop() and vq handler
>>   virtio-scsi: fix race between .ioeventfd_stop() and vq handler
>>   vl: introduce vm_shutdown()
>>
>>  include/block/aio-wait.h        | 13 +++++++++++++
>>  include/sysemu/iothread.h       |  1 -
>>  include/sysemu/sysemu.h         |  1 +
>>  cpus.c                          | 16 +++++++++++++---
>>  hw/block/dataplane/virtio-blk.c | 24 +++++++++++++++++-------
>>  hw/scsi/virtio-scsi-dataplane.c |  9 +++++----
>>  iothread.c                      | 31 -------------------------------
>>  util/aio-wait.c                 | 31 +++++++++++++++++++++++++++++++
>>  vl.c                            | 13 +++----------
>>  9 files changed, 83 insertions(+), 56 deletions(-)
>>
>> -- 
>> 2.14.3
