Received: from eggs.gnu.org ([2001:4830:134:3::10]:44015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRDDN-0000Mm-4B
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRDDJ-0002v2-W5
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:25:29 -0500
References: <20171218224616.21030-1-david@redhat.com>
	<20171218224616.21030-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <efbd564a-3d50-eade-6aac-0dac7eb7f7d9@redhat.com>
Date: Tue, 19 Dec 2017 09:25:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171218224616.21030-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 2/2] s390x/sclp: fix
 missing be conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 18.12.2017 23:46, David Hildenbrand wrote:
> Linux crashes right now if maxmem > mem is specified on the command line.
> 
> On s390x, the guest can hotplug memory itself right now - very weird -
> and e.g. Fedora 27 will simply add all memory it can when booting.
> 
> So now, we have at least the same behavior on TCG and KVM.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/sclp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 9be0cb80ad..829c13bcf2 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -233,7 +233,7 @@ static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>          return;
>      }
> -    assign_addr = (assign_info->rn - 1) * mhd->rzm;
> +    assign_addr = (be16_to_cpu(assign_info->rn) - 1) * mhd->rzm;
>  
>      if ((assign_addr % MEM_SECTION_SIZE == 0) &&
>          (assign_addr >= mhd->padded_ram_size)) {
> @@ -292,7 +292,7 @@ static void unassign_storage(SCLPDevice *sclp, SCCB *sccb)
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>          return;
>      }
> -    unassign_addr = (assign_info->rn - 1) * mhd->rzm;
> +    unassign_addr = (be16_to_cpu(assign_info->rn) - 1) * mhd->rzm;
>  
>      /* if the addr is a multiple of 256 MB */
>      if ((unassign_addr % MEM_SECTION_SIZE == 0) &&
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
