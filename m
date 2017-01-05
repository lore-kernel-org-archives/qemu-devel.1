Received: from eggs.gnu.org ([2001:4830:134:3::10]:53037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cP56g-0005Bv-Ao
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cP56b-0004zO-A3
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:17:14 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:33203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cP56b-0004zA-3y
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:17:09 -0500
Received: by mail-wj0-x241.google.com with SMTP id kp2so78558420wjc.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 02:17:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <586cb5ab.f31d9d0a.38ac3.acf2@mx.google.com>
	<7a63340c-2fd8-f5ec-c39c-8958b9582752@redhat.com>
	<20170104152329-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d2b00e1-9ff6-8f7d-3733-bf99abb1ca5b@redhat.com>
Date: Thu, 5 Jan 2017 11:17:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170104152329-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] serial: fix memory leak in serial exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>



On 04/01/2017 14:24, Michael S. Tsirkin wrote:
> On Wed, Jan 04, 2017 at 12:43:35PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 04/01/2017 09:43, Li Qiang wrote:
>>> From: Li Qiang <liqiang6-s@360.cn>
>>>
>>> The serial_exit_core function doesn't free some resources.
>>> This can lead memory leak when hotplug and unplug. This
>>> patch avoid this.
>>>
>>> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
>>> ---
>>>  hw/char/serial.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/hw/char/serial.c b/hw/char/serial.c
>>> index ffbacd8..67b18ed 100644
>>> --- a/hw/char/serial.c
>>> +++ b/hw/char/serial.c
>>> @@ -906,6 +906,16 @@ void serial_realize_core(SerialState *s, Error **errp)
>>>  void serial_exit_core(SerialState *s)
>>>  {
>>>      qemu_chr_fe_deinit(&s->chr);
>>> +
>>> +    timer_del(s->modem_status_poll);
>>> +    timer_free(s->modem_status_poll);
>>> +
>>> +    timer_del(s->fifo_timeout_timer);
>>> +    timer_free(s->fifo_timeout_timer);
>>> +
>>> +    fifo8_destroy(&s->recv_fifo);
>>> +    fifo8_destroy(&s->xmit_fifo);
>>> +
>>>      qemu_unregister_reset(serial_reset, s);
>>>  }
>>>  
>>>
>>
>> Thanks, looks good.
>>
>> Paolo
> 
> 
> Paolo, so are you merging this?
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Yes, thanks.

Paolo
