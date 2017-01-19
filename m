Received: from eggs.gnu.org ([2001:4830:134:3::10]:36801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUG3e-0002Vw-C1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUG3a-0003AJ-Cb
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:59:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cUG3a-00039s-72
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:59:26 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DCF876E1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 16:59:26 +0000 (UTC)
Date: Thu, 19 Jan 2017 16:59:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170119165923.GC27032@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-11-pbonzini@redhat.com>
	<20170118154310.GK30347@stefanha-x1.localdomain>
	<ab2a2b6d-9796-d0e2-0d95-4eefa9c8ce36@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <ab2a2b6d-9796-d0e2-0d95-4eefa9c8ce36@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/16] block: explicitly acquire aiocontext
 in timers that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 05:44:24PM +0100, Paolo Bonzini wrote:
> On 18/01/2017 16:43, Stefan Hajnoczi wrote:
> > On Fri, Jan 13, 2017 at 02:17:25PM +0100, Paolo Bonzini wrote:
> >> diff --git a/block/null.c b/block/null.c
> >> index b300390..356209a 100644
> >> --- a/block/null.c
> >> +++ b/block/null.c
> >> @@ -141,7 +141,11 @@ static void null_bh_cb(void *opaque)
> >>  static void null_timer_cb(void *opaque)
> >>  {
> >>      NullAIOCB *acb =3D opaque;
> >> +    AioContext *ctx =3D bdrv_get_aio_context(acb->common.bs);
> >> +
> >> +    aio_context_acquire(ctx);
> >>      acb->common.cb(acb->common.opaque, 0);
> >> +    aio_context_release(ctx);
> >>      timer_deinit(&acb->timer);
> >>      qemu_aio_unref(acb);
> >=20
> > Is qemu_aio_unref() thread-safe?
>=20
> qemu_aio_ref()/qemu_aio_unref() is only used by bdrv_aio_cancel, which
> in turn is not used by dataplane.  So in the multithreaded case
> qemu_aio_unref() is effectively qemu_aio_free().
>=20
> Probably needs more documentation, or a different implementation of
> bdrv_aio_cancel (e.g. replacing the reference counting with a
> NotifierList of some kind).  Let me know what you prefer for v2.

Documentation is fine.  I just checked and see that virtio-scsi
dataplane uses blk_aio_cancel_async() so the aio refcount is never
touched - no race.

Stefan

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYgPBrAAoJEJykq7OBq3PIu2AH/AuoL8EDT+f7bWB88UkGhJzv
xTcaNCUWbhLK3pL+V8J87+Q7QBACfO1Nni1rHoWQNKnMHij91j2KGRTrj9sM7PP5
3K+ISBHwCZ6atP2uIrvGdxVjTAIpF13KCu1BRkrUPnTvoLRPvKDlzKmoRlSq/piY
ejU+3XeSADba/L+jj6SAKI6wnQt1pqJvjxudKRzv+k2NMu+FIoArZQP9XF0cLwav
GhPCkv+Sf+U49Z0jfqHrX9D/GlIFkj8X9VYQbH4xLK4BmT//snXZvY+8x5I3qd6Q
Jm5HTwn8QSVj+GblP4HC1ybRHB22pHBTboHcxxJlZS6amMRop42o5LNxboEdERw=
=uVsu
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
