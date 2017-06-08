Received: from eggs.gnu.org ([2001:4830:134:3::10]:49482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dInn4-0007sa-8F
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dInn1-0001bI-2r
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:07:18 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dInn0-0001aY-TT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:07:15 -0400
Received: by mail-pg0-x243.google.com with SMTP id v18so3109582pgb.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 20:07:13 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20170607080639.22120-1-haozhong.zhang@intel.com>
Message-ID: <011f1bfe-f882-d940-52eb-7b5d511f9ffc@gmail.com>
Date: Thu, 8 Jun 2017 11:07:19 +0800
MIME-Version: 1.0
In-Reply-To: <20170607080639.22120-1-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix region format interface
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>



On 06/07/2017 04:06 PM, Haozhong Zhang wrote:
> Per ACPI 6.2, section 5.2.25.6 and JEDEC Annex L Release 3, the
> current region format interface code 0x201 indicates the block
> addressed function interface 1, rather than a byte addressable
> interface. Fix it by using 0x301 which indicates the byte addressable
> no energy backed function interface 1.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>   hw/acpi/nvdimm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 8e7d6ec034..b5734f5897 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -338,9 +338,10 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
>       nfit_dcr->revision_id = cpu_to_le16(1 /* Current Revision supported
>                                                in ACPI 6.0 is 1. */);
>       nfit_dcr->serial_number = cpu_to_le32(sn);
> -    nfit_dcr->fic = cpu_to_le16(0x201 /* Format Interface Code. See Chapter
> -                                         2: NVDIMM Device Specific Method
> -                                         (DSM) in DSM Spec Rev1.*/);
> +    nfit_dcr->fic = cpu_to_le16(0x301 /* Format Interface Code:
> +                                         Byte addressable, no energy backed.
> +                                         See ACPI 6.2, sect 5.2.25.6 and
> +                                         JEDEC Annex L Release 3. */);

Shouldn't the 'no energy backend' indicator be set only for !dax disk?
