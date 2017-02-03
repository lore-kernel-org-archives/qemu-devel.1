Received: from eggs.gnu.org ([2001:4830:134:3::10]:39526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZc4D-0000i3-Tx
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZc49-00076j-Vc
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:30:13 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cZc49-00075F-PK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:30:09 -0500
Received: by mail-wm0-x22f.google.com with SMTP id b65so24177067wmf.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:30:09 -0800 (PST)
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-22-alex.bennee@linaro.org>
	<CAFEAcA_TviTHP-WkppW342wSHRMHX8P9wqGd1UA6bdLG6n8_oQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_TviTHP-WkppW342wSHRMHX8P9wqGd1UA6bdLG6n8_oQ@mail.gmail.com>
Date: Fri, 03 Feb 2017 11:30:12 +0000
Message-ID: <87tw8bfr5n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 21/25] target-arm: don't generate
 WFE/YIELD calls for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 1 February 2017 at 15:05, Alex Bennée <alex.bennee@linaro.org> wrote:
>> The WFE and YIELD instructions are really only hints and in TCG's case
>> they were useful to move the scheduling on from one vCPU to the next. In
>> the parallel context (MTTCG) this just causes an unnecessary cpu_exit
>> and contention of the BQL.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  target/arm/op_helper.c     |  7 +++++++
>>  target/arm/translate-a64.c |  8 ++++++--
>>  target/arm/translate.c     | 20 ++++++++++++++++----
>>  3 files changed, 29 insertions(+), 6 deletions(-)
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> though I'm not much of a fan of yet another global variable :-(

It's unfortunate but I think justified in the case. parallel_cpus is a
global state that controls the emission of barriers and generation of
atomics. It does sometime get turned off for the EXCP_ATOMIC processing
(but only in a temporary exclusive region).

>
> thanks
> -- PMM


--
Alex Bennée
