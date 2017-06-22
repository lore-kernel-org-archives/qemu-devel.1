Received: from eggs.gnu.org ([2001:4830:134:3::10]:60100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO0Zz-0006Jd-6D
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO0Zt-0000TU-TE
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dO0Zt-0000T4-Mz
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:47:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6615A120E8
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 11:47:12 +0000 (UTC)
Date: Thu, 22 Jun 2017 12:47:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170622114708.GB2624@work-vm>
References: <20170614203000.19984-1-ehabkost@redhat.com>
	<20170614203000.19984-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614203000.19984-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] memory: Allow RAM up to
 block->max_length to be discarded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> Currently ram_block_discard_range() is called only by the postcopy code,
> using length=block->used_length.  However, new code will use
> ram_block_discard_range() to discard the contents of the entire
> RAMBlock, so change the limit check to use max_length instead of
> used_length.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index a93e209625..585d6ed6d7 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3522,7 +3522,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>          goto err;
>      }
>  
> -    if ((start + length) <= rb->used_length) {
> +    if ((start + length) <= rb->max_length) {
>          uint8_t *host_endaddr = host_startaddr + length;
>          if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
>              error_report("ram_block_discard_range: Unaligned end address: %p",
> -- 
> 2.11.0.259.g40922b1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
