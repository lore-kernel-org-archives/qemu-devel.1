Received: from eggs.gnu.org ([2001:4830:134:3::10]:45605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bPB-0000Ee-Hw
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bPA-00016Z-Lr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:40:21 -0400
Date: Mon, 8 May 2017 15:26:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170508052617.GC25748@umbus.fritz.box>
References: <20170505193810.2934-1-eblake@redhat.com>
	<20170505193810.2934-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20170505193810.2934-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/5] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Stefan Weil <sw@weilnetz.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Old World" <qemu-ppc@nongnu.org>, "open list:Overall" <kvm@vger.kernel.org>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 02:38:08PM -0500, Eric Blake wrote:
> Time to wire up all the call sites that request a shutdown or
> reset to use the enum added in the previous patch.
>=20
> It would have been less churn to keep the common case with no
> arguments as meaning guest-triggered, and only modified the
> host-triggered code paths, via a wrapper function, but then we'd
> still have to audit that I didn't miss any host-triggered spots;
> changing the signature forces us to double-check that I correctly
> categorized all callers.
>=20
> Since command line options can change whether a guest reset request
> causes an actual reset vs. a shutdown, it's easy to also add the
> information to reset requests.
>=20
> Replay adds a FIXME to preserve the cause across the replay stream,
> that will be tackled in the next patch.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> [ppc parts]
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [SPARC part]

[snip]

> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 9f18f75..2735fe9 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1166,7 +1166,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      spapr_ovec_cleanup(ov5_updates);
>=20
>      if (spapr->cas_reboot) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);

I'm not 100% sure about this one, since I'm not sure 100% of how the
different enum values are defined.  This one is tripped when feature
negotiation between firmware and guest can't be satisfied without
rebooting (next time round the firmware will use some different
options).

So it's essentially a firmware/hypervisor triggered reset, but one
that should only ever be tripped during early guest boot.  Is
CAUSE_GUEST_RESET correct for that?

Apart from this, ppc changes

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEAF3AAoJEGw4ysog2bOSKUEQAIHEYWHQbtglHYNeWCFshRU1
B2yYZkSIpestqK2pOaBSYHw7GAnIcqCS47d9jJZsvVqzivJyV+pZGm+oWnCMyYVX
vrMjN16R3TSALFVAnSEwqNlgR3my62B7ElUaWEn6A9nUbZj4lKiXGF2HtSK1GjuK
CIBtxN65CQobrO+YGtq2fVLKFt/yONvKbwgOTNixEpmxuPEuGa5+d3c9xnV2FhT1
LOMsvv4EEqZaMEay3DkV+BYyMShogMB8th+oF7FTYWo1l0FWOEqQlQRTiSg44WPk
U5WCyGEXG22ljDFzdau5r0YAZNfMHzajEQ6c+A81ebQr41NNuE0d9nMXDUEH3BG1
UN3j5XdC0j/gSh03PTMob0di/cqjONhYbrdZEjaX5AFqt88T7WgsNbWhFZBCr1KW
ihHP1fLuTDCd2Hmbr6yTCIHjf8dagI8okTFUZey+9JF9N/KLYXUEbk8tVckX3jKi
+KBvLUm8RoG7IcrY4qKyELtuUaOvx2Nh5Sthdl3dOahmXuEfxzwGb0AkCYZ/ycK/
a2XZ/6D/v5Z3kIeMbCWJt7ATIyIzDG+0A5f41V6s87Nda5FTe50IxHFaoRPquCO+
8t9JFEW3YFN2MxrIAcXjI6mvFoC9jhbR2w/4F+utRmdi+AqaGgsXah7Kl7s2iEmK
GI6v5jijqm6cgO6HeFdZ
=UO+j
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
