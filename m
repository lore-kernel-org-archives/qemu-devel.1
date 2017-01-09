Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQd5e-0002kX-9m
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQd5b-0006aP-5v
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQd5a-0006a3-W0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:46:31 -0500
Date: Mon, 9 Jan 2017 16:35:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109163535.GJ30228@stefanha-x1.localdomain>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Content-Disposition: inline
In-Reply-To: <148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
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
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 09:34:54PM +0100, Llu=EDs Vilanova wrote:
> +static void segv_handler(int signum, siginfo_t *siginfo, void *sigctxt)
> +{
> +    CPUState *vcpu =3D current_cpu;
> +    void *control_0 =3D vcpu->hypertrace_control;
> +    void *control_1 =3D vcpu->hypertrace_control + config.control_size /=
 2;
> +    void *control_2 =3D control_1 + config.control_size / 2;
> +
> +    if (control_0 <=3D siginfo->si_addr && siginfo->si_addr < control_1)=
 {
> +
> +        /* 1st fault (guest will write cmd) */
> +        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =3D=
=3D 0);
> +        swap_control(control_0, control_1);
> +
> +    } else if (control_1 <=3D siginfo->si_addr && siginfo->si_addr < con=
trol_2) {
> +        size_t client =3D (siginfo->si_addr - control_1) / sizeof(uint64=
_t);
> +        uint64_t vcontrol =3D ((uint64_t *)control_0)[client];
> +        uint64_t *data_ptr =3D &qemu_data[client * config.client_data_si=
ze];
> +
> +        /* 2nd fault (invoke) */
> +        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =3D=
=3D 0);
> +        hypertrace_emit(current_cpu, vcontrol, data_ptr);
> +        swap_control(control_1, control_0);

A simpler and faster approach is to permanently mprotect just one region
and load all arguments from data[] (including the first argument).  Then
swapping isn't necessary.

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc7vXAAoJEJykq7OBq3PIeeEIAIcCtogpylR+nnawADQIstp0
SCVYu5WOpmyILYCqztNy9NpbhGBiUmqqDXlWU3LNHPBFPae5TkqzdHjiAdgtgLTp
JO4jBlaIj6YSt4ZYOZXqR7Ln2HAvGICsUS2jYo/TrPz9lVOLIGqlV7WDXBdt/oTL
LkB/RTxrncUvsLv4KkvKPFPzl7NXakN8IKq1NoEQ0O7eFl4iNoyRbH9PsIsPt/cB
ccq6TYxjb+rpV8varXnn7GU2It8TlN+gGMZItZL+3y/iXtaR4hKsZxmmGuZ+LlSm
mKY2idtxaYyLaRk6QBkIrWvy0HSnjdRdYeC7HBF/NAUFBRXLL5ZFLmkKkWafupM=
=VLHT
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--
