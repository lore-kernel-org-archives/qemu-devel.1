Received: from eggs.gnu.org ([2001:4830:134:3::10]:38412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3h3C-0008KV-9K
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3h3B-0004kv-1D
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:58:02 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3h3A-0004kV-S1
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:58:00 -0400
Received: by mail-oi0-x241.google.com with SMTP id x9-v6so18946216oig.7
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 04:58:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6db56a4f-f877-8052-e6e7-65f3ac58a95b@amsat.org>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
	<20180319161556.16446-3-peter.maydell@linaro.org>
	<6db56a4f-f877-8052-e6e7-65f3ac58a95b@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 12:57:39 +0100
Message-ID: <CAFEAcA8_b4RyxM+-GAJK-++5f8m7hktR4nj5YygDFUJu=mtrkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 4 April 2018 at 12:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
> On 03/19/2018 01:15 PM, Peter Maydell wrote:
>> The Linux bcm2835_sdhost driver doesn't work on QEMU, because our
>> model raises spurious data interrupts.  Our function
>> bcm2835_sdhost_fifo_run() will flag an interrupt any time it is
>> called with s->datacnt =3D=3D 0, even if the host hasn't actually issued
>> a data read or write command yet.  This means that the driver gets a
>> spurious data interrupt as soon as it enables IRQs and then does
>> something else that causes us to call the fifo_run routine, like
>> writing to SDHCFG, and before it does the write to SDCMD to issue the
>> read.  The driver's IRQ handler then spins forever complaining that
>> there's no data and the SD controller isn't in a state where there's
>> going to be any data:
>>
>> [   41.040738] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
>> [   41.042059] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
>> (continues forever).
>>
>> Move the interrupt flag setting to more plausible places:
>>  * for BUSY, raise this as soon as a BUSYWAIT command has executed
>>  * for DATA, raise this when the FIFO has any space free (for a write)
>>    or any data in it (for a read)
>>  * for BLOCK, raise this when the data count is 0 and we've
>>    actually done some reading or writing
>>
>> This is pure guesswork since the documentation for this hardware is
>> not public, but it is sufficient to get the Linux bcm2835_sdhost
>> driver to work.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/sd/bcm2835_sdhost.c | 43 +++++++++++++++++++++++--------------------
>>  1 file changed, 23 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
>> index 79f3c5ceeb..0fd0853fa3 100644
>> --- a/hw/sd/bcm2835_sdhost.c
>> +++ b/hw/sd/bcm2835_sdhost.c
>> @@ -137,6 +137,9 @@ static void bcm2835_sdhost_send_command(BCM2835SDHos=
tState *s)
>>          }
>>  #undef RWORD
>>      }
>> +    if ((s->cmd & SDCMD_BUSYWAIT) && (s->config & SDHCFG_BUSY_IRPT_EN))=
 {
>> +        s->status |=3D SDHSTS_BUSY_IRPT;
>> +    }
>>      return;
>>
>>  error:
>> @@ -187,18 +190,27 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostS=
tate *s)
>>                  n++;
>>                  if (n =3D=3D 4) {
>>                      bcm2835_sdhost_fifo_push(s, value);
>> +                    s->status |=3D SDHSTS_DATA_FLAG;
>
> ^ I'd move this line in bcm2835_sdhost_fifo_push(),

The bcm2835_sdhost_fifo_push() function is also used when
pushing data into the FIFO from the guest, though
(in the handling of writes to the SDDATA register), and
we don't want to set the DATA flag in that case I think.
So we need to set the flag only at the callsites where
it's the SD card pushing data into (or removing it from)
the FIFO.

>
>> +                    if (s->config & SDHCFG_DATA_IRPT_EN) {
>> +                        s->status |=3D SDHSTS_SDIO_IRPT;
>> +                    }
>>                      n =3D 0;
>>                      value =3D 0;
>>                  }
>>              }
>>              if (n !=3D 0) {
>>                  bcm2835_sdhost_fifo_push(s, value);
>> +                s->status |=3D SDHSTS_DATA_FLAG;
>
> removing this one.
>
>>              }
>>          } else { /* write */
>>              n =3D 0;
>>              while (s->datacnt > 0 && (s->fifo_len > 0 || n > 0)) {
>>                  if (n =3D=3D 0) {
>>                      value =3D bcm2835_sdhost_fifo_pop(s);
>> +                    s->status |=3D SDHSTS_DATA_FLAG;
>> +                    if (s->config & SDHCFG_DATA_IRPT_EN) {
>> +                        s->status |=3D SDHSTS_SDIO_IRPT;
>> +                    }
>>                      n =3D 4;
>>                  }
>>                  n--;
>> @@ -207,28 +219,19 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostS=
tate *s)
>>                  value >>=3D 8;
>>              }
>>          }
>> +        if (s->datacnt =3D=3D 0) {
>> +            s->edm &=3D ~0xf;
>
> while here, let's use SDEDM_FSM_MASK.

Sure.

thanks
-- PMM
