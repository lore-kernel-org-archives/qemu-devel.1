Received: from eggs.gnu.org ([209.51.188.92]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Aiv-0004DZ-Ey
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Aip-0004mG-Nq
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:07:13 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1Aip-0004lK-E0
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:07:07 -0500
Received: by mail-wr1-f51.google.com with SMTP id i16so9579478wrs.13
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 06:07:07 -0800 (PST)
References: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1551733750-4902-3-git-send-email-aleksandar.markovic@rt-rk.com>
	<8acd73e1-219f-b5f7-e001-6f6dd086171d@redhat.com>
	<BN6PR2201MB12512A365C6D47928700801CC6720@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <96d80f22-8f7b-950a-283d-2c814827cd82@redhat.com>
Date: Tue, 5 Mar 2019 15:07:04 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12512A365C6D47928700801CC6720@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 02/14] disas: nanoMIPS: Add graphical
 description of pool organization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

On 3/5/19 1:39 PM, Aleksandar Markovic wrote:
>> From: Philippe Mathieu-Daud¨¦ <philmd@redhat.com>
>> Subject: Re: [Qemu-devel] [PATCH v7 02/14] disas: nanoMIPS: Add graphical description of > pool organization
>>
>> On 3/4/19 10:08 PM, Aleksandar Markovic wrote:
>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> Add graphical description of nanoMIPS instruction pool organization.
>>>
>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>  disas/nanomips.cpp | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 102 insertions(+)
>>>
>>> diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
>>> index 10f6d96..9b44208 100644
>>> --- a/disas/nanomips.cpp
>>> +++ b/disas/nanomips.cpp
>>> @@ -16592,6 +16592,108 @@ std::string NMD::YIELD(uint64 instruction)
>>>
>>>
>>>
>>> +/*
>>> + *                nanoMIPS instruction pool organization
>>> + *                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> + *
>>> + *
>>> + *                 ©°©¤ P.ADDIU ©¤©¤©¤ P.RI ©¤©¤©¤ P.SYSCALL
>>> + *                 ©¦
>>> + *                 ©¦                                      ©°©¤ P.TRAP
>>> + *                 ©¦                                      ©¦
>>> + *                 ©¦                      ©°©¤ _POOL32A0_0 ©¤©à©¤ P.CMOVE
>>> + *                 ©¦                      ©¦               ©¦
>>> + *                 ©¦                      ©¦               ©¸©¤ P.SLTU
>>> + *                 ©¦        ©°©¤ _POOL32A0 ©¤©È
>>> + *                 ©¦        ©¦             ©¦
>>> + *                 ©¦        ©¦             ©¦
>>> + *                 ©¦        ©¦             ©¸©¤ _POOL32A0_1 ©¤©¤©¤ CRC32
>>> + *                 ©¦        ©¦
>>> + *                 ©À©¤ P32A ©¤©È
>>> + *                 ©¦        ©¦                           ©°©¤ PP.LSX
>>> + *                 ©¦        ©¦             ©°©¤ P.LSX ©¤©¤©¤©¤©¤©È
>>> + *                 ©¦        ©¦             ©¦             ©¸©¤ PP.LSXS
>>> + *                 ©¦        ©¸©¤ _POOL32A7 ©¤©È
>>> + *                 ©¦                      ©¦             ©°©¤ POOL32Axf_4
>>> + *                 ©¦                      ©¸©¤ POOL32Axf ©¤©È
>>> + *                 ©¦                                    ©¸©¤ POOL32Axf_5
>>> + *                 ©¦
>>> + *                 ©À©¤ PBAL
>>> + *                 ©¦
>>> + *                 ©À©¤ P.GP.W   ©°©¤ PP.LSX
>>> + *         ©°©¤ P32 ©¤©È           ©¦
>>> + *         ©¦       ©À©¤ P.GP.BH ©¤©Ø©¤ PP.LSXS
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P.J ©¤©¤©¤©¤©¤©¤©¤ PP.BALRSC
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P48I
>>> + *         ©¦       ©¦           ©°©¤ P.SR
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©¦           ©À©¤ P.SHIFT
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©À©¤ P.U12 ©¤©¤©¤©à©¤ P.ROTX
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©¦           ©À©¤ P.INS
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©¦           ©¸©¤ P.EXT
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P.LS.U12 ©¤©¤ P.PREF.U12
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P.BR1 ©¤©¤©¤©¤©¤ P.BR3A
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©¦           ©°©¤ P.LS.S0 ©¤©¤©¤ P16.SYSCALL
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©¦           ©¦           ©°©¤ P.LL
>>> + *         ©¦       ©¦           ©À©¤ P.LS.S1 ©¤©È
>>> + *         ©¦       ©¦           ©¦           ©¸©¤ P.SC
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©¦           ©¦           ©°©¤ P.PREFE
>>> + *  MAJOR ©¤©È       ©À©¤ P.LS.S9 ©¤©È           ©¦
>>> + *         ©¦       ©¦           ©À©¤ P.LS.E0 ©¤©à©¤ P.LLE
>>> + *         ©¦       ©¦           ©¦           ©¦
>>> + *         ©¦       ©¦           ©¦           ©¸©¤ P.SCE
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©¦           ©À©¤ P.LS.WM
>>> + *         ©¦       ©¦           ©¦
>>> + *         ©¦       ©¦           ©¸©¤ P.LS.UAWM
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P.BR2
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P.BRI
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©¸©¤ P.LUI
>>> + *         ©¦
>>> + *         ©¦
>>> + *         ©¦       ©°©¤ P16.MV ©¤©¤©¤©¤ P16.RI ©¤©¤©¤ P16.SYSCALL
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P16.SR
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P16.SHIFT
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P16.4x4
>>> + *         ©¦       ©¦
>>> + *         ©¦       ©À©¤ P16C ©¤©¤©¤©¤©¤©¤ POOL16C_0 ©¤©¤ POOL16C_00
>>> + *         ©¦       ©¦
>>> + *         ©¸©¤ P16 ©¤©à©¤ P16.LB
>>> + *                 ©¦
>>> + *                 ©À©¤ P16.A1
>>> + *                 ©¦
>>> + *                 ©À©¤ P16.LH
>>> + *                 ©¦
>>> + *                 ©À©¤ P16.A2 ©¤©¤©¤©¤ P.ADDIU[RS5]
>>> + *                 ©¦
>>> + *                 ©À©¤ P16.ADDU
>>> + *                 ©¦
>>> + *                 ©¸©¤ P16.BR ©¤©¤©Ð©¤ P16.JRC
>>> + *                             ©¦
>>> + *                             ©¸©¤ P16.BR1
>>
>> Nice ASCII tree! And you got it fits the 80 chars per line limit =)
>>
> 
> Too bad we don't have a mark "Enjoyed-by:" ;).

There is an "Inspired-by:" although!

> Yes, it does fit 80 characters limit. It was created manually. I stumbled
> upon https://pythonhosted.org/asciitree/#ascii-trees the other day, but
> never used it, you may find it useful.

I'm tempted add it to the decodetree script...

> By the way, there is a serious science on creating such trees in the most
> compact or balanced way. See, for example, Reingold-Tilford algorithm
> ("Tidier Drawings of Trees", 1981).

Is this how nanoMIPS came with a rebalanced ISA?

Regards,

Phil.
