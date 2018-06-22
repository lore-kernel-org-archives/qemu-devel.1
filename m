Received: from eggs.gnu.org ([2001:4830:134:3::10]:49883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWEcO-0006vt-Ij
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWEcL-0001lt-F4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:28:20 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:47937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fWEcL-0001iC-7U
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:28:17 -0400
Received: from player687.ha.ovh.net (unknown [10.109.108.22])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1944D1842D1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:28:15 +0200 (CEST)
References: <20180621223946.20738-1-clg@kaod.org>
	<20180621223946.20738-2-clg@kaod.org>
	<CACPK8XevZ-n9+M+zYmnnZPqb35SxCZjb8TB6fp17jZ+DZ1mPiw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <27a0d65e-5d67-eb24-2ee3-f13fdb53cdec@kaod.org>
Date: Fri, 22 Jun 2018 07:28:04 +0200
MIME-Version: 1.0
In-Reply-To: <CACPK8XevZ-n9+M+zYmnnZPqb35SxCZjb8TB6fp17jZ+DZ1mPiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] aspeed/scu: introduce clock frequencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>

On 06/22/2018 02:57 AM, Joel Stanley wrote:
> On 22 June 2018 at 08:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> All Aspeed SoC clocks are driven by an input source clock which can
>> have different frequencies : 24MHz or 25MHz, and also, on the Aspeed
>> AST2400 SoC, 48MHz. The H-PLL (CPU) clock is defined from a
>> calculation using parameters in the H-PLL Parameter register or from a
>> predefined set of frequencies if the setting is strapped by hardware
>> (Aspeed AST2400 SoC). The other clocks of the SoC are then defined
>> from the H-PLL using dividers.
>>
>> We introduce first the APB clock because it drives the timer.
>=20
> Looks good! One small issue below.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/misc/aspeed_scu.h |  70 ++++++++++++++++++++++++++--
>>  hw/misc/aspeed_scu.c         | 106 ++++++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 172 insertions(+), 4 deletions(-)
>>
>=20
>> +static uint32_t aspeed_scu_calc_hpll_ast2400(AspeedSCUState *s)
>> +{
>> +    uint32_t hpll_reg =3D s->regs[HPLL_PARAM];
>> +    uint8_t freq_select;
>> +    bool clk_25m_in;
>> +
>> +    if (hpll_reg & SCU_AST2400_H_PLL_OFF) {
>> +        return 0;
>> +    }
>> +
>> +    if (hpll_reg & SCU_AST2400_H_PLL_PROGRAMMED) {
>> +        uint32_t multiplier =3D 1;
>> +
>> +        if (!(hpll_reg & SCU_AST2400_H_PLL_BYPASS_EN)) {
>> +            uint32_t n  =3D (hpll_reg >> 5) & 0x3f;
>> +            uint32_t od =3D (hpll_reg >> 4) & 0x1;
>> +            uint32_t d  =3D hpll_reg & 0xf;
>> +
>> +            multiplier =3D (2 - od) * ((n + 2) / (d + 1));
>> +        }
>> +
>> +        return s->clkin * multiplier;
>> +    }
>> +
>> +    /* HW strapping */
>> +    clk_25m_in =3D (s->hw_strap1 & SCU_HW_STRAP_CLK_25M_IN);
>=20
> I think you want to do !! to this result, or shift it down. Otherwise
> you are getting 1 << 23 or zero, when I think you want 1 or 0.

yes. I will fix that.

Thanks,

C.

>> +    freq_select =3D SCU_AST2400_HW_STRAP_GET_H_PLL_CLK(s->hw_strap1);
>> +
>> +    return hpll_ast2400_freqs[clk_25m_in][freq_select] * 1000000;
>> +}
