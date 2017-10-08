Received: from eggs.gnu.org ([2001:4830:134:3::10]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1LSn-000596-Ff
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1LSm-0000Xy-0D
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:58:29 -0400
Date: Mon, 9 Oct 2017 10:48:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171008234821.GP10050@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659509034.25889.15033474935802042526.stgit@aravinda>
	<20171004012921.GQ3260@umbus.fritz.box>
	<14aeb1ff-867f-722a-28ce-7d66193051fc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+hz2tM55CCA8Ej21"
Content-Disposition: inline
In-Reply-To: <14aeb1ff-867f-722a-28ce-7d66193051fc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/6] target/ppc: Handle NMI guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--+hz2tM55CCA8Ej21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2017 at 02:29:26PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Wednesday 04 October 2017 06:59 AM, David Gibson wrote:
> > On Thu, Sep 28, 2017 at 04:08:10PM +0530, Aravinda Prasad wrote:
> >> Memory error such as bit flips that cannot be corrected
> >> by hardware are passed on to the kernel for handling.
> >> If the memory address in error belongs to guest then
> >> the guest kernel is responsible for taking suitable action.
> >> Patch [1] enhances KVM to exit guest with exit reason
> >> set to KVM_EXIT_NMI in such cases.
> >>
> >> This patch handles KVM_EXIT_NMI exit. If the guest OS
> >> has registered the machine check handling routine by
> >> calling "ibm,nmi-register", then the handler builds
> >> the error log and invokes the registered handler else
> >> invokes the handler at 0x200.
> >>
> >> Note that FWNMI handles synchronous machine check exceptions
> >> triggered by the hardware and hence we do not extend
> >> such support to the "nmi" command available in the QEMU
> >> monitor. Hence, "nmi" command from the monitor will
> >> always go through 0x200 vector.
> >>
> >> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >> 	(e20bbd3d and related commits)
> >=20
> > What does happen on KVM if an asynchronous machine check exception
> > occurs while in the guest?  Or under PowerVM for that matter.
>=20
> AFAIK asynchronous errors take a different path in KVM as it can happen
> in a different process context.

Well, obviously, I'm wondering what impact it will have on the guest,
one way or another.

[snip]
> >> +ssize_t spapr_get_rtas_size(void)
> >> +{
> >> +    return RTAS_ERRLOG_OFFSET + sizeof(struct rtas_event_log_mce);
> >=20
> > Erm.. because of the definition of rtas_event_log_mce, this only
> > allows for 1 byte of extended log buffer.  That doesn't seem right.
>=20
> This is directly taken from the kernel's RTAS log (struct rtas_error_log
> in arch/powerpc/include/asm/rtas.h). I am not sure why they use 1 byte
> extended log buffer.

I think you'd better find out, then.

[snip]
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 28b6e2e..a75e9cf 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -556,6 +556,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, targ=
et_ulong opcode,
> >>  #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
> >>  #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
> >> =20
> >> +/* Offset from rtas-base where error log is placed */
> >> +#define RTAS_ERRLOG_OFFSET       0x200
> >=20
> > Is there any particular rationale for this offset?  Our actual RTAS
> > code is 20 bytes, much smaller than this.
>=20
> Just to ensure some space if in case RTAS code needs to be extended in
> future.

Hm, but IIUC, we control both sides here.  qemu puts the log into the
RTAS buffer at a particular offset, and qemu tells the guest where to
find it at a particular offset within the RTAS buffer.

So, if we need to extend the RTAS code (unlikely) we can increase our
offset, and the guest will be none the wiser.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+hz2tM55CCA8Ej21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnauUUACgkQbDjKyiDZ
s5JqGxAAgMyKHWBjeYQRtgkaCfJjOrdV6hPxi6vgesRw3HuQn4D/rH3VcVnqB7y8
VnIn18fDx3tT+EBqnYgILzLXk3VtAUVhHyakR+Hx1dBa70U2wtRczx8McZXikiMQ
0/o7uvjVpR7iC/eM/O0gMEIdv1JcOHqQq87SIqQ8o3e/U/pmGOVEvrhAXg5jR8Cb
G+X5VZSnd3/cpB64lM5PAVjUdd/dEwymcBGmkzdguC1zaE9u6rvygy3q9FIam5jN
XXkA4kTGW/reUPaqlDXD6Fc5+hErXDxjfaz2lYNr8RjxpNwcgiP+3IOz8UGJsH6Q
b864y/UzX0yg0VPFJs5jsOXyR1bGeeQxQ/IBi1SeLu1mt59qIa7IeMkRe/ZNOVKR
IYo0ZX3Mv041EAxtqsyv8e/ZRXgAz2dx90/9ItHd4t6OBqyT+Mm6bb8lAuwUO6zG
9ah8NEELuZ131GARAcwSqrikVRHhwKFnxTV8Kp564RRdi6nI//bzNvG9lKSiXJ4c
zs9TogVPsDXNzm649KxM765OeRC28EUR/syJDUPdgwe28/NN1+bjxYnihRydOQvB
4kVY7cUk/itgRrFOxRBCP2MNgE+1HjxyH3aghphgUSuje3+22uG/jcYQGdRhM0Wm
SixBxRPZjUEIFvcQ65TNyf9MmKYVtqFB4tRyPb/URDl2GgG1/ZY=
=RjtQ
-----END PGP SIGNATURE-----

--+hz2tM55CCA8Ej21--
