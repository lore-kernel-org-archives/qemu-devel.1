Received: from eggs.gnu.org ([2001:4830:134:3::10]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQxr5-00049n-HW
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQxr2-0002AP-GQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:56:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQxr2-0002A2-7y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:56:52 -0500
Date: Tue, 10 Jan 2017 14:47:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170110144754.GB17540@stefanha-x1.localdomain>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
	<20170109163535.GJ30228@stefanha-x1.localdomain>
	<87zij0jdt4.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <87zij0jdt4.fsf@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH v4 3/6] hypertrace: [*-user] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 07:20:07PM +0100, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > On Mon, Dec 26, 2016 at 09:34:54PM +0100, Llu=EDs Vilanova wrote:
> >> +static void segv_handler(int signum, siginfo_t *siginfo, void *sigctx=
t)
> >> +{
> >> +    CPUState *vcpu =3D current_cpu;
> >> +    void *control_0 =3D vcpu->hypertrace_control;
> >> +    void *control_1 =3D vcpu->hypertrace_control + config.control_siz=
e / 2;
> >> +    void *control_2 =3D control_1 + config.control_size / 2;
> >> +
> >> +    if (control_0 <=3D siginfo->si_addr && siginfo->si_addr < control=
_1) {
> >> +
> >> +        /* 1st fault (guest will write cmd) */
> >> +        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =
=3D=3D 0);
> >> +        swap_control(control_0, control_1);
> >> +
> >> +    } else if (control_1 <=3D siginfo->si_addr && siginfo->si_addr < =
control_2) {
> >> +        size_t client =3D (siginfo->si_addr - control_1) / sizeof(uin=
t64_t);
> >> +        uint64_t vcontrol =3D ((uint64_t *)control_0)[client];
> >> +        uint64_t *data_ptr =3D &qemu_data[client * config.client_data=
_size];
> >> +
> >> +        /* 2nd fault (invoke) */
> >> +        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =
=3D=3D 0);
> >> +        hypertrace_emit(current_cpu, vcontrol, data_ptr);
> >> +        swap_control(control_1, control_0);
>=20
> > A simpler and faster approach is to permanently mprotect just one region
> > and load all arguments from data[] (including the first argument).  Then
> > swapping isn't necessary.
>=20
> I'm don't understand what you propose.
>=20
> With a single protected region, you don't know when to restore protection=
 of it
> so that later accesses will be detected too. That could be solved if we u=
sed
> single-stepping (maybe that's what you meant):
>=20
> * trap access
> * unprotect memory region
> * single-step guest
> * read written data and emit event
> * protect memory region again
> * resume guest
>=20
> If the single-stepping can be done without too much complexity, that'd be=
 a
> faster option, and that piece of code might be cleaner too.
>=20
> We could only avoid the protect/unprotect sequence if we added target-spe=
cific
> code to "skip" the failed instruction (assuming all useful writes go to t=
he data
> channel), but I wanted to make all code target-agnostic.

Okay, I didn't realize the instruction would be restarted.  I thought
swapping was solely to allow the guest to write vcontrol =3D
control_0[client].

Assuming for a second that the instruction isn't restarted, my
suggestion was to use si_addr to identify which client and then load all
args out of the (read/write) data region.  This eliminates vcontrol.

Stefan

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdPQaAAoJEJykq7OBq3PIYf0H/0GQg0MW4vVakxrW8SOKzjDn
DLflBqKQAzOClSVgLHKxlsd4D+oI9QMo3GZmi8iF1BgrseAkwTKk8vAA/9P2YIBy
HeEXDsCQmSv7rEUlguOUQmwbBRYUQzOq2APnmKekx8+a634pphROU+tbKYomsCcR
vjNqMrn+zX2yElkPtKpeb1j8o93VjKPApMOTHdZ60tXW5+nSq5V+9FZQKS9HyBIj
aN0xbFHAj69M6ZN0bR6QN7hj9BbDsvsh7lyBHnSYYZ6CqvPU/2j3cAGiqDjmz4s7
ylppWKK4uRqQYZwoRwL2MMq+GwiO6acccXY8Zjw5A6H53Qdfk8PsuszI9wR79ao=
=0RC1
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
