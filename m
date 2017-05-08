Received: from eggs.gnu.org ([2001:4830:134:3::10]:59520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7jXq-00062t-Qp
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7jXp-0005LW-Tl
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:21:50 -0400
References: <20170507113540.8687-1-krzk@kernel.org>
	<20170507113540.8687-4-krzk@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8b021fa-e3f8-50d7-8013-d67e66e25ce6@redhat.com>
Date: Mon, 8 May 2017 09:21:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170507113540.8687-4-krzk@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f7DB2ABJN9Mfl5VVjmTDukd1KvTHtcrdb"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/exynos: Add support for system
 poweroff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f7DB2ABJN9Mfl5VVjmTDukd1KvTHtcrdb
From: Eric Blake <eblake@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8b021fa-e3f8-50d7-8013-d67e66e25ce6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/exynos: Add support for system
 poweroff
References: <20170507113540.8687-1-krzk@kernel.org>
 <20170507113540.8687-4-krzk@kernel.org>
In-Reply-To: <20170507113540.8687-4-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/07/2017 06:35 AM, Krzysztof Kozlowski wrote:
> On all Exynos-based boards, the system powers down itself by driving
> PS_HOLD signal low.  Handle writing to respective PMU register to fix
> power off failure:
>=20
>     reboot: Power down
>     Unable to poweroff system
>     shutdown: 31 output lines suppressed due to ratelimiting
>     Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00=
000000
>=20
>     CPU: 0 PID: 1 Comm: shutdown Not tainted 4.11.0-rc8 #846
>     Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>     [<c031050c>] (unwind_backtrace) from [<c030ba6c>] (show_stack+0x10/=
0x14)
>     [<c030ba6c>] (show_stack) from [<c05b2800>] (dump_stack+0x88/0x9c)
>     [<c05b2800>] (dump_stack) from [<c03d3140>] (panic+0xdc/0x268)
>     [<c03d3140>] (panic) from [<c0343614>] (do_exit+0xa90/0xab4)
>     [<c0343614>] (do_exit) from [<c035f2dc>] (SyS_reboot+0x164/0x1d0)
>     [<c035f2dc>] (SyS_reboot) from [<c0307c80>] (ret_fast_syscall+0x0/0=
x3c)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/misc/exynos4210_pmu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

> @@ -397,6 +398,12 @@ typedef struct Exynos4210PmuState {
>      uint32_t reg[PMU_NUM_OF_REGISTERS];
>  } Exynos4210PmuState;
> =20
> +static void exynos4210_pmu_poweroff(void)
> +{
> +    PRINT_DEBUG("QEMU PMU: PS_HOLD bit down, powering off\n");
> +    qemu_system_shutdown_request();

Depending on whether your patch lands before or after mine, we'll have
to update this. It sounds like it is a guest-triggered reset, so my
patch would have this use SHUTDOWN_CAUSE_GUEST_SHUTDOWN.

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01380.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f7DB2ABJN9Mfl5VVjmTDukd1KvTHtcrdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEH70AAoJEKeha0olJ0NqrnYH/2B0h0Z1on6J33t3X+BIRAJi
u9cLRxp3+TYgjDfQa88bkUPgHLBFsOQbX2Hf2A1z48WZnGrULgW0D89LzHH45fYY
MGGVLfbVijp9tMjPjyVQkygABvbJ1mcWB2Bg2zBGw78xmg1ZPvexd+w0Gr2wkofh
v8Mu8hS3acmRZLU7JA1BkxxQUtAyGycdVXnaErhNLiLELOdx5ryS9Ntw0q5+qiBE
3CbRQJ4yPma/faaxLimZEucCLvplxaynnOUMolDI7aAxfRrOEstrXoV7woaNbRT6
B9kvTheWZAVF1k65IB06hSa4g2lSUnpQwru/BoGv6TixPpZOn03SPbSvKDwRIK0=
=ks00
-----END PGP SIGNATURE-----

--f7DB2ABJN9Mfl5VVjmTDukd1KvTHtcrdb--
