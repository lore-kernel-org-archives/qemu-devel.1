Received: from eggs.gnu.org ([2001:4830:134:3::10]:60207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1exyI6-0005ab-UY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1exyI3-0001Q0-K5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:09:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1exyI3-0001PU-Dz
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:09:43 -0400
Date: Mon, 19 Mar 2018 17:09:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180319170931.GC21259@stefanha-x1.localdomain>
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA-x8PryWiOdh3CR-0o5UvL=0day0LMUyPRKzy2dE0XL=A@mail.gmail.com>
	<af1ce941-2b9a-bc84-4419-52727c7bd236@adacore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <af1ce941-2b9a-bc84-4419-52727c7bd236@adacore.com>
Subject: Re: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead
 of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 07:45:18PM +0100, KONRAD Frederic wrote:
> On 03/16/2018 05:34 PM, Peter Maydell wrote:
> > On 16 March 2018 at 16:23, KONRAD Frederic <frederic.konrad@adacore.com=
> wrote:
> > > Since the commit:
> > > commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
> > > Author: Stefan Hajnoczi <stefanha@redhat.com>
> > > Date:   Wed Mar 7 14:42:05 2018 +0000
> > >=20
> > >      vl: introduce vm_shutdown()
> > >=20
> > > GDB crash when qemu exits (at least on sparc-softmmu):
> > > Remote communication error.  Target disconnected.: Connection reset b=
y peer.
> > > Quitting: putpkt: write failed: Broken pipe.
> > >=20
> > > So send a packet to kill GDB before we exit QEMU:
> > > [Inferior 1 (Thread 0) exited normally]
> > >=20
> > > Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> > > ---
> > >   gdbstub.c              | 7 +++++++
> > >   include/exec/gdbstub.h | 2 ++
> > >   vl.c                   | 2 ++
> > >   3 files changed, 11 insertions(+)
> >=20
> > We didn't send an exiting packet before commit 4486e89c219c0,
> > so do you know why this worked before then? (Telling gdb we're
> > exiting seems like the right thing, though.)
> >=20
>=20
> Hmmm good question, I didn't had time to investigate in detail
>=20
> Before 4486e89c219c0:
>=20
> (gdb) tar rem :1234
> Remote debugging using :1234
> 0x40000000 in trap_table ()
> (gdb) c
> Continuing.
> Remote connection closed
>=20
> After 4486e89c219c0:
>=20
> (gdb) tar rem :1234
> Remote debugging using :1234
> 0x40000000 in trap_table ()
> (gdb) c
> Continuing.
> putpkt: write failed: Connection reset by peer.
>=20
> With the patch:
>=20
> (gdb) tar rem :1234
> Remote debugging using :1234
> 0x40000000 in trap_table ()
> (gdb) c
> Continuing.
> [Inferior 1 (Thread 0) exited normally]
>=20
> We use to have this patch in our repository to avoid the remote
> connection closed above.

Previously pause_vcpus() didn't invoke the vm change state handler.
Therefore the gdbstub didn't tell GDB that the vcpu was being stopped
=66rom gdb_vm_state_change().

Now vm_shutdown() invokes vm change state handlers so the gdbstub tells
GDB that the vcpu is stopping.  As a result GDB sends a packet to query
the state of the vcpu - but QEMU terminates and closes the connection
partway through.

Here is the strace:
31365 poll([{fd=3D3, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D11,=
 events=3DPOLLIN}, {fd=3D13, events=3DPOLLIN}], 4, -1) =3D 1 ([{fd=3D13, re=
vents=3DPOLLIN}])
31365 recvfrom(13, "$T03thread:01;#05", 8192, 0, NULL, NULL) =3D 17
31365 poll([{fd=3D13, events=3DPOLLIN}], 1, 0) =3D 1 ([{fd=3D13, revents=3D=
POLLIN}])
31365 sendto(13, "+", 1, 0, NULL, 0)    =3D 1
31365 sendto(13, "$g#67", 5, 0, NULL, 0) =3D -1 EPIPE (Broken pipe)
31365 --- SIGPIPE {si_signo=3DSIGPIPE, si_code=3DSI_USER, si_pid=3D31365, s=
i_uid=3D1000} ---

The ugly error message is because QEMU doesn't respond to GDB's "$g#67"
message.

Your patch is making GDB exit gracefully.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJar+7LAAoJEJykq7OBq3PI9YoH/1RgxpTracE9lLlqPmxWs3i6
qi58DmtUoffXGYqNFS+ce8kpV+TscPRXhTCgYLSDQKC/QKkpCl9OV8Gl7g33wPe6
b3xd9N+3kY3qsghpNIgx0XHqHE2l/QJzI4XCU8AxsGnJQ8GRTz9bV5lFk7aZ5Ley
6A/P/4GvmbQ5YAXAXHOor9jABGESKLCVnwoSx2FHZhP+27bWXQf45HfMhrOcqnxr
/CZz7Dni0QkHcFvmgkyOvmhiPwsN7LBJ5FQQcbJWLmZjZdzKP7reGkL8LqkVA/Zw
bLiThT6WbNI4pbNE+hlI8CCTtpC4eJDm2YkrvLn0G6T05qjcsp5TfgzrvarSY38=
=AOdI
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
