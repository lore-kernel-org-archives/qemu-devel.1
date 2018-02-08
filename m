Received: from eggs.gnu.org ([2001:4830:134:3::10]:50617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmLd-0001rD-7V
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmLZ-0000wf-9S
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:34:45 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmLZ-0000wV-4e
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:34:41 -0500
Received: by mail-qt0-x241.google.com with SMTP id u6so5714749qtg.13
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:34:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
	<caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
	<CAFEAcA90+5RL+WPVDS00NH8WuLmG4C0Ou74v-m20+RB6zYz8WQ@mail.gmail.com>
	<91dde6c1-e282-37dd-d843-eb6b186e8bff@amsat.org>
Message-ID: <c68fa4de-fad8-a686-2f87-3de0ede8f949@amsat.org>
Date: Thu, 8 Feb 2018 10:34:33 -0300
MIME-Version: 1.0
In-Reply-To: <91dde6c1-e282-37dd-d843-eb6b186e8bff@amsat.org>
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

On 02/08/2018 10:16 AM, Philippe Mathieu-Daudé wrote:
> On 02/08/2018 10:01 AM, Peter Maydell wrote:
>> On 8 February 2018 at 12:15, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> Hi Daniel,
>>>
>>> On 02/08/2018 07:57 AM, Daniel Henrique Barboza wrote:
>>>> This patch adds a break in the switch() statement of complete(),
>>>> value 0x42:
>>>>
>>>>     case 0x42:              /* FT2 sets output freq with this, go figure */
>>>>         qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
>>>>                       " should\n");
>>>>         break; <-------
>>>>     case 0x41:
>>>
>>> It seems this is an intentional fallthrough, I understand cmd 0x42 is
>>> expected to do the same of 0x41 and _a bit more_ (see commit 85571bc7415).
>>
>> Yes, I agree; I wrote a bit about this in this thread:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02081.html
> 
> Oh, very useful link!
> 
>> (though my guess is that actually 0x42 is supposed to do exactly
>> what 0x41 does, and that the LOG_UNIMP should maybe just be removed).
> 
> I now understand 0x42 sets the dsp input sampling freq, the model seems
> to be designed with output in mind, then added input support (using same
> freq as output).

Now I see Fabrice comment "FT2 sets output freq with this, go figure"
and agree with him.

I like to think this is a bug in Fast Tracker 2, so Peter suggestion
about using LOG_GUEST_ERROR here might be clever.

> 
> So imho the simpler/safer fix would be:
> 
>   case 0x42:
>       if (dsp_get_hilo(s) != s->freq) {
>           qemu_log_mask(LOG_UNIMP,
>                         "input sampling freq different than "
>                         "output not implemented");
>       }
>       /* fallthrough */
>   case 0x41:
>       ...
> 
> and the correct fix would be split s->freq in {s->freq_in, s->freq_out}
> but nobody ever required this during at least 14 years.
> 
