Received: from eggs.gnu.org ([2001:4830:134:3::10]:44550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnk9L-0001Ri-9J
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnk9H-0000yg-AO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:57:55 -0400
References: <1489488980-130668-1-git-send-email-liqiang6-s@360.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4819e813-91e2-3181-fb86-02a2906198c7@redhat.com>
Date: Tue, 14 Mar 2017 11:57:47 +0100
MIME-Version: 1.0
In-Reply-To: <1489488980-130668-1-git-send-email-liqiang6-s@360.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi: mptsas: fix the wrong reading size
 in fetch request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>, qemu-stable <qemu-stable@nongnu.org>



On 14/03/2017 11:56, Li Qiang wrote:
> When fetching request, it should read sizeof(*hdr), not the
> pointer hdr.
> 
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/scsi/mptsas.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 2e091c0..765ab53 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -756,7 +756,7 @@ static void mptsas_fetch_request(MPTSASState *s)
>  
>      /* Read the message header from the guest first. */
>      addr = s->host_mfa_high_addr | MPTSAS_FIFO_GET(s, request_post);
> -    pci_dma_read(pci, addr, req, sizeof(hdr));
> +    pci_dma_read(pci, addr, req, sizeof(*hdr));
>  
>      if (hdr->Function < ARRAY_SIZE(mpi_request_sizes) &&
>          mpi_request_sizes[hdr->Function]) {
> @@ -766,8 +766,8 @@ static void mptsas_fetch_request(MPTSASState *s)
>           */
>          size = mpi_request_sizes[hdr->Function];
>          assert(size <= MPTSAS_MAX_REQUEST_SIZE);
> -        pci_dma_read(pci, addr + sizeof(hdr), &req[sizeof(hdr)],
> -                     size - sizeof(hdr));
> +        pci_dma_read(pci, addr + sizeof(*hdr), &req[sizeof(*hdr)],
> +                     size - sizeof(*hdr));
>      }
>  
>      if (hdr->Function == MPI_FUNCTION_SCSI_IO_REQUEST) {
> 

Cc: qemu-stable@nongnu.org

Queued for 2.9, thanks.

Paolo
