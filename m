Received: from eggs.gnu.org ([209.51.188.92]:49917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIaI1-0007KV-6s
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIaHz-0000HM-WC
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:51:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hIaHz-0000Gi-N4
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:51:23 -0400
References: <20190211182442.8542-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46b6b751-4e3f-1b11-9ac7-d0d73cca2227@redhat.com>
Date: Mon, 22 Apr 2019 09:51:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190211182442.8542-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs"
Subject: Re: [Qemu-devel] [PATCH v3 00/16] chardev: refactoring & many
 bugfixes related tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yongji Xie <elohimes@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <46b6b751-4e3f-1b11-9ac7-d0d73cca2227@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/16] chardev: refactoring & many
 bugfixes related tcp_chr_wait_connected
References: <20190211182442.8542-1-berrange@redhat.com>
In-Reply-To: <20190211182442.8542-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 12:24 PM, Daniel P. Berrang=C3=A9 wrote:
> This is a followup to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.ht=
ml
>   v2: http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg05947.=
html
>=20
> This series comes out of a discussion between myself & Yongji Xie in:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01881.html
>=20
> I eventually understood that the problem faced was that
> tcp_chr_wait_connected was racing with the background connection attemp=
t
> previously started, causing two connections to be established. This
> broke because some vhost user servers only allow a single connection.
>=20
> After messing around with the code alot the final solution was in fact
> very easy. We simply have to delay the first background connection
> attempt until the main loop is running. It will then automatically
> turn into a no-op if tcp_chr_wait_connected has been run. This is
> dealt with in the last patch in this series
>=20
> I believe this should solve the problem Yongji Xie faced, and thus not
> require us to add support for "nowait" option with client sockets at
> all. The reconnect=3D1 option effectively already implements nowait
> semantics, and now plays nicely with tcp_chr_wait_connected.
>=20
> In investigating this I found various other bugs that needed fixing and=

> identified some useful refactoring to simplify / clarify the code, henc=
e
> this very long series.

Even with this series applied, I'm still seeing sporadic failures of
iotest 169. Max posted a hack patch a while back that tries to work
around the race:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05907.html

which he originally diagnosed in iotest 147:
https://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html

but as it was a hack, he has not pursued it further, and so the symptoms
are still there, although not completely reproducible:

169 10s ... - output mismatch (see 169.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/169.out	2018-11-16
15:48:12.018526748 -0600
+++ /home/eblake/qemu/tests/qemu-iotests/169.out.bad	2019-04-22
09:38:45.481517132 -0500
@@ -1,3 +1,5 @@
+WARNING:qemu:qemu received signal 11:
/home/eblake/qemu/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86=
_64
-chardev
socket,id=3Dmon,path=3D/home/eblake/qemu/tests/qemu-iotests/scratch/tmp4c=
lmPF/qemua-26803-monitor.sock
-mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
unix:path=3D/home/eblake/qemu/tests/qemu-iotests/scratch/qemua-26803-qtes=
t.sock
-machine accel=3Dqtest -nodefaults -machine accel=3Dqtest -drive
if=3Dvirtio,id=3Ddrive0,file=3D/home/eblake/qemu/tests/qemu-iotests/scrat=
ch/disk_a,format=3Dqcow2,cache=3Dwriteback

Any chance you can take a look as to what a non-hack fix should be?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly91OUACgkQp6FrSiUn
Q2ollAf+Lov4gqZFQztOSUfKIEQWVZ2ZLrzueZdfeeIgqNolFFTNnxN0tmFeMb+y
OncB8GJ10B4U1DBJsoHWg1cwwtea9g55ZNerFgvPpBJ6uKXVRnO/S5UG2Gtp/2dw
LSzrnStdJ0Antl/+kaMMUN9p5Mz17h27mGZNvFcYithI1fjj/JX9y632+w+Ssaf1
4QBdPEIaNqn5YnEh7W0OmAcMkwW09PgH8L08iHkxR+BxtoXGS/0+Q4jr1SBebkf3
gk22ChgGSksUeRsxemTO/n97P/ONg1aIOPCNreZXK6mO0KDU9nxyljNiOykOYo32
82nu2a8zSARKmrC2hVsaUmOma488sw==
=9QLn
-----END PGP SIGNATURE-----

--z3hgxBtKre85to5bdVEyc7HYKiSm0hBKs--
