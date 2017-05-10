Received: from eggs.gnu.org ([2001:4830:134:3::10]:49864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8M7j-0006Sy-H9
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8M7i-0000jV-7e
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:33:27 -0400
Date: Wed, 10 May 2017 17:33:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170510073312.GX25748@umbus.fritz.box>
References: <20170505193810.2934-1-eblake@redhat.com>
	<20170505193810.2934-4-eblake@redhat.com>
	<20170508052617.GC25748@umbus.fritz.box>
	<117db2fa-302b-362a-738c-0c114439f8af@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0btr6/5+bhBdui6J"
Content-Disposition: inline
In-Reply-To: <117db2fa-302b-362a-738c-0c114439f8af@redhat.com>
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


--0btr6/5+bhBdui6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 09:32:42AM -0500, Eric Blake wrote:
> On 05/08/2017 12:26 AM, David Gibson wrote:
> > On Fri, May 05, 2017 at 02:38:08PM -0500, Eric Blake wrote:
> >> Time to wire up all the call sites that request a shutdown or
> >> reset to use the enum added in the previous patch.
> >>
> >> It would have been less churn to keep the common case with no
> >> arguments as meaning guest-triggered, and only modified the
> >> host-triggered code paths, via a wrapper function, but then we'd
> >> still have to audit that I didn't miss any host-triggered spots;
> >> changing the signature forces us to double-check that I correctly
> >> categorized all callers.
> >>
> >> Since command line options can change whether a guest reset request
> >> causes an actual reset vs. a shutdown, it's easy to also add the
> >> information to reset requests.
> >>
> >> Replay adds a FIXME to preserve the cause across the replay stream,
> >> that will be tackled in the next patch.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> Acked-by: David Gibson <david@gibson.dropbear.id.au> [ppc parts]
> >> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [SPARC p=
art]
> >=20
> > [snip]
> >=20
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 9f18f75..2735fe9 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1166,7 +1166,7 @@ static target_ulong h_client_architecture_suppor=
t(PowerPCCPU *cpu,
> >>      spapr_ovec_cleanup(ov5_updates);
> >>
> >>      if (spapr->cas_reboot) {
> >> -        qemu_system_reset_request();
> >> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >=20
> > I'm not 100% sure about this one, since I'm not sure 100% of how the
> > different enum values are defined.  This one is tripped when feature
> > negotiation between firmware and guest can't be satisfied without
> > rebooting (next time round the firmware will use some different
> > options).
>=20
> Patch 2/5 introduced the enum.  The biggest part of the patch (for now)
> is that anything SHUTDOWN_CAUSE_HOST_ will be exposed to the QMP client
> as host-triggered, anything SHUTDOWN_CAUSE_GUEST_ will be exposed as
> guest-triggered.  I basically used SHUTDOWN_CAUSE_GUEST_RESET for any
> call to qemu_system_reset_requst() underneath the hw/ tree, because the
> hw/ tree is emulating guest behavior and therefore it is presumably a
> reset caused by a guest request.

Ok.

> > So it's essentially a firmware/hypervisor triggered reset, but one
> > that should only ever be tripped during early guest boot.  Is
> > CAUSE_GUEST_RESET correct for that?
>=20
> Of course, I'm not an export on SPAPR, so I'll happily change it to
> anything else if you think that is more appropriate. But the rule of
> thumb I went by is whether this is qemu emulating a bare-metal
> reset/shutdown, vs. qemu killing the guest without waiting for guest
> instructions to reach some magic
> memory/register/ACPI/who-knows-what-else request.  While it may happen
> only early during guest boot, it is still the guest firmware that is
> requesting it, and not qemu causing a unilateral death.

So, I think GUEST_RESET is the right choice here.  The distinctions
are blurry, because PAPR is built as a paravirtualized platform -
there is no bare metal equivalent.  For example, on PowerVM this
really would be initiated by guest firmware, but it's working in
communication with the hypervisor.  But with qemu and KVM, we actually
implement all this negotiation logic in qemu directly (this is easier
than having complex communication channels between guest firware and
qemu).

But I guess the point is that this is a "business as usual" reboot and
the guest is expected to continue booting at some point after this,
rather than being killed by qemu.

Things get more complicated still if we think about what happens if
this feature negotiation fails - then we can't boot the guest OS.  At
the moment the few cases where this happens, I think we just exit
qemu, but notifying this as a host caused shutdown might be
appropriate.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0btr6/5+bhBdui6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEsI2AAoJEGw4ysog2bOSrZQQAONQcDrk+8XBHkJ+cjUrLJmD
GvWf8otaUn05Y8BqwzsDqav4jUGX9hlt1nyamQVXRGrjjOoWx3vGO3n3n6E9rqkj
iNnEHqnXgvYn8JgGBpYQ1pawEsCuq+NpQa9wLu9SDsg9WEFpu0kA/SjXqSQAsej2
RSCn39/UvO/3h2uDKCxntQ1UiMW9+hywaxfTNX8r1+n4h10LRcD3OhvqdN3v4wlw
nzU81CXhM3XHVkMD5nG7T/Deg7BrmR0aaogvJmDvhsqIqa+KnLLZw2f8R4mclOEA
A25e9xG8sze0J2yFyS2TDTuQuQzp/r0fnvH5A9b49S51gn2rHgZ3xIVs8rz+KUGa
uAkmYzyEtXoLKfZyf+lHjVfJRhGpINu9JzhRBlR+0GRwm9a10Onzeo27cDRFc5CM
E50UVmIecjfWO9x0CAemez6YqfXuqLIBB408+Y4WkOLoWHiwGqZjEHRNtzGY3tI9
4g2t17iHfhkhMw5Eq6B3pBtEQOY21d+PODL93iwfuAq1RmAcUhjmUD1+mRM3GdcA
pBNZNAE/5k3r3VzA10DRd3ebmJ6UDOWefUWOHIqK2fZsf/tNHhJBo0k3WPOlmq+m
MTCMqSkqIsOpDYK7YHvLWZNxk+jymMTf9albzjCX202C77zbpmQa0Y59o03HMbDf
mrS9Yc16j48Dox+nzqwT
=IB2R
-----END PGP SIGNATURE-----

--0btr6/5+bhBdui6J--
