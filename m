Received: from eggs.gnu.org ([2001:4830:134:3::10]:38700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAZsp-0000BD-E8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAZsk-0005W6-CH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:16:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAZsj-0005SU-89
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:15:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so8710526wmf.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:15:56 -0700 (PDT)
References: <20181011112436.9305-1-ppandit@redhat.com>
	<a5508166-efdc-d1d9-0fe1-9acb1f590633@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c688482-fccc-ee8c-b871-ee3a7c42ecf4@redhat.com>
Date: Thu, 11 Oct 2018 14:15:48 +0200
MIME-Version: 1.0
In-Reply-To: <a5508166-efdc-d1d9-0fe1-9acb1f590633@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ccid-card-passthru: check buffer size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Arash TC <tohidi.arash@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Gerd Hoffmann <kraxel@redhat.com>

On 11/10/2018 13:58, Philippe Mathieu-Daudé wrote:
> Cc'ing Paolo & Marc-André.
> 
> On 11/10/2018 13:24, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While reading virtual smart card data, if buffer 'size' is negative
>> it would lead to memory corruption errors. Add check to avoid it.
> 
> The IOReadHandler does not have documentation.
> 
>  typedef void IOReadHandler(void *opaque, const uint8_t *buf, int size);
> 
> Why is the 'size' argument signed? Does it makes sens to call it with a
> negative value?

Yeah, it probably should be changed to size_t (same for the return value
of can_read callbacks); the size cannot be negative, in fact it can also
never be zero.

Also, the "if" should never trigger because the size is bound to what
can_read returns, which is VSCARD_IN_SIZE - card->vscard_in_pos.

So it is probably better to:

1) move the

    assert(card->vscard_in_pos < VSCARD_IN_SIZE);

to can_read, which becomes

    assert(card->vscard_in_pos <= VSCARD_IN_SIZE);
    return VSCARD_IN_SIZE - card->vscard_in_pos;

2) here, replace the if with an

    assert(size <= VSCARD_IN_SIZE - card->vscard_in_pos);

Note that the right side of the comparison is the return value of
can_read.  Also, this assert will always fail if card->vscard_in_pos >=
VSCARD_IN_SIZE), since size > 0.

3) also here, replace the

    assert(card->vscard_in_hdr < VSCARD_IN_SIZE);

with the stricter and more correct

    assert(card->vscard_in_hdr < card->vscard_in_pos);


Related, I don't understand why the read function ends with

    if (card->vscard_in_hdr == card->vscard_in_pos) {
        card->vscard_in_pos = card->vscard_in_hdr = 0;
    }

I would have expected something more generic, like:

    /* Drop any messages that were fully processed.  */
    if (card->vscard_in_hdr > 0) {
        memmove(card->vscard_in_data,
                card->vscard_in_data + card->vscard_in_hdr,
                card->vscard_in_pos - card->vscard_in_hdr);
        card->vscard_in_pos -= card->vscard_in_hdr;
        card->vscard_in_hdr = 0;
    }

Marc-André, do you know something about libcacard that justifies the
latter?  If the error_report is changed to an assert it's probably a
good idea anyway to make the code more liberal in what it accepts.
Prasad, can you prepare a v2 that does these changes?

Thanks,

Paolo

> 
> Thanks,
> 
> Phil.
> 
>>
>> Reported-by: Arash TC <tohidi.arash@gmail.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/usb/ccid-card-passthru.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
>> index 0a6c657228..63ed78f4c6 100644
>> --- a/hw/usb/ccid-card-passthru.c
>> +++ b/hw/usb/ccid-card-passthru.c
>> @@ -275,6 +275,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
>>      PassthruState *card = opaque;
>>      VSCMsgHeader *hdr;
>>  
>> +    assert(0 <= size && size < VSCARD_IN_SIZE);
>>      if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
>>          error_report("no room for data: pos %u +  size %d > %" PRId64 "."
>>                       " dropping connection.",
>>
> 
