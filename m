Received: from eggs.gnu.org ([209.51.188.92]:37427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0AVg-00025Q-TU
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0AVg-0000di-4O
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:41:24 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0AVf-0000dI-TC
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:41:24 -0500
Received: by mail-wr1-f41.google.com with SMTP id i16so1288244wrs.13
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 11:41:23 -0800 (PST)
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
	<fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
	<CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <63b980a2-6b28-d5e2-891c-6245ddb1e851@redhat.com>
Date: Sat, 2 Mar 2019 20:41:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Damien Hedde <damien.hedde@greensocs.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Damien,

On 3/1/19 5:52 PM, Peter Maydell wrote:
> On Fri, 1 Mar 2019 at 15:34, Damien Hedde <damien.hedde@greensocs.com> wrote:
>> On 3/1/19 12:43 PM, Peter Maydell wrote:
>>> In my design the only thing that I thought would happen in phase 3
>>> was the "clear the resetting flag", but you've moved that to RELEASE.
>>> What's left ? Do you have a concrete example where we'd need this?
>>
>> I hesitated to remove this phase (would be easy to add it after if it is
>> really needed). I see 2 cases where it might be useful.

If I RELEASE a PLL which need some time to warm up and stabilize, once
stabilized it moves the device to the POST phase where it is ready?

>>
>> To stay in my use case for clocks, here how it can be used: For an uart,
>> during release phase, the clock will propagate and only after every
>> release phases has been executed we will have the final/valid input
>> frequency.
>> So we can either recompute the uart baudrate every time the clock change
>> due to propagation or wait till post phase to do it once for all (and
>> initialize the backend parameters). But it is probably no big deal for
>> this case if we don't have post phase.
> 
> I think I'd rather have the model be simpler rather than
> complicate it for the sake of optimisation. It's not like
> we reset very frequently...
