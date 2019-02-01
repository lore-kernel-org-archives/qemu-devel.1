Received: from eggs.gnu.org ([209.51.188.92]:45783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpdJr-0008VH-Pe
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpdJp-0002Yg-1o
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:13:39 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpdJo-0002KY-3j
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:13:36 -0500
Received: by mail-pl1-x642.google.com with SMTP id z23so3614120plo.0
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 10:13:10 -0800 (PST)
References: <20190125225714.10234-1-richard.henderson@linaro.org>
	<20190125225714.10234-6-richard.henderson@linaro.org>
	<CAFEAcA-vftmrAfy+tx6gLYJrBPHvqRaxKYT3rodQ8prnzi0g9w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70c83e72-b5f2-5e7e-b60e-8d07caa6e356@linaro.org>
Date: Fri, 1 Feb 2019 10:13:05 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vftmrAfy+tx6gLYJrBPHvqRaxKYT3rodQ8prnzi0g9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] linux-user: Initialize aarch64 pac keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/1/19 7:11 AM, Peter Maydell wrote:
> On Fri, 25 Jan 2019 at 22:57, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Initialize the keys to a non-zero value on process start.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +static uint64_t arm_rand64(void)
>> +{
>> +    int shift = 64 - clz64(RAND_MAX);
>> +    int i, n = 64 / shift + (64 % shift != 0);
>> +    uint64_t ret = 0;
>> +
>> +    for (i = 0; i < n; i++) {
>> +        ret = (ret << shift) | rand();
>> +    }
>> +    return ret;
>> +}
> 
> I'm not a huge fan of the use of rand() here, but it's what
> we're using to initialize AT_RANDOM in linux-user, so I guess
> it's OK here. At some point we should investigate whether
> there's something better we are guaranteed to have available,
> I suppose. (Coverity gripes about use of rand().)

I considered implementing a qemu version of getentropy,
but then I saw our "-seed" option and thought perhaps
repeatability is more important for qemu.


r~
