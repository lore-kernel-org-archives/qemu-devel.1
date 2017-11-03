Received: from eggs.gnu.org ([2001:4830:134:3::10]:48894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAcvq-00007J-3z
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAcvk-0004V8-9e
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:26:50 -0400
Date: Fri, 3 Nov 2017 14:26:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103142633.GO5078@stefanha-x1.localdomain>
References: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
	<w5160b3k4c0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jx/LfW4V5TfZLeq7"
Content-Disposition: inline
In-Reply-To: <w5160b3k4c0.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] throttle: fix a qemu crash
 problem when calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: sochin jiang <sochin.jiang@huawei.com>, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com, qemu-devel@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>


--jx/LfW4V5TfZLeq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2017 at 10:40:47AM +0200, Alberto Garcia wrote:
> On Tue 24 Oct 2017 05:33:51 AM CEST, sochin jiang wrote:
> > --- a/block/throttle-groups.c
> > +++ b/block/throttle-groups.c
> > @@ -576,7 +576,9 @@ void throttle_group_unregister_tgm(ThrottleGroupMem=
ber *tgm)
> > =20
> >      /* remove the current tgm from the list */
> >      QLIST_REMOVE(tgm, round_robin);
> > -    throttle_timers_destroy(&tgm->throttle_timers);
> > +    if (throttle_timers_are_initialized(&tgm->throttle_timers)) {
> > +        throttle_timers_destroy(&tgm->throttle_timers);
> > +    }
> >      qemu_mutex_unlock(&tg->lock);
> > =20
> >      throttle_group_unref(&tg->ts);
>=20
> I don't know what the rest of the people think, but I'm not completely
> convinced that it's a good idea to have an active ThrottleState inside a
> ThrottleGroupMember without timers.
>=20
> Perhaps in blk_remove_bs() after detaching the AioContext from the BDS
> we can attach the default one (what you would get with
> blk_get_aio_context()).
>=20
> On the other hand I think that Manos's series to remove the legacy
> throttling code gets rid of BlockBackend.ThrottleGroupMember completely.

What is the status of Manos' series?

It would be good to merge it and then consider currently open throttling
bugs again.

Stefan

--jx/LfW4V5TfZLeq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/HyZAAoJEJykq7OBq3PIcfsH/A5dfXZwVHQnKMUUkgP9j7vS
f3X5jutPP2bnSvT4Fa66gbMFcDIAUrCLvrj6db/PZX+XFz5a7m4g7+Cf/48SsaeZ
XCt6kiYDi/WQhdHw5eaZlrxCjUo1Z8s4TJg+0PCqHVExDfcioZmJDog6aX9rMMmp
psrb1kujXhIC0nuobbqvimsHC3Fuo+/UzkiHCwN7mBMvR7jdMSMarcZP3MU+m5tl
qGcZZ8AzoCAP82gx3jkRFSHoujyLoRM9xZ/XhlwaoyRDwibtgzV7vwWDVA50wlyv
K73b2/Ou78kb5gUqoLo9eL/6h/pZbcGnn5cjGTB9Y6Bl3XIdbjBoA59Lhk4cy6s=
=O8kh
-----END PGP SIGNATURE-----

--jx/LfW4V5TfZLeq7--
