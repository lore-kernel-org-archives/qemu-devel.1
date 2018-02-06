Received: from eggs.gnu.org ([2001:4830:134:3::10]:43142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eiqqh-0006Jv-6m
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eiqqd-0004Ph-VB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:10:59 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eiqqd-0004PT-Ot
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:10:55 -0500
Received: by mail-qk0-x244.google.com with SMTP id f68so162644qke.9
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:10:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180201205307.30343-1-christoffer.dall@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <431ec46d-33dd-71d8-9ea1-f331ba01bd62@amsat.org>
Date: Mon, 5 Feb 2018 21:10:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180201205307.30343-1-christoffer.dall@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="XAZDqqBbWi5zpcI7LCK4OIuL0P1MGhaAQ"
Subject: Re: [Qemu-devel] [PATCH] target/arm/kvm: gic: Prevent creating
 userspace GICv3 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <christoffer.dall@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alex Bennee <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XAZDqqBbWi5zpcI7LCK4OIuL0P1MGhaAQ
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Christoffer Dall <christoffer.dall@linaro.org>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>
Message-ID: <431ec46d-33dd-71d8-9ea1-f331ba01bd62@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] target/arm/kvm: gic: Prevent creating
 userspace GICv3 with KVM
References: <20180201205307.30343-1-christoffer.dall@linaro.org>
In-Reply-To: <20180201205307.30343-1-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christoffer,

On 02/01/2018 05:53 PM, Christoffer Dall wrote:
> KVM doesn't support emulating a GICv3 in userspace, only GICv2.  We
> currently attempt this anyway, and as a result a KVM guest doesn't
> receive interrupts and the user is left wondering why.  Report an error=

> to the user if this particular combination is requested.
>=20
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  target/arm/kvm_arm.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index ff53e9fafb..cfb7e5af72 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -234,6 +234,10 @@ static inline const char *gicv3_class_name(void)

Any reason why these functions are inlined in this include?

Also - not related to your patch - while gicv3_class_name() is
self-explicit, gic_class_name() isn't (to me at least).

There are many check for gic_version 1/2/3 in virt.c, which we could
clean using more generic functions such gic_class_name(int gic_version)
and Co.

Alistair/Edgar:
Why the ZynqMP is not using the GICv3 for the APU? I remember hearing
something about not fully implemented so not working correctly.

>          exit(1);
>  #endif
>      } else {
> +        if (kvm_enabled()) {
> +            error_report("Userspace GICv3 is not supported with KVM");=

> +            exit(1);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +        }
>          return "arm-gicv3";
>      }
>  }
>=20

Regards,

Phil.


--XAZDqqBbWi5zpcI7LCK4OIuL0P1MGhaAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp48ogACgkQ4+MsLN6t
wN6IdxAAg9ObWZCyYqN04SGA8C6WBIbPFGUAEqlaqArE0wMbEKdWrCyyiOUE7T5e
oeLTSFSkqx44i7mZBs6SJAb19fIIMPKr4SfltbQ9455Ymre+kBlXzeaO1SYmt4Hx
Dfu5ZmEWLdvNJQ25oYbyNnyHZaAHlZMlRo+npVTN5h59FpssonAA55qBH8RV++9F
p3/pHedPgOH9O+8UiR4ExULvt6qNggZQPAoz1NFrey2qBxk5o0dGCz7QByIzQFo9
Oc1ED3c8kND1IjSCM645FnYfhowaVYZ8Kp7R6sfZMWnp31HA45Bvmxcpo8ExWXAA
9YLUOFCBaPRlP93HCb2ynfwQxXfCFB/3Se0HCJ1tGdA7aiS+scdi3LvUp6sUGFM/
WiP3oYrF787FN9FGaBfhRp/MVuyPNqaA2qA8ZwpC15zvGwaT/34dlS9RgWeJId6a
Xk1ZDXaB0eJum+ZF8v/4FiL9qQASfVHKfACJsz9s6oaJX1hrVAPP9V38ePlGmhIQ
SyGoppTeCDr+8NZP/YCfL4C4LIrFryPb3jbQJkgr69sBt9V3B9ZgTiRzoFHeFoGT
3rcQE0Bdt7zuZmPcXwtfTBJp2bqFbA3THpv8a1U/ebBqWYyuaEw3P8w5t4a8gMkL
fQyF7ko/Mew9ZOLaTLL+zO7bAeNe+DhemrnChJvoVan8WTNQZ1c=
=zmRV
-----END PGP SIGNATURE-----

--XAZDqqBbWi5zpcI7LCK4OIuL0P1MGhaAQ--
