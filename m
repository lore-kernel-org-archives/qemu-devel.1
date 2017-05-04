Received: from eggs.gnu.org ([2001:4830:134:3::10]:55158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HFR-0007NI-OO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HFO-0006iW-OP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:56:49 -0400
Date: Thu, 4 May 2017 14:56:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504135642.GN32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-9-pbonzini@redhat.com>
	<20170504065748.GC19184@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y4VYWfdFdHwFhC6D"
Content-Disposition: inline
In-Reply-To: <20170504065748.GC19184@lemon.lan>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 08/17] throttle-groups:
 protect throttled requests with a CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--Y4VYWfdFdHwFhC6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 02:57:48PM +0800, Fam Zheng wrote:
> On Thu, 04/20 14:00, Paolo Bonzini wrote:
> > diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-back=
end.h
> > index 87a43b0..e9529fb 100644
> > --- a/include/sysemu/block-backend.h
> > +++ b/include/sysemu/block-backend.h
> > @@ -72,11 +72,8 @@ typedef struct BlockDevOps {
> >   * fields that must be public. This is in particular for QLIST_ENTRY()=
 and
> >   * friends so that BlockBackends can be kept in lists outside block-ba=
ckend.c */
> >  typedef struct BlockBackendPublic {
> > -    /* I/O throttling has its own locking, but also some fields are
> > -     * protected by the AioContext lock.
> > -     */
> > -
> > -    /* Protected by AioContext lock.  */
> > +    /* reqs_lock protects the CoQueues for throttled requests.  */
> > +    CoMutex      reqs_lock;
>=20
> Bikeshedding: will it be more readable if it's called throttled_reqs_lock=
 or
> throttled_lock?

Yes, please.

Stefan

--Y4VYWfdFdHwFhC6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCzMaAAoJEJykq7OBq3PILuoH/jTATt6CIMJFY64htLunueRM
/JI/bmsZjXsbKs5pU4XzRQd8WukE/pnFvPISIo/+sIcmXeFQ4scBC8jaZJaHnZRO
PPN+McsAQTtmeR8cWysekHoMJ2E9MvHQDdqS+U9sQH/ucs7gaXJaQSFWqVlK2TPC
QWoACTKheGwmmGMDIwwSpS38y3GiCI6lTz7OE6uI0JXUR5eBdXPMQ2J66dWWxwB1
PXPtPU8+JTP5vCeBo76rfwXLf/wgKVkPVHet+YVkK5ZH6hyhOu4BMDjRIHPFrDq0
JfKUlh3pPet5l1BUv3iJwX+MjuViK9WTph5+0YzGtzbcNBr+Qa07rb7mK+nA56w=
=E0mO
-----END PGP SIGNATURE-----

--Y4VYWfdFdHwFhC6D--
