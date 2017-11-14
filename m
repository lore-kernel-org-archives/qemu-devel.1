Received: from eggs.gnu.org ([2001:4830:134:3::10]:40632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eEXAj-0003Nh-Is
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eEXAf-0003vb-LF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:06:21 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eEXAf-0003ud-DT
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:06:17 -0500
Received: by mail-wm0-x243.google.com with SMTP id b189so12979111wmd.5
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 01:06:17 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA95abAHYQ=FpS_n4Aqiui7uQCF=ONEPkUCXGOv-joSDtw@mail.gmail.com>
	<b4c558f5-3b8e-52f0-4b66-c40519bc0500@twiddle.net>
	<CAFEAcA9rELYend1C3SJOpgb55UQ4NKSeyBg8JDKo_JtnPjDa9w@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fa2385b4-4f3b-dd44-08ff-a09385ad5c43@twiddle.net>
Date: Tue, 14 Nov 2017 10:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9rELYend1C3SJOpgb55UQ4NKSeyBg8JDKo_JtnPjDa9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] how do we determine correct guest PC for segfaults
 in atomic helpers for linux-user mode?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>

On 11/14/2017 09:52 AM, Peter Maydell wrote:
> On 13 November 2017 at 23:31, Richard Henderson <rth@twiddle.net> wrote:
>> On 11/13/2017 08:59 PM, Peter Maydell wrote:
>>> Am I misreading my debugger entrails (entirely possible)? How is this
>>> code intended to get the right guest PC for segfaults in these helpers?
>>
>> It looks like we can't.
>>
>> We get it right for system mode, but not linux-user.
> 
> How does it work for system mode?

We have retaddr from GETPC which we pass down through tlb_fill and friends,
which means the correct pc is used for restore state.

What's different about user-mode is that we don't have tlb_fill or equivalent,
and we rely on the pc from the signal handler.  Which leads to the bogusness
that you see.

I've just about got a patch together that uses a TLS variable for retaddr.  It
is the smaller change than setjmp for soft freeze.


r~
