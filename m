Received: from eggs.gnu.org ([2001:4830:134:3::10]:49340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHbWn-00029I-48
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHbWf-0007TU-Kz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:26:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHbWf-0007Sf-Cz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:26:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id t10-v6so14201139wrn.10
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 14:26:13 -0700 (PDT)
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1324e72-4568-d167-4206-5092b17f0bb9@redhat.com>
Date: Tue, 30 Oct 2018 22:26:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] scsi-generic: avoid out-of-bounds
 access to VPD page list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, mreitz@redhat.com

On 29/10/18 18:34, Paolo Bonzini wrote:
> A device can report an excessive number of VPD pages when asked for a
> list; this can cause an out-of-bounds access to buf in
> scsi_generic_set_vpd_bl_emulation.  It should not happen, but
> it is technically not incorrect so handle it: do not check any byte
> past the allocation length that was sent to the INQUIRY command.
> 
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/scsi/scsi-generic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index aebb7cdd82..c5497bbea8 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -538,7 +538,7 @@ static void scsi_generic_set_vpd_bl_emulation(SCSIDevice *s)
>       }
>   
>       page_len = buf[3];
> -    for (i = 4; i < page_len + 4; i++) {
> +    for (i = 4; i < MIN(sizeof(buf), page_len + 4); i++) {
>           if (buf[i] == 0xb0) {
>               s->needs_vpd_bl_emulation = false;
>               return;
> 
