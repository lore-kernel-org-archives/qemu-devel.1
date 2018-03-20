Received: from eggs.gnu.org ([2001:4830:134:3::10]:38281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eyEXP-0006DN-Dr
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eyEXL-0000yE-EY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:30:39 -0400
References: <20180319215335.1119213-1-eblake@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <56ec7ba5-a6e1-2268-3313-8babc640c024@redhat.com>
Date: Tue, 20 Mar 2018 12:30:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180319215335.1119213-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>
Cc: qemu-trivial@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>

Hi Eric,

On 19/03/2018 23:53, Eric Blake wrote:
> Use the correct printf formats, so that a 32-bit compile doesn't
> spit out lots of warnings about %lx being incompatible with uint64_t.
> Broken since initial commit ef6d4ccd.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> I don't know if 'make vm-build-ubuntu.i368' would catch this (it failed
> for me for other reasons); I found it via a 32-bit rawhide VM.
> 

I couldn't run 'make vm-build-ubuntu.i368' either. (Stuck on "Booting from Hard Disk...")

I run make docker-test-build@debian-win32-cross to be sure it compiles on 32bit arch,
however I found out the docker configuration results in 'RDMA support no', so it will not help.

Fam, is there any way the docker image can be updated with the RDMA libraries
so we can check this too?

>  hw/rdma/rdma_backend.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index e306fba5344..89020fdcf62 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -656,7 +656,8 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
>  #define CHK_ATTR(req, dev, member, fmt) ({ \
>      pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req->member); \
>      if (req->member > dev.member) { \
> -        warn_report("%s = 0x%lx is higher than host device capability 0x%lx", \
> +        warn_report("%s = 0x%" PRIx64 " is higher than host device " \
> +                    "capability 0x%" PRIx64, \
>                      #member, (uint64_t)req->member, (uint64_t)dev.member); \
>          req->member = dev.member; \
>      } \
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>


Thanks,
Marcel
