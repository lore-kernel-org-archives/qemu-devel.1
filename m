Received: from eggs.gnu.org ([2001:4830:134:3::10]:38416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDQQQ-00089b-Ea
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDQQN-0001E0-3m
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:46:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gDQQM-0000xh-Nw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A2F330832D7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:46:21 +0000 (UTC)
References: <20181016135027.9856-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b1519d7-ef3b-fca6-398d-294bd63f2a54@redhat.com>
Date: Fri, 19 Oct 2018 10:46:19 +0200
MIME-Version: 1.0
In-Reply-To: <20181016135027.9856-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] es1370: more fixes for ADC_FRAMEADR and
 ADC_FRAMECNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 2018-10-16 15:50, Paolo Bonzini wrote:
> They are not consecutive with DAC1_FRAME* and DAC2_FRAME*; Coverity
> still complains about es1370_read, while es1370_write was fixed in
> commit cf9270e5220671f49cc238deaf6136669cc07ae1.
> 
> Fixes: 154c1d1f960c5147a3f8ef00907504112f271cd8
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/audio/es1370.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index 4f980a598b..aa5a8d728c 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -585,9 +585,12 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
>  #endif
>          break;
>  
> +    case ES1370_REG_ADC_FRAMECNT:
> +        d += 2;
> +        goto framecnt;
>      case ES1370_REG_DAC1_FRAMECNT:
>      case ES1370_REG_DAC2_FRAMECNT:
> -    case ES1370_REG_ADC_FRAMECNT:
> +    framecnt:
>          d += (addr - ES1370_REG_DAC1_FRAMECNT) >> 3;
>          val = d->frame_cnt;
>  #ifdef DEBUG_ES1370
> @@ -602,9 +605,12 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
>  #endif
>          break;
>  
> +    case ES1370_REG_ADC_FRAMEADR:
> +        d += 2;
> +        goto frameadr;
>      case ES1370_REG_DAC1_FRAMEADR:
>      case ES1370_REG_DAC2_FRAMEADR:
> -    case ES1370_REG_ADC_FRAMEADR:
> +    frameadr:
>          d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
>          val = d->frame_addr;
>          break;
> 

It's in a pull request already, so this is likely too late: But for the
next time, could you maybe rather use a "/* fall through */" comment
instead of a goto? That looks less ugly.

 Thomas
