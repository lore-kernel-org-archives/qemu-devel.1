Received: from eggs.gnu.org ([2001:4830:134:3::10]:58450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f0s2A-0001dF-E1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f0s25-0005ER-Ox
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:05:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1f0s25-0005Ds-Hw
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:05:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2RH0O2w147258
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 13:05:12 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gys1rtu5h-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 13:05:12 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 27 Mar 2018 11:05:11 -0600
References: <20180327164141.19075-1-famz@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 14:05:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180327164141.19075-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <131b5c04-014b-20b7-6967-3551291fbdc0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgibson@redhat.com



On 03/27/2018 01:41 PM, Fam Zheng wrote:
> Some backends report big max_io_sectors. Making min_io_size the same
> value in this case will make it impossible for guest to align memory,
> therefore the disk may not be usable at all.
>
> Do not enlarge them when they are zero.
>
> Reported-by: David Gibson <dgibson@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
>
> ---
>
> v2: Leave the values alone if zero. [Paolo]
>      At least we can consult block layer for a slightly more sensible
>      opt_io_size, but that's for another patch.
> ---
>   hw/scsi/scsi-disk.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index f5ab767ab5..f8ed8cf2b4 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -714,10 +714,12 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>
>                   /* min_io_size and opt_io_size can't be greater than
>                    * max_io_sectors */
> -                min_io_size =
> -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> -                opt_io_size =
> -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> +                if (min_io_size) {
> +                    min_io_size = MIN(min_io_size, max_io_sectors);
> +                }
> +                if (opt_io_size) {
> +                    opt_io_size = MIN(opt_io_size, max_io_sectors);
> +                }
>               }
>               /* required VPD size with unmap support */
>               buflen = 0x40;

Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
