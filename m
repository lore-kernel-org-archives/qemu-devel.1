Received: from eggs.gnu.org ([2001:4830:134:3::10]:39624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHPek-0003mM-CW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHPeg-0000JV-AT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:45:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHPeg-0000C9-2t
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:45:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so11586372wrv.6
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 01:45:30 -0700 (PDT)
References: <20181030082340.17170-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6c8e609-9daa-0f60-81d0-50d51db5ba3a@redhat.com>
Date: Tue, 30 Oct 2018 09:45:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181030082340.17170-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad J Pandit <ppandit@redhat.com>

Hi Gerd,

On 30/10/18 9:23, Gerd Hoffmann wrote:

Can you add your previous patch description,

   We have a lovely, guest-triggerable buffer overflow in opl2 emulation.

   Reproducer:
       outw(0xff60, 0x220);
       outw(0x1020, 0x220);
       outw(0xffb0, 0x220);
   Result:
       Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])

And Prasad Pandit triggering flow:

   In set_ar_dr

     SLOT->AR = ar ? &OPL->AR_TABLE[ar<<2] : RATE_0;

   SLOT->AR is set to point to OPL->DR_TABLE[60] and while so if s->ksr
   is set to 15, in CALC_FCSLOT()

   SLOT->evsa = SLOT->AR[ksr];  <= accesses OPL->AR_TABLE[60 + 15];

Thanks.

> Fixes: CVE-2018-???
> Cc: P J P <ppandit@redhat.com>
> Reported-by: Wangjunqing <wangjunqing@huawei.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/audio/fmopl.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
> index e7e578a48e..7199afaa3c 100644
> --- a/hw/audio/fmopl.h
> +++ b/hw/audio/fmopl.h
> @@ -72,8 +72,8 @@ typedef struct fm_opl_f {
>   	/* Rhythm sention */
>   	uint8_t rhythm;		/* Rhythm mode , key flag */
>   	/* time tables */
> -	int32_t AR_TABLE[75];	/* atttack rate tables */
> -	int32_t DR_TABLE[75];	/* decay rate tables   */
> +	int32_t AR_TABLE[76];	/* atttack rate tables */
> +	int32_t DR_TABLE[76];	/* decay rate tables   */
>   	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
>   	/* LFO */
>   	int32_t *ams_table;
> 
