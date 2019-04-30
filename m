Received: from eggs.gnu.org ([209.51.188.92]:41582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLSJ0-0003lB-PH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLSIz-00084I-Kd
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:56:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLSIz-000838-Ev
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:56:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so3724307wmc.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:56:16 -0700 (PDT)
References: <20190430115404.18483-1-pl@kamp.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1667a919-9d20-14ca-fd72-e4d3074fd4a0@redhat.com>
Date: Tue, 30 Apr 2019 14:56:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190430115404.18483-1-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RESEND] megasas: fix mapped frame size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, hare@suse.com, qemu-stable@nongnu.org

On 4/30/19 1:54 PM, Peter Lieven wrote:
> the current value of 1024 bytes (16 * MFI_FRAME_SIZE) we map is not enough to hold
> the maximum number of scatter gather elements we advertise. We actually need a
> maximum of 2048 bytes. This is 128 max sg elements * 16 bytes (sizeof (union mfi_sgl)).

Looking at megasas_map_sgl(), we indeed accept up to MEGASAS_MAX_SGE
iov_count. Broken since ever then?

Fixes: e8f943c3bcc2
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index a56317e026..5ad762de23 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -477,7 +477,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
>  {
>      PCIDevice *pcid = PCI_DEVICE(s);
>      MegasasCmd *cmd = NULL;
> -    int frame_size = MFI_FRAME_SIZE * 16;
> +    int frame_size = MEGASAS_MAX_SGE * sizeof(union mfi_sgl);
>      hwaddr frame_size_p = frame_size;
>      unsigned long index;
>  
> 
