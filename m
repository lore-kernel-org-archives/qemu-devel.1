Received: from eggs.gnu.org ([2001:4830:134:3::10]:44879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmmK-0003xC-IS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmmH-0002ii-FJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:42:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBmmG-0002iI-VL
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:42:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCF8B81A88D5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 19:41:59 +0000 (UTC)
References: <20180426183404.3756-1-lersek@redhat.com>
	<20180426183404.3756-5-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16b5979b-3db1-73fe-fb9b-d73b08b11177@redhat.com>
Date: Thu, 26 Apr 2018 14:41:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180426183404.3756-5-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eebF8dKM1VRx2sTzGYxlbjTbWdufZyXHD"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qapi: discriminate CpuInfoFast on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eebF8dKM1VRx2sTzGYxlbjTbWdufZyXHD
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <16b5979b-3db1-73fe-fb9b-d73b08b11177@redhat.com>
Subject: Re: [PATCH v2 4/4] qapi: discriminate CpuInfoFast on SysEmuTarget,
 not CpuInfoArch
References: <20180426183404.3756-1-lersek@redhat.com>
 <20180426183404.3756-5-lersek@redhat.com>
In-Reply-To: <20180426183404.3756-5-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 01:34 PM, Laszlo Ersek wrote:
> Add a new field @target (of type @SysEmuTarget) to the output of the
> @query-cpus-fast command, which provides more information about the
> emulation target than the field @arch (of type @CpuInfoArch). Make @tar=
get
> the new discriminator for the @CpuInfoFast return structure. Keep @arch=

> for compatibility.
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>=20

> +static CpuInfoArch sysemu_target_to_cpuinfo_arch(SysEmuTarget target)
> +{
> +    /*
> +     * The @SysEmuTarget -> @CpuInfoArch mapping below is based on the=

> +     * TARGET_ARCH -> TARGET_BASE_ARCH mapping in the "configure" scri=
pt.
> +     */
> +    switch (target) {
> +    case SYS_EMU_TARGET_I386:
> +    case SYS_EMU_TARGET_X86_64:
> +        return CPU_INFO_ARCH_X86;

Thankfully, the addition of new targets is infrequent, so hopefully not
too hard to keep this mapping up-to-date.

I also like that this approach is introspectible via 'query-qmp-schema'
- if 'query-cpus-fast' has the "target" member, then you know that it is
fixed (you can ignore "arch" in that case, even though you know it
works); if it lacks "target", you know that "arch":"s390x" is the only
real string to look for and that all other systems report "x86" whether
or not that was accurate.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eebF8dKM1VRx2sTzGYxlbjTbWdufZyXHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriK4QACgkQp6FrSiUn
Q2pTzgf/RZaaGLG1jviOEMNedo/cTK71QEKGikPZ0ivdYhlxPTihQy2N8YNVBmO3
G/ufytzxE/U4m2MyKdc3GkSCNZok0ngYyGGXyQho1xcAlhNNr4eKYABujK2Zp5MC
9oIozoChXbEyOxAYPfE/eJgvMdUl/+Dn4IwZzZZXxDFSWMiyPMklScNi3wSnAszg
4svQbrsQgdN19gAtJgZbPR4KoqTsXFAlpd1MlWU2U/XJchf2x4dSem6HEwtmb04i
WkYrymR4oe+nyUUIubuia6TCdTsp17uIGE0MozS+hYKS6HeI2nLUn+bWqVYzjzmL
HjmYtuKLpwOnpN5yACNuLJY7CDzn7w==
=fCGG
-----END PGP SIGNATURE-----

--eebF8dKM1VRx2sTzGYxlbjTbWdufZyXHD--
