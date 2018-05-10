Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmil-00075e-CF
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmik-0000Zf-HH
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:39:03 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGmik-0000ZO-D4
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:39:02 -0400
Received: by mail-oi0-x243.google.com with SMTP id e80-v6so1938384oig.11
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:39:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4525d99-e8cd-e56b-e23e-d486cb9f57ef@twiddle.net>
References: <20180510143618.23673-1-peter.maydell@linaro.org>
	<d4525d99-e8cd-e56b-e23e-d486cb9f57ef@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 15:38:41 +0100
Message-ID: <CAFEAcA8V_Zb3kHThShPQshC4=wt2Oof=VoVU35C0-TyusGzC_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] atomic.h: Work around gcc spurious "unused
 value" warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 10 May 2018 at 15:37, Richard Henderson <rth@twiddle.net> wrote:
> On 05/10/2018 07:36 AM, Peter Maydell wrote:
>> Some versions of gcc produce a spurious warning if the result of
>> __atomic_compare_echange_n() is not used and the type involved
>> is a signed 8 bit value:
>>   error: value computed is not used [-Werror=unused-value]
>> This has been seen on at least
>>  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>>
>> Work around this by using an explicit cast to void to indicate
>> that we don't care about the return value.
>>
>> We don't currently use our atomic_cmpxchg() macro on any signed
>> 8 bit types, but the upcoming support for the Arm v8.1-Atomics
>> will require it.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Sending out my workaround as an actual patch. If this is OK I'll
>> put in via target-arm.next as it's a dependency for the v8.1-atomics
>> series.
>>
>>  include/qemu/atomic.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks. Do we care about trying to follow up on the gcc side
to find out if this is a definitely-fixed bug?

-- PMM
