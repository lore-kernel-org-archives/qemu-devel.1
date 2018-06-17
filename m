Received: from eggs.gnu.org ([2001:4830:134:3::10]:36533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fUcjI-0007o3-5B
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fUcjF-0007kU-3I
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:48:48 -0400
Received: from smtp39.i.mail.ru ([94.100.177.99]:40484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fUcjE-0007hT-OF
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:48:45 -0400
References: <20180612204632.28780-1-jusual@mail.ru>
	<CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
	<826808f0-4dc4-261d-4c54-46c807bb75c9@linaro.org>
	<CAFEAcA9BVi_yzA6wPjrE62mdd21d9QtVixc1OvB9PWLN2ydq+A@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <be965630-767c-4721-6239-474f61a08e6e@mail.ru>
Date: Sun, 17 Jun 2018 21:48:34 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9BVi_yzA6wPjrE62mdd21d9QtVixc1OvB9PWLN2ydq+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>

On 17.06.2018 19:33, Peter Maydell wrote:
> On 17 June 2018 at 06:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 06/15/2018 12:55 AM, Peter Maydell wrote:
>>>> +    uint32_t armv6m_insn[] = {0xf3808000 /* msr */, 0xf3b08040 /* dsb */,
>>>> +                              0xf3b08050 /* dmb */, 0xf3b08060 /* isb */,
>>>> +                              0xf3e08000 /* mrs */, 0xf000d000 /* bl */};
>>>> +    uint32_t armv6m_mask[] = {0xffe0d000, 0xfff0d0f0, 0xfff0d0f0,
>>>> +                              0xfff0d0f0, 0xffe0d000, 0xf800d000};
>>> I think these arrays should be 'const'; we can also move them closer
>>> to their point of use, inside the scope of the if() below.
>>
>> static as well.
> 
> Mmm; commit is already in master though, will need a followup patch.

I can make it if you wish.
In addition, we can simplify following "if" by removing ARM_FEATURE_V6
since V7M and V8M define V6:

     if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
         !(arm_dc_feature(s, ARM_FEATURE_V6) &&
           arm_dc_feature(s, ARM_FEATURE_M))) {
         goto illegal_op;
     }

Like this:

     if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
         !arm_dc_feature(s, ARM_FEATURE_M)) {
         goto illegal_op;
     }

What do you think?

Best regards, Julia Suvorova.
