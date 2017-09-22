Received: from eggs.gnu.org ([2001:4830:134:3::10]:46647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMgW-0006AE-Fm
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMgQ-0004dn-O1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:03:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60804 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1dvMgQ-0004c2-Hb
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:03:50 -0400
References: <20170919115055.19278-1-jgross@suse.com>
	<20170919115055.19278-3-jgross@suse.com>
	<20170920150006.GB1859@perard.uk.xensource.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <912fbfb9-59b9-fceb-237f-3b201f6eaa38@suse.com>
Date: Fri, 22 Sep 2017 14:03:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170920150006.GB1859@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/2] xen: dont try setting max
 grants multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, qemu-devel@nongnu.org, kraxel@redhat.com

On 20/09/17 17:00, Anthony PERARD wrote:
> On Tue, Sep 19, 2017 at 01:50:55PM +0200, Juergen Gross wrote:
>> Trying to call xengnttab_set_max_grants() with the same file handle
>> might fail on some kernels, as this operation is allowed only once.
>>
>> This is a problem for the qdisk backend as blk_connect() can be
>> called multiple times for a domain, e.g. in case grub-xen is being
>> used to boot it.
>>
>> So instead of letting the generic backend code open the gnttab device
>> do it in blk_connect() and close it again in blk_disconnect.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  hw/block/xen_disk.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
>> index 6632746250..7cff8863cb 100644
>> --- a/hw/block/xen_disk.c
>> +++ b/hw/block/xen_disk.c
>> @@ -1220,6 +1220,12 @@ static int blk_connect(struct XenDevice *xendev)
>>      /* Add on the number needed for the ring pages */
>>      max_grants += blkdev->nr_ring_ref;
>>  
>> +    blkdev->xendev.gnttabdev = xengnttab_open(NULL, 0);
>> +    if (blkdev->xendev.gnttabdev == NULL) {
>> +        xen_pv_printf(xendev, 0, "xengnttab_open failed: %s\n",
>> +                      strerror(errno));
>> +        return -1;
>> +    }
>>      if (xengnttab_set_max_grants(blkdev->xendev.gnttabdev, max_grants)) {
>>          xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
>>                        strerror(errno));
>> @@ -1327,6 +1333,11 @@ static void blk_disconnect(struct XenDevice *xendev)
>>          }
>>          blkdev->feature_persistent = false;
>>      }
>> +
>> +    if (blkdev->xendev.gnttabdev) {
>> +        xengnttab_close(blkdev->xendev.gnttabdev);
>> +        blkdev->xendev.gnttabdev = NULL;
>> +    }
> 
> I think blk_disconnect needs to be called from blk_free in case where
> the gnttabdev is not closed (like it is done when blk or the sring are
> not cleared, in blk_free).

Right. Just calling it always from blk_free() should do the job.

BTW: in practice this wouldn't be necessary as xen_pv_del_xendev()
already does the close, but this is just good luck. Better closing it
via blk_free() in case xen_pv_del_xendev() adds a test for
DEVOPS_FLAG_NEED_GNTDEV.


Thanks,

Juergen
