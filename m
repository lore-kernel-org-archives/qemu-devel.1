Received: from eggs.gnu.org ([2001:4830:134:3::10]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeIC-0005qE-7m
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeI8-0001Gq-CB
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:48 -0400
Date: Tue, 29 Aug 2017 17:23:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829072310.GJ2578@umbus.fritz.box>
References: <20170825211119.474-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline
In-Reply-To: <20170825211119.474-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2] hw/ppc: CAS reset on early
 device hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 06:11:18PM -0300, Daniel Henrique Barboza wrote:
> v2:
> - rebased with ppc-for-2.11
> - function 'spapr_cas_completed' dropped
> - function 'spapr_drc_needed' made public and it's now used inside
>   'spapr_hotplugged_dev_before_cas'
> - 'spapr_drc_needed' was changed to support the migration of logical
>   DRCs with devs attached in UNUSED state
> - new function: 'spapr_clear_pending_events'. This function is used
>   inside ppc_spapr_reset to reset the pending_events QTAILQ

Thanks for the followup, unfortunately there is still an important bug
left, see comments on the patch itself.

At a higher level, though, looking at the event reset code made me
think of a possible even simpler solution to this problem.

The queue of events (both hotplug and epow) is already in a simple
internal form that's independent of the two delivery mechanisms.  The
only difference is what event source triggers the interrupt.  This
explains why an extra hotplug event after the CAS "unstuck" the queue.

AFAICT, a spurious interrupts here should be harmless - the kernel
will just check the queue and find nothing there.

So, it should be sufficient to, after CAS, pulse the hotplug queue
interrupt if the hotplug queue is negotiated.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmlFlsACgkQbDjKyiDZ
s5I0DRAAy9uWB197Z203nbOGWUs8HdvIeepnsIfaXVIR9tPwMkR7xG1oclEWXBXt
0MiJKxzYkzKHkoBBR+BzkXKe2kYYwWYYxY36uK+3OIvhQwnpeZziHsCKxa1kZnOs
7UPsrhDZSnU4DbT1p+DaV263xWCtQnpaMCkVghuygwpTK9N2g8tVTTNK4Np7KhqG
GWYS/DqpT6qy8Wxao4JJFviNVM52KTrgP8deTm65pm47C8FrsgZqzqw+OuSGxnhS
EQNhhmPFvl4sEhXBamfVKSguf6fu7P52B+NBI5OruzipqICh12xAHbxmagqYWlx8
FvS4Z12y2OjUYJH2zWNkcX4E98g0eHenscrDOkLSJGzGMK5c1Jb7PzcMZ0ErApwE
nlbaCIY723P9urmLBj06jAOqRkMtdmmFI3qGdFQxVE9/ZqOrGLvLo1b41ivyN3nS
VoFyxmeBnPLh05SdMfEKjnoPwpjlOCZfhTvzhAs32uYyuPNKrhHAZRENE7IvES23
KGX+U1yTWOcVeregywlXBRGOaAWWOl+TH5ic5wBSZEcDeLuO/gGfkw8ieIAVh45k
xOyPcseM20KkSg5Sv7lkV7/ugaSkRhZCtkXVijUGIIzJTQk7nRePzjqo/HDM6h4x
vvuWOn50sr04MhktpG962FGbWCEG1t74yWB9wMWgLWTWgiBo0ho=
=6ahE
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
