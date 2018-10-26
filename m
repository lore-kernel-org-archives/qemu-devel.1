Received: from eggs.gnu.org ([2001:4830:134:3::10]:41933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gG2NS-00075Q-Ld
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gG2NN-0005kv-Mc
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:42:14 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gG2NJ-0005bM-EU
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:42:07 -0400
Date: Fri, 26 Oct 2018 15:42:00 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181026134200.GA2377@sx9>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181022172343.GB2331@sx9>
	<alpine.LFD.2.21.1810221901170.19280@eddie.linux-mips.org>
	<20181023191023.GB2244@sx9>
	<alpine.LFD.2.21.1810240213290.19280@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810240213290.19280@eddie.linux-mips.org>
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Maciej,

>  I'm not sure if every single random vendor-specific instruction (or a 
> bunch of) deserves its own ASE designation, be it internal or externally 
> exposed.  I think the MMI set being a substantial architectural feature 
> makes sense to be shown in /proc/cpuinfo (in Linux), but I don't think 
> there's much more about it.  It's limited to 2 implementations only, so 
> internally I think it can well be handled with a macro or static inline 
> function (as appropriate) which boil down to (CPU_R5900 || CPU_TX79).

Are there benefits in leaving out features? Their utility, such as
in choosing compiler options, may not correlate with their (lack of)
architectural weight.

A random pc, for instance, comes fully dressed flying the flags of

	fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
	cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
	pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts
	rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni
	pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16
	xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer
	aes xsave avx lahf_lm epb kaiser tpr_shadow vnmi flexpriority
	ept vpid xsaveopt dtherm ida arat pln pts

in its /proc/cpuinfo. It also has a bugs field with

	cpu_meltdown spectre_v1 spectre_v2

where the R5900 could have an entry for its short loop bug.

>  And if you run out of bits for ASEs regardless, then I suggest just to 
> expand the field in question.  In QEMU you can rely on the presence of the 
> `uint64_t' data type, so with only 8 bits exhausted you're far from 
> getting into trouble.

DisasContext::insn_flags is already uint64_t, where bits 63..56 are
reserved for vendor-specific ASEs. Of course, one could organise them
differently, especially since they may be mutually exclusive, or one
could use a new ASE-specific field for them.

Fredrik
