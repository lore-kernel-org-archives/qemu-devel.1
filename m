Received: from eggs.gnu.org ([2001:4830:134:3::10]:39832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZGoe-0004rB-Rs
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZGoe-0002RV-0f
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:48:44 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZGod-0002RB-Rh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:48:43 -0500
Received: by mail-ua0-x234.google.com with SMTP id y9so10326393uae.2
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 04:48:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87a8a44wi9.fsf@linaro.org>
References: <CAFEAcA9j47hSCHyYh5TzNh5P-V3_ddcmA=XMcini+d8PnqruZA@mail.gmail.com>
	<87bmuk4zyb.fsf@linaro.org>
	<CAFEAcA_vxpT+rErpPBmyst+g71KassD-N2755yyY8TvW6S2Y=g@mail.gmail.com>
	<87a8a44wi9.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 12:48:22 +0000
Message-ID: <CAFEAcA_NWwQGjXwEMpYBwV=CH_CcmQNhjnXunQMQYNvPFbR0Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Claudio Fontana <claudio.fontana@huawei.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 2 February 2017 at 12:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> Your longjump is effectively skipping the normal "end of the TB" code,
>> which is what usually does the set_condexec for you. At the end of a
>> TB the expectation is that everything's been sync'd back to the CPU
>> state structure.
>
> Hmm so as long as the tlb flush helpers don't set ARM_CP_SUPPRESS_TB_END
> things should just work normally?

If they're register writes, yes -- we end the TB on writes but not
on reads (on the assumption that only writes might modify state that
requires a TB end). If the TLB instructions are reads then we can
add a "force TB end" flag.

> Is shouldn't matter if the TB with the
> flush is chained to a new TB as the exit_request test should fire before
> any more state changing operations happen?

I think so, but again if you know that you're always going to exit
the TB then there's no point setting it up so it might chain.

thanks
-- PMM
