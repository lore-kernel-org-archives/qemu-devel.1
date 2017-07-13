Received: from eggs.gnu.org ([2001:4830:134:3::10]:59232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVbE5-0005QQ-5M
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVbE1-0008De-4I
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:20:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVbE0-0008DK-Vn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:20:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id c20so5424195qte.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:20:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170621043401.19842-1-hpoussin@reactos.org>
	<20170621043401.19842-2-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0344b107-7e9e-f1d0-acee-fd9d3cbe25ee@amsat.org>
Date: Thu, 13 Jul 2017 07:18:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170621043401.19842-2-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] audio/fmopl: modify timer callback to
 give opaque and channel parameters in two arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi Hervé,

On 06/21/2017 01:34 AM, Hervé Poussineau wrote:
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>   hw/audio/adlib.c |  2 +-
>   hw/audio/fmopl.c | 18 +++++++++++++-----
>   hw/audio/fmopl.h |  7 ++++---
>   3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index c6e0f10c16..be4203476a 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -130,7 +130,7 @@ static uint32_t adlib_read(void *opaque, uint32_t nport)
>       return data;
>   }
>   
> -static void timer_handler (int c, double interval_Sec)
> +static void timer_handler (void *opaque, int c, double interval_Sec)
>   {
>       AdlibState *s = glob_adlib;
>       unsigned n = c & 1;
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index 202f752c5d..5cfb6a96dd 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -788,14 +788,18 @@ static void OPLWriteReg(FM_OPL *OPL, int r, int v)
>   				{
>   					double interval = st2 ? (double)OPL->T[1]*OPL->TimerBase : 0.0;
>   					OPL->st[1] = st2;
> -					if (OPL->TimerHandler) (OPL->TimerHandler)(OPL->TimerParam+1,interval);
> +                    if (OPL->TimerHandler) {
> +                        (OPL->TimerHandler)(OPL->TimerParam, 1, interval);
> +                    }
>   				}
>   				/* timer 1 */
>   				if(OPL->st[0] != st1)
>   				{
>   					double interval = st1 ? (double)OPL->T[0]*OPL->TimerBase : 0.0;
>   					OPL->st[0] = st1;
> -					if (OPL->TimerHandler) (OPL->TimerHandler)(OPL->TimerParam+0,interval);
> +                    if (OPL->TimerHandler) {
> +                        (OPL->TimerHandler)(OPL->TimerParam, 0, interval);
> +                    }
>   				}
>   			}
>   			return;
> @@ -1128,10 +1132,11 @@ void OPLDestroy(FM_OPL *OPL)
>   
>   /* ----------  Option handlers ----------       */
>   
> -void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset)
> +void OPLSetTimerHandler(FM_OPL *OPL, OPL_TIMERHANDLER TimerHandler,
> +                        void *param)
>   {
>   	OPL->TimerHandler   = TimerHandler;
> -	OPL->TimerParam = channelOffset;
> +    OPL->TimerParam = param;
>   }
>   
>   /* ---------- YM3812 I/O interface ---------- */
> @@ -1197,6 +1202,9 @@ int OPLTimerOver(FM_OPL *OPL,int c)
>   		}
>   	}
>   	/* reload timer */
> -	if (OPL->TimerHandler) (OPL->TimerHandler)(OPL->TimerParam+c,(double)OPL->T[c]*OPL->TimerBase);
> +    if (OPL->TimerHandler) {
> +        (OPL->TimerHandler)(OPL->TimerParam, c,
> +                            (double)OPL->T[c] * OPL->TimerBase);
> +    }
>   	return OPL->status>>7;
>   }
> diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
> index fc9f16b58a..f4065f425c 100644
> --- a/hw/audio/fmopl.h
> +++ b/hw/audio/fmopl.h
> @@ -3,7 +3,7 @@
>   
>   #include <stdint.h>
>   
> -typedef void (*OPL_TIMERHANDLER)(int channel,double interval_Sec);
> +typedef void (*OPL_TIMERHANDLER)(void *param, int channel, double interval_Sec);
>   
>   /* !!!!! here is private section , do not access there member direct !!!!! */
>   
> @@ -87,13 +87,14 @@ typedef struct fm_opl_f {
>   	uint8_t wavesel;
>   	/* external event callback handler */
>   	OPL_TIMERHANDLER  TimerHandler;		/* TIMER handler   */
> -	int TimerParam;						/* TIMER parameter */
> +    void *TimerParam; /* TIMER parameter */

not very useful comment ;)

>   } FM_OPL;
>   
>   /* ---------- Generic interface section ---------- */
>   FM_OPL *OPLCreate(int clock, int rate);
>   void OPLDestroy(FM_OPL *OPL);
> -void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset);
> +void OPLSetTimerHandler(FM_OPL *OPL, OPL_TIMERHANDLER TimerHandler,
> +                        void *param);
>   
>   int OPLWrite(FM_OPL *OPL,int a,int v);
>   unsigned char OPLRead(FM_OPL *OPL,int a);
> 
