Received: from eggs.gnu.org ([2001:4830:134:3::10]:45791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0Prz-0005aP-Ux
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0Prw-0006Wt-T7
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:56:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0Prw-0006Wl-Mn
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:56:20 -0400
References: <20170415192930.1443-1-bobby.prani@gmail.com>
	<CAFEAcA-JrBV6Vi21NRPk25u+NuiLG-untt7qbnqfdtd96f63TA@mail.gmail.com>
	<CAJhHMCBKQyOd8ZoDZWDV=NDu1PCx=6M8K1S0pfOr__H2TsR8sw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <507aa35d-83dc-2861-ab3f-1e185da8ca02@redhat.com>
Date: Tue, 18 Apr 2017 11:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAJhHMCBKQyOd8ZoDZWDV=NDu1PCx=6M8K1S0pfOr__H2TsR8sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] timer.h: Provide monotonic time for ARM
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>



On 17/04/2017 20:55, Pranith Kumar wrote:
>>> +/* ARM does not have a user-space readble cycle counter available.
>>> + * This is a compromise to get monotonically increasing time.
>>> + */
>>> +static inline int64_t cpu_get_host_ticks(void)
>>> +{
>>> +    return get_clock();
>>> +}
>> This doesn't look like it should be ARM-specific. Is it
>> better than the current default implementation? If so,
>> why not make this the default implementation?
>
> I think we can do that...

Yes, it is always better for emulation accuracy.  It may be much slower,
depending on your OS (especially if get_clock requires a
user->kernel->user transition), but the current code is quite broken.

Paolo

>>> +
>>>  #else
>>>  /* The host CPU doesn't have an easily accessible cycle counter.
>>>     Just return a monotonically increasing value.  This will be
>> The comment here says that our default is already a monotonically
>> increasing implementation -- is it wrong, or is there some other
>> advantage of your version?
> Comment #6 in the bug report by Laszlo Ersek explains why.
> Incrementing by 1 for approximately 55 ms is what is causing the
> divide by zero in grub.
