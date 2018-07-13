Received: from eggs.gnu.org ([2001:4830:134:3::10]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdzJh-0007h4-RH
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdzJg-0002V5-Mv
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:45:05 -0400
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-15-luc.michel@greensocs.com>
	<CAFEAcA_R9zp7EBtFetH5Q1Dnzj-kjPzDKRsBAo9aVnMZ3PW0VA@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <d4406995-ad08-b6e4-bf97-f9c212569047@greensocs.com>
Date: Fri, 13 Jul 2018 16:44:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_R9zp7EBtFetH5Q1Dnzj-kjPzDKRsBAo9aVnMZ3PW0VA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YHiNZgu1cQKIbjPAMqJZ94mFQG0soNmCd"
Subject: Re: [Qemu-devel] [PATCH v3 14/20] intc/arm_gic: Wire the vCPU
 interface
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
--YHiNZgu1cQKIbjPAMqJZ94mFQG0soNmCd
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <d4406995-ad08-b6e4-bf97-f9c212569047@greensocs.com>
Subject: Re: [PATCH v3 14/20] intc/arm_gic: Wire the vCPU interface
References: <20180629132954.24269-1-luc.michel@greensocs.com>
 <20180629132954.24269-15-luc.michel@greensocs.com>
 <CAFEAcA_R9zp7EBtFetH5Q1Dnzj-kjPzDKRsBAo9aVnMZ3PW0VA@mail.gmail.com>
In-Reply-To: <CAFEAcA_R9zp7EBtFetH5Q1Dnzj-kjPzDKRsBAo9aVnMZ3PW0VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/12/2018 03:37 PM, Peter Maydell wrote:
> On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
>> Add the read/write functions to handle accesses to the vCPU interface.=

>> Those accesses are forwarded to the real CPU interface, with the CPU i=
d
>> being converted to the corresponding vCPU id (vCPU id =3D CPU id +
>> GIC_NCPU).
>>
>> As for the CPU interface, we create a base region for the vCPU interfa=
ce
>> that fetches the current vCPU id using the current_cpu global variable=
, and
>> one mirror region per vCPU which maps to that specific vCPU id. This i=
s
>> required by the GIC architecture specification.
>=20
>=20
>>  static void arm_gic_realize(DeviceState *dev, Error **errp)
>>  {
>>      /* Device instance realize function for the GIC sysbus device */
>> @@ -1531,7 +1590,7 @@ static void arm_gic_realize(DeviceState *dev, Er=
ror **errp)
>>      }
>>
>>      /* This creates distributor and main CPU interface (s->cpuiomem[0=
]) */
>=20
> Can we also update this comment to indicate what virt-related
> memory regions are being created?
>=20
>> -    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, NULL);
>> +    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, gic_virt_ops);
>>
>>      /* Extra core-specific regions for the CPU interfaces. This is
>>       * necessary for "franken-GIC" implementations, for example on
>> @@ -1547,6 +1606,16 @@ static void arm_gic_realize(DeviceState *dev, E=
rror **errp)
>>                                &s->backref[i], "gic_cpu", 0x100);
>>          sysbus_init_mmio(sbd, &s->cpuiomem[i+1]);
>>      }
>> +
>> +    if (s->virt_extn) {
>=20
> ...and a comment about what these regions are for.
>=20
> What requires these per-core regions anyway? There's no way to
> specify them in the device tree bindings for Linux, which AFAIK
> only cares about using the "vcpu i/f for this core" registers.
> I don't think the GIC-400 has these. (It does have per-cpu
> aliases of the GICH_* registers, but this patchset doesn't seem
> to implement those.)
My mistake. I misread the specifications. Those aliases should target
the virtual interfaces, and not the virtual CPU interfaces. I'll change
that.

>=20
>> +        for (i =3D 0; i < s->num_cpu; i++) {
>> +            memory_region_init_io(&s->vcpuiomem[i + 1], OBJECT(s),
>> +                                  &gic_vcpu_ops, &s->backref[i],
>> +                                  "gic_vcpu", 0x2000);
>> +            sysbus_init_mmio(sbd, &s->vcpuiomem[i + 1]);
>> +        }
>> +    }
>> +
>>  }
>=20
> thanks
> -- PMM
>=20


--YHiNZgu1cQKIbjPAMqJZ94mFQG0soNmCd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltIut0ACgkQd8knW3Qn
Tr78JQ//b8PVwiTP+CX4FcKkdEkOpEh7ejWreN9outjsig19XAlMb1i74iB+7NP3
bavtUrNjTiio5COPN7NT1wgCKagvasFr5yUWlBrg0cGhoehrjK1j2Gi6SX+smAV0
dTH2VfPD3jp7dBy+QrduT9W3GwuS0bInHaIYSSIPoqyX6EE7ocFkVoc6bJILxQrG
CQagHIpW6oyCJRzrLJU4X0eREQUAA4/Bup13ntRHJVyPMV1eB/RYU/SJEc7MX1Fj
zzwxxS3t4f5GMQi4DmRmfPrrG0K+Tw9h6H02EAt+DNZ4c9FpKsOtOwa2axUyS1nY
9y7lP14lAJsLZts7ap3QryOxlA1NEv8jBLZOWNO4o7xjCaVIrTas6zGGIj93unBr
Mq7BdnEZFfO/dGHjd37U/Qa0TA3i/fhHT6itaT4EILwGorsNSpEON6SHOYLMOY9B
5HyhfIGjNEofcmnpUzneXrRDLeuOj2CaPbanqhM0IFFOXZCdWa13qsV3i8EmbHSj
k9n27G2WVErJJMnuIHnDXTM1iakMXmwbiS50tV0C8Bi4hqHrumy7fKeRTyHnSaMS
GxlL+xFhL5+Lv4k9jOuRvwXAbUsvQUJ/nSiopKo4Y0l0TZ4F3R7PCzgjgLXHZqCy
AG6odpV4r4aNLBO1nKy3Sso6H+SjN8YCqzA3RdtJPeVVP6DaPmY=
=FfvZ
-----END PGP SIGNATURE-----

--YHiNZgu1cQKIbjPAMqJZ94mFQG0soNmCd--
