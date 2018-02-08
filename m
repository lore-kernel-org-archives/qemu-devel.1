Received: from eggs.gnu.org ([2001:4830:134:3::10]:46299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejm4W-0007NT-MG
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejm4R-0007UP-0H
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:17:04 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejm4Q-0007UH-Qo
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:16:58 -0500
Received: by mail-qk0-x242.google.com with SMTP id x127so5507461qkb.12
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:16:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
	<caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
	<CAFEAcA90+5RL+WPVDS00NH8WuLmG4C0Ou74v-m20+RB6zYz8WQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <91dde6c1-e282-37dd-d843-eb6b186e8bff@amsat.org>
Date: Thu, 8 Feb 2018 10:16:53 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90+5RL+WPVDS00NH8WuLmG4C0Ou74v-m20+RB6zYz8WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

On 02/08/2018 10:01 AM, Peter Maydell wrote:
> On 8 February 2018 at 12:15, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Daniel,
>>
>> On 02/08/2018 07:57 AM, Daniel Henrique Barboza wrote:
>>> This patch adds a break in the switch() statement of complete(),
>>> value 0x42:
>>>
>>>     case 0x42:              /* FT2 sets output freq with this, go figure */
>>>         qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
>>>                       " should\n");
>>>         break; <-------
>>>     case 0x41:
>>
>> It seems this is an intentional fallthrough, I understand cmd 0x42 is
>> expected to do the same of 0x41 and _a bit more_ (see commit 85571bc7415).
> 
> Yes, I agree; I wrote a bit about this in this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02081.html

Oh, very useful link!

> (though my guess is that actually 0x42 is supposed to do exactly
> what 0x41 does, and that the LOG_UNIMP should maybe just be removed).

I now understand 0x42 sets the dsp input sampling freq, the model seems
to be designed with output in mind, then added input support (using same
freq as output).

So imho the simpler/safer fix would be:

  case 0x42:
      if (dsp_get_hilo(s) != s->freq) {
          qemu_log_mask(LOG_UNIMP,
                        "input sampling freq different than "
                        "output not implemented");
      }
      /* fallthrough */
  case 0x41:
      ...

and the correct fix would be split s->freq in {s->freq_in, s->freq_out}
but nobody ever required this during at least 14 years.
