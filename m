Received: from eggs.gnu.org ([2001:4830:134:3::10]:50008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftKKh-0003ql-Fk
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftKKg-0004y5-P6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:13:31 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftKKg-0004tg-Cd
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:13:30 -0400
Received: by mail-oi0-x244.google.com with SMTP id 13-v6so17888996ois.1
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 15:13:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJg=JhJX-rP+U8rd+feUzuRsTPzJdTyA7+rmA0HyoHD2Q@mail.gmail.com>
References: <20180820023110.6583-1-jcmvbkbc@gmail.com>
	<CAFEAcA8JPnTaa_uXEMbTbBXwM+ATxBSMs5ed3PJm_R9srag_cQ@mail.gmail.com>
	<CAMo8BfJg=JhJX-rP+U8rd+feUzuRsTPzJdTyA7+rmA0HyoHD2Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 23:13:07 +0100
Message-ID: <CAFEAcA9+HUYQx-13aVAgFEDP+CfUquVcKreEOu7Mn=jscD4Nnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: convert to
 do_transaction_failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 August 2018 at 19:10, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> On Fri, Aug 24, 2018 at 10:56 AM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> On 20 August 2018 at 03:31, Max Filippov <jcmvbkbc@gmail.com> wrote:
>>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>>> ---
>>>  target/xtensa/cpu.c       |  2 +-
>>>  target/xtensa/cpu.h       |  7 ++++---
>>>  target/xtensa/op_helper.c | 12 +++++++-----
>>>  3 files changed, 12 insertions(+), 9 deletions(-)
>>
>> Hi -- thanks for doing this conversion. This change means that
>> you'll no longer get guest exceptions for bus errors that happen
>> during get_pte()'s page table entry fetch. Don't you need at
>> least a TODO comment there indicating that there's missing
>> behaviour?
>
> Thanks for taking a look and letting me know, I've missed that entirely.

Basically the new hook only handles failures for code
paths that go via the MMU; anything where the target code
does a direct physical address lookup has to handle the
failure itself. I think for xtensa that's just the page
table reads.

(This is why it's a bit of a pain to convert a target,
but the end result makes much more sense, because almost
always the target code doing physical address accesses
doesn't want to handle bus errors by randomly longjumping out.)

thanks
-- PMM
