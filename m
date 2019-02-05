Received: from eggs.gnu.org ([209.51.188.92]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gr27I-0006dp-Bx
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gr27G-0007xl-Ps
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:54:28 -0500
Received: from greensocs.com ([193.104.36.180]:48503)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gr27C-0007un-Rr
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:54:25 -0500
References: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
	<622bb639-5ab5-d427-e84f-bc3ef85c83da@greensocs.com>
	<1994195934.1510428.1549031139233@mail.yahoo.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <c2dd9bff-85a5-b87b-0334-fc8f3e3fec36@greensocs.com>
Date: Tue, 5 Feb 2019 15:54:17 +0100
MIME-Version: 1.0
In-Reply-To: <1994195934.1510428.1549031139233@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NIhpr6PjlGk0nAPanvnoaJviQQhK1f6T3"
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NIhpr6PjlGk0nAPanvnoaJviQQhK1f6T3
From: Luc Michel <luc.michel@greensocs.com>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
Message-ID: <c2dd9bff-85a5-b87b-0334-fc8f3e3fec36@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
References: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
 <622bb639-5ab5-d427-e84f-bc3ef85c83da@greensocs.com>
 <1994195934.1510428.1549031139233@mail.yahoo.com>
In-Reply-To: <1994195934.1510428.1549031139233@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 2/1/19 3:25 PM, Lucien Anti-Spam wrote:
> Hi Luc,
>=20
> Great feedback from both you and Eric - im blown away, I dont think
> theres a single 1byte ascii character left unturned there :)
> My coding style snuck in erywhere, as did my Scottish English!
>=20
> On Friday, February 1, 2019, 10:33:18 PM GMT+9, Luc Michel
> <luc.michel@greensocs.com> wrote:
>> > +=C2=A0 =C2=A0 GDBThreadIdKind vcontThreadType ;
>> The coding style ...=C2=A0CODING_STYLE ...
> Ah I didnt pick up on this whilst reading the Wiki for coding style,
> thank you!
>=20
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcontThreadType =3D GDB_A=
LL_THREAD ;> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D 1 ;
>> The spec is not clear but I would opt for GDB_ALL_PROCESSES instead of=

>> GDB_ALL_THREAD here. pid =3D 1; is clearly wrong since you don't know =
if
>> this PID exists or is currently attached.
>=20
> I was in a quandary here, and I did see your previous email too.
> However, I looked at how the call to=C2=A0read_thread_id()=C2=A0behaved=
 and
> =C2=A0copied over the same behavior as if the command was vCont;c:-1
> which I understand to mean continue all threads?
This is where the spec lacks details. The doc says that the vCont packet
is used to "Resume the inferior, specifying different actions for each
thread."

So it seems to target only one inferior (i.e. one process).

When multiprocess extension is in use, this packet must be supported,
and used in place of 'Hc' (which modifies s->c_cpu) and other action
packets (s, S, ...) which are deprecated.

So the question is: when the vCont packet does not specifies a
thread-id, what _process_ we should choose?

Going for all process is probably ok because:
  - we don't have to bother choosing a PID,
  - it will cover the mono-process case correctly (main use-case of this
form of vCont packet I think).

Otherwise, we can go for GDB_ALL_THREAD and take the PID of the first
attached CPU. I'm not sure sure which one is better...

Thanks.

Luc

>=20
> So maybe we should look at altering=C2=A0read_thread_id() which sets pi=
d=3D1
> when there
> is no "ppid." part to the thread-id description, and if you set "tid=3D=
-1"
> then it performs a GDB_ALL_THREAD
>=20
> From the vCont spec I also got;
> "p-1 ... means all processes"
> "An action with no thread-id matches all threads."
> "tid=3D-1 ... matches all threads"
>=20
> But it is not very clear what happens if you omit ppid and supply tid a=
s -1.
>=20
> What do you think?
>=20
> Cheers,
>=20
> Luc
>=20
>=20


--NIhpr6PjlGk0nAPanvnoaJviQQhK1f6T3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlxZo5kACgkQd8knW3Qn
Tr4wRQ/7B6uc4SvuCxuj41VBwrc5tjJyqAKMFrjmISGo1PLWfbK0Dgk9NZJOFCyx
+5I9VGdKa8nRVp+t/Gxl2yyVoUB6+8tlswL/9gvNFKwSJdJkL/6YutgyKSrAeWiP
nAy1cceEZNC9/TfFFo6PB4aIR/bHISodVE6sWk+kHCXY9IWHp2CQb8STiP1FX91Y
rvsq6anui0YTe4xdGY7OpDuwymEiXuQ0Gjed1YO/jFvkbPAys6hgvyZB+ufBTHO0
pdzE1k4XVyQB4EAHP14uW4wJXcKWM9oJz/hGDEnJ9nhC7J2LWP4xezR8vnH+izNx
KkYSncRBARnKgZqGaAYukFPVZskPLUAUmX69NRLzonhDYRh0Lub2iS5lkOQGDd1F
8Xaw0XC8tmgr/xE+yggG2k5qb1H0zZeTZbdkQz275qiEsDzAeleCsDJcI+3MRrYr
nrsZP9+PITImhrOfl+rPGTjOkABvdLiWUD3svA5H/dBbKDIUYm/bQ6EfevSW12or
z4xDdkkf5lLcd6VJRNUGn37TnlkMy43g+iX9xF3yImxP/w3JHa3S7LY9HjvlTupD
7rI4z3+UTzR+WnbJHqGe45dugsp63W6SL/CPBHOlYm1R4UeuujWdPg4zgrM64VF0
CujmCEqtHEOk+LczfeTQghnk29wvqcWaME1PgpecSllAZJpX6ug=
=GTvX
-----END PGP SIGNATURE-----

--NIhpr6PjlGk0nAPanvnoaJviQQhK1f6T3--
