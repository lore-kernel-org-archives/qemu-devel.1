Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fcTMV-0006Hy-Cm
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fcTMU-0005l5-He
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:25:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fcTMU-0005kH-Aj
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:25:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id h9-v6so10398758wro.3
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 03:25:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
	<4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Jul 2018 12:25:40 +0200
Message-ID: <CAJ+F1CLjAXcdkUS2cj_6x2UnE1jTcFAfy88yDWfomp6+Mt7v+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Jun 5, 2018 at 11:18 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 05/06/2018 09:54, Sergio Lopez wrote:
>> Only retry on serial_xmit if qemu_chr_fe_write returns 0, as this is the
>> only recoverable error.
>>
>> Retrying with any other scenario, in addition to being a waste of CPU
>> cycles, can compromise the Guest stability if by the vCPU issuing the
>> write and the main loop thread are, by chance or explicit pinning,
>> running on the same pCPU.
>>
>> Previous discussion:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06998.html
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  hw/char/serial.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/char/serial.c b/hw/char/serial.c
>> index 605b0d0..6de6c29 100644
>> --- a/hw/char/serial.c
>> +++ b/hw/char/serial.c
>> @@ -260,7 +260,7 @@ static void serial_xmit(SerialState *s)
>>          if (s->mcr & UART_MCR_LOOP) {
>>              /* in loopback mode, say that we just received a char */
>>              serial_receive1(s, &s->tsr, 1);
>> -        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) !=3D 1 &&
>> +        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) =3D=3D 0 &&
>>                     s->tsr_retry < MAX_XMIT_RETRY) {
>>              assert(s->watch_tag =3D=3D 0);
>>              s->watch_tag =3D
>>
>
> Queued, thanks to you and all those who participated in the discussion.

Shouldn't it rety if it returns -1 and the errno =3D=3D EAGAIN? I am not
sure when it would return 0 and a retry would make sense.



--=20
Marc-Andr=C3=A9 Lureau
