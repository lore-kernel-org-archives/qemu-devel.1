Received: from eggs.gnu.org ([2001:4830:134:3::10]:45948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1cSxCF-0001bq-4i
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 21:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1cSxCA-0003Cc-8D
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 21:38:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujbjl@linux.vnet.ibm.com>)
	id 1cSxC9-0003CN-VB
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 21:38:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0G2cbFe022108
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 21:38:52 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27ym8fa3wh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 21:38:51 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <liujbjl@linux.vnet.ibm.com>;
	Sun, 15 Jan 2017 19:38:51 -0700
References: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
	<20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
From: liujing <liujbjl@linux.vnet.ibm.com>
Date: Mon, 16 Jan 2017 10:38:43 +0800
MIME-Version: 1.0
In-Reply-To: <20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <7428bd3f-0cc8-f42f-a2bd-442c2c6ffbef@linux.vnet.ibm.com>
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
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com
Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>, kwolf@redhat.com, famz@redhat.com, qemu-stable@nongnu.org

Dears,

We would like to know if this patch will be pulled

into upstream or what else we need to do for it?

Because for upstream, the qemu-iotests case 055 still failed.

Thanks.

Jing


On 12/16/2016 01:20 PM, QingFeng Hao wrote:
> The problem was triggered by qemu-iotests case 055. It failed when it
> was comparing the compressed vmdk image with original test.img.
>
> The cause is that buf_len in vmdk_write_extent wasn't converted to
> little-endian before it was stored to disk. But later vmdk_read_extent
> read it and converted it from little-endian to cpu endian.
> If the cpu is big-endian like s390, the problem will happen and
> the data length read by vmdk_read_extent will become invalid!
> The fix is to add the conversion in vmdk_write_extent, meanwhile,
> repair the endianness problem of lba field which shall also be converted
> to little-endian before storing to disk.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>   block/vmdk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/vmdk.c b/block/vmdk.c
> index a11c27a..26e5f95 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1354,8 +1354,8 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
>               goto out;
>           }
>
> -        data->lba = offset >> BDRV_SECTOR_BITS;
> -        data->size = buf_len;
> +        data->lba = cpu_to_le64(offset >> BDRV_SECTOR_BITS);
> +        data->size = cpu_to_le32(buf_len);
>
>           n_bytes = buf_len + sizeof(VmdkGrainMarker);
>           iov = (struct iovec) {
