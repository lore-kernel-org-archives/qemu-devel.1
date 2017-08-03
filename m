Received: from eggs.gnu.org ([2001:4830:134:3::10]:50658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddK6b-0001r8-En
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddK6Y-0008MH-OP
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:40:17 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddK6Y-0008Lw-K4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:40:14 -0400
Received: by mail-qk0-x241.google.com with SMTP id q66so1955503qki.1
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 10:40:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-7-f4bug@amsat.org>
	<9a40c690-0b80-cd34-6129-849703b452e2@amsat.org>
	<87a83reidf.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <748298c3-8616-05b7-d4f0-1287c625739a@amsat.org>
Date: Thu, 3 Aug 2017 14:40:10 -0300
MIME-Version: 1.0
In-Reply-To: <87a83reidf.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] tcg/tci: disable MTTCG if TCI is
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, Jaroslaw Pelczar <j.pelczar@samsung.com>

On 07/26/2017 05:02 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Hi Peter,
>>
>> I think this patch belongs to 2.10, as there is no time to fix TCI +
>> MTTCG. Should I RESEND it alone with "for 2.10" subject?
>>
>> One other option might be disable TCI if MTTCG enabled, but there is
>> no ./configure option for MTTCG while there is for TCI.
>>
>> Regards,
>>
>> Phil.
>>
>> On 06/28/2017 10:02 PM, Philippe Mathieu-Daudé wrote:
>>> TCI + MTTCG cause strange errors...
>>>
>>>     $ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
>>>     qemu-system-arm: Guest expects a stronger memory ordering than the host provides
>>>     This may cause strange/hard to debug errors
>>>     Segmentation fault (core dumped)
> 
> So this isn't TCI enabling MTTCG by accident - this is the user forcing
> it when it wouldn't otherwise be enabled. Hence the scary warning...

Hmmm this is the user enabling TCI, I'm not sure about "forcing it".
Now MTTCG is enforced by the ./configure and there is no option to 
disable it.

I posted this patch after realizing there are more TCI users/testers 
than just Stefan Weil, Jaroslaw Pelczar and me. Peter commented about 
http://qira.me/ which doesn't look very active.
(see this thread: 
http://lists.nongnu.org/archive/html/qemu-devel/2017-06/threads.html#06528 )

Thinking about eventual downstream project using the TCI part of QEMU 
and trying to stay up-to-date with upstream, this patch might save 
headaches.

Since there is no formal yes/no to this patch I'm still wondering if I 
should track it or no.

Regards,

Phil.

>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>    configure | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index c571ad14e5..510f443e06 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -6225,7 +6225,11 @@ fi
>>>    if test "$target_softmmu" = "yes" ; then
>>>      echo "CONFIG_SOFTMMU=y" >> $config_target_mak
>>>      if test "$mttcg" = "yes" ; then
>>> -    echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
>>> +    if test "$tcg_interpreter" = "yes" ; then
>>> +        echo "TCI enabled, disabling MTTCG"
>>> +    else
>>> +        echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
>>> +    fi
>>>      fi
>>>    fi
>>>    if test "$target_user_only" = "yes" ; then
>>>
> 
> 
> --
> Alex Bennée
> 
