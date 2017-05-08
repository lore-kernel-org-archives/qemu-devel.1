Received: from eggs.gnu.org ([2001:4830:134:3::10]:35749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lPi-0007Ss-7s
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lPd-000718-71
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:21:32 -0400
Date: Mon, 8 May 2017 12:21:21 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508162121.GB22428@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-15-pbonzini@redhat.com>
	<20170504145906.GR32376@stefanha-x1.localdomain>
	<a60d65e8-fff3-dbe3-7357-38095a91e83a@redhat.com>
	<20170505102550.GA11350@stefanha-x1.localdomain>
	<1bf3079d-3af5-ffa9-c074-660b77874ff7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <1bf3079d-3af5-ffa9-c074-660b77874ff7@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 14/17] block: optimize access
 to reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 12:45:38PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 05/05/2017 12:25, Stefan Hajnoczi wrote:
> > On Thu, May 04, 2017 at 06:06:39PM +0200, Paolo Bonzini wrote:
> >> On 04/05/2017 16:59, Stefan Hajnoczi wrote:
> >>> On Thu, Apr 20, 2017 at 02:00:55PM +0200, Paolo Bonzini wrote:
> >>>> Hot path reqs_lock critical sections are very small; the only large =
critical
> >>>> sections happen when a request waits for serialising requests, and t=
hese
> >>>> should never happen in usual circumstances.
> >>>>
> >>>> We do not want these small critical sections to yield in any case,
> >>>> which calls for using a spinlock while writing the list.
> >>>
> >>> Is this patch purely an optimization?
> >>
> >> Yes, it is, and pretty much a no-op until we have true multiqueue.  But
> >> I expect it to have a significant effect for multiqueue.
> >>
> >>> I'm hesitant about using spinlocks in userspace.  There are cases whe=
re
> >>> the thread is descheduled that are beyond our control.  Nested virt w=
ill
> >>> probably make things worse.  People have been optimizing and trying
> >>> paravirt approaches to kernel spinlocks for these reasons for years.
> >>
> >> This is true, but here we're talking about a 5-10 instruction window f=
or
> >> preemption; it matches the usage of spinlocks in other parts of QEMU.
> >=20
> > Only util/qht.c uses spinlocks, it's not a widely used primitive.
>=20
> Right, but the idea is the same---very short, heavy and
> performance-critical cases use spinlocks.  (util/qht.c is used heavily
> in TCG mode).
>=20
> >> It is efficient when there is no contention, but when there is, the
> >> latency goes up by several orders of magnitude.
> >=20
> > Doesn't glibc spin for a while before waiting on the futex?  i.e. the
> > best of both worlds.
>=20
> You have to specify that manually with pthread_mutexattr_settype(...,
> PTHRED_MUTEX_ADAPTIVE_NP).  It is not enabled by default because IIUC
> the adaptive one doesn't support pthread_mutex_timedlock.

If you want to use spinlocks in QEMU please document strict rules that
ensure they will be used safely.  For example, I'd be comfortable with:

Spinlock regions may only call functions in the same source file or
functions explicitly documented as spinlock-safe.  Only memory accesses
and computation may be performed; do not make system calls or invoke
library functions.

Stefan

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEJsBAAoJEJykq7OBq3PI4ikIAMlyqVyqgjGCLofMkPqtv/K5
23NIClSoFedcgm/xoE9jWWPHIlE1v7A5FZOo+3LrtfXeYE+iYDSW/6QwtHyKkjrt
oVqm0YG4vu/wndG18+A6Re/SnWJ0IDTT8ELjFC2TrtUH2IyCo0fLmLmHjz+yt5L/
sGF8ogczq27HBaMlyl6dIovf3l8MgmrsjpceLUaYDGm0kdYgJDGGCyKPJ+A93LE4
B6p9pdowhWx4ueY6c1xOcI9QIW+DHPbiVK4Q7YwZx699DTRVfSkUMdZd/rD4o2R5
DNpfslyHtY2Gtnqpzp0GAvIGaim2Q5HPmL+jN4uLUmAbhJY0EYled0miWwFbxEI=
=FeBq
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
