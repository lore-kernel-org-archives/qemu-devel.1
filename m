Received: from eggs.gnu.org ([2001:4830:134:3::10]:48224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdyCl-0006OQ-I3
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdyCk-0001EB-OW
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:33:51 -0400
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-17-luc.michel@greensocs.com>
	<CAFEAcA_fFsqwr316OLcZVwBs72ESLob1AKDZN24JfFo78zQ=AQ@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <f32095a2-72b7-662d-ee58-670c2b322218@greensocs.com>
Date: Fri, 13 Jul 2018 15:33:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fFsqwr316OLcZVwBs72ESLob1AKDZN24JfFo78zQ=AQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jNatGSrGE5zBqU40d5GY8YLanGzNDm563"
Subject: Re: [Qemu-devel] [PATCH v3 16/20] intc/arm_gic: Implement
 gic_update_virt() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jNatGSrGE5zBqU40d5GY8YLanGzNDm563
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f32095a2-72b7-662d-ee58-670c2b322218@greensocs.com>
Subject: Re: [PATCH v3 16/20] intc/arm_gic: Implement gic_update_virt()
 function
References: <20180629132954.24269-1-luc.michel@greensocs.com>
 <20180629132954.24269-17-luc.michel@greensocs.com>
 <CAFEAcA_fFsqwr316OLcZVwBs72ESLob1AKDZN24JfFo78zQ=AQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_fFsqwr316OLcZVwBs72ESLob1AKDZN24JfFo78zQ=AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/12/2018 03:56 PM, Peter Maydell wrote:
> On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
>> Add the gic_update_virt() function to update the vCPU interface states=

>> and raise vIRQ and vFIQ as needed. This commit renames gic_update() to=

>> gic_update_internal() and generalizes it to handle both cases, with a
>> `virt' parameter to track whether we are updating the CPU or vCPU
>> interfaces.
>>
>> The main difference between CPU and vCPU is the way we select the best=

>> IRQ. This part has been split into the gic_get_best_(v)irq functions.
>> For the virt case, the LRs are iterated to find the best candidate.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> ---
>>  hw/intc/arm_gic.c | 170 +++++++++++++++++++++++++++++++++++----------=
-
>>  1 file changed, 130 insertions(+), 40 deletions(-)
>=20
>=20
>> +
>> +/* Return true if IRQ signaling is enabled:
>> + *   - !virt -> from the distributor to the CPU interfaces,
>> + *              for the given group mask,
>> + *   -  virt -> from the given virtual interface to the CPU virtual i=
nterface.
>> + */
>> +static inline bool gic_irq_signaling_enabled(GICState *s, int cpu, bo=
ol virt,
>> +                                    int group_mask)
>> +{
>> +    return (virt && (s->h_hcr[cpu] & R_GICH_HCR_EN_MASK))
>> +        || (!virt && (s->ctlr & group_mask));
>> +}
>=20
> For a real CPU interface we test the GICC_CTLR EnableGrp0/1 bits here.
> For a virt CPU interface shouldn't we test the GICV_CTLR bits ?
This test is still done in gic_update_internal() (we test
s->cpu_ctlr[cpu_iface], with cpu_iface being the index of a vcpu when
virt is true). I can move it in this function if you think it's clearer?

>=20
> (This doesn't actually cause any wrong behaviour because this check
> is just an efficiency check: "if interrupts are entirely disabled
> then we don't need to do the expensive look-at-all-irqs checks".)
>=20
>=20
> Otherwise looks OK.
>=20
> thanks
> -- PMM
>=20


--jNatGSrGE5zBqU40d5GY8YLanGzNDm563
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltIqioACgkQd8knW3Qn
Tr5zNA//dGn7wc0V7Gg1AwhLxLSYLB6WFuUDMTO8Io8SPpyDZPuyUox9qJF+z5qy
pxAhMjp5hHM7xb2v5jckK1hIk8A0cZsBG++sug3Y4P/PML+VUGGLP3G8gXTQ1Ypm
6u+BiZDhq6o2SCd1ZJ7b1YOEnb7CvWnKqD4mh83XFFL/6VPrhB8vHossqLLr5s9j
AnQcZYuz/2KDJGh0Bo4sN87f7vtFslP9vOH/iQLFnnxYZPRBRCgfxNuTWql917MF
dQrtIyuSC2pXLidgsF2FyAeyfcCZpKweuWN6A8/CruOR02hgvubC1QasokfdeH46
HmJglAHqsOup+m6kioVYT0npXI8cs5egVlQlGm7CBmdoYE7oIJ9xgKfNC7HcG7zf
VPtaBln9cN1a0V9JALcJeIH9MPYQ2maAkSaP8L/ytxn5Z2Eq4ed3Jjk3gRJTi7RO
rl/lgmrAy6FUfzLLMdTkP41n9dTR17R229QxYjxp16m7/rOZiWiJSZhlngLp3A7h
FMa3k8mMf6s6k8ItsGApAJF18mOlm6TrbiQHsWRugVH/r07JZ87iCT4tj1di57kN
CfAvXSsvdy/sEwx22snyjJ5w7dyPHu7MIfrkgrrqDrxrL0IimQYkYnDOzL8SPr86
OV3yU7wfcZVORBsLMd9Ir41h9gJjMKFoVgeZbX5CKNE82npn9yM=
=0rBD
-----END PGP SIGNATURE-----

--jNatGSrGE5zBqU40d5GY8YLanGzNDm563--
