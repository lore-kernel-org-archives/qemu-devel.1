Received: from eggs.gnu.org ([2001:4830:134:3::10]:47271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZHOI-0006Hw-3l
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZHOF-0001il-1w
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:25:34 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:33720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cZHOE-0001iI-Rd
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:25:30 -0500
Received: by mail-wm0-x230.google.com with SMTP id t18so5279152wmt.0
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 05:25:30 -0800 (PST)
References: <CAFEAcA9j47hSCHyYh5TzNh5P-V3_ddcmA=XMcini+d8PnqruZA@mail.gmail.com>
	<87bmuk4zyb.fsf@linaro.org>
	<CAFEAcA_vxpT+rErpPBmyst+g71KassD-N2755yyY8TvW6S2Y=g@mail.gmail.com>
	<87a8a44wi9.fsf@linaro.org>
	<CAFEAcA_NWwQGjXwEMpYBwV=CH_CcmQNhjnXunQMQYNvPFbR0Tg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_NWwQGjXwEMpYBwV=CH_CcmQNhjnXunQMQYNvPFbR0Tg@mail.gmail.com>
Date: Thu, 02 Feb 2017 13:25:32 +0000
Message-ID: <878tpo4tdf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 23/25] target-arm: introduce
 ARM_CP_EXIT_PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Claudio Fontana <claudio.fontana@huawei.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 2 February 2017 at 12:17, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> Your longjump is effectively skipping the normal "end of the TB" code,
>>> which is what usually does the set_condexec for you. At the end of a
>>> TB the expectation is that everything's been sync'd back to the CPU
>>> state structure.
>>
>> Hmm so as long as the tlb flush helpers don't set ARM_CP_SUPPRESS_TB_END
>> things should just work normally?
>
> If they're register writes, yes -- we end the TB on writes but not
> on reads (on the assumption that only writes might modify state that
> requires a TB end). If the TLB instructions are reads then we can
> add a "force TB end" flag.
>
>> Is shouldn't matter if the TB with the
>> flush is chained to a new TB as the exit_request test should fire before
>> any more state changing operations happen?
>
> I think so, but again if you know that you're always going to exit
> the TB then there's no point setting it up so it might chain.

So setting s->is_jmp = DISAS_JUMP ensures that?

--
Alex Bennée
