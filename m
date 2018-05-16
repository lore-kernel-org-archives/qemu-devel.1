Received: from eggs.gnu.org ([2001:4830:134:3::10]:44937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIysg-0003FS-6Q
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIysd-00009Y-1M
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:02:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
	<1526493784-25328-2-git-send-email-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85f12e3c-f3a5-3627-6865-4508f3492a6f@amsat.org>
Date: Wed, 16 May 2018 13:02:03 -0300
MIME-Version: 1.0
In-Reply-To: <1526493784-25328-2-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] hw/arm/smmuv3: Fix Coverity
 issue in smmuv3_record_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

On 05/16/2018 03:03 PM, Eric Auger wrote:
> Coverity complains about use of uninitialized Evt struct.
> The EVT_SET_TYPE and similar setters use deposit32() on fields
> in the struct, so they read the uninitialized existing values.
> In cases where we don't set all the fields in the event struct
> we'll end up leaking random uninitialized data from QEMU's
> stack into the guest.
> 
> Initializing the struct with "Evt evt = {};" ought to satisfy
> Coverity and fix the data leak.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/smmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b3026de..42dc521 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -143,7 +143,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>  
>  void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>  {
> -    Evt evt;
> +    Evt evt = {};
>      MemTxResult r;
>  
>      if (!smmuv3_eventq_enabled(s)) {
> 
