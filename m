Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275EDC34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E779D24656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtUhCyqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E779D24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4TdA-00070N-5s
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j4Tc6-0005YG-5s
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j4Tc5-00011n-0y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j4Tc4-00011X-Ts
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582135100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mu8dDkybuf2T+R1N1p6pN4YYhyHyt5cpP3dEJdBPbk4=;
 b=GtUhCyqCJD5hSXoX5EyuYu5IWTUqP1yaACMaSbB5+QKF/OtTCzzkanbFgSIuNMur+lqZOW
 kPoSFYA2z7uaNyuAccb3LFaP6nZoulga2jhUM51Sb3MfFBtBwSwiKAcGPiLvIlptzdyBEm
 G83oVqxn6wxQeHwRxQ0eCmJVf9rzld0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-zl7HuAHENJekxVdW5BqJzA-1; Wed, 19 Feb 2020 12:58:16 -0500
X-MC-Unique: zl7HuAHENJekxVdW5BqJzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDCA7801E74;
 Wed, 19 Feb 2020 17:58:14 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA8990761;
 Wed, 19 Feb 2020 17:58:14 +0000 (UTC)
Date: Wed, 19 Feb 2020 16:54:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] util/async: make bh_aio_poll() O(1)
Message-ID: <20200219165425.GB1089598@stefanha-x1.localdomain>
References: <20200219100045.1074381-1-stefanha@redhat.com>
 <ad80faf5-7e77-739e-36d7-8d88101b9d59@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ad80faf5-7e77-739e-36d7-8d88101b9d59@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 12:09:48PM +0100, Paolo Bonzini wrote:
> Really a great idea, though I have some remarks on the implementation bel=
ow.
>=20
> On 19/02/20 11:00, Stefan Hajnoczi wrote:
> > + * Each aio_bh_poll() call carves off a slice of the BH list.  This wa=
y newly
> > + * scheduled BHs are not processed until the next aio_bh_poll() call. =
 This
> > + * concept extends to nested aio_bh_poll() calls because slices are ch=
ained
> > + * together.
>=20
> This is the tricky part so I would expand a bit on why it's needed:
>=20
> /*
>  * Each aio_bh_poll() call carves off a slice of the BH list, so that
>  * newly scheduled BHs are not processed until the next aio_bh_poll()
>  * call.  All active aio_bh_poll() calls chained their slices together
>  * in a list, so that nested aio_bh_poll() calls process all scheduled
>  * bottom halves.
>  */

Thanks, will fix in v2.

> > +struct BHListSlice {
> > +    QEMUBH *first_bh;
> > +    BHListSlice *next;
> > +};
> > +
>=20
> Using QLIST and QSLIST removes the need to create your own lists, since
> you can use QSLIST_MOVE_ATOMIC and QSLIST_INSERT_HEAD_ATOMIC.  For exampl=
e:
>=20
> struct BHListSlice {
>     QSLIST_HEAD(, QEMUBH) first_bh;
>     QLIST_ENTRY(BHListSlice) next;
> };
>=20
> ...
>=20
>     QSLIST_HEAD(, QEMUBH) active_bh;
>     QLIST_HEAD(, BHListSlice) bh_list;

I thought about this but chose the explicit tail pointer approach
because it lets aio_compute_timeout() and aio_ctx_check() iterate over
both the active BH list and slices in a single for loop :).  But
thinking about it more, maybe it can still be done by replacing
active_bh with a permanently present first BHListSlice element.

>=20
> Related to this, in the aio_bh_poll() loop:
>=20
>     for (s =3D ctx->bh_list.next; s; s =3D s->next) {
>     }
>=20
> You can actually do the removal inside the loop.  This is slightly more
> efficient since you can remove slices early from the nested
> aio_bh_poll().  Not that it's relevant for performance, but I think the
> FIFO order for slices is also more intuitive than LIFO.
>=20
> Putting this idea together with the QLIST one, you would get:
>=20
>     /*
>      * If a bottom half causes a recursive call, this slice will be
>      * removed by the nested aio_bh_poll().
>      */
>     QSLIST_MOVE_ATOMIC(&slice.first_bh, ctx->active_bh);
>     QLIST_INSERT_TAIL(&ctx->bh_list, slice);
>     while ((s =3D QLIST_FIRST(&ctx->bh_list)) {
>         while ((bh =3D aio_bh_dequeue(&s, &flags))) {
>         }
>         QLIST_REMOVE_HEAD(s, next);
>     }

Cool, reusing "queue.h" is nice.

>=20
> >  /* Multiple occurrences of aio_bh_poll cannot be called concurrently.
> >   * The count in ctx->list_lock is incremented before the call, and is
> >   * not affected by the call.
>=20
> The second sentence is now stale.

Thanks, will fix in v2.

Stefan

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5NaEEACgkQnKSrs4Gr
c8hgVwgAmXimS3GZsCIqTlzXhi7Xu5bmF2wdJ/AH7xiil92p9v88IzXlQUT+Rgam
ywEvBPxXZSk8F0ouSqHK/s/EWJrFFUZLMtapaCMtLa44oS27vfc+5KI2TmRtcU9e
c3zW8xTT0EN8Eg+st8JjslWXuzVDhrDYfLvS3Gz8BMPaU5t/luYXp4UyVYTJQUd/
zbbe6J8AdJrfXDt5AAs2LNI/82rpBrkBlIYOQZMwz7teZ7Eivr6OPEILArID8h5H
mHZf5rW7eoRryZJOiqDGdo6PkuVQakocikx4yLDJO8sgwBO+N3TTwoWMAgEvvbyc
eDpJmXpB0RIUOmb8RmA6Ivrev2aHpQ==
=ozi2
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--


