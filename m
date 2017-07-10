Received: from eggs.gnu.org ([2001:4830:134:3::10]:35526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUYDV-0005Qn-KN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUYDO-0001so-6H
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:55:05 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUYDN-0001sG-VV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:55:02 -0400
Received: by mail-wr0-x231.google.com with SMTP id r103so137836358wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 05:55:01 -0700 (PDT)
References: <20170707161822.29659-1-alex.bennee@linaro.org>
	<87inj49mr1.fsf@linaro.org>
	<CAFEAcA_YvS8OQVTPnvRtWyVuAKO2bccyNALOs1Oq7snTO1WwkA@mail.gmail.com>
	<a391e7e5-0be9-0863-bfb7-88d9168484f3@twiddle.net>
	<87h8yo9k2n.fsf@linaro.org>
	<638cda88-5bd8-2a86-d720-04005fa1c1c8@twiddle.net>
	<87tw2ka3p1.fsf@linaro.org>
	<CAFEAcA_+q-bgKwSRq-rmZ190vVEcq+DXWt-WohJm3=RoJc_99A@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_+q-bgKwSRq-rmZ190vVEcq+DXWt-WohJm3=RoJc_99A@mail.gmail.com>
Date: Mon, 10 Jul 2017 13:54:58 +0100
Message-ID: <87shi4a1ul.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: ensure eret exits the
 run-loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "Emilio G . Cota" <cota@braap.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 10 July 2017 at 13:15, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Looking at translate.c (32 bit arm), we have:
>>
>>   gen_srs
>>   gen_mrs_banked
>>   gen_msr_banked
>>
>> These all manually set:
>>
>>   gen_set_pc_im(s, s->pc - 4);
>>
>> before their respective helpers. I think setting the PC after the helper
>> is superfluous given we are will at that point be exiting the block.
>
> No, you need both. We do
>   gen_set_pc_im(s, s->pc - 4);
> before calling the helper because the helper might throw an
> exception, in which case the PC needs to point to that insn.
> We then call
>  gen_set_pc_im(dc, dc->pc);
> before exiting the block because if we leave execution by
> falling off the end of the block then the PC should point to
> the insn that comes next (ie just after the last one in the block)

OK I see now. I think I have a plan going forward.

>
> thanks
> -- PMM


--
Alex Bennée
