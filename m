Received: from eggs.gnu.org ([2001:4830:134:3::10]:50744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diJEk-0003pw-Lg
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diJEf-0002WD-JK
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:45:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diJEf-0002TZ-Ch
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02135E183E
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:45:11 +0000 (UTC)
References: <20170817102848.19294-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d0ebe1e-293d-b119-0621-d0f666b9ca36@redhat.com>
Date: Thu, 17 Aug 2017 13:44:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170817102848.19294-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-block: Add qdev error properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 17/08/2017 12:28, Fam Zheng wrote:
> This makes the werror/rerror options available on the scsi-block device,
> to allow user specify error handling policy in the same way as scsi-hd
> etc.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

I'm not sure this is enough, because you would only obey the
rerror/werror action if ioctl fails, not if the ioctl succeeds but the
command fails (the "r->status && *r->status" conditional in
scsi_disk_req_check_error).

Paolo

> ---
>  hw/scsi/scsi-disk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5f1e5e8070..27d917f7c3 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2972,6 +2972,7 @@ static const TypeInfo scsi_cd_info = {
>  
>  #ifdef __linux__
>  static Property scsi_block_properties[] = {
> +    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
>      DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> 
