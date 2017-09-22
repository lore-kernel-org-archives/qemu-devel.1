Received: from eggs.gnu.org ([2001:4830:134:3::10]:42378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMPb-0008DQ-BQ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMPY-00026v-6k
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58203 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1dvMPX-00024f-T3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:24 -0400
References: <20170919115055.19278-1-jgross@suse.com>
	<20170919115055.19278-2-jgross@suse.com>
	<20170920145300.GA1859@perard.uk.xensource.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <55c1c15f-ead3-54a1-5269-a4149cc83005@suse.com>
Date: Fri, 22 Sep 2017 13:46:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170920145300.GA1859@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] xen: add a global indicator for grant
 copy being available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, kraxel@redhat.com, sstabellini@kernel.org

On 20/09/17 16:53, Anthony PERARD wrote:
> On Tue, Sep 19, 2017 at 01:50:54PM +0200, Juergen Gross wrote:
>> The Xen qdisk backend needs to test whether grant copy operations is
>> available in the kernel. Unfortunately this collides with using
>> xengnttab_set_max_grants() on some kernels as this operation has to
>> be the first one after opening the gnttab device.
>>
>> In order to solve this problem test for the availability of grant copy
>> in xen_be_init() opening the gnttab device just for that purpose and
>> closing it again afterwards. Advertise the availability via a global
>> flag and use that flag in the qdisk backend.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  hw/block/xen_disk.c          | 18 ++++++------------
>>  hw/xen/xen_backend.c         | 11 +++++++++++
>>  include/hw/xen/xen_backend.h |  1 +
>>  3 files changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
>> index d42ed7070d..6632746250 100644
>> --- a/hw/block/xen_disk.c
>> +++ b/hw/block/xen_disk.c
>> @@ -121,9 +121,6 @@ struct XenBlkDev {
>>      unsigned int        persistent_gnt_count;
>>      unsigned int        max_grants;
>>  
>> -    /* Grant copy */
>> -    gboolean            feature_grant_copy;
>> -
>>      /* qemu block driver */
>>      DriveInfo           *dinfo;
>>      BlockBackend        *blk;
>> @@ -616,7 +613,7 @@ static void qemu_aio_complete(void *opaque, int ret)
>>          return;
>>      }
>>  
>> -    if (ioreq->blkdev->feature_grant_copy) {
>> +    if (xen_feature_grant_copy) {
>>          switch (ioreq->req.operation) {
>>          case BLKIF_OP_READ:
>>              /* in case of failure ioreq->aio_errors is increased */
>> @@ -638,7 +635,7 @@ static void qemu_aio_complete(void *opaque, int ret)
>>      }
>>  
>>      ioreq->status = ioreq->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
>> -    if (!ioreq->blkdev->feature_grant_copy) {
>> +    if (!xen_feature_grant_copy) {
>>          ioreq_unmap(ioreq);
>>      }
>>      ioreq_finish(ioreq);
>> @@ -698,7 +695,7 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
>>  {
>>      struct XenBlkDev *blkdev = ioreq->blkdev;
>>  
>> -    if (ioreq->blkdev->feature_grant_copy) {
>> +    if (xen_feature_grant_copy) {
>>          ioreq_init_copy_buffers(ioreq);
>>          if (ioreq->req.nr_segments && (ioreq->req.operation == BLKIF_OP_WRITE ||
>>              ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
>> @@ -750,7 +747,7 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
>>      }
>>      default:
>>          /* unknown operation (shouldn't happen -- parse catches this) */
>> -        if (!ioreq->blkdev->feature_grant_copy) {
>> +        if (!xen_feature_grant_copy) {
>>              ioreq_unmap(ioreq);
>>          }
>>          goto err;
>> @@ -1010,18 +1007,15 @@ static int blk_init(struct XenDevice *xendev)
>>  
>>      blkdev->file_blk  = BLOCK_SIZE;
>>  
>> -    blkdev->feature_grant_copy =
>> -                (xengnttab_grant_copy(blkdev->xendev.gnttabdev, 0, NULL) == 0);
>> -
>>      xen_pv_printf(&blkdev->xendev, 3, "grant copy operation %s\n",
>> -                  blkdev->feature_grant_copy ? "enabled" : "disabled");
>> +                  xen_feature_grant_copy ? "enabled" : "disabled");
>>  
>>      /* fill info
>>       * blk_connect supplies sector-size and sectors
>>       */
>>      xenstore_write_be_int(&blkdev->xendev, "feature-flush-cache", 1);
>>      xenstore_write_be_int(&blkdev->xendev, "feature-persistent",
>> -                          !blkdev->feature_grant_copy);
>> +                          !xen_feature_grant_copy);
>>      xenstore_write_be_int(&blkdev->xendev, "info", info);
>>  
>>      xenstore_write_be_int(&blkdev->xendev, "max-ring-page-order",
>> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
>> index c46cbb0759..00210627a9 100644
>> --- a/hw/xen/xen_backend.c
>> +++ b/hw/xen/xen_backend.c
>> @@ -44,6 +44,7 @@ BusState *xen_sysbus;
>>  /* public */
>>  struct xs_handle *xenstore = NULL;
>>  const char *xen_protocol;
>> +gboolean xen_feature_grant_copy;
> 
> I think it would be better if this was changed to bool instead of a
> gboolean.

Okay.

> 
> Beside that,
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

Juergen
