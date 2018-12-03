Received: from eggs.gnu.org ([2001:4830:134:3::10]:58165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTx9O-0006XL-HH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTx9J-0000oI-U7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:57:14 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTx9J-0000lk-5N
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:57:09 -0500
Received: by mail-oi1-x241.google.com with SMTP id u18so12536801oie.10
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 14:57:09 -0800 (PST)
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-8-aaron@os.amperecomputing.com>
	<CAFEAcA92+6NdqpB+L42cu1Ba7qvvHoLkjSDgcEDLvR=iqpd4gg@mail.gmail.com>
	<20181203204452.GB5549@quinoa.localdomain>
	<CAFEAcA900U3amGOGRKGNu+-j9EDhdrZ1U1U5MtoW5BeTo74iOQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05205391-27bf-c6be-bc71-648eee127c47@linaro.org>
Date: Mon, 3 Dec 2018 16:57:03 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA900U3amGOGRKGNu+-j9EDhdrZ1U1U5MtoW5BeTo74iOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 07/13] target-arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 12/3/18 4:19 PM, Peter Maydell wrote:
> On Mon, 3 Dec 2018 at 20:45, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>>
>> On Nov 30 16:10, Peter Maydell wrote:
>>> PMCEID2 and PMCEID3 are only defined from ARMv8.1; before that they
>>> are UNDEFINED. So these registers need to be only defined if a
>>> suitable feature bit or ID register field check passes.
>>
>> It looks like we don't currently support any ARMv8.1+ CPUs and don't
>> have an entry in the `arm_features` enum for it. I'll plan to add
>> ARM_FEATURE_V81 and make defining these registers depend on it, assuming
>> any future CPUs supporting it will use that, unless you feel I should do
>> something different.
> 
> I think that the idea going forward is to prefer an ID
> register check of some kind -- Richard ?

Yes.  It would appear that this feature should be controlled by
ID_DFR0.PerfMon.  So,

  if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4)

once the appropriate FIELDs are added to cpu.h.

Since this test is not used within translate*.c, there is no need to move
id_dfr* into ARMISARegisters.  Since these are only aliases, they do not affect
migration, and so do not (yet) need to be filled in by kvm.


r~
