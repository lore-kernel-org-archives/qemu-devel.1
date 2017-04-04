Received: from eggs.gnu.org ([2001:4830:134:3::10]:37962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvNeD-0000Ij-Pi
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvNeA-0001Ad-LY
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:33:21 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40243
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvNeA-0001AC-ET
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:33:18 -0400
References: <20170404102315.24923-1-kraxel@redhat.com>
	<20170404102315.24923-7-kraxel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <75e91504-305c-cee6-d832-f11b9af9fdb0@ilande.co.uk>
Date: Tue, 4 Apr 2017 13:32:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170404102315.24923-7-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/10] cg3: fix up size parameter for
 memory_region_get_dirty()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 04/04/17 11:23, Gerd Hoffmann wrote:

> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> The code was incorrectly calculating the end address rather than the size of
> the required region.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/display/cg3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index e05ca92..6e19da0 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -115,7 +115,7 @@ static void cg3_update_display(void *opaque)
>          int update = s->full_update;
>  
>          page = y * width;
> -        update |= memory_region_get_dirty(&s->vram_mem, page, page + width,
> +        update |= memory_region_get_dirty(&s->vram_mem, page, width - 1,
>                                            DIRTY_MEMORY_VGA);
>          if (update) {
>              if (y_start < 0) {
> 

The size here should actually be "width" rather than "width - 1" here
(this patch was originally written when the assert()s for checking the
start/end of the region size were off-by-one).


ATB,

Mark.
