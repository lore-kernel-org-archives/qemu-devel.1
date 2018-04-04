Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3io7-0005sk-5L
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3io2-0007aV-FD
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:50:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
	<20180319161556.16446-3-peter.maydell@linaro.org>
	<6db56a4f-f877-8052-e6e7-65f3ac58a95b@amsat.org>
	<CAFEAcA8_b4RyxM+-GAJK-++5f8m7hktR4nj5YygDFUJu=mtrkg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <66fe9757-1ef7-6d3a-1bb3-fd09fc216747@amsat.org>
Date: Wed, 4 Apr 2018 10:50:25 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8_b4RyxM+-GAJK-++5f8m7hktR4nj5YygDFUJu=mtrkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/2] hw/sd/bcm2835_sdhost: Don't
 raise spurious interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 04/04/2018 08:57 AM, Peter Maydell wrote:
> On 4 April 2018 at 12:50, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Peter,
>>
>> On 03/19/2018 01:15 PM, Peter Maydell wrote:
>>> The Linux bcm2835_sdhost driver doesn't work on QEMU, because our
>>> model raises spurious data interrupts.  Our function
>>> bcm2835_sdhost_fifo_run() will flag an interrupt any time it is
>>> called with s->datacnt == 0, even if the host hasn't actually issued
>>> a data read or write command yet.  This means that the driver gets a
>>> spurious data interrupt as soon as it enables IRQs and then does
>>> something else that causes us to call the fifo_run routine, like
>>> writing to SDHCFG, and before it does the write to SDCMD to issue the
>>> read.  The driver's IRQ handler then spins forever complaining that
>>> there's no data and the SD controller isn't in a state where there's
>>> going to be any data:
>>>
>>> [   41.040738] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
>>> [   41.042059] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
>>> (continues forever).
>>>
>>> Move the interrupt flag setting to more plausible places:
>>>  * for BUSY, raise this as soon as a BUSYWAIT command has executed
>>>  * for DATA, raise this when the FIFO has any space free (for a write)
>>>    or any data in it (for a read)
>>>  * for BLOCK, raise this when the data count is 0 and we've
>>>    actually done some reading or writing
>>>
>>> This is pure guesswork since the documentation for this hardware is
>>> not public, but it is sufficient to get the Linux bcm2835_sdhost
>>> driver to work.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  hw/sd/bcm2835_sdhost.c | 43 +++++++++++++++++++++++--------------------
>>>  1 file changed, 23 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
>>> index 79f3c5ceeb..0fd0853fa3 100644
>>> --- a/hw/sd/bcm2835_sdhost.c
>>> +++ b/hw/sd/bcm2835_sdhost.c
>>> @@ -137,6 +137,9 @@ static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
>>>          }
>>>  #undef RWORD
>>>      }
>>> +    if ((s->cmd & SDCMD_BUSYWAIT) && (s->config & SDHCFG_BUSY_IRPT_EN)) {
>>> +        s->status |= SDHSTS_BUSY_IRPT;
>>> +    }
>>>      return;
>>>
>>>  error:
>>> @@ -187,18 +190,27 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
>>>                  n++;
>>>                  if (n == 4) {
>>>                      bcm2835_sdhost_fifo_push(s, value);
>>> +                    s->status |= SDHSTS_DATA_FLAG;
>>
>> ^ I'd move this line in bcm2835_sdhost_fifo_push(),
> 
> The bcm2835_sdhost_fifo_push() function is also used when
> pushing data into the FIFO from the guest, though
> (in the handling of writes to the SDDATA register), and
> we don't want to set the DATA flag in that case I think.> So we need to set the flag only at the callsites where
> it's the SD card pushing data into (or removing it from)
> the FIFO.

Ok, thanks.

> 
>>
>>> +                    if (s->config & SDHCFG_DATA_IRPT_EN) {
>>> +                        s->status |= SDHSTS_SDIO_IRPT;
>>> +                    }
>>>                      n = 0;
>>>                      value = 0;
>>>                  }
>>>              }
>>>              if (n != 0) {
>>>                  bcm2835_sdhost_fifo_push(s, value);
>>> +                s->status |= SDHSTS_DATA_FLAG;
>>
>> removing this one.
>>
>>>              }
>>>          } else { /* write */
>>>              n = 0;
>>>              while (s->datacnt > 0 && (s->fifo_len > 0 || n > 0)) {
>>>                  if (n == 0) {
>>>                      value = bcm2835_sdhost_fifo_pop(s);
>>> +                    s->status |= SDHSTS_DATA_FLAG;
>>> +                    if (s->config & SDHCFG_DATA_IRPT_EN) {
>>> +                        s->status |= SDHSTS_SDIO_IRPT;
>>> +                    }
>>>                      n = 4;
>>>                  }
>>>                  n--;
>>> @@ -207,28 +219,19 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
>>>                  value >>= 8;
>>>              }
>>>          }
>>> +        if (s->datacnt == 0) {
>>> +            s->edm &= ~0xf;
>>
>> while here, let's use SDEDM_FSM_MASK.
> 
> Sure.
> 
> thanks
> -- PMM
> 
