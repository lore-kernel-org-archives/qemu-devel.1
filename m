Received: from eggs.gnu.org ([2001:4830:134:3::10]:43028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH6qY-0005DI-K0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH6qX-0004Ns-QM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:40:42 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:34253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH6qV-0004IO-7A
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:40:40 -0400
Received: by mail-ot1-x32f.google.com with SMTP id e9so5856029oti.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 05:40:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <27ed2a56-987d-677b-1457-3428aca19d49@linaro.org>
References: <CAFEAcA-=Wqxp1GOtBOZpck9J-LUgDhthP5u9PQuT-2fGdz9mwQ@mail.gmail.com>
	<27ed2a56-987d-677b-1457-3428aca19d49@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 12:40:16 +0000
Message-ID: <CAFEAcA-zQQBhqm376guhMXzbXg-1d1V--5opTatUXRvbb3uUDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] a64 simd decode in handle_vec_simd_shli()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 29 October 2018 at 12:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/29/18 12:06 PM, Peter Maydell wrote:
>> I'm having difficulty figuring out where this check has come from;
>> it doesn't seem to match up with the pseudocode and in any case
>> I don't think size can ever be > 3. We calculate:
>>
>>     int size = 32 - clz32(immh) - 1;
>> where immh is a 4 bit field which we know cannot be all-zeroes.
>> So the clz32() return must be in {28,29,30,31} and the resulting
>> size is in {0,1,2,3}, so the check above can't ever fire.
>
> Correct.
>
> The check appeared with the initial commit for aa64 support, so perhaps Alex
> just trying to be defensive in his coding?
>
>> Am I missing something? As far as I can see we should simply delete
>> the can't-happen condition, which will probably satisfy coverity.
>
> Agreed.

As assert that size is in [0..3] would probably be reasonable too,
since the thing that requires it (that the immh field is 4-bit non-zero)
is something implicitly determined by the decode so it's a bit
action-at-a-distance. I'll put together a patch.

thanks
-- PMM
