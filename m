Received: from eggs.gnu.org ([2001:4830:134:3::10]:46251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eefMz-0002SP-Kd
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eefMw-0007ZZ-Ez
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:07:01 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-3-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce230364-5139-e49c-0cb9-95fe36296c75@redhat.com>
Date: Thu, 25 Jan 2018 12:06:50 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-3-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/10] s390-ccw: refactor eckd_block_num
 to use CHS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> Add new cylinder/head/sector struct. Use it to calculate
> eckd block numbers instead of a BootMapPointer (which used
> eckd chs anyway).
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 28 ++++++++++++++--------------
>  pc-bios/s390-ccw/bootmap.h |  8 ++++++--
>  2 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 6b6c915..621adbe 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -95,32 +95,32 @@ static inline void verify_boot_info(BootInfo *bip)
>                 "Bad block size in zIPL section of the 1st record.");
>  }
>  
> -static block_number_t eckd_block_num(BootMapPointer *p)
> +static block_number_t eckd_block_num(EckdCHS chs)

Should this maybe rather be call-by-pointer instead? I'm not a fan of
passing structs by value, though it might be OK in this case since it's
a small struct only...

What do others think?

 Thomas


PS: Apart from that, the patch looks fine to me.
