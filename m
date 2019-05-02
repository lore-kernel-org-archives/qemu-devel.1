Received: from eggs.gnu.org ([209.51.188.92]:60666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEen-0002bY-An
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEem-0008H3-9P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:34:01 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMEel-0008GL-59
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:34:00 -0400
References: <877eb86hcf.fsf@zen.linaroharston>
	<20190502145846.26226-1-alex.bennee@linaro.org>
	<765fa2ab-2803-1945-61ea-2e80b2da6072@vivier.eu>
	<CABoDooM+DtCbTTsoYdvAJOOKuybgKUAR1yYmckM1b=dGA10=NA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <280c5642-725a-ba94-076b-f0bb3b778dec@vivier.eu>
Date: Thu, 2 May 2019 18:33:48 +0200
MIME-Version: 1.0
In-Reply-To: <CABoDooM+DtCbTTsoYdvAJOOKuybgKUAR1yYmckM1b=dGA10=NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: avoid treading on gprof's
 SIGPROF signals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 02/05/2019 18:27, Laurent Desnogues wrote:
> On Thu, May 2, 2019 at 6:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> On 02/05/2019 16:58, Alex Bennée wrote:
>>> The guest tends to get confused when it receives signals it doesn't
>>> know about. Given the gprof magic has also set up it's own handler we
>>> would do well to avoid stomping on it as well.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  linux-user/signal.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>>> index e2c0b37173..44b2d3b35a 100644
>>> --- a/linux-user/signal.c
>>> +++ b/linux-user/signal.c
>>> @@ -508,6 +508,11 @@ void signal_init(void)
>>>      act.sa_flags = SA_SIGINFO;
>>>      act.sa_sigaction = host_signal_handler;
>>>      for(i = 1; i <= TARGET_NSIG; i++) {
>>> +#ifdef TARGET_GPROF
>>> +        if (i == SIGPROF) {
>>> +            continue;
>>> +        }
>>> +#endif
>>>          host_sig = target_to_host_signal(i);
>>>          sigaction(host_sig, NULL, &oact);
>>>          if (oact.sa_sigaction == (void *)SIG_IGN) {
>>>
>>
>> Perhaps merge this with the previous one and send a v2: it will ease
>> bisecting.
> 
> I agree it would be better, though it should be noted that the signal
> issue has existed for at least 8 years (that's when I had to add a
> specific patch in my private repository).

I can also apply the second first, and the first then...

Thanks,
Laurent
