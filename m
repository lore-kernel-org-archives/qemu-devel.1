Received: from eggs.gnu.org ([209.51.188.92]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPXy-0002jb-Q3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPXY-0003ek-Bo
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:18:09 -0500
Date: Tue, 15 Jan 2019 14:18:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190115141800.GB29056@stefanha-x1.localdomain>
References: <w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
	<20190114133553.GE7038@stefanha-x1.localdomain>
	<w51won7480o.fsf@maestria.local.igalia.com>
	<20190114161525.GA32304@stefanha-x1.localdomain>
	<w51zhs32ojb.fsf@maestria.local.igalia.com>
	<20190114163117.GA521@stefanha-x1.localdomain>
	<w51h8eb7ybn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <w51h8eb7ybn.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] throttle-groups: fix restart
 coroutine iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 09:56:28PM +0100, Alberto Garcia wrote:
> On Mon 14 Jan 2019 05:31:17 PM CET, Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > On Mon, Jan 14, 2019 at 05:26:48PM +0100, Alberto Garcia wrote:
> >> On Mon 14 Jan 2019 05:15:25 PM CET, Stefan Hajnoczi wrote:
> >> >> > I've been able to reproduce this in an iotest, please see v2 of t=
his
> >> >> > series.
> >> >>=20
> >> >> That iotest doesn't crash for me :-?
> >> >
> >> > Does my iotest pass for you?
> >>=20
> >> Yes, it does. I'm trying to figure out why because if I run the QMP
> >> commands by hand then it does crash.
> >
> > I ran the iotest 20 times on my machine and it segfaulted every time
> > (with the fix not yet applied).
>=20
> Yeah I can also reproduce it all the time if I run it by hand...
>=20
> I was debugging it and although I don't know why this is different when
> I run it through tests/qemu-iotests/check, here's why it doesn't crash:
>=20
> After the ThrottleGroupMember is unregistered and its BlockBackend is
> destroyed, the throttle_group_co_restart_queue() coroutine takes
> control.
>=20
> The first thing that it does is lock tgm->throttled_reqs_lock. It turns
> out that although this memory has been freed (it's part of the
> BlockBackend struct) it is still accessible but contains pure
> gargabe. 'Garbage' here means that the mutex counter contains some
> random value !=3D 0, so the thread waits, it doesn't have a chance to
> crash the process, and QEMU shuts down cleanly.
>=20
> So if my understanding is correct QEMU can be shut down when there are
> iothreads waiting for a mutex. Is that something that we should be
> worried about?

Nothing joins the iothreads in vl.c:main().

The assumption is that anything using iothreads will detach from them.
For example, the vm runstate changes during shutdown so devices can
disable the iothread code path (and this involves draining in-flight
requests).

My fix effectively does this by waiting for in-flight throttling restart
coroutines.

Stefan

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPeuYAAoJEJykq7OBq3PIv/sH/1uB5H/Fry2TeX7OfdPtcR5r
x1zYGseI9pTjd4DvvW8M15VUt4BivofyuLVPhsmy8hNjNafEhOZnvtdEve7iZQWz
fg7QqodMxTOywMKbvaEPsBhAexnZVSFZX+VecBU6jT+JShoEXbPtOTk8zHtj4Xrz
IU/bSh0xH4BmGCJXBHKew+QVxHivBAfmsZMoS1OyzMwIxmy8fg6Rxbg2fsMQqofW
novMILX+cqxzQv5T2dlOk2R2jEF5Jp0Y6alG/ZjLtIJtTj7h5F2QBL8Kn/oXEgSD
Uz1/sWUNsGa3q/4XUtVKOpE60Yq6wZgG6g2RdLEgZaJOVj9rxNd1vqFaXxJ+f1A=
=J6/Q
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
