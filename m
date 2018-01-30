Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egXs7-0008HQ-9P
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egXs1-00048r-BT
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:30:55 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:40731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1egXs1-00048f-6A
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:30:49 -0500
Received: by mail-it0-x22b.google.com with SMTP id 196so979715iti.5
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 07:30:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180130094140.67xjf26jcymuz2bb@sirius.home.kraxel.org>
Date: Tue, 30 Jan 2018 10:30:46 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <167881EE-F694-46C3-A15B-94B1733D2E40@gmail.com>
References: <20180130051837.8725-1-programmingkidx@gmail.com>
	<20180130094140.67xjf26jcymuz2bb@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH] hw/audio/sb16.c: Convert file to new
 logging API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


> On Jan 30, 2018, at 4:41 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>> @@ -148,15 +142,16 @@ static int irq_of_magic (int magic)
>> #if 0
>> static void log_dsp (SB16State *dsp)
>> {
>> -    ldebug ("%s:%s:%d:%s:dmasize=3D%d:freq=3D%d:const=3D%d:speaker=3D%=
d\n",
>> -            dsp->fmt_stereo ? "Stereo" : "Mono",
>> -            dsp->fmt_signed ? "Signed" : "Unsigned",
>> -            dsp->fmt_bits,
>> -            dsp->dma_auto ? "Auto" : "Single",
>> -            dsp->block_size,
>> -            dsp->freq,
>> -            dsp->time_const,
>> -            dsp->speaker);
>> +    qemu_log_mask(LOG_UNIMP, =
"%s:%s:%d:%s:dmasize=3D%d:freq=3D%d:const=3D%d:"
>> +                  "speaker=3D%d\n",
>> +                  dsp->fmt_stereo ? "Stereo" : "Mono",
>> +                  dsp->fmt_signed ? "Signed" : "Unsigned",
>> +                  dsp->fmt_bits,
>> +                  dsp->dma_auto ? "Auto" : "Single",
>> +                  dsp->block_size,
>> +                  dsp->freq,
>> +                  dsp->time_const,
>> +                  dsp->speaker);
>> }
>> #endif
>=20
> Hmm, dead code.  Any places which call log_dsp() ?

There are several places but they are all dead code. Do you want this =
removed?

>=20
>>         case 0x42:              /* FT2 sets output freq with this, go =
figure */
>> #if 0
>> -            dolog ("cmd 0x42 might not do what it think it =
should\n");
>> +            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it =
think it"
>> +                          " should\n");
>> #endif
>=20
> More dead code.

Would you like this enabled or removed?

>=20
>>         case 0xe2:
>> #ifdef DEBUG
>>             d0 =3D dsp_get_data (s);
>> -            dolog ("E2 =3D %#x\n", d0);
>> +            qemu_log_mask(LOG_UNIMP, "E2 =3D %#x\n", d0);
>> #endif
>=20
> Conditional code.  Enable this unconditionally, now that we can switch
> the logging at runtime?
>=20
>> #ifndef DEBUG_SB16_MOST
>>     if (s->mixer_nreg !=3D 0x82) {
>> -        ldebug ("mixer_read[%#x] -> %#x\n",
>> -                s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
>> +        qemu_log_mask(LOG_UNIMP, "mixer_read[%#x] -> %#x\n", =
s->mixer_nreg,
>> +                      s->mixer_regs[s->mixer_nreg]);
>>     }
>> #else
>> -    ldebug ("mixer_read[%#x] -> %#x\n",
>> -            s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
>> +    qemu_log_mask(LOG_UNIMP, "mixer_read[%#x] -> %#x\n",
>> +                  s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
>> #endif
>=20
> Same question here.

You want all of this enabled?

>=20
>> #ifdef DEBUG_SB16_MOST
>> -    dolog ("pos:%06d %d till:%d len:%d\n",
>> -           dma_pos, free, till, dma_len);
>> +    qemu_log_mask(LOG_UNIMP, "pos:%06d %d till:%d len:%d\n", =
dma_pos, free,
>> +                  till, dma_len);
>> #endif
>=20
> And here.
>=20
>> #ifdef DEBUG_SB16_MOST
>> -    ldebug ("pos %5d free %5d size %5d till % 5d copy %5d written =
%5d size %5d\n",
>> -            dma_pos, free, dma_len, s->left_till_irq, copy, written,
>> -            s->block_size);
>> +    qemu_log_mask(LOG_UNIMP, "pos %5d free %5d size %5d till % 5d =
copy %5d"
>> +                  " written %5d size %5d\n", dma_pos, free, dma_len,
>> +                  s->left_till_irq, copy, written, s->block_size);
>> #endif
>=20
> Again.
>=20
> cheers,
>  Gerd

Thank you.=20=
