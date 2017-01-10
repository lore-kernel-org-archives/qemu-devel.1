Received: from eggs.gnu.org ([2001:4830:134:3::10]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQzKx-0002ZF-Dj
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQzKt-0005D6-L6
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:31:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQzKt-0005Cf-Cj
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:31:47 -0500
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295047061.19871.11792107348459066542.stgit@fimbulvetr.bsc.es>
	<20170109170156.GL30228@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34ec95ff-7283-4e6f-fc07-7678424d0e13@redhat.com>
Date: Tue, 10 Jan 2017 17:31:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170109170156.GL30228@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A6fgk4sACM6gXJ7sFslv48w2X4IOmH5nO"
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
To: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A6fgk4sACM6gXJ7sFslv48w2X4IOmH5nO
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <34ec95ff-7283-4e6f-fc07-7678424d0e13@redhat.com>
Subject: Re: [PATCH v6 3/7] trace: [tcg] Delay changes to dynamic state when
 translating
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
 <148295047061.19871.11792107348459066542.stgit@fimbulvetr.bsc.es>
 <20170109170156.GL30228@stefanha-x1.localdomain>
In-Reply-To: <20170109170156.GL30228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 09/01/2017 18:01, Stefan Hajnoczi wrote:
> Or use a simpler scheme:
>=20
> struct CPUState {
>     ...
>     uint32_t dstate_update_count;
> };
>=20
> In trace_event_set_vcpu_state_dynamic():
>=20
>     if (state) {
>         trace_events_enabled_count++;
>         set_bit(vcpu_id, vcpu->trace_dstate_delayed);
> 	atomic_inc(&vcpu->dstate_update_count, 1);
>         (*ev->dstate)++;
>     } ...
>=20
> In cpu_exec() and friends:
>=20
>     last_dstate_update_count =3D atomic_read(&vcpu->dstate_update_count=
);
>=20
>     tb =3D tb_find(cpu, last_tb, tb_exit);
>     cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
>=20
>     /* apply and disable delayed dstate changes */
>     if (unlikely(atomic_read(&cpu->dstate_update_count) !=3D last_dstat=
e_update_count)) {
>         bitmap_copy(cpu->trace_dstate, cpu->trace_dstate_delayed,
>         trace_get_vcpu_event_count());
>     }
>=20
> (You'll need to adjust the details but the update counter approach
> should be workable.)

Would it work to use async_run_on_cpu?

Thanks,

Paolo


--A6fgk4sACM6gXJ7sFslv48w2X4IOmH5nO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYdQxsAAoJEL/70l94x66DHrYH/2jT1e+BBtNpr+JSAvp9CPWX
haDzMVZU9R6e4Gyh3xtH10qhuQ3RK4cIiwO+YvsQgqn/px92i9ZUuIidtnVBWL3T
gqVVC833HT/7YNo28TJheo9V+AWQpXAyVZNeqprG8K9Nwhf2pV234ZpJsGOv11nl
l82Z68ig6KT7jTUfvlhBlp12+Ftn89aiSyViioJa2VIJpV/yy93WGYJs1de5IOTi
q3TPhRJsVX6Y8q86lZseFHGv5/Fq/HozbeA3XJvXKUK9lmwXcv9jU5epkLE0+1ZP
dlOVnL95M50qwgajwWMtCvwiLYT++KCnUuS7Zc9FDmjdwylhNmZ9eTlLfA7UfEA=
=XooR
-----END PGP SIGNATURE-----

--A6fgk4sACM6gXJ7sFslv48w2X4IOmH5nO--
