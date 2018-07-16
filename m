Received: from eggs.gnu.org ([2001:4830:134:3::10]:46031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ff3Bp-0005Pq-TC
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ff3Bk-00052V-VG
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:05:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60639)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ff3Bk-000518-Ha
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:05:16 -0400
References: <BN7PR08MB4868F5BE2EBF580CE8F1C244C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<5368d20b-2b39-2fee-8851-f749f97071f8@vivier.eu>
	<BN7PR08MB4868A93EDEAA419282D376D9C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<CAFEAcA9muPW8d6QTwzyFc+364fzhy9s0J9ok1FgJEjbP1vQicQ@mail.gmail.com>
	<BN7PR08MB4868051FE8DADE7A1CA8A62AC65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <945b2112-83e6-47eb-a70f-190846b4150e@vivier.eu>
Date: Mon, 16 Jul 2018 15:04:58 +0200
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868051FE8DADE7A1CA8A62AC65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] tcg_register_jit_int() interface problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Markovic <smarkovic@wavecomp.com>

Le 16/07/2018 à 14:55, Aleksandar Markovic a écrit :
>> From: Peter Maydell <peter.maydell@linaro.org>
>> Sent: Monday, July 16, 2018 1:55 PM
>>  
>> On 16 July 2018 at 12:36, Aleksandar Markovic <amarkovic@wavecomp.com>
> wrote:
>> >> From: Laurent Vivier <laurent@vivier.eu>
>> >> Le 16/07/2018 à 13:10, Aleksandar Markovic a écrit :
>> >> > For MIPS, the situation is different: Up until recently, MIPS had
> only
>> >> > one value for e_machine: that was EM_MIPS (used for both 32-bit and
>> >> > 64-bit MIPS systems). However, new nanoMIPS systems have a new
> value in
>> >> > that field: EM_NANOMIPS (that is to be applied for both 32-bit and
>> >> > 64-bit nanoMIPS systems).
>> >> >
>> >> >
>> >> > The situation described above represent a problem for us developing
>> >> > nanoMIPS support, forcing us to have different compilations (and
>> >> > executables) for MIPS and nanoMIPS.
>> >> >
>> >> >
>> >> > Is there a possibility to refactor tcg_register_jit_int() to receive
>> >> > "e_machine" value as an argument, instead of expecting preprocessor
>> >> > constant to be set?
>> >>
>> >> I don't know this par of code, but for PPC we have:
>> >>
>> >> #if TCG_TARGET_REG_BITS == 64
>> >> # define ELF_HOST_MACHINE EM_PPC64
>> >> #else
>> >> # define ELF_HOST_MACHINE EM_PPC
>> >> #endif
>> >>
>> >> So perhaps you could have something like:
>> >>
>> >> #if defined(HOST_NANOMIPS)
>> >> # define ELF_HOST_MACHINE EM_NANOMIPS
>> >> #else
>> >> # define ELF_HOST_MACHINE EM_MIPS
>> >> #endif
>> >
>> > The problem is, this means there will be separate executables for
> QEMU for
>> > MIPS and QEMU for nanoMIPS. Would that be acceptable from overall QEMU
>> > design point of view? Peter, Richard?
>>
>> The assumption has previously been that there must be a value known
>> at compile time (because it would be the value of whatever is in the
>> ELF header for the QEMU executable itself, effectively). I'm not
>> sure why this doesn't work for MIPS still -- if you're building
>> on a host with the new nanoMIPS stuff and with that support enabled,
>> then report EM_NANOMIPS; if you're building a binary that works with
>> the older MIPS CPUs, report EM_MIPS ?
>>
>> That said, if this doesn't work for MIPS, then it would be a trivial
>> refactor to allow the tcg per-target code to do
>> #define ELF_HOST_MACHINE mips_get_elf_host_machine()
>> so you could compute the value at runtime.
>>
> 
> Thanks for hints and suggestions. I will have to revisit the code and
> find the most suitable solution.

Does this mean an EM_NANOMIPS binary can be run on an EM_MIPS machine
and vice-versa?

Thanks,
Laurent
