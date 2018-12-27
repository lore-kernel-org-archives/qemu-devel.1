Received: from eggs.gnu.org ([208.118.235.92]:57721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gcdpo-0004k6-Cj
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gcdpn-0004eF-KB
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:08:56 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gcdpn-0004bO-Aw
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:08:55 -0500
Received: by mail-wm1-x342.google.com with SMTP id a62so17731618wmh.4
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 14:08:55 -0800 (PST)
From: "=?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?=" <dirty.ice.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<1415d73f73787a48532cc6cdd3c2a5a0c2e02e2f.1545598229.git.DirtY.iCE.hu@gmail.com>
	<a2d562e5-99fa-02de-94d3-3b39f78d3148@amsat.org>
Message-ID: <9677d9f5-2583-1c46-004d-ca8a318693d8@gmail.com>
Date: Thu, 27 Dec 2018 23:08:52 +0100
MIME-Version: 1.0
In-Reply-To: <a2d562e5-99fa-02de-94d3-3b39f78d3148@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: hu-HU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 52/52] usbaudio: change playback
 counters to 64 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi,

On 2018-12-25 11:50, Philippe Mathieu-Daudé wrote:
> On 12/23/18 9:52 PM, Kővágó, Zoltán wrote:
>> With stereo playback, they need about 375 minutes of continuous audio
>> playback to overflow, which is usually not a problem (as stopping and
>> later resuming playback resets the counters).  But with 7.1 audio, they
>> only need about 95 minutes to overflow.
>>
>> After the overflow, the buf->prod % USBAUDIO_PACKET_SIZE(channels)
>> assertion no longer holds true, which will result in overflowing the
>> buffer.  With 64 bit variables, it would take about 762000 years to
>> overflow.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>  hw/usb/dev-audio.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
>> index 29475a2b70..45ffc3ebb3 100644
>> --- a/hw/usb/dev-audio.c
>> +++ b/hw/usb/dev-audio.c
>> @@ -577,9 +577,9 @@ static const USBDesc desc_audio_multi = {
>>  
>>  struct streambuf {
>>      uint8_t *data;
>> -    uint32_t size;
>> -    uint32_t prod;
>> -    uint32_t cons;
>> +    size_t size;
>> +    uint64_t prod;
>> +    uint64_t cons;
> 
> OK.
> 
>>  };
>>  
>>  static void streambuf_init(struct streambuf *buf, uint32_t size,
>> @@ -600,12 +600,14 @@ static void streambuf_fini(struct streambuf *buf)
>>  
>>  static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
>>  {
>> -    uint32_t free = buf->size - (buf->prod - buf->cons);
>> +    uint64_t free = buf->size - (buf->prod - buf->cons);
> 
> I'd use ssize_t here.
>

Hm, I agree with the signed part, but I'm not sure about the size_t
part. Granted, there's a big problem if buf->prod - buf->cons can't be
representated on 32 bits, but still I'd rather use int64_t in this case
and prevent this potential truncation on 32-bit platforms.

>>  
>>      if (free < USBAUDIO_PACKET_SIZE(channels)) {
>>          return 0;
>>      }
>>  
>> +    /* can happen if prod overflows */
>> +    assert(buf->prod % USBAUDIO_PACKET_SIZE(channels) == 0);
>>      usb_packet_copy(p, buf->data + (buf->prod % buf->size),
>>                      USBAUDIO_PACKET_SIZE(channels));
>>      buf->prod += USBAUDIO_PACKET_SIZE(channels);
>> @@ -614,7 +616,7 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
>>  
>>  static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
>>  {
>> -    uint32_t used = buf->prod - buf->cons;
>> +    uint64_t used = buf->prod - buf->cons;
>>      uint8_t *data;
>>  
>>      if (!used) {
> 
> Eventually here:
> 
>     ssize_t used = buf->prod - buf->cons;
> 
>     if (used <= 0) {
>         return NULL;
>     }
> 

Regards,
Zoltan
