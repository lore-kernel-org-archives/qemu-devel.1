Received: from eggs.gnu.org ([2001:4830:134:3::10]:58059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e9WGq-00010C-F2
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e9WGl-0003s1-FE
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:07:56 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 31 Oct 2017 13:07:36 +0000
Message-ID: <MWHPR21MB015998D56801F7253F33D1FB9E5E0@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <20171031130223.220-1-Andrew.Baumann@microsoft.com>
In-Reply-To: <20171031130223.220-1-Andrew.Baumann@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] arm: implement cache/shareability
 attribute bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Andrew Baumann
> Sent: Tuesday, 31 October 2017 21:02
[...]
> +static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
> +{
> +    uint8_t hiattr =3D extract32(s2attrs, 2, 2);
> +    uint8_t loattr =3D extract32(s2attrs, 0, 2);
> +    uint8_t hihint =3D 0, lohint =3D 0;
> +
> +    if (hiattr !=3D 0) { /* normal memory */
> +        /* TODO: to faithfully emulate S2CacheDisabled() for the case
> +         * when EL2 is aarch32, we should check HCR2 (not HCR_EL2), but
> +         * qemu doesn't presently model this register.
> +         */
> +        if ((env->cp15.hcr_el2 & HCR_CD) !=3D 0) { /* cache disabled */
> +            hiattr =3D loattr =3D 1; /* non-cacheable */
> +        } else {
> +            if (hiattr !=3D 1) { /* Write-through or write-back */
> +                hihint =3D 3; /* RW allocate */
> +            }
> +            if (loattr !=3D 1) { /* Write-through or write-back */
> +                lohint =3D 3; /* RW allocate */
> +            }
> +        }
> +    }
> +
> +    return (hiattr << 6) | (hihint << 2) | (loattr << 2) | lohint;
> +}

Right after sending this, I noticed a dumb copy-paste bug: the above should=
 be hihint << 4.
I'm obviously going a bit too fast, sorry.

Andrew
