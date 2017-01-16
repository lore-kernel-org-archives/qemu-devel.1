Received: from eggs.gnu.org ([2001:4830:134:3::10]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cSzo7-0001rk-I7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cSzo6-0004cI-Lg
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:26:15 -0500
Date: Mon, 16 Jan 2017 13:26:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116052600.GA16076@lemon>
References: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
	<20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
	<7428bd3f-0cc8-f42f-a2bd-442c2c6ffbef@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7428bd3f-0cc8-f42f-a2bd-442c2c6ffbef@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] block/vmdk: Fix the endian problem
 of buf_len and lba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liujing <liujbjl@linux.vnet.ibm.com>, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, "cornelia.huck@de.ibm.com QingFeng Hao" <haoqf@linux.vnet.ibm.com>, qemu-stable@nongnu.org

On Mon, 01/16 10:38, liujing wrote:
> Dears,
> 
> We would like to know if this patch will be pulled
> 
> into upstream or what else we need to do for it?
> 
> Because for upstream, the qemu-iotests case 055 still failed.

Kevin, would you like to take this or should I do it?

Fam

> 
> Thanks.
> 
> Jing
> 
> 
> On 12/16/2016 01:20 PM, QingFeng Hao wrote:
> > The problem was triggered by qemu-iotests case 055. It failed when it
> > was comparing the compressed vmdk image with original test.img.
> > 
> > The cause is that buf_len in vmdk_write_extent wasn't converted to
> > little-endian before it was stored to disk. But later vmdk_read_extent
> > read it and converted it from little-endian to cpu endian.
> > If the cpu is big-endian like s390, the problem will happen and
> > the data length read by vmdk_read_extent will become invalid!
> > The fix is to add the conversion in vmdk_write_extent, meanwhile,
> > repair the endianness problem of lba field which shall also be converted
> > to little-endian before storing to disk.
> > 
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > ---
> >   block/vmdk.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/vmdk.c b/block/vmdk.c
> > index a11c27a..26e5f95 100644
> > --- a/block/vmdk.c
> > +++ b/block/vmdk.c
> > @@ -1354,8 +1354,8 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
> >               goto out;
> >           }
> > 
> > -        data->lba = offset >> BDRV_SECTOR_BITS;
> > -        data->size = buf_len;
> > +        data->lba = cpu_to_le64(offset >> BDRV_SECTOR_BITS);
> > +        data->size = cpu_to_le32(buf_len);
> > 
> >           n_bytes = buf_len + sizeof(VmdkGrainMarker);
> >           iov = (struct iovec) {
> 
> 
