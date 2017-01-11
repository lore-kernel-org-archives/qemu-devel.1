Received: from eggs.gnu.org ([2001:4830:134:3::10]:38289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRLZy-000530-PI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRLZu-0005kf-QA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRLZu-0005kB-Jy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:16:46 -0500
Date: Wed, 11 Jan 2017 16:16:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111161640.GA9269@stefanha-x1.localdomain>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295047061.19871.11792107348459066542.stgit@fimbulvetr.bsc.es>
	<20170109170156.GL30228@stefanha-x1.localdomain>
	<34ec95ff-7283-4e6f-fc07-7678424d0e13@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <34ec95ff-7283-4e6f-fc07-7678424d0e13@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/7] trace: [tcg] Delay changes to
 dynamic state when translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 05:31:37PM +0100, Paolo Bonzini wrote:
> On 09/01/2017 18:01, Stefan Hajnoczi wrote:
> > Or use a simpler scheme:
> >=20
> > struct CPUState {
> >     ...
> >     uint32_t dstate_update_count;
> > };
> >=20
> > In trace_event_set_vcpu_state_dynamic():
> >=20
> >     if (state) {
> >         trace_events_enabled_count++;
> >         set_bit(vcpu_id, vcpu->trace_dstate_delayed);
> > 	atomic_inc(&vcpu->dstate_update_count, 1);
> >         (*ev->dstate)++;
> >     } ...
> >=20
> > In cpu_exec() and friends:
> >=20
> >     last_dstate_update_count =3D atomic_read(&vcpu->dstate_update_count=
);
> >=20
> >     tb =3D tb_find(cpu, last_tb, tb_exit);
> >     cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
> >=20
> >     /* apply and disable delayed dstate changes */
> >     if (unlikely(atomic_read(&cpu->dstate_update_count) !=3D last_dstat=
e_update_count)) {
> >         bitmap_copy(cpu->trace_dstate, cpu->trace_dstate_delayed,
> >         trace_get_vcpu_event_count());
> >     }
> >=20
> > (You'll need to adjust the details but the update counter approach
> > should be workable.)
>=20
> Would it work to use async_run_on_cpu?

I think so.

Stefan

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdlpoAAoJEJykq7OBq3PIX34IAIe9ItpqiFG1y8b3qB++V5wY
PEkadQ0HDlvJzEVSaFpL+6cgKBnYUGfCV6Hmf32T+1dKZkzsetYBlwgFQoH/9vg/
7tRM3XeoBRGmpt1WxMl9NRdLM9t1q8YGJNUzqQdFcKqR+YhyKDQfkGiZx8ZAErvL
Pgi7LGQix1wPQR1IQ03ERtF34bVxS4/qs3bHWw2vJZ6PhYp5YT8FbRARmXxzOyHc
cJ/YUMzL9Q1iGRJRgXmTHdR3DhkNeg5vwm+hWujslcQYh5IyjAP4Jo/D1x+Ad6AB
bTX+2yrCf5P+ADdf9MR3VEJWipz6276u+QC4Aiogs05OplVjJiY3il+GrJ4clkc=
=oyTs
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
