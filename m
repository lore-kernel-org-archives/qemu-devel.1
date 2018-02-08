Received: from eggs.gnu.org ([2001:4830:134:3::10]:54804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejmbr-0001yd-8i
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejmbq-0004Dx-IM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:51:31 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:45284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejmbq-0004Dn-De
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:51:30 -0500
Received: by mail-oi0-x235.google.com with SMTP id c189so3498439oib.12
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:51:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c68fa4de-fad8-a686-2f87-3de0ede8f949@amsat.org>
References: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
	<caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
	<CAFEAcA90+5RL+WPVDS00NH8WuLmG4C0Ou74v-m20+RB6zYz8WQ@mail.gmail.com>
	<91dde6c1-e282-37dd-d843-eb6b186e8bff@amsat.org>
	<c68fa4de-fad8-a686-2f87-3de0ede8f949@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 13:51:09 +0000
Message-ID: <CAFEAcA9v6Jwdk0X9qpYAmHfOq-cK_W7rSg+zdNu=-_BTfaDTaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/audio/sb16.c: missing break
 statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

On 8 February 2018 at 13:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Now I see Fabrice comment "FT2 sets output freq with this, go figure"
> and agree with him.
>
> I like to think this is a bug in Fast Tracker 2, so Peter suggestion
> about using LOG_GUEST_ERROR here might be clever.
>
>>
>> So imho the simpler/safer fix would be:
>>
>>   case 0x42:
>>       if (dsp_get_hilo(s) !=3D s->freq) {
>>           qemu_log_mask(LOG_UNIMP,
>>                         "input sampling freq different than "
>>                         "output not implemented");
>>       }
>>       /* fallthrough */
>>   case 0x41:
>>       ...

Wouldn't this falsely report a warning for guest code that really
is trying to set the input sampling frequency and doesn't care
about output?

>> and the correct fix would be split s->freq in {s->freq_in, s->freq_out}

...but that would differ from the hardware implementation, which
(apparently) uses a single frequency for both.

thanks
-- PMM
