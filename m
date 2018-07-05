Received: from eggs.gnu.org ([2001:4830:134:3::10]:46074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fb0VD-0002fH-BK
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fb0VA-0002br-6W
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:24:39 -0400
Date: Thu, 5 Jul 2018 11:24:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180705112430.4e74049f.cohuck@redhat.com>
In-Reply-To: <1530536651-1588-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1530536651-1588-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x/storage attributes: fix
 CMMA_BLOCK_SIZE usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon,  2 Jul 2018 15:04:11 +0200
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> The macro CMMA_BLOCK_SIZE was defined but not used, and a hardcoded
> value was instead used in the code.
> 
> This patch fixes the value of CMMA_BLOCK_SIZE and uses it in the
> appropriate place in the code, and fixes another case of hardcoded
> value in the KVM backend, replacing it with the more appropriate
> constant KVM_S390_CMMA_SIZE_MAX.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-stattrib-kvm.c | 3 ++-
>  hw/s390x/s390-stattrib.c     | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index 70b9555..a788cdb 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -20,7 +20,8 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  
> -#define CMMA_BLOCK_SIZE  (1 << 10)
> +/* 512kB cover 2GB of guest memory */
> +#define CMMA_BLOCK_SIZE  (1 << 19)

Hm, this doesn't apply to current master anymore. Do we want to switch
to something based on the IEC binary prefix definitions here, or keep
the 1 << 19?

>  
>  #define STATTR_FLAG_EOS     0x01ULL
>  #define STATTR_FLAG_MORE    0x02ULL
> @@ -202,7 +203,7 @@ static int cmma_save(QEMUFile *f, void *opaque, int final)
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>      uint8_t *buf;
>      int r, cx, reallen = 0, ret = 0;
> -    uint32_t buflen = 1 << 19;   /* 512kB cover 2GB of guest memory */
> +    uint32_t buflen = CMMA_BLOCK_SIZE;
>      uint64_t start_gfn = sas->migration_cur_gfn;
>  
>      buf = g_try_malloc(buflen);
