Received: from eggs.gnu.org ([2001:4830:134:3::10]:38894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDWQG-000110-BD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDWQA-0006La-W9
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:10:44 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:45932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDWQA-0006JN-N5
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:10:38 -0400
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-18-kbastian@mail.uni-paderborn.de>
	<2826c8b3-fcaf-d646-1153-801cc93eebc8@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <5bae16da-c534-b812-5810-f4a475f9c86b@mail.uni-paderborn.de>
Date: Fri, 19 Oct 2018 17:10:36 +0200
MIME-Version: 1.0
In-Reply-To: <2826c8b3-fcaf-d646-1153-801cc93eebc8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 17/28] target/riscv: Convert quadrant 2 of
 RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org


On 10/13/18 9:34 PM, Richard Henderson wrote:
> On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>> +@c_flwsp_ldsp   ... .  ..... ..... .. &c_flwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
>> +    uimm_ldsp=%uimm_6bit_ld %rd
>> +@c_fswsp_sdsp   ... .  ..... ..... .. &c_fswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
>> +    uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
> I'm not especially keen about decoding the same bits twice.
>
> I wonder if it's better to call the proper extract_foo function
> within the trans_ function like you do elsewhere.  Written as
>
> c_flwsp_ldsp	011 -  ----- ----- 10


Hmm, Do you mean split the formats up into:

@c_fswsp ... . ..... ..... .. &fswsp_sdsp uimm=%uimm_6bit_sw

and

@c_sdsp ... . ..... ..... .. &fswsp_sdsp uimm=%uimm_6bit_sd rs2=%rs2_5


And then call extract_c_sdsp and extract_c_fswsp in each of the 
TARGET_RVX cases. However then we end up with unused functions in either 
TARGET_RV32 and TARGET_RV64.

I don't think its worth it to go through all that trouble for a small 
optimization.


Cheers,

Bastian
