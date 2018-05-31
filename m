Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOLQo-0004e5-3R
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOLQn-0004Ft-6d
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:07:46 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fOLQm-0004FF-Vm
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:07:45 -0400
Received: by mail-wm0-x242.google.com with SMTP id 18-v6so47734142wml.2
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 04:07:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531110321.ltm3ti6onab2w3vg@dritchie>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
	<CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
	<20180531110321.ltm3ti6onab2w3vg@dritchie>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 May 2018 13:07:43 +0200
Message-ID: <CAJ+F1CJx4mekhsK1y_AQOYy12ETdL-BqB+iA9NUfQE5STGxXiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, May 31, 2018 at 1:03 PM, Sergio Lopez <slp@redhat.com> wrote:
> On Thu, May 31, 2018 at 11:52:01AM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> On Thu, May 31, 2018 at 9:46 AM, Sergio Lopez <slp@redhat.com> wrote:
>> > If writing to the frontend channel failed with EPIPE, don't set up a
>> > retry. EPIPE is not a recoverable error, so trying again is a waste of=
 CPU
>> > cycles.
>> >
>> > If the vCPU writing to the serial device and emulator thread are pinne=
d
>> > to the same pCPU, it can also compromise the stability of the Guest OS=
,
>> > as both threads will be competing for pCPU's time, with the vCPU
>> > actively polling the serial device and barely giving time to the
>> > emulator thread to make actual progress.
>> > ---
>> >  hw/char/serial.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/hw/char/serial.c b/hw/char/serial.c
>> > index 2c080c9..f26e86b 100644
>> > --- a/hw/char/serial.c
>> > +++ b/hw/char/serial.c
>> > @@ -262,6 +262,7 @@ static void serial_xmit(SerialState *s)
>> >              /* in loopback mode, say that we just received a char */
>> >              serial_receive1(s, &s->tsr, 1);
>> >          } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) !=3D 1 &&
>> > +                   errno !=3D EPIPE &&
>> >                     s->tsr_retry < MAX_XMIT_RETRY) {
>>
>> Instead of adding explicit handling of EPIPE, shouldn't the code be
>> rewritten to treat -1 return && errno !=3D EAGAIN as fatal?
>
> What kind of action should it trigger if treating errno !=3D EAGAIN as fa=
tal?

"fatal" was perhaps the wrong word. I mean that we don't go into the
retry loop and treat the chardev as disconnected (without explicit
handling of EPIPE).

>
> If you meant something like calling 'abort()', I think that, while this
> could be considered as the "correct" behavior, it's a bit unpractical
> for the users. The most common situation for this to happen is
> restarting virtlogd while having the console/serial redirected to it.
> The VM will stop writing to the serial device, but otherwise the Guest
> OS can probably keep working without any issues.
>
> Sergio.



--=20
Marc-Andr=C3=A9 Lureau
