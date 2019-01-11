Received: from eggs.gnu.org ([209.51.188.92]:58150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghwLy-0000hD-BR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghwLw-0003oO-O6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:56:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghwLw-0003nM-I3
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:56:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so1961642wmh.0
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 04:55:58 -0800 (PST)
References: <20181207204107.GH7395@habkost.net>
	<20181209222738.GA9292@flamenco> <20181210163601.GA4669@habkost.net>
	<20181210170720.GA21344@flamenco> <20181210173427.GG4669@habkost.net>
	<20181210190942.GL4669@habkost.net> <20190110205859.GL4500@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f504e634-a67f-0789-b691-e874d500a9cf@redhat.com>
Date: Fri, 11 Jan 2019 13:55:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190110205859.GL4500@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Help needed: test-qht-par hangs on Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Greg Kurz <groug@kaod.org>

On 10/01/19 21:58, Eduardo Habkost wrote:
> On Mon, Dec 10, 2018 at 05:09:42PM -0200, Eduardo Habkost wrote:
>> On Mon, Dec 10, 2018 at 03:34:27PM -0200, Eduardo Habkost wrote:
>>> On Mon, Dec 10, 2018 at 12:07:20PM -0500, Emilio G. Cota wrote:
>>>> On Mon, Dec 10, 2018 at 14:36:01 -0200, Eduardo Habkost wrote:
>>>>> On Sun, Dec 09, 2018 at 05:27:38PM -0500, Emilio G. Cota wrote:
>>>>>> Can you try re-running the test, after applying the appended patch?
>>>>>> (It disables the "resize" thread.)
>>>>>
>>>>> It is running right now, here:
>>>>> https://travis-ci.org/ehabkost/qemu-hacks/jobs/466074591
>>>>>
>>>>>>
>>>>>> Also, does it reliably hang on Travis, or are these hangs
>>>>>> intermittent?
>>>>>
>>>>> It can be reproduced reliably.  qemu.git builds are failing since
>>>>> Thursday:
>>>>> https://travis-ci.org/qemu/qemu/builds
>>>>
>>>> I see the build you launched timed out. Can you try the following
>>>> patch (after discarding the previous one)? Let's see if just by
>>>> disabling the second test we can get the build to move ahead.
>>>
>>> I will try it.  I'm not sure yet if it's the first or the second
>>> test case timing out.  Maybe the "OK\n" we see in the log file is
>>> from another process running in parallel.
>>
>> Yeah, I think the first test case is the one hanging:
>>
>> https://travis-ci.org/ehabkost/qemu-hacks/jobs/466074591#L7741
> 
> Finally found out what's happening:
> 
> https://travis-ci.org/ehabkost/qemu-hacks/builds/478025908
> 
> sleep(1) is being interrupted before 1 second has elapsed, and
> never exits the loop:
> 
>     do {
>         remaining = sleep(duration);
>     } while (remaining);
> 

Great, then the solution is simply to switch to g_usleep!

Paolo
