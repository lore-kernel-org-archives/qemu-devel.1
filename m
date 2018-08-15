Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpwxc-0007Ft-8y
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpwxY-0001VK-2b
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:39:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-15-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56981299-9424-66b1-9e3b-26bf35f58a82@amsat.org>
Date: Wed, 15 Aug 2018 11:39:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180809130115.28951-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 14/16] hw/dma/pl080: Correct bug
 in register address decode logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/09/2018 10:01 AM, Peter Maydell wrote:
> A bug in the handling of the register address decode logic
> for the PL08x meant that we were incorrectly treating
> accesses to the DMA channel registers (DMACCxSrcAddr,
> DMACCxDestaddr, DMACCxLLI, DMACCxControl, DMACCxConfiguration)
> as bad offsets. Fix this long-standing bug.

Since this file's origin (cdbdb648b7c).

> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1637974
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This has been around for a long time, identified by code
> inspection several years ago in the LP bug. Now I have
> some guest code that actually tries to use the PL08x I
> can test the fix...
> ---
>  hw/dma/pl080.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
> index a7aacad74f0..8f92550392b 100644
> --- a/hw/dma/pl080.c
> +++ b/hw/dma/pl080.c
> @@ -229,7 +229,7 @@ static uint64_t pl080_read(void *opaque, hwaddr offset,
>          i = (offset & 0xe0) >> 5;
>          if (i >= s->nchannels)
>              goto bad_offset;
> -        switch (offset >> 2) {
> +        switch ((offset >> 2) & 7) {

So only the first channel ever worked...

>          case 0: /* SrcAddr */
>              return s->chan[i].src;
>          case 1: /* DestAddr */
> @@ -290,7 +290,7 @@ static void pl080_write(void *opaque, hwaddr offset,
>          i = (offset & 0xe0) >> 5;
>          if (i >= s->nchannels)
>              goto bad_offset;
> -        switch (offset >> 2) {
> +        switch ((offset >> 2) & 7) {
>          case 0: /* SrcAddr */
>              s->chan[i].src = value;
>              break;
> @@ -308,6 +308,7 @@ static void pl080_write(void *opaque, hwaddr offset,
>              pl080_run(s);
>              break;
>          }
> +        return;
>      }
>      switch (offset >> 2) {

Eventually copy/pasted from here.

>      case 2: /* IntTCClear */
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
