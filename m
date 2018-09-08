Received: from eggs.gnu.org ([2001:4830:134:3::10]:42741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fyRZK-0006Ah-NP
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 20:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fyRZJ-0000oU-GJ
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 20:57:46 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fyRZF-0000V2-Qv
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 20:57:45 -0400
Received: by mail-oi0-x241.google.com with SMTP id l202-v6so30461143oig.7
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 17:57:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lg8dz809.fsf@linaro.org>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<87lg8dz809.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Sep 2018 01:57:19 +0100
Message-ID: <CAFEAcA-iTfGnjc+0ndTMxZ=RYRCK3_RRmE1RCNgDnTVL_brrXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation
 prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, maria.klimushenkova@ispras.ru, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>

On 7 September 2018 at 15:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
>
>> The following series implements dynamic binary instrumentation upon
>> QEMU.
>
> OK I've done a pass through the patches, final comments bellow.
>
> <snip>
>>
>> For the current patches the plugins should provide the following
>> callbacks:
>>  - "needs" callback to check whether the specific instruction
>>    should be instrumented by this plugin
>>  - "run" callback which called before executing the instuction
>
> I think with a little re-jigging we could reduce this to a single run
> call which can then decide if it is going to deal with things in this
> case.
>
>> Our instrumentation subsystem exploits TCG helper mechanism to embed
>> callbacks into the translation blocks. These callbacks may be inserted
>> before the specific instructions.
>>
>> The aim of submission of this series at that early stage is to get
>> the feedback which will guide the development process. We are faced
>> the following questions:
>>  1. Does every plugins should have its own callback embedded into the TB
>>     (which will cause TB extra growth in case of multiple plugins),
>>     or the instrumentation layer's callback should invoke the plugins
>>     that wanted to instrument that specific instruction?
>
> The common case is having one plugin and I'd rather give the flexibility
> of what helper to call and how much information to give it to the plugin
> and deal with the potential to have multiple helper calls per
> instruction for the complex cases.
>
> Now I can see arguments against it from an interface complexity point of
> view but I think plugins should get access to the TCG functions so they
> can generate their own op sequences if need be and not have to call a
> helper at all if they don't need to.

I strongly disagree -- plugins should not have access to details
of QEMU internals that might change from version to version, and
definitely not access to generating their own TCG code.

thanks
-- PMM
