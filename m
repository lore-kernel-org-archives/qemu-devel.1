Received: from eggs.gnu.org ([2001:4830:134:3::10]:35618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0BpA-0001OT-80
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 14:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0Bp9-0002qH-CE
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 14:56:32 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:34889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1d0Bp9-0002pk-9E
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 14:56:31 -0400
Received: by mail-yw0-x241.google.com with SMTP id k13so10701203ywk.2
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 11:56:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-JrBV6Vi21NRPk25u+NuiLG-untt7qbnqfdtd96f63TA@mail.gmail.com>
References: <20170415192930.1443-1-bobby.prani@gmail.com>
	<CAFEAcA-JrBV6Vi21NRPk25u+NuiLG-untt7qbnqfdtd96f63TA@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 17 Apr 2017 14:55:59 -0400
Message-ID: <CAJhHMCBKQyOd8ZoDZWDV=NDu1PCx=6M8K1S0pfOr__H2TsR8sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Mon, Apr 17, 2017 at 2:42 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 15 April 2017 at 20:29, Pranith Kumar <bobby.prani@gmail.com> wrote:
>> Tested and confirmed that the stretch i386 debian qcow2 image on a
>> raspberry pi 2 works.
>>
>> Fixes: LP#: 893208 <https://bugs.launchpad.net/qemu/+bug/893208/>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> ---
>>  include/qemu/timer.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
>> index e1742f2f3d..14c9558da4 100644
>> --- a/include/qemu/timer.h
>> +++ b/include/qemu/timer.h
>> @@ -1015,6 +1015,16 @@ static inline int64_t cpu_get_host_ticks(void)
>>      return cur - ofs;
>>  }
>>
>> +#elif defined(__arm__) || defined(__aarch64__)
>> +
>> +/* ARM does not have a user-space readble cycle counter available.
>> + * This is a compromise to get monotonically increasing time.
>> + */
>> +static inline int64_t cpu_get_host_ticks(void)
>> +{
>> +    return get_clock();
>> +}
>
> This doesn't look like it should be ARM-specific. Is it
> better than the current default implementation? If so,
> why not make this the default implementation?
>

I think we can do that...

>> +
>>  #else
>>  /* The host CPU doesn't have an easily accessible cycle counter.
>>     Just return a monotonically increasing value.  This will be
>
> The comment here says that our default is already a monotonically
> increasing implementation -- is it wrong, or is there some other
> advantage of your version?

Comment #6 in the bug report by Laszlo Ersek explains why.
Incrementing by 1 for approximately 55 ms is what is causing the
divide by zero in grub.

-- 
Pranith
