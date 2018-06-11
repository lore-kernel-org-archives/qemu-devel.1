Received: from eggs.gnu.org ([2001:4830:134:3::10]:45441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSOp3-0006sB-2y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSOp2-0007zI-42
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:33:33 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSOp1-0007z5-Uy
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:33:32 -0400
Received: by mail-ot0-x243.google.com with SMTP id w13-v6so24249913ote.11
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 08:33:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611172644.5eeef770@redhat.com>
References: <20180601160355.15393-1-peter.maydell@linaro.org>
	<20180611172644.5eeef770@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 16:33:10 +0100
Message-ID: <CAFEAcA8XC08joMpMgrBD99DSJLW=ri-8gtUpqM9jtFZLHnoxAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm: Don't crash if user tries to use a
 Cortex-M CPU without an NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 11 June 2018 at 16:26, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri,  1 Jun 2018 17:03:55 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> The Cortex-M CPU and its NVIC are two intimately intertwined parts of
>> the same hardware; it is not possible to use one without the other.
>> Unfortunately a lot of our board models don't do any sanity checking
>> on the CPU type the user asks for, so a command line like
>>     qemu-system-arm -M versatilepb -cpu cortex-m3
>> will create an M3 without an NVIC, and coredump immediately.
>> In the other direction, trying a non-M-profile CPU in an M-profile
>> board won't blow up, but doesn't do anything useful either:
>>     qemu-system-arm -M lm3s6965evb -cpu arm926

>> +#ifndef CONFIG_USER_ONLY
>> +    /* The NVIC and M-profile CPU are two halves of a single piece of
>> +     * hardware; trying to use one without the other is a command line
>> +     * error and will result in segfaults if not caught here.
>> +     */
>> +    if (arm_feature(env, ARM_FEATURE_M)) {
>> +        if (!env->nvic) {
>> +            error_setg(errp, "This board cannot be used with Cortex-M CPUs");
> mentioning board in CPU's realize seems a little bit strange,
> maybe something similar to following would be better:
>
>   "Cortex-M CPUs require device_foo for working"

I think the text as I have it is of more practical use to the
user, who is clearly not going to be very familiar with how
M-profile systems work if they've run into this error message.
"requires an NVIC" doesn't tell them what's actually wrong;
"this board doesn't work with this CPU" gives them a fighting
chance of understanding that they've given two incompatible
command line options.

thanks
-- PMM
