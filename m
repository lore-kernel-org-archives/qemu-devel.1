Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsp3-0008Hu-Pq
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsp0-000571-Hd
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:22:13 -0400
Date: Sun, 10 Sep 2017 13:22:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910032202.GA2735@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287475974.9760.13295593936611613542.stgit@aravinda>
	<20170817015735.GD5509@umbus.fritz.box>
	<f7f837f6-9ce9-3eb3-8083-31878c851267@linux.vnet.ibm.com>
	<20170823083923.GR5379@umbus.fritz.box>
	<99c1f372-1db0-e89a-423b-63ec113caf37@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ny1v8xcV31BR+sbv"
Content-Disposition: inline
In-Reply-To: <99c1f372-1db0-e89a-423b-63ec113caf37@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 4/5] target/ppc: Handle NMI
 guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com


--ny1v8xcV31BR+sbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2017 at 01:39:37PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Wednesday 23 August 2017 02:09 PM, David Gibson wrote:
> > On Mon, Aug 21, 2017 at 06:00:52PM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Thursday 17 August 2017 07:27 AM, David Gibson wrote:
> >>> On Wed, Aug 16, 2017 at 02:42:39PM +0530, Aravinda Prasad wrote:
> >>>> Memory error such as bit flips that cannot be corrected
> >>>> by hardware are passed on to the kernel for handling.
> >>>> If the memory address in error belongs to guest then
> >>>> guest kernel is responsible for taking suitable action.
> >>>> Patch [1] enhances KVM to exit guest with exit reason
> >>>> set to KVM_EXIT_NMI in such cases.
> >>>>
> >>>> This patch handles KVM_EXIT_NMI exit. If the guest OS
> >>>> has registered the machine check handling routine by
> >>>> calling "ibm,nmi-register", then the handler builds
> >>>> the error log and invokes the registered handler else
> >>>> invokes the handler at 0x200.
> >>>>
> >>>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >>>> 	(e20bbd3d and related commits)
> >>>>
> >>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>> ---
> >>>>  hw/ppc/spapr.c       |    4 ++
> >>>>  target/ppc/kvm.c     |   86 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  target/ppc/kvm_ppc.h |   81 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >>>>  3 files changed, 171 insertions(+)
> >>>>
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 0bb2c4a..6cc3f69 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -2346,6 +2346,10 @@ static void ppc_spapr_init(MachineState *mach=
ine)
> >>>>          error_report("Could not get size of LPAR rtas '%s'", filena=
me);
> >>>>          exit(1);
> >>>>      }
> >>>> +
> >>>> +    /* Resize blob to accommodate error log. */
> >>>> +    spapr->rtas_size =3D RTAS_ERRLOG_OFFSET + sizeof(struct RtasMCE=
Log);
> >>>> +
> >>>>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >>>>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_siz=
e) < 0) {
> >>>>          error_report("Could not load LPAR rtas '%s'", filename);
> >>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >>>> index 8571379..73f64ed 100644
> >>>> --- a/target/ppc/kvm.c
> >>>> +++ b/target/ppc/kvm.c
> >>>> @@ -1782,6 +1782,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct=
 kvm_run *run)
> >>>>          ret =3D 0;
> >>>>          break;
> >>>> =20
> >>>> +    case KVM_EXIT_NMI:
> >>>> +        DPRINTF("handle NMI exception\n");
> >>>> +        ret =3D kvm_handle_nmi(cpu);
> >>>> +        break;
> >>>> +
> >>>>      default:
> >>>>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_=
reason);
> >>>>          ret =3D -1;
> >>>> @@ -2704,6 +2709,87 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >>>>      return data & 0xffff;
> >>>>  }
> >>>> =20
> >>>> +int kvm_handle_nmi(PowerPCCPU *cpu)
> >>>
> >>> So you only handle NMIs with KVM.  Wouldn't it make sense to also
> >>> handle them for TCG (where they can be triggered with the "nmi"
> >>> command on the monitor).
> >>
> >> For TCG it is already handled in spapr_nmi() which ultimately branches
> >> to guest's 0x200 vector. Even with KVM when KVM_CAP_PPC_FWNMI is not
> >> enabled we branch to guest's 0x200 vector. Should TCG behave as if
> >> KVM_CAP_PPC_FWNMI is not enabled?
> >=20
> > No, we should implement the FWNMI feature for TCG, which means it
> > needs to respect the address given by nmi-register.
>=20
> I have couple of questions regarding supporting NMIs triggered through
> "nmi" command from the monitor.
>=20
> 1. The FWNNMI builds an error log upon machine check that includes the
> effective address that triggered the machine check and places the error
> log in RTAS blob. Hence, we need to build error log for the NMI
> triggered via the monitor "nmi" command. What should be the effective
> address and the other values of the error log in this case? Should "nmi"
> command be enhanced to take these arguments (as of now it does not take
> any arguments)?

Ah!  That's something I hadn't realised - sounds like FWNMI is only
designed to handle synchronous machine checks, whereas the monitor
command (obviously) generates asynchronous checks.

In that case it's probably reasonable that the monitor command doesn't
go through the FWNMI path.  However, it would be nice to make it a bit
more obvious, by updating some of the comments and commit messages in
the FWNMI code to emphasise that it's only for synchronous checks.

> 2. On Power architecture "nmi" monitor command triggers NMI on all the
> CPUs, while the NMI due to hardware error is triggered only on the CPU
> that accessed the bad memory region. Triggering NMI on all the CPUs
> could be a problem as it cause kernel panic if the CPU was in kernel
> space at that time or kills the process running on that CPU if it was in
> userspace.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ny1v8xcV31BR+sbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0r9oACgkQbDjKyiDZ
s5KAVA//dirIB6kX/szR48SJ4teabB04yrAPKU48bOIkXsGIPVp+QP4ZOGlrjP2L
ZoxMWVVtt9Evn+Po40C6e7J7qjNEkY17tp5YoTZQYfu0NCcDQf8EYlMN0zK9JweN
S3K495yC/PcN/31l2Hg34/Z64ejm1ul1cZG59oUXelbjrDCny+ilkRX4iUzDYXzh
ADYLqFkp4ozn+jFhR/pE3f33GgNf4nzxYeIYTT/8lZ2CXa++hYI5o2DdpLxbc7Pw
vQVdrcWL8bR97OZmAFXeRFAUQHP+bRyruimuxpK6gc43fm9KVtWuRa6U9SzVWt1w
9eeryIi7XLf2rxYiLvr1CGQv7IcwX8yuab8z9RzmWtZ/zlmk5bSmv7uHcSmpZW2z
/FXEQo/PKv5lxufrsB5cFJwvd8GbP4j8+y49JI9clUQxZcvNrJPastuqP4MO4G+Y
o+z0ffy5tCagI/cq0ZHHSXcqY1suwc/XhseO++/IMFyaVA7wsQsGuel5QLfb6xJn
H4a06wtWHjJs8hNqGD3BYAOxrzkyiKQypw/0JOfpr5bBb4q9z3XCPZgM3r/RBvcp
GCN8Pir+QR3nBGGLVbmG+ouIooz6w38JOgNmpJbw4nXvzV1Dj+f2OtLqk2Q5AmJ9
UiP2UB1dfEdhdFOw22FeKIMkK/RiilRZgsUxmZhaeulksM8kA/o=
=DWZ5
-----END PGP SIGNATURE-----

--ny1v8xcV31BR+sbv--
