Received: from eggs.gnu.org ([2001:4830:134:3::10]:46520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIEV6-0003Ur-Kh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIEV3-0000Zt-Gw
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:26:24 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIEV3-0000Zm-Af
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:26:21 -0400
Received: by mail-ot0-x242.google.com with SMTP id i31so2041220ota.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 06:26:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170606121747.25356-1-pbonzini@redhat.com>
	<20170606121747.25356-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4dc94314-3a5b-7cf6-12d9-c63fbfc22cb6@amsat.org>
Date: Tue, 6 Jun 2017 10:26:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170606121747.25356-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] megasas: do not read sense length more
 than once from frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zyy4013@stu.ouc.edu.cn, hare@suse.de, ppandit@redhat.com

Hi Paolo,

Should this patch go in qemu-stable?

On 06/06/2017 09:17 AM, Paolo Bonzini wrote:
> Avoid TOC-TOU bugs depending on how the compiler behaves.

Can you be more descriptive here? Which compiler? (thinking about how to 
prevent this class of bugs).

Regards,

Phil.

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/megasas.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 804122ab05..1888118e5f 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -309,9 +309,11 @@ static int megasas_build_sense(MegasasCmd *cmd, uint8_t *sense_ptr,
>      PCIDevice *pcid = PCI_DEVICE(cmd->state);
>      uint32_t pa_hi = 0, pa_lo;
>      hwaddr pa;
> +    int frame_sense_len;
>
> -    if (sense_len > cmd->frame->header.sense_len) {
> -        sense_len = cmd->frame->header.sense_len;
> +    frame_sense_len = cmd->frame->header.sense_len;
> +    if (sense_len > frame_sense_len) {
> +        sense_len = frame_sense_len;
>      }
>      if (sense_len) {
>          pa_lo = le32_to_cpu(cmd->frame->pass.sense_addr_lo);
>
