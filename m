Received: from eggs.gnu.org ([2001:4830:134:3::10]:43743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gK3T0-00057r-Rs
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gK3T0-0002Cu-4v
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:40:34 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:43977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gK3Sz-0002Br-Vt
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:40:34 -0500
Received: by mail-qt1-x844.google.com with SMTP id i7so3054953qtj.10
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 07:40:33 -0800 (PST)
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-3-pbonzini@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <c2aeac3a-07c9-f5ef-16e5-48e384f50a72@gmail.com>
Date: Tue, 6 Nov 2018 13:40:30 -0200
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: mreitz@redhat.com



On 10/29/18 2:34 PM, Paolo Bonzini wrote:
> A device can report an excessive number of VPD pages when asked for a
> list; this can cause an out-of-bounds access to buf in
> scsi_generic_set_vpd_bl_emulation.  It should not happen, but
> it is technically not incorrect so handle it: do not check any byte
> past the allocation length that was sent to the INQUIRY command.
>
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

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
