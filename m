Received: from eggs.gnu.org ([2001:4830:134:3::10]:44186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFEA1-0000H1-0O
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFE9w-0005Pf-QJ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:05:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFE9w-0005Jq-5W
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:04:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id d2-v6so4471788wro.7
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 01:04:55 -0700 (PDT)
References: <20181023203710.GA2239@sx9>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9aea2b05-24d7-f845-d899-0c6fec033672@linaro.org>
Date: Wed, 24 Oct 2018 09:04:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181023203710.GA2239@sx9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On 10/23/18 9:37 PM, Fredrik Noring wrote:
> Hi Peter, Aleksandar,
> 
>> Hi: I get compile errors on 32-bit hosts:
>>
>> /home/petmay01/qemu-for-merges/disas/mips.c:615:35: error: large
>> integer implicitly truncated to unsigned type [-Werror=overflow]
>>  #define INSN_5900                 0x100000000
>>                                    ^
>> /home/petmay01/qemu-for-merges/disas/mips.c:1200:17: note: in
>> expansion of macro 'INSN_5900'
>>  #define EE      INSN_5900    /* Emotion Engine */
>>                  ^
>> /home/petmay01/qemu-for-merges/disas/mips.c:2326:73: note: in
>> expansion of macro 'EE'
>>  {"div1",    "z,s,t",  0x7000001a, 0xfc00ffff, RD_s | RD_t | WR_HILO, 0, EE },
>>                                                                          ^
>>
>> (and repeats on other similar uses).
>>
>> This is because this line is an initializer for "struct mips_opcode",
>> and the final field is "unsigned long membership", which may be only
>> 32 bits wide, but you're trying to put a number in that's too big for that.
> 
> I am sorry about that. We are out of bits.
> 
> Option 1: Discard all disassembly parts of the series. I would prefer this
> if possible -- they are not essential now in my opinion.
> 
> Option 2: Drop all R5900 related changes for now.
> 
> Option 3: Extend the mips_opcode::membership field.

It's trivial to extend the field to uint64_t.


r~
